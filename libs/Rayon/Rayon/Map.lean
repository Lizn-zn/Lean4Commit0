-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Rayon.Types
import Rayon.FromList
import Rayon.Collect

namespace Rayon


/-! ## ParIter.map -/

def ParIter.map (it : ParIter α) (f : α → β) : ParIter β :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def ParIter.map_postcond (it : ParIter α) (f : α → β) (result : ParIter β) : Prop :=
  result.data = it.data.map f


theorem ParIter.map_spec (it : ParIter α) (f : α → β) :
    ParIter.map_postcond it f (it.map f) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Rayon
-- === END: FIXED_FINAL ===
