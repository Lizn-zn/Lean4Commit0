-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Caffeine.CachePut
import Caffeine.Admit

namespace Caffeine

@[reducible]
def get_after_put_rel [BEq α] [LawfulBEq α] (cache : Cache α β) (k : α) (v : β)
    (result : Option β) : Prop :=
  cache.maxSize > 0 → result = some v

theorem get_after_put_spec [BEq α] [LawfulBEq α]
    (cache : Cache α β) (k : α) (v : β) :
    get_after_put_rel cache k v (Cache.get (Cache.put cache k v) k).2 := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Cache.put_preserves_other_rel [BEq α] [LawfulBEq α] (cache : Cache α β) (k k' : α) (v : β)
    (orig : Option β) (after : Option β) : Prop :=
  k ≠ k' → orig ≠ none → Cache.estimatedSize cache < cache.maxSize → after = orig

theorem Cache.put_preserves_other_spec [BEq α] [LawfulBEq α]
    (cache : Cache α β) (k k' : α) (v : β)
    (hne : k ≠ k') (hpresent : (Cache.get cache k').2 ≠ none)
    (hnotfull : Cache.estimatedSize cache < cache.maxSize) :
    Cache.put_preserves_other_rel cache k k' v
      (Cache.get cache k').2
      (Cache.get (Cache.put cache k v) k').2 := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Caffeine
-- === END: FIXED_FINAL ===
