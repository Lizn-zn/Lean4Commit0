-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Picocli

/-! ## Types -/

/-- The type of a command-line parameter value. -/
inductive ParamType where
  | bool : ParamType
  | string : ParamType
  | int : ParamType
  | float : ParamType
  | list : ParamType → ParamType
  deriving Repr, BEq

/-- A parsed parameter value. -/
inductive ParamValue where
  | boolVal : Bool → ParamValue
  | stringVal : String → ParamValue
  | intVal : Int → ParamValue
  | floatVal : Float → ParamValue
  | listVal : List ParamValue → ParamValue
  deriving Repr, BEq

/-- Arity specification: how many values an option accepts. -/
structure Arity where
  min : Nat
  max : Nat
  deriving Repr, BEq

/-- An option specification. -/
structure OptionSpec where
  shortName : Option Char := none
  longName : Option String := none
  description : String := ""
  paramType : ParamType := .string
  required : Bool := false
  defaultValue : Option ParamValue := none
  arity : Arity := { min := 1, max := 1 }
  hidden : Bool := false
  deriving Repr, BEq

/-- A positional parameter specification. -/
structure PositionalSpec where
  index : Nat
  description : String := ""
  paramType : ParamType := .string
  required : Bool := false
  defaultValue : Option ParamValue := none
  label : String := "PARAM"
  deriving Repr, BEq

/-- Mutual exclusion group: at most one option from the group can be specified. -/
structure MutualExclusion where
  optionNames : List String
  deriving Repr, BEq

/-- A command specification. -/
structure CommandSpec where
  name : String
  description : String := ""
  version : String := ""
  options : List OptionSpec := []
  positionals : List PositionalSpec := []
  subcommands : List CommandSpec := []
  mutualExclusions : List MutualExclusion := []
  deriving Repr, BEq

/-- A parse error. -/
inductive ParseError where
  | missingRequired : String → ParseError
  | unknownOption : String → ParseError
  | invalidValue : String → String → ParseError
  | tooManyArgs : List String → ParseError
  | mutualExclusionViolation : String → String → ParseError
  | missingSubcommand : ParseError
  deriving Repr, BEq

/-- A successful parse result. -/
structure ParseResult where
  matchedOptions : List (String × List ParamValue)
  matchedPositionals : List (Nat × ParamValue)
  subcommandResult : Option ParseResult := none
  unmatchedArgs : List String := []
  deriving Repr, BEq

end Picocli
-- === END: FIXED_FINAL ===
