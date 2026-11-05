-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Schedule.Helpers

namespace Schedule

/-! ## Core Function 1: Compute Next Run Time -/

def computeNextRun (j : Job) (refTime : Nat) : Nat :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def computeNextRun_postcond (j : Job) (refTime : Nat) (result : Nat) : Prop :=
  result = refTime + j.interval * unitMultiplier j.unit

theorem computeNextRun_spec (j : Job) (refTime : Nat) :
    computeNextRun_postcond j refTime (computeNextRun j refTime) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Schedule
-- === END: FIXED_FINAL ===
