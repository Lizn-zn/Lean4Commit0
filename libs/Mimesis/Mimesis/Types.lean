-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Mimesis

/-! ## Types -/

/-- A pure pseudo-random number generator state. -/
structure PrngState where
  seed : Nat
  deriving Repr, BEq

/-- Supported locales for data generation. -/
inductive MimesisLocale where
  | en | de | fr | es | it | pt | ru | ja | ko | zh | uk | pl | nl | sv | da
  deriving Repr, BEq, DecidableEq

/-- Gender for person data. -/
inductive Gender where
  | male   : Gender
  | female : Gender
  deriving Repr, BEq, DecidableEq

/-- Person data. -/
structure PersonData where
  firstName  : String
  lastName   : String
  fullName   : String
  gender     : Gender
  age        : Nat
  email      : String
  phone      : String
  username   : String
  deriving Repr, BEq

/-- Schema field definition. -/
inductive FieldType where
  | firstName    : FieldType
  | lastName     : FieldType
  | fullName     : FieldType
  | email        : FieldType
  | phone        : FieldType
  | address      : FieldType
  | city         : FieldType
  | country      : FieldType
  | postalCode   : FieldType
  | text         : Nat → FieldType
  | integer      : Int → Int → FieldType
  | floatField   : Float → Float → FieldType
  | boolean      : FieldType
  | date         : FieldType
  | uuid         : FieldType
  | ipv4         : FieldType
  | url          : FieldType
  | username     : FieldType
  | password     : Nat → FieldType
  | choice       : List String → FieldType
  deriving Repr, BEq

/-- A schema definition for structured data generation. -/
structure Schema where
  fields : List (String × FieldType)
  deriving Repr, BEq

/-- A generated data row (field name → value). -/
abbrev DataRow := List (String × String)

end Mimesis
-- === END: FIXED_FINAL ===
