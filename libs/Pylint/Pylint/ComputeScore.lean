-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Pylint.Types
import Pylint.CheckLineLength
import Pylint.RunChecker

namespace Pylint


/-! ## Core Function 3: Score Computation -/

/-- Compute the pylint score from message counts. -/
def computeScore (stmtCount : Nat) (errors warnings refactors conventions : Nat) : Float :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def computeScore_postcond (stmtCount : Nat) (errors warnings refactors conventions : Nat) (result : Float) : Prop :=
  result ≤ 10.0 ∧
  result ≥ 0.0 ∧
  (stmtCount = 0 → result = 0.0) ∧
  (stmtCount > 0 ∧ errors = 0 ∧ warnings = 0 ∧ refactors = 0 ∧ conventions = 0 → result = 10.0) ∧
  (stmtCount > 0 ∧ errors + warnings + refactors + conventions ≥ stmtCount → result = 0.0) ∧
  (stmtCount > 0 →
    result == (if errors + warnings + refactors + conventions ≥ stmtCount then 0.0 else max 0.0 (min 10.0
      (10.0 - 10.0 * Float.ofNat (errors + warnings + refactors + conventions) / Float.ofNat stmtCount))))


theorem computeScore_spec (stmtCount : Nat) (errors warnings refactors conventions : Nat) 
    (hstable : (Float.ofNat stmtCount).isFinite = true ∧
      (10.0 * Float.ofNat (errors + warnings + refactors + conventions)).isFinite = true) :
    computeScore_postcond stmtCount errors warnings refactors conventions
      (computeScore stmtCount errors warnings refactors conventions) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Pylint
-- === END: FIXED_FINAL ===
