-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # Serde
   A generic serialization/deserialization framework.

   Summarized from the full spec to 3 core functions: serializeOption,
   deserializeOption, renameField.
   Original: https://github.com/serde-rs/serde
-/

namespace Serde

/-! ## Serde Data Model -/

/-- The universal Serde data model value. -/
inductive Value where
  | bool      : Bool → Value
  | int       : Int → Value
  | float     : Float → Value
  | char      : Char → Value
  | string    : String → Value
  | bytes     : List UInt8 → Value
  | none      : Value
  | some      : Value → Value
  | unit      : Value
  | seq       : List Value → Value
  | map       : List (Value × Value) → Value
  | newtype   : String → Value → Value
  | struct    : String → List (String × Value) → Value
  | enum      : String → String → Option Value → Value
  deriving Repr, BEq, Inhabited

/-! ## Serialize / Deserialize Type Classes -/

/-- Serialize a value of type `α` into the Serde data model. -/
class Serialize (α : Type) where
  serialize : α → Value

/-- Deserialize from the Serde data model into type `α`. -/
class Deserialize (α : Type) where
  deserialize : Value → Option α

/-! ## Primitive Serialize Instances -/

instance : Serialize Bool where
  serialize b := Value.bool b

instance : Serialize Int where
  serialize n := Value.int n

instance : Serialize Float where
  serialize f := Value.float f

instance : Serialize String where
  serialize s := Value.string s

instance : Serialize Char where
  serialize c := Value.char c

end Serde
-- === END: FIXED_FINAL ===
