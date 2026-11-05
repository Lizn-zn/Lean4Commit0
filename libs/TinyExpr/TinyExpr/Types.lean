-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace TinyExpr

inductive UnaryOp where
  | neg | abs | sqrt | sin | cos | tan | asin | acos | atan
  | log | log2 | log10 | exp | ceil | floor | round | fac
  deriving Repr, BEq


inductive BinaryOp where
  | add | sub | mul | div | pow | fmod | atan2 | min | max
  deriving Repr, BEq


inductive Expr where
  | num     : Float → Expr
  | var     : String → Expr
  | unary   : UnaryOp → Expr → Expr
  | binary  : BinaryOp → Expr → Expr → Expr
  deriving Repr, BEq


abbrev Env := List (String × Float)


end TinyExpr
-- === END: FIXED_FINAL ===
