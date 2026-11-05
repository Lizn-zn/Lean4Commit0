-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Immutables.Types
import Immutables.Helpers

namespace Immutables

/-! ## Core Function 1: ImmutableList.sorted -/

def ImmutableList.sorted [Ord α] (l : ImmutableList α) : ImmutableList α := 
                                                                            
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                            sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def ImmutableList.sorted_postcond [Ord α] (l : ImmutableList α) (result : ImmutableList α) : Prop :=
  result.data.length = l.data.length ∧
  (∀ x, x ∈ result.data ↔ x ∈ l.data) ∧
  List.Pairwise (fun a b => Ord.compare a b ≠ .gt) result.data

theorem ImmutableList.sorted_spec [Ord α] [Std.TransOrd α] [Std.LawfulEqOrd α] (l : ImmutableList α) :
    ImmutableList.sorted_postcond l (l.sorted) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Immutables
-- === END: FIXED_FINAL ===
