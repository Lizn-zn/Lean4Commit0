-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import RapidJson.Types
import RapidJson.Parse
import RapidJson.Serialize
import RapidJson.Validate

namespace RapidJson


/-! ## Relational: parse and serialize roundtrip -/

@[reducible]
def parse_serialize_rel (v : Value) (serialized : String) (parsed : Option Value) : Prop :=
  let vnorm :=
    match v with
    | Value.int n =>
        if n < 0 then Value.int n else Value.uint n.toNat
    | _ => v
  parsed = some vnorm


theorem parse_serialize_spec (v : Value) :
    parse_serialize_rel v (serialize v) (parse (serialize v)) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end RapidJson
-- === END: FIXED_FINAL ===
