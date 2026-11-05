-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Marshmallow

inductive Value where
  | null   : Value
  | bool   : Bool → Value
  | int    : Int → Value
  | float  : Float → Value
  | str    : String → Value
  | list   : List Value → Value
  | dict   : List (String × Value) → Value
  deriving Repr, BEq, Inhabited
/-- A validation error on a specific field. -/
structure FieldError where
  field : String
  messages : List String
  deriving Repr, BEq
/-- Collection of validation errors. -/
structure ValidationError where
  errors : List FieldError
  deriving Repr
/-- How to handle missing fields. -/
inductive MissingBehavior where
  | raise       : MissingBehavior
  | useDefault  : Value → MissingBehavior
  | exclude     : MissingBehavior
  deriving Repr, BEq
/-- Field metadata. -/
structure FieldMeta where
  name : String
  dataKey : Option String := none
  required : Bool := true
  allowNone : Bool := false
  missing : MissingBehavior := .raise
  dump : Bool := true
  load : Bool := true
  deriving Repr
/-- A field definition with type-specific validation and conversion. -/
inductive Field where
  | string   (fieldMeta : FieldMeta) : Field
  | integer  (fieldMeta : FieldMeta) (strict : Bool := false) : Field
  | float_   (fieldMeta : FieldMeta) (strict : Bool := false) : Field
  | boolean  (fieldMeta : FieldMeta) : Field
  | dateTime (fieldMeta : FieldMeta) (format : String := "iso") : Field
  | date     (fieldMeta : FieldMeta) (format : String := "iso") : Field
  | list     (fieldMeta : FieldMeta) (inner : Field) : Field
  | nested   (fieldMeta : FieldMeta) (schemaName : String) : Field
  | dict     (fieldMeta : FieldMeta) (keyField : Field) (valueField : Field) : Field
  | email    (fieldMeta : FieldMeta) : Field
  | url      (fieldMeta : FieldMeta) : Field
  | uuid     (fieldMeta : FieldMeta) : Field
  | enum_    (fieldMeta : FieldMeta) (values : List Value) : Field
  | constant (fieldMeta : FieldMeta) (value : Value) : Field
  | raw      (fieldMeta : FieldMeta) : Field
  | method   (fieldMeta : FieldMeta) (methodName : String) : Field
  deriving Repr
/-- Get the metadata from a field. -/
inductive UnknownFields where
  | raise   : UnknownFields
  | exclude : UnknownFields
  | include : UnknownFields
  deriving Repr, BEq
/-- Schema options. -/
structure SchemaOptions where
  unknown : UnknownFields := .raise
  ordered : Bool := false
  deriving Repr
/-- A schema defining how to serialize/deserialize an object. -/
structure Schema where
  name : String
  fields : List Field
  options : SchemaOptions := {}
  deriving Repr
/-- A registry that maps schema names to schemas. -/
structure SchemaRegistry where
  schemas : List (String × Schema)
  deriving Repr

end Marshmallow
-- === END: FIXED_FINAL ===
