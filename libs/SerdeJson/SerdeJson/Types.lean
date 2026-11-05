-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # SerdeJson
   JSON serialization/deserialization.

   Summarized from the full spec to 3 core functions: toStringCompact, parse, pointer.
   Original: https://github.com/serde-rs/json
-/

namespace SerdeJson

/-! ## JSON Value -/

/-- A JSON value (RFC 8259). -/
inductive JsonValue where
  | null   : JsonValue
  | bool   : Bool → JsonValue
  | number : Float → JsonValue
  | string : String → JsonValue
  | array  : List JsonValue → JsonValue
  | object : List (String × JsonValue) → JsonValue
  deriving Repr, BEq, Inhabited

end SerdeJson
-- === END: FIXED_FINAL ===
