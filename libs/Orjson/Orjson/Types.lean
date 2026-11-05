-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Orjson

/-! ## Types -/

/-- A JSON value. -/
inductive JsonValue where
  | null   : JsonValue
  | bool   : Bool → JsonValue
  | int    : Int → JsonValue
  | float  : Float → JsonValue
  | str    : String → JsonValue
  | array  : List JsonValue → JsonValue
  | object : List (String × JsonValue) → JsonValue
  deriving Repr, BEq, Inhabited

end Orjson
-- === END: FIXED_FINAL ===
