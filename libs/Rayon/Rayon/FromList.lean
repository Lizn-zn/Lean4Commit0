-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Rayon.Types

namespace Rayon


/-- Convert a list to a parallel iterator. -/
def ParIter.fromList (xs : List α) : ParIter α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def ParIter.fromList_postcond (xs : List α) (result : ParIter α) : Prop :=
  result.data = xs


theorem ParIter.fromList_spec (xs : List α) :
    ParIter.fromList_postcond xs (ParIter.fromList xs) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Rayon
-- === END: FIXED_FINAL ===
