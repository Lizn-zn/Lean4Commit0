-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Rayon.Types
import Rayon.FromList

namespace Rayon


/-- Collect results back to a list. -/
def ParIter.collect (it : ParIter α) : List α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def ParIter.collect_postcond (it : ParIter α) (result : List α) : Prop :=
  result = it.data


theorem ParIter.collect_spec (it : ParIter α) :
    ParIter.collect_postcond it (it.collect) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Rayon
-- === END: FIXED_FINAL ===
