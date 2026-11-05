-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace RapidJson


/-! ## Value Type -/

inductive Value where
  | null   : Value
  | bool   : Bool → Value
  | int    : Int → Value
  | uint   : Nat → Value
  | double : Float → Value
  | string : String → Value
  | array  : List Value → Value
  | object : List (String × Value) → Value
  deriving Repr, BEq, Inhabited


/-! ## Schema Type -/

inductive SchemaType where
  | any     : SchemaType
  | null    : SchemaType
  | boolean : SchemaType
  | integer : (min : Option Int) → (max : Option Int) → SchemaType
  | number  : (min : Option Float) → (max : Option Float) → SchemaType
  | string  : (minLen : Option Nat) → (maxLen : Option Nat) → (pattern : Option String) → SchemaType
  | array   : (items : Option SchemaType) → (minItems : Option Nat) → (maxItems : Option Nat) → SchemaType
  | object  : (required : List String) → (properties : List (String × SchemaType)) → SchemaType
  | oneOf   : List SchemaType → SchemaType
  | enum    : List Value → SchemaType
  deriving Repr, BEq

end RapidJson
-- === END: FIXED_FINAL ===
