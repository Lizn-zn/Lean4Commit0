-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Pydantic


/-! ## Value Type -/

/-- A dynamically typed value (JSON-compatible). -/
inductive Value where
  | null   : Value
  | bool   : Bool → Value
  | int    : Int → Value
  | float  : Float → Value
  | str    : String → Value
  | list   : List Value → Value
  | dict   : List (String × Value) → Value
  deriving Repr, BEq, Inhabited


/-! ## Constraints -/

/-- Constraints on a type. -/
inductive Constraint where
  | minLength  : Nat → Constraint
  | maxLength  : Nat → Constraint
  | pattern    : String → Constraint
  | gt         : Float → Constraint
  | ge         : Float → Constraint
  | lt         : Float → Constraint
  | le         : Float → Constraint
  | multipleOf : Float → Constraint
  | minItems   : Nat → Constraint
  | maxItems   : Nat → Constraint
  | unique     : Constraint
  deriving Repr, BEq


/-! ## Type Descriptors -/

/-- Describes the expected type of a field for validation. -/
inductive TypeDesc where
  | any        : TypeDesc
  | str        : TypeDesc
  | int        : TypeDesc
  | float      : TypeDesc
  | bool       : TypeDesc
  | bytes      : TypeDesc
  | none_      : TypeDesc
  | literal    : List Value → TypeDesc
  | optional   : TypeDesc → TypeDesc
  | list       : TypeDesc → TypeDesc
  | set        : TypeDesc → TypeDesc
  | dict       : TypeDesc → TypeDesc → TypeDesc
  | tuple      : List TypeDesc → TypeDesc
  | union      : List TypeDesc → TypeDesc
  | model      : String → TypeDesc
  | constrained : TypeDesc → List Constraint → TypeDesc
  deriving Repr


/-! ## Field Definition -/

/-- Field configuration. -/
structure FieldInfo where
  name : String
  typeDesc : TypeDesc
  default : Option Value := none
  defaultFactory : Option (Unit → Value) := none
  alias_ : Option String := none
  validationAlias : Option String := none
  title : Option String := none
  description : Option String := none
  frozen : Bool := false
  exclude : Bool := false
  deprecated : Bool := false
  constraints : List Constraint := []

instance : Repr FieldInfo where
  reprPrec f _ := s!"FieldInfo(name={repr f.name}, typeDesc={repr f.typeDesc})"


/-! ## Validation Errors -/

/-- A single validation error. -/
structure ValidationErrorItem where
  loc : List String
  msg : String
  input : Option Value := none
  deriving Repr, BEq


/-- Collection of validation errors. -/
structure ValidationError where
  errors : List ValidationErrorItem
  modelName : String
  deriving Repr


/-! ## Model Definition -/

/-- Extra fields handling mode. -/
inductive ExtraMode where
  | allow   : ExtraMode
  | forbid  : ExtraMode
  | ignore  : ExtraMode
  deriving Repr, BEq


/-- Model configuration. -/
structure ModelConfig where
  title : Option String := none
  frozen : Bool := false
  extra : ExtraMode := .ignore
  populateByName : Bool := false
  validateDefault : Bool := false
  useEnumValues : Bool := false
  strict : Bool := false
  deriving Repr


/-- When to run a validator. -/
inductive ValidatorMode where
  | before : ValidatorMode
  | after  : ValidatorMode
  | wrap   : ValidatorMode
  deriving Repr, BEq


/-- A model-level validator. -/
structure ModelValidator where
  name : String
  validate : Value → Except String Value
  mode : ValidatorMode := .after

instance : Repr ModelValidator where
  reprPrec v _ := s!"ModelValidator(name={repr v.name}, mode={repr v.mode})"


/-- A model definition (analogous to a class inheriting BaseModel). -/
structure ModelDef where
  name : String
  fields : List FieldInfo
  config : ModelConfig := {}
  validators : List ModelValidator := []
  deriving Repr


/-- An instance of a model. -/
structure ModelInstance where
  modelDef : ModelDef
  data : List (String × Value)
  extraData : List (String × Value) := []
  deriving Repr

end Pydantic
-- === END: FIXED_FINAL ===
