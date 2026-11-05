-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import SortedContainers.Helpers
import SortedContainers.SortedListAdd
import SortedContainers.SortedDictSet
import SortedContainers.SortedSetAdd

namespace SortedContainers

/-! ## Relational Specs -/

@[reducible]
def SortedList.add_contains_rel [Ord α] [BEq α] (sl : SortedList α) (v : α)
    (addResult : SortedList α) (containsResult : Bool) : Prop :=
  containsResult = true

theorem SortedList.add_contains_rel_spec [Ord α] [Std.TransOrd α] [Std.LawfulEqOrd α] [BEq α] [LawfulBEq α] (sl : SortedList α) (v : α) :
    SortedList.add_contains_rel sl v (sl.add v) ((sl.add v).contains v) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def SortedDict.set_get_rel [Ord α] [BEq α] [LawfulBEq α] (d : SortedDict α β)
    (k : α) (v : β) (setResult : SortedDict α β) (getResult : Option β) : Prop :=
  getResult = some v

theorem SortedDict.set_get_rel_spec [Ord α] [Std.TransOrd α] [Std.LawfulEqOrd α] [BEq α] [LawfulBEq α]
    (d : SortedDict α β) (k : α) (v : β) :
    SortedDict.set_get_rel d k v (d.set k v) ((d.set k v).get k) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def SortedSet.add_contains_rel [Ord α] [BEq α] (s : SortedSet α) (v : α)
    (addResult : SortedSet α) (containsResult : Bool) : Prop :=
  containsResult = true

theorem SortedSet.add_contains_rel_spec [Ord α] [Std.TransOrd α] [Std.LawfulEqOrd α] [BEq α] [LawfulBEq α] (s : SortedSet α) (v : α) :
    SortedSet.add_contains_rel s v (s.add v) ((s.add v).contains v) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SortedContainers
-- === END: FIXED_FINAL ===
