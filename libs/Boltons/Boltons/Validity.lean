-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Boltons.Types

namespace Boltons

def LRUCache.Valid [BEq α] (c : LRUCache α β) : Prop :=
  c.data.length ≤ c.maxSize ∧ (c.data.map Prod.fst).Nodup

end Boltons
-- === END: FIXED_FINAL ===
