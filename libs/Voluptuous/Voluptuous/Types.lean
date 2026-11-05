-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Voluptuous

inductive Value where
  | null   : Value
  | bool   : Bool → Value
  | int    : Int → Value
  | float  : Float → Value
  | str    : String → Value
  | list   : List Value → Value
  | dict   : List (String × Value) → Value
  deriving Repr, BEq


structure Invalid where
  message : String
  path : List String
  deriving Repr, BEq


structure MultipleInvalid where
  errors : List Invalid
  deriving Repr

/-! ## Schema Definition -/


inductive ExtraKeys where
  | prevent : ExtraKeys
  | allow   : ExtraKeys
  | remove  : ExtraKeys
  deriving Repr, BEq, DecidableEq


inductive KeyRequirement where
  | required : KeyRequirement
  | optional (default : Option Value := none) : KeyRequirement
  deriving Repr


inductive SchemaNode where
  | literal (v : Value) : SchemaNode
  | typeCheck (typeName : String) (check : Value → Bool) : SchemaNode
  | coerce (typeName : String) (convert : Value → Option Value) : SchemaNode
  | all (validators : List SchemaNode) : SchemaNode
  | any (validators : List SchemaNode) : SchemaNode
  | range (min : Option Float) (max : Option Float) : SchemaNode
  | length (min : Option Nat) (max : Option Nat) : SchemaNode
  | matchRegex (pattern : String) : SchemaNode
  | listOf (elemSchema : SchemaNode) : SchemaNode
  | dictOf (keys : List (String × KeyRequirement × SchemaNode))
           (extra : ExtraKeys := .prevent) : SchemaNode
  | custom (name : String) (validate : Value → Option Value) : SchemaNode

/-! ## Infrastructure: isBoolean -/


end Voluptuous
-- === END: FIXED_FINAL ===
