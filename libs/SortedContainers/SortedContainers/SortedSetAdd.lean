-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import SortedContainers.Types

namespace SortedContainers

/-! ## SortedSet.add -/

def SortedSet.add [Ord α] [BEq α] (s : SortedSet α) (v : α) : SortedSet α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def SortedSet.add_postcond [Ord α] [BEq α] (s : SortedSet α) (v : α)
    (result : SortedSet α) : Prop :=
  List.Pairwise (fun a b => Ord.compare a b ≠ .gt) result.data ∧
  v ∈ result.data ∧
  result.data.Nodup ∧
  (v ∈ s.data → result.data.length = s.data.length) ∧
  (¬ v ∈ s.data → result.data.length = s.data.length + 1) ∧
  (∀ w, w ∈ s.data → w ∈ result.data)

theorem SortedSet.add_spec [Ord α] [Std.TransOrd α] [Std.LawfulEqOrd α] [BEq α] [LawfulBEq α] (s : SortedSet α) (v : α) 
    (hvalid : s.data.Nodup) :
    SortedSet.add_postcond s v (s.add v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SortedContainers
-- === END: FIXED_FINAL ===
