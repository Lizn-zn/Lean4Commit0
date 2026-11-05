-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Click

/-! ## Types -/

/-- Parameter types for CLI options and arguments -/
inductive ParamType where
  | STRING     : ParamType
  | INT        : ParamType
  | FLOAT      : ParamType
  | BOOL       : ParamType
  | Choice     : List String → ParamType
  | Path       : (exists_ : Option Bool) → (fileOkay : Bool) → (dirOkay : Bool) → ParamType
  | File       : (mode : String) → ParamType
  | IntRange   : (min : Option Int) → (max : Option Int) → (clamp : Bool) → ParamType
  | FloatRange : (min : Option Float) → (max : Option Float) → (clamp : Bool) → ParamType
  | UUID       : ParamType
  | Tuple      : List ParamType → ParamType
  deriving Repr, BEq

/-- A parsed parameter value -/
inductive ParamValue where
  | str     : String → ParamValue
  | int     : Int → ParamValue
  | float   : Float → ParamValue
  | bool    : Bool → ParamValue
  | list    : List ParamValue → ParamValue
  | tuple   : List ParamValue → ParamValue
  | none    : ParamValue
  deriving Repr, BEq

/-- Source from which a parameter value was resolved -/
inductive ParameterSource where
  | environment    : ParameterSource
  | defaultValue   : ParameterSource
  | prompt         : ParameterSource
  | commandLine    : ParameterSource
  deriving Repr, BEq

/-- Definition of a CLI option -/
structure OptionDef where
  name       : String
  paramType  : ParamType
  default    : Option ParamValue
  required   : Bool
  help       : String
  multiple   : Bool
  isFlag     : Bool
  envVar     : Option String
  hidden     : Bool
  showDefault : Bool
  nargs      : Nat
  shortName  : Option Char
  deriving Repr, BEq

/-- Definition of a CLI argument -/
structure ArgumentDef where
  name      : String
  paramType : ParamType
  required  : Bool
  nargs     : Int
  default   : Option ParamValue
  envVar    : Option String
  deriving Repr, BEq

/-- A resolved parameter with its source -/
structure ResolvedParam where
  name   : String
  value  : ParamValue
  source : ParameterSource
  deriving Repr, BEq

/-- A CLI command definition -/
structure Command where
  name           : String
  help           : String
  epilog         : String
  shortHelp      : String
  options        : List OptionDef
  arguments      : List ArgumentDef
  hidden         : Bool
  deprecated     : Bool
  addHelpOption  : Bool
  noArgsIsHelp   : Bool
  deriving Repr, BEq

end Click
-- === END: FIXED_FINAL ===
