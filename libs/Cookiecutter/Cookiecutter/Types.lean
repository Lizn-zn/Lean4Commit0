-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

def _root_.Cookiecutter.containsSubstr (s sub : String) : Bool :=
  (s.splitOn sub).length > 1

namespace Cookiecutter

/-! ## Types -/

/-- A template variable value -/
inductive VarValue where
  | str      : String → VarValue
  | int      : Int → VarValue
  | float    : Float → VarValue
  | bool     : Bool → VarValue
  | list     : List String → VarValue
  | dict     : List (String × VarValue) → VarValue
  | null     : VarValue
  deriving Repr, BEq

/-- A template variable definition -/
structure VarDef where
  name         : String
  defaultValue : VarValue
  prompt       : Option String
  choices      : Option (List String)
  validation   : Option String
  deriving Repr, BEq

/-- Template context (variable bindings) -/
abbrev TemplateContext := List (String × VarValue)

/-- A hook definition (pre or post generation) -/
inductive HookType where
  | preGenProject  : HookType
  | postGenProject : HookType
  deriving Repr, BEq, DecidableEq

/-- Template rendering error -/
inductive RenderError where
  | undefinedVariable : String → RenderError
  | invalidTemplate   : String → RenderError
  | validationError   : String → String → RenderError
  | hookError         : HookType → String → RenderError
  deriving Repr, BEq

/-- A token in a Jinja-like template -/
inductive TemplateToken where
  | literal    : String → TemplateToken
  | variable   : String → TemplateToken
  | ifBlock    : String → TemplateToken
  | elseBlock  : TemplateToken
  | endIf      : TemplateToken
  | forBlock   : String → String → TemplateToken
  | endFor     : TemplateToken
  | comment    : String → TemplateToken
  deriving Repr, BEq

end Cookiecutter
-- === END: FIXED_FINAL ===
