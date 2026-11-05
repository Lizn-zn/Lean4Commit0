-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Boltons.Validity
import Std
import Lean

import Boltons.Types

namespace Boltons

/-! ## cacheutils.LRUCache.get -/

def LRUCache.get [BEq α] (c : LRUCache α β) (k : α) : LRUCache α β × Option β :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def LRUCache.get_postcond [BEq α] [LawfulBEq α] (c : LRUCache α β) (k : α)
    (result : LRUCache α β × Option β) : Prop :=
  (∀ v, result.2 = some v → (k, v) ∈ c.data) ∧
  (result.2 = none → ∀ v, (k, v) ∉ c.data) ∧
  result.1.maxSize = c.maxSize ∧
  result.1.data.length = c.data.length

theorem LRUCache.get_spec [BEq α] [LawfulBEq α] (c : LRUCache α β) (k : α) 
    (hvalid : LRUCache.Valid c) :
    LRUCache.get_postcond c k (c.get k) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Boltons
-- === END: FIXED_FINAL ===
