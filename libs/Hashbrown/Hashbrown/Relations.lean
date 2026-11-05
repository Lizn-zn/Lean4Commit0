-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Hashbrown.Types
import Hashbrown.Insert
import Hashbrown.Get
import Hashbrown.Difference

namespace Hashbrown

/-! ## Relational: get after insert -/

@[reducible]
def HashMap.get_insert_rel [BEq α] [Hashable α] [LawfulBEq α]
    (m : HashMap α β) (k : α) (v : β) (get_result : Option β) : Prop :=
  get_result = some v

theorem HashMap.get_insert_spec [BEq α] [Hashable α] [LawfulBEq α]
    (m : HashMap α β) (k : α) (v : β) :
    HashMap.get_insert_rel m k v ((m.insert k v).get k) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Hashbrown
-- === END: FIXED_FINAL ===
