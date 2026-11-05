-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Caffeine.CacheGet

namespace Caffeine

def Cache.put [BEq α] (cache : Cache α β) (key : α) (value : β) : Cache α β :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Cache.put_postcond [BEq α] (cache : Cache α β) (key : α) (value : β) (result : Cache α β) : Prop :=
  Cache.estimatedSize result ≤ cache.maxSize ∧
  (cache.maxSize > 0 → (Cache.get result key).2 = some value)

theorem Cache.put_spec [BEq α] [LawfulBEq α] (cache : Cache α β) (key : α) (value : β) :
    Cache.put_postcond cache key value (Cache.put cache key value) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Caffeine
-- === END: FIXED_FINAL ===
