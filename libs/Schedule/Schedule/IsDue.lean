-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Schedule.Types

namespace Schedule

/-! ## Core Function 2: Is Job Due -/

def isDue (j : Job) (now : Nat) : Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def isDue_postcond (j : Job) (now : Nat) (result : Bool) : Prop :=
  (result = true ↔ now ≥ j.nextRun)

theorem isDue_spec (j : Job) (now : Nat) :
    isDue_postcond j now (isDue j now) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Schedule
-- === END: FIXED_FINAL ===
