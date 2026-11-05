-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Orjson.Dumps
import Orjson.Loads

namespace Orjson

/-! ## Relational: loads/dumps roundtrip -/

@[reducible]
def loads_dumps_roundtrip_rel (v : JsonValue) (result : Option JsonValue) : Prop :=
  result = some v

theorem loads_dumps_roundtrip_spec (v : JsonValue) :
    loads_dumps_roundtrip_rel v (loads (dumps v)) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Orjson
-- === END: FIXED_FINAL ===
