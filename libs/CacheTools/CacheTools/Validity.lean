-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import CacheTools.Types

namespace CacheTools

def LRUCache.Valid (c : LRUCache α β) : Prop :=
  c.data.length ≤ c.maxsize' ∧ (c.data.map Prod.fst).Nodup

def TTLCache.Valid (c : TTLCache α β) : Prop :=
  c.data.length ≤ c.maxsize' ∧ (c.data.map TTLEntry.key).Nodup

end CacheTools
-- === END: FIXED_FINAL ===
