-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Rayon.Types
import Rayon.FromList
import Rayon.Collect
import Rayon.Map

namespace Rayon


/-! ## ParIter.reduce -/

/-- Parallel reduce with an associative operation. -/
def ParIter.reduce (it : ParIter α) (identity : α) (f : α → α → α) : α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def ParIter.reduce_postcond (it : ParIter α) (identity : α) (f : α → α → α) (result : α) : Prop :=
  result = it.data.foldl f identity


theorem ParIter.reduce_spec (it : ParIter α) (identity : α) (f : α → α → α) :
    ParIter.reduce_postcond it identity f (it.reduce identity f) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Rayon
-- === END: FIXED_FINAL ===
