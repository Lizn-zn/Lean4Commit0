#!/usr/bin/env python3
"""Verify the published library contracts using trusted source, types and axioms.

In evaluation, --baseline must point to a trusted release copy, not solver output.
"""
import argparse,hashlib,json,re,subprocess,sys,tempfile,os,shutil,contextlib
from pathlib import Path


from .lean_lex import scrub,lexical_spans


REPO_ROOT = Path(__file__).resolve().parents[1]


def region_spans(text,kind):
    spans=[]
    for m in re.finditer(r'(?m)^-- === BEGIN: (.*?) \('+kind+r'\) ===[^\n]*\n',text):
        end=re.search(r'(?m)^-- === END: '+re.escape(m.group(1))+r' ===[^\n]*',text[m.end():])
        if end:spans.append((m.end(),m.end()+end.start()))
    return spans


def skeleton_parts(text):
    spans=[]
    for m in re.finditer(r'(?m)^-- === BEGIN: (.*?) \(editable\) ===[^\n]*\n',text):
        end=re.search(r'(?m)^-- === END: '+re.escape(m.group(1))+r' ===[^\n]*',text[m.end():])
        if end:spans.append((m.end(),m.end()+end.start()))
    provided=region_spans(text,'provided')
    for m in re.finditer(r'\bsorry\b',scrub(text)):
        if not any(a<=m.start()<b for a,b in spans+provided):spans.append(m.span())
    spans.sort();merged=[]
    for a,b in spans:
        if merged and a<=merged[-1][1]:merged[-1]=(merged[-1][0],max(b,merged[-1][1]))
        else:merged.append((a,b))
    parts=[];last=0
    for a,b in merged:parts.append(text[last:a]);last=b
    parts.append(text[last:]);return parts


@contextlib.contextmanager
def trusted_workspace(root,data,record,dependencies):
    """Only authenticated support files and selected task files enter the compiler tree."""
    for required in ['lakefile.toml','lean-toolchain']:
        if required not in data.get('locked_files',{}):
            raise ValueError('trusted baseline does not lock '+required)
    deps=dependencies.resolve()
    if not deps.is_dir():raise ValueError('trusted dependencies missing; install the pinned dependencies first')
    with tempfile.TemporaryDirectory(prefix='lean4commit0-verify-') as tmp:
        work=Path(tmp)
        for rel in set(data['locked_files']) | set(record['files']):
            target=work/rel;target.parent.mkdir(parents=True,exist_ok=True)
            shutil.copyfile(root/rel,target)
        (work/'.lake').mkdir(exist_ok=True)
        (work/'.lake/packages').symlink_to(deps,target_is_directory=True)
        yield work


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root',type=Path,default=REPO_ROOT)
    parser.add_argument('--baseline',type=Path)
    parser.add_argument('--library',required=True)
    parser.add_argument('--trusted-dependencies',type=Path,default=REPO_ROOT/'.lake/packages',help='Evaluator-controlled pinned dependency cache; never solver-supplied')
    mode=parser.add_mutually_exclusive_group()
    mode.add_argument('--integrity-only',action='store_true')
    mode.add_argument('--scan-only','--cheats-only',dest='scan_only',action='store_true')
    mode.add_argument('--compile-only','--compile',dest='compile_only',action='store_true')
    mode.add_argument('--mechanical-only',action='store_true',help='Return 0 for partial screening plus compilation; never a solved-task verdict')
    a=parser.parse_args();root=a.root.resolve();base=a.baseline or root/'INTEGRITY_BASELINE.json'
    if not re.fullmatch(r'[A-Za-z][A-Za-z0-9]*',a.library):parser.error('Invalid library name')
    lib=root/'libs'/a.library
    if not lib.is_dir():parser.error('Library directory missing')
    if not base.is_file():
        print('FAIL: trusted integrity baseline missing',file=sys.stderr);return 1
    try:data=json.loads(base.read_text());record=data['libraries'][a.library];expected=record['files']
    except (ValueError,KeyError):
        print('FAIL: trusted baseline is invalid or library absent',file=sys.stderr);return 1
    failures=[]
    actual_files={str(p.relative_to(root)) for p in lib.rglob('*.lean') if '.lake' not in p.parts}
    for rel in actual_files-set(expected):failures.append((rel,'unexpected Lean source; custom axiom/helper files are not allowed'))
    legacy=lib/'.provided_hash'
    if not legacy.is_file() or hashlib.sha256(legacy.read_bytes()).hexdigest()!=record['legacy_hash_sha256']:
        failures.append((str(legacy.relative_to(root)),'legacy integrity marker missing or changed'))
    for rel,digest in data.get('locked_files',{}).items():
        p=root/rel
        if not p.is_file() or p.is_symlink() or hashlib.sha256(p.read_bytes()).hexdigest()!=digest:
            failures.append((rel,'trusted build/support file missing or changed'))
    for rel,parts in expected.items():
        p=root/rel
        if not p.is_file() or p.is_symlink():failures.append((rel,'expected task file missing or symlink'));continue
        text=p.read_text()
        match=re.fullmatch(r'([\s\S]*?)'.join(re.escape(s) for s in parts),text)
        if not match:
            failures.append((rel,'protected source/specification changed'))
            continue
        for match_import in re.finditer(r'(?ms)^-- === BEGIN: PROOF_IMPORTS \(editable\) ===[^\n]*\n(.*?)^-- === END: PROOF_IMPORTS ===',text):
            code=scrub(match_import[1])
            if any(line.strip() and not re.fullmatch(r'\s*import (?:Mathlib|Batteries|Std|Lean)(?:\.[A-Za-z0-9_]+)*\s*',line) for line in code.splitlines()):
                failures.append((rel,'proof-import region permits only trusted dependency imports'))
        tokens=lexical_spans(text)
        for i in range(1,len(parts)):
            start,end=match.span(i)
            if any(x<edge<y for x,y in tokens for edge in (start,end)):
                failures.append((rel,'lexical token crosses editable/protected boundary'))
            # Interpolated strings contain executable Lean expressions. Until a Lean
            # parser checks those expressions, conservatively refuse them in edits.
            if re.search(r'\b[A-Za-z_][A-Za-z0-9_]*!"',text[start:end]):
                failures.append((rel,'interpolated string in edit requires independent parser review'))
    if failures:
        for rel,reason in failures:print('FAIL:',rel,reason,file=sys.stderr)
        return 1
    if a.integrity_only:
        print('PASS: source integrity only; no solution verdict.');return 0
    if not a.compile_only and (record['provided_holes'] or record['unmarked_holes']):
        print('FAIL: task-boundary policy unresolved:',len(record['provided_holes']),'protected holes and',len(record['unmarked_holes']),'unmarked holes in trusted baseline. No fully-verified solution verdict.',file=sys.stderr)
        return 1
    patterns={
        'unresolved proof hole':r'\b(?:sorry|sorryAx|admit|admitGoal|sorry_proof|lcProof)\b',
        'custom axiom':r'(?m)^\s*(?:(?:private|protected)\s+)*axiom\b',
        'early exit/evaluation':r'(?m)^\s*#(?:exit|eval|reduce)\b',
        'axiom injection/metaprogramming':r'\b(?:addDecl|axiomDecl|macro|macro_rules|elab|elab_rules|syntax|run_tac|run_elab|implemented_by|extern|csimp|unsafe|attribute|deriving_handler)\b',
    }
    for p in ([] if a.compile_only else lib.rglob('*.lean')):
        if '.misc' in p.parts:continue
        if p.is_symlink():failures.append((str(p.relative_to(root)),'symlink task source'));continue
        code=scrub(p.read_text())
        for reason,pattern in patterns.items():
            m=re.search(pattern,code)
            if m:failures.append((str(p.relative_to(root))+':'+str(code[:m.start()].count('\n')+1),reason))
    if failures:
        for rel,reason in failures:print('FAIL:',rel,reason,file=sys.stderr)
        return 1
    if a.scan_only:
        print('PASS: integrity and static screening only; not compiled or instruction-checked.');return 0
    try:
        with trusted_workspace(root,data,record,a.trusted_dependencies) as work:
            rc=subprocess.call(['lake','build',a.library],cwd=work)
            if rc:return rc
            if a.compile_only or a.mechanical_only:
                print('PASS: fresh authenticated template compilation/mechanical checks only; no contract verdict.')
                return 0
            types=record.get('declaration_types')
            if not types:
                print('FAIL: trusted compiler declaration baseline missing',file=sys.stderr);return 1
            tool=Path(__file__).with_name('AuditDeclarations.lean')
            if not tool.is_file():
                print('FAIL: trusted declaration auditor missing',file=sys.stderr);return 1
            names=work/'required-names.txt';report=work/'declaration-audit.json'
            names.write_text(''.join(name+'\n' for name in sorted(types)))
            proc=subprocess.run(['lake','env','lean','--run',str(tool),a.library,str(names),str(report)],cwd=work,env=dict(os.environ,LEAN_NUM_THREADS='2'))
            if proc.returncode or not report.is_file():return 1
            payload=json.loads(report.read_text());decls=payload['declarations']
    except (ValueError,OSError) as err:
        print('FAIL: verifier setup: '+str(err),file=sys.stderr);return 1
    allowed={'propext','Classical.choice','Quot.sound','Lean.ofReduceBool','Lean.trustCompiler'}
    if not set(types)<={row['name'] for row in decls}:
        print('FAIL: incomplete declaration audit',file=sys.stderr);return 1
    bad_module=set(payload['module_axioms'])-allowed
    if bad_module:failures.append((a.library,'untrusted axioms anywhere in task modules: '+', '.join(sorted(bad_module))))
    for row in decls:
        name=row['name']
        if name not in types:continue
        if not row.get('present'):
            failures.append((name,'required declaration missing'));continue
        if hashlib.sha256(row['type'].encode()).hexdigest()!=types[name]:
            failures.append((name,'required trusted type changed'))
    if failures:
        for name,reason in failures:print('FAIL:',name,reason,file=sys.stderr)
        return 1
    print('PASS: library contract verification: protected source, compilation, required declarations/types and transitive axiom policy. Unit: one library. This verifies the published model, not unstated upstream behavior.')
    return 0

if __name__=='__main__':raise SystemExit(main())
