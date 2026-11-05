-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Fabric

/-! ## Types -/

/-- A shell command fragment that can be composed -/
inductive ShellFragment where
  | literal   : String → ShellFragment
  | quoted    : String → ShellFragment
  | pipe      : ShellFragment → ShellFragment → ShellFragment
  | andThen   : ShellFragment → ShellFragment → ShellFragment
  | orElse    : ShellFragment → ShellFragment → ShellFragment
  | subshell  : ShellFragment → ShellFragment
  | redirect  : ShellFragment → (file : String) → (appendMode : Bool) → ShellFragment
  | env       : (key value : String) → ShellFragment → ShellFragment
  | cd        : (dir : String) → ShellFragment → ShellFragment
  | sudo      : ShellFragment → (sudoUser : Option String) → ShellFragment
  deriving Repr, BEq

/-- A task identifier -/
structure TaskId where
  namespace_ : List String
  name       : String
  deriving Repr, BEq, Inhabited

/-- Task execution order -/
inductive TaskOrder where
  | sequential : TaskOrder
  | parallel   : TaskOrder
  deriving Repr, BEq, DecidableEq

/-- A task definition (pure metadata, no actual execution) -/
structure TaskDef where
  id           : TaskId
  description  : Option String
  hosts        : List String
  dependencies : List TaskId
  order        : TaskOrder := .sequential
  deriving Repr, BEq

/-- Configuration levels in order of precedence (lowest to highest) -/
inductive ConfigLevel where
  | defaults  : ConfigLevel
  | system    : ConfigLevel
  | user      : ConfigLevel
  | project   : ConfigLevel
  | runtime   : ConfigLevel
  deriving Repr, BEq, DecidableEq

/-- A configuration value that can be various types -/
inductive ConfigValue where
  | str    : String → ConfigValue
  | int    : Int → ConfigValue
  | bool   : Bool → ConfigValue
  | list   : List ConfigValue → ConfigValue
  | dict   : List (String × ConfigValue) → ConfigValue
  | none   : ConfigValue
  deriving Repr, BEq

/-- A configuration entry with its source level -/
structure ConfigEntry where
  key   : String
  value : ConfigValue
  level : ConfigLevel
  deriving Repr, BEq

/-- A layered configuration store -/
structure Config where
  entries : List ConfigEntry
  deriving Repr, BEq


end Fabric
-- === END: FIXED_FINAL ===
