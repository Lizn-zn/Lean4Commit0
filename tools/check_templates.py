#!/usr/bin/env python3
"""Compile task templates sequentially. Compilation permits sorry; never a solution verdict."""
import argparse,json,subprocess,time
from pathlib import Path

def main():
 p=argparse.ArgumentParser(description=__doc__)
 g=p.add_mutually_exclusive_group(required=True);g.add_argument('--all',action='store_true');g.add_argument('--library')
 p.add_argument('--report',type=Path,default=Path('template-build-report.json'))
 p.add_argument('--timeout',type=float,default=600,help='Seconds per library target')
 a=p.parse_args();root=Path(__file__).resolve().parents[1]
 libs=sorted(q.name for q in (root/'libs').iterdir() if q.is_dir() and q.name!='Shared')
 if a.library and a.library not in libs:p.error('Unknown library')
 if a.timeout<=0:p.error('Timeout must be positive')
 targets=libs if a.all else [a.library];rows=[]
 logs=a.report.resolve().parent/(a.report.stem+'-logs');logs.mkdir(parents=True,exist_ok=True)
 for lib in targets:
  start=time.monotonic();log=logs/(lib+'.log')
  with log.open('w') as f:
   try:
    result=subprocess.run(['lake','build',lib],cwd=root,stdout=f,stderr=subprocess.STDOUT,timeout=a.timeout)
    rc=result.returncode;status='pass' if rc==0 else 'fail'
   except subprocess.TimeoutExpired:rc=None;status='timeout'
   except OSError as e:rc=None;status='setup_error';f.write(str(e)+'\n')
  rows.append(dict(library=lib,status=status,returncode=rc,seconds=round(time.monotonic()-start,2),log=str(log)))
  a.report.write_text(json.dumps({'kind':'template_build_only','solution_verdict':None,'libraries':rows},indent=2)+'\n')
  print(lib+': '+status+' (template only)',flush=True)
 return 0 if all(r['status']=='pass' for r in rows) else 1

if __name__=='__main__':raise SystemExit(main())
