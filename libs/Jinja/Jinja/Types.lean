-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Jinja
/-! ## Types -/
inductive Value where
  | none     : Value
  | bool     : Bool → Value
  | int      : Int → Value
  | float    : Float → Value
  | str      : String → Value
  | list     : List Value → Value
  | dict     : List (String × Value) → Value
  deriving Repr, BEq
/-- Convert a Value to its string representation. -/
structure Context where
  bindings : List (String × Value)
  deriving Repr, BEq
/-- First-match lookup in a list of bindings. -/
inductive Expr where
  | variable   : String → Expr
  | literal    : Value → Expr
  | getattr    : Expr → String → Expr
  | getitem    : Expr → Expr → Expr
  | filterApp  : Expr → String → List Expr → Expr
  | testApp    : Expr → String → List Expr → Expr
  | unaryOp    : String → Expr → Expr
  | binOp      : String → Expr → Expr → Expr
  | condExpr   : Expr → Expr → Expr → Expr
  | callExpr   : Expr → List Expr → Expr
  | listExpr   : List Expr → Expr
/-- A template AST node. -/
inductive TemplateNode where
  | output      : Expr → TemplateNode
  | text        : String → TemplateNode
  | ifBlock     : Expr → List TemplateNode → List TemplateNode → TemplateNode
  | forBlock    : String → Expr → List TemplateNode → List TemplateNode → TemplateNode
  | blockDef    : String → List TemplateNode → TemplateNode
  | extends_    : String → TemplateNode
  | include_    : String → TemplateNode
  | macro_      : String → List String → List TemplateNode → TemplateNode
  | callBlock   : Expr → List TemplateNode → TemplateNode
  | setVar      : String → Expr → TemplateNode
  | raw         : String → TemplateNode
  | comment     : TemplateNode
end Jinja
-- === END: FIXED_FINAL ===
