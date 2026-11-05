-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import DashMap.Helpers
import DashMap.Insert
import DashMap.Get
import DashMap.Remove

namespace DashMap

/-! ## Relational: get after insert -/

@[reducible]
def get_insert_rel [BEq α] [LawfulBEq α] (m : DashMap α β) (k : α) (v : β) (result : Option β) : Prop :=
  result = some v

theorem get_insert_spec [BEq α] [LawfulBEq α] (m : DashMap α β) (k : α) (v : β) :
    get_insert_rel m k v ((m.insert k v).get k) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-- Inserting k v then getting a different key k' returns the same as before insert. -/
@[reducible]
def get_insert_other_rel [BEq α] [LawfulBEq α] (m : DashMap α β) (k k' : α) (v : β) (result : Option β) : Prop :=
  (k == k') = false → result = m.get k'

theorem get_insert_other_spec [BEq α] [LawfulBEq α] (m : DashMap α β) (k k' : α) (v : β)
    (h : (k == k') = false) :
    get_insert_other_rel m k k' v ((m.insert k v).get k') := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Relational: get after remove -/

@[reducible]
def get_remove_rel [BEq α] [LawfulBEq α] (m : DashMap α β) (k : α) (result : Option β) : Prop :=
  result = none

theorem get_remove_spec [BEq α] [LawfulBEq α] (m : DashMap α β) (k : α) :
    get_remove_rel m k ((m.remove k).1.get k) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



/-- Removing k then getting a different key k' returns the same as before remove. -/
@[reducible]
def get_remove_other_rel [BEq α] [LawfulBEq α] (m : DashMap α β) (k k' : α) (result : Option β) : Prop :=
  (k == k') = false → result = m.get k'

theorem get_remove_other_spec [BEq α] [LawfulBEq α] (m : DashMap α β) (k k' : α)
    (h : (k == k') = false) :
    get_remove_other_rel m k k' ((m.remove k).1.get k') := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end DashMap
-- === END: FIXED_FINAL ===
