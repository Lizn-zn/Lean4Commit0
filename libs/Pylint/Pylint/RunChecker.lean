-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Pylint.Types
import Pylint.CheckLineLength

namespace Pylint


/-! ## Core Function 2: Run Checker -/

/-- Run a checker on a module, visiting all statements. -/
def runChecker (checker : CheckerDef) (mod : Module) : List Message :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def runChecker_postcond (checker : CheckerDef) (mod : Module) (result : List Message) : Prop :=
  (mod.body = [] → result = []) ∧
  (∀ m ∈ result, m.filePath = mod.filePath) ∧
  (∀ stmt ∈ mod.body,
    ((checker.visitFn {moduleName := mod.name, filePath := mod.filePath, parentStmt := none} stmt).all
      (fun m => result.any (· == m))) = true)


theorem runChecker_spec (checker : CheckerDef) (mod : Module) 
    (hcallback : ∀ stmt ∈ mod.body, ∀ msg ∈ checker.visitFn
      {moduleName := mod.name, filePath := mod.filePath, parentStmt := none} stmt,
      msg.filePath = mod.filePath) :
    runChecker_postcond checker mod (runChecker checker mod) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Pylint
-- === END: FIXED_FINAL ===
