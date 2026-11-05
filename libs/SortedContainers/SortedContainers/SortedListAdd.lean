-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import SortedContainers.Types

namespace SortedContainers

/-! ## SortedList.add -/

def SortedList.add [Ord α] (sl : SortedList α) (v : α) : SortedList α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def SortedList.add_postcond [Ord α] [DecidableEq α] (sl : SortedList α) (v : α)
    (result : SortedList α) : Prop :=
  List.Pairwise (fun a b => Ord.compare a b ≠ .gt) result.data ∧
  result.data.length = sl.data.length + 1 ∧
  v ∈ result.data ∧
  (∀ w, w ∈ sl.data → w ∈ result.data) ∧
  (∀ w, result.data.count w = sl.data.count w + if w == v then 1 else 0)

theorem SortedList.add_spec [Ord α] [Std.TransOrd α] [Std.LawfulEqOrd α] [DecidableEq α] (sl : SortedList α) (v : α) :
    SortedList.add_postcond sl v (sl.add v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SortedContainers
-- === END: FIXED_FINAL ===
