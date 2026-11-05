-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Clap

/-! ## Types -/

/-- Value type for an argument. -/
inductive ArgValue where
  | string : String → ArgValue
  | flag   : Bool → ArgValue
  | list   : List String → ArgValue
  deriving Repr, BEq

/-- Number of values an argument accepts. -/
inductive NumArgs where
  | zero    : NumArgs
  | one     : NumArgs
  | many    : NumArgs
  | range   : Nat → Nat → NumArgs
  deriving Repr, BEq

/-- An argument definition. -/
structure Arg where
  name         : String
  short        : Option Char
  long         : Option String
  help         : String
  required     : Bool := false
  defaultValue : Option String := none
  numArgs      : NumArgs := .one
  possibleValues : List String := []
  conflicts    : List String := []
  requires_    : List String := []
  deriving Repr, BEq

/-- A command definition (can have subcommands). -/
structure Command where
  name         : String
  about        : String := ""
  version      : String := ""
  args         : List Arg := []
  subcommands  : List Command := []
  deriving Repr, BEq

/-- Parsed argument result. -/
structure ArgMatches where
  values       : List (String × ArgValue)
  subcommand   : Option (String × ArgMatches)
  deriving Repr, BEq

/-- Parse error types. -/
inductive ParseError where
  | missingRequired : String → ParseError
  | unknownArg      : String → ParseError
  | invalidValue    : String → String → ParseError
  | conflict        : String → String → ParseError
  | missingValue    : String → ParseError
  | tooManyValues   : String → ParseError
  deriving Repr, BEq

end Clap
-- === END: FIXED_FINAL ===
