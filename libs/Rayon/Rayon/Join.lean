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
import Rayon.Reduce

namespace Rayon


/-! ## join -/

/-- Execute two closures in parallel and return both results. -/
def join (f : Unit → α) (g : Unit → β) : α × β :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def join_postcond (f : Unit → α) (g : Unit → β) (result : α × β) : Prop :=
  result = (f (), g ())


theorem join_spec (f : Unit → α) (g : Unit → β) :
    join_postcond f g (join f g) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Rayon
-- === END: FIXED_FINAL ===
