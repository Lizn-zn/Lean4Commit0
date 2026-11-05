-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Boltons.Validity
import Std
import Lean

import Boltons.CacheGet

namespace Boltons

/-! ## cacheutils.LRUCache.put -/

def LRUCache.put [BEq α] (c : LRUCache α β) (k : α) (v : β) : LRUCache α β :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def LRUCache.put_postcond [BEq α] [LawfulBEq α] (c : LRUCache α β) (k : α) (v : β)
    (result : LRUCache α β) : Prop :=
  (k, v) ∈ result.data ∧
  result.data.length ≤ max c.maxSize 1 ∧
  result.maxSize = c.maxSize ∧
  (c.data.length < c.maxSize →
    ∀ k' v', (k', v') ∈ c.data → k' ≠ k → (k', v') ∈ result.data) ∧
  ((c.data.any (fun p => p.1 == k)) = true →
    result.data.length = c.data.length) ∧
  ((c.data.any (fun p => p.1 == k)) = false →
    result.data.length = Nat.min (c.data.length + 1) (Nat.max c.maxSize 1))

theorem LRUCache.put_spec [BEq α] [LawfulBEq α] (c : LRUCache α β) (k : α) (v : β) 
    (hvalid : LRUCache.Valid c) :
    LRUCache.put_postcond c k v (c.put k v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Boltons
-- === END: FIXED_FINAL ===
