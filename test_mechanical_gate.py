"""Integration/regression tests for mechanical screening; no benchmark solutions."""
import hashlib,importlib.util,json,os,subprocess,sys,tempfile,unittest
from pathlib import Path
from check_solution import skeleton_parts,region_spans
from lean_lex import scrub

ROOT=Path(__file__).resolve().parent
TEMPLATE='''-- === BEGIN: SPEC (provided) ===
theorem toy : True := by
-- === END: SPEC ===
-- === BEGIN: BODY (editable) ===
  sorry
-- === END: BODY ===
'''

class GateTests(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  cls.audit_tmp=tempfile.TemporaryDirectory(prefix='benchmark-type-fixture-');root=Path(cls.audit_tmp.name)
  lib=root/'libs/Toy';lib.mkdir(parents=True)
  (root/'lakefile.toml').write_text('name = "toy"\n[[lean_lib]]\nname = "Toy"\nsrcDir = "libs/Toy"\n')
  (root/'lean-toolchain').write_text('leanprover/lean4:v4.28.0\n');(lib/'Toy.lean').write_text(TEMPLATE)
  build=subprocess.run(['lake','build','Toy'],cwd=root,capture_output=True,text=True);assert build.returncode==0,build.stdout+build.stderr
  names=root/'names.txt';report=root/'audit.json';names.write_text('toy\n')
  audit=subprocess.run(['lake','env','lean','--run',str(ROOT/'tools/AuditDeclarations.lean'),'Toy',str(names),str(report)],cwd=root,capture_output=True,text=True);assert audit.returncode==0,audit.stdout+audit.stderr
  cls.toy_type=hashlib.sha256(json.loads(report.read_text())['declarations'][0]['type'].encode()).hexdigest()
 @classmethod
 def tearDownClass(cls):cls.audit_tmp.cleanup()
 def setUp(self):
  self.tmp=tempfile.TemporaryDirectory(prefix='benchmark-gate-test-');self.root=Path(self.tmp.name)
  self.lib=self.root/'libs/Toy';self.lib.mkdir(parents=True)
  (self.root/'lakefile.toml').write_text('name = "toy"\n[[lean_lib]]\nname = "Toy"\nsrcDir = "libs/Toy"\n')
  (self.root/'lean-toolchain').write_text('leanprover/lean4:v4.28.0\n')
  (self.lib/'.provided_hash').write_text('trusted-test-marker\n');self.source=self.lib/'Toy.lean';self.source.write_text(TEMPLATE)
  self.baseline=self.root/'INTEGRITY_BASELINE.json';self.make_baseline(TEMPLATE)
 def tearDown(self):self.tmp.cleanup()
 def make_baseline(self,text,provided=None,unmarked=None):
  d={'locked_files':{name:hashlib.sha256((self.root/name).read_bytes()).hexdigest() for name in ['lakefile.toml','lean-toolchain']},'libraries':{'Toy':{'files':{'libs/Toy/Toy.lean':skeleton_parts(text)},
    'provided_holes':provided or [],'unmarked_holes':unmarked or [],'declaration_types':{'toy':self.toy_type},
    'legacy_hash_sha256':hashlib.sha256((self.lib/'.provided_hash').read_bytes()).hexdigest()}}}
  self.baseline.write_text(json.dumps(d))
 def run_gate(self,*args):
  return subprocess.run([sys.executable,str(ROOT/'check_solution.py'),'--root',str(self.root),'--library','Toy',*args],capture_output=True,text=True)
 def test_unsolved_template_rejected(self):
  r=self.run_gate();self.assertNotEqual(r.returncode,0);self.assertIn('unresolved proof hole',r.stderr)
 def test_solved_fixture_compiles(self):
  self.source.write_text(TEMPLATE.replace('  sorry','  trivial -- sorry in a comment is harmless'))
  r=self.run_gate();self.assertEqual(r.returncode,0,r.stdout+r.stderr);self.assertIn('library contract verification',r.stdout)
 def test_mechanical_mode_is_explicit(self):
  self.source.write_text(TEMPLATE.replace('  sorry','  trivial'))
  r=self.run_gate('--mechanical-only');self.assertEqual(r.returncode,0,r.stdout+r.stderr);self.assertIn('no contract verdict',r.stdout)
 def test_quoted_sorryax_rejected(self):
  self.source.write_text(TEMPLATE.replace('  sorry','  exact «sorryAx» True true'))
  r=self.run_gate('--scan-only');self.assertNotEqual(r.returncode,0);self.assertIn('unresolved proof hole',r.stderr)
 def test_interpolation_rejected(self):
  self.source.write_text(TEMPLATE.replace('  sorry','  let x := s!"{sorryAx Nat true}"\n  trivial'))
  r=self.run_gate('--scan-only');self.assertNotEqual(r.returncode,0);self.assertIn('interpolated string',r.stderr)
 def test_cross_boundary_comment_rejected(self):
  template='''def x : Nat :=
-- === BEGIN: X (editable) ===
  sorry
-- === END: X ===
theorem required : x = 1 := by
-- === BEGIN: PROOF (editable) ===
  sorry
-- === END: PROOF ===
'''
  self.make_baseline(template)
  self.source.write_text(template.replace('  sorry','  0 /-',1).replace('  sorry','-/\n'))
  r=self.run_gate('--scan-only');self.assertNotEqual(r.returncode,0);self.assertIn('crosses editable/protected boundary',r.stderr)
 def test_missing_required_declaration_rejected_by_compiler_audit(self):
  template="""def value : Nat :=
-- === BEGIN: VALUE (editable) ===
  sorry
-- === END: VALUE ===
theorem toy : True := by
-- === BEGIN: PROOF (editable) ===
  sorry
-- === END: PROOF ===
"""
  self.make_baseline(template)
  self.source.write_text(template.replace('  sorry','  0\nnamespace Hidden',1).replace('  sorry','  trivial\nend Hidden',1))
  result=self.run_gate();self.assertNotEqual(result.returncode,0,result.stdout+result.stderr);self.assertIn('required declaration missing',result.stderr)
 def test_changed_required_type_rejected_by_compiler_audit(self):
  template="""def value : Nat :=
-- === BEGIN: VALUE (editable) ===
  sorry
-- === END: VALUE ===
theorem toy : True := by
-- === BEGIN: PROOF (editable) ===
  sorry
-- === END: PROOF ===
"""
  self.make_baseline(template)
  self.source.write_text(template.replace('  sorry','  0\nlocal notation "True" => (1 = 1)',1).replace('  sorry','  rfl',1))
  result=self.run_gate();self.assertNotEqual(result.returncode,0,result.stdout+result.stderr);self.assertIn('required trusted type changed',result.stderr)
 def test_forged_build_cache_ignored(self):
  self.source.write_text(TEMPLATE.replace('  sorry','  trivial'))
  cache=self.root/'.lake/build/lib/lean';cache.mkdir(parents=True);(cache/'Toy.olean').write_bytes(b'forged compiler object')
  result=self.run_gate();self.assertEqual(result.returncode,0,result.stdout+result.stderr)
 def test_import_region_rejects_commands(self):
  text='-- === BEGIN: PROOF_IMPORTS (editable) ===\n\n-- === END: PROOF_IMPORTS ===\n'+TEMPLATE
  self.make_baseline(text);self.source.write_text(text.replace('(editable) ===\n\n','(editable) ===\nnamespace Hidden\n',1).replace('  sorry','  trivial'))
  result=self.run_gate('--scan-only');self.assertNotEqual(result.returncode,0);self.assertIn('proof-import region',result.stderr)
 def test_auditor_reports_unused_module_axiom(self):
  self.source.write_text(TEMPLATE.replace('  sorry','  trivial')+'\naxiom unusedBad : False\n')
  build=subprocess.run(['lake','build','Toy'],cwd=self.root,capture_output=True,text=True);self.assertEqual(build.returncode,0,build.stdout+build.stderr)
  names=self.root/'required.txt';report=self.root/'raw-audit.json';names.write_text('toy\n')
  result=subprocess.run(['lake','env','lean','--run',str(ROOT/'tools/AuditDeclarations.lean'),'Toy',str(names),str(report)],cwd=self.root,capture_output=True,text=True)
  self.assertEqual(result.returncode,0,result.stdout+result.stderr)
  payload=json.loads(report.read_text());self.assertIn('unusedBad',payload['module_axioms']);self.assertEqual(payload['declarations'][0]['name'],'toy');self.assertIsNone(payload['declarations'][0]['axioms'])
 def test_protected_spec_tamper_rejected(self):
  self.source.write_text(TEMPLATE.replace(': True',': False').replace('  sorry','  trivial'))
  r=self.run_gate();self.assertNotEqual(r.returncode,0);self.assertIn('protected source',r.stderr)
 def test_unmarked_nonhole_spec_tamper_rejected(self):
  baseline='def fixedValue : Nat := 1\n'+TEMPLATE;self.make_baseline(baseline)
  self.source.write_text(baseline.replace(':= 1',':= 2').replace('  sorry','  trivial'))
  self.assertNotEqual(self.run_gate().returncode,0)
 def test_missing_trusted_baseline_rejected(self):
  self.baseline.unlink();self.assertNotEqual(self.run_gate('--integrity-only').returncode,0)
 def test_missing_legacy_marker_rejected(self):
  (self.lib/'.provided_hash').unlink();self.assertNotEqual(self.run_gate('--integrity-only').returncode,0)
 def test_new_custom_axiom_rejected(self):
  self.source.write_text(TEMPLATE.replace('  sorry','  trivial'))
  (self.lib/'Extra.lean').write_text('axiom bad : False\n')
  r=self.run_gate('--scan-only');self.assertNotEqual(r.returncode,0);self.assertIn('custom axiom',r.stderr)
 def test_provided_hole_is_immutable_and_not_solved(self):
  s='-- === BEGIN: GIVEN (provided) ===\ndef given : Nat := sorry\n-- === END: GIVEN ===\n'+TEMPLATE
  self.make_baseline(s,provided=[{'file':'libs/Toy/Toy.lean','line':2}]);self.source.write_text(s.replace('  sorry','  trivial'))
  self.assertEqual(self.run_gate('--integrity-only').returncode,0)
  r=self.run_gate();self.assertNotEqual(r.returncode,0);self.assertIn('task-boundary policy unresolved',r.stderr)
  self.source.write_text(self.source.read_text().replace(':= sorry',':= 0'));self.assertNotEqual(self.run_gate('--integrity-only').returncode,0)
 def test_unmarked_hole_requires_policy(self):
  s='def helper : Nat := sorry\n'+TEMPLATE;self.make_baseline(s,unmarked=[{'file':'libs/Toy/Toy.lean','line':1}]);self.source.write_text(s)
  r=self.run_gate();self.assertNotEqual(r.returncode,0);self.assertIn('task-boundary policy unresolved',r.stderr)
 def test_literal_and_nested_comment_screening(self):
  text='def quote : Char := \'"\'\n/- sorry /- sorry -/ -/\ndef text := "sorry"\ntheorem test : True := by sorry\n'
  import re
  self.assertEqual(len(re.findall(r'\bsorry\b',scrub(text))),1)

if __name__=='__main__':unittest.main()
