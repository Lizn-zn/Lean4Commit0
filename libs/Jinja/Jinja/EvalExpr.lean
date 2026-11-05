-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Jinja.Types
import Jinja.Helpers

namespace Jinja

/-! ## Core Function 1: evalExpr -/
def evalExpr (expr : Expr) (ctx : Context) : Value :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def evalExpr_postcond (expr : Expr) (ctx : Context) (result : Value) : Prop :=
  (∀ v, expr = Expr.literal v → result = v) ∧
  (∀ name, expr = Expr.variable name →
    ((ctx.get name = some result) ∨ (ctx.get name = Option.none ∧ result = Value.none))) ∧
  (∀ name v, expr = Expr.variable name → ctx.get name = some v → result = v) ∧
  (∀ a b, expr = Expr.binOp "+" (Expr.literal (Value.int a)) (Expr.literal (Value.int b)) →
    result = Value.int (a + b)) ∧
  (∀ a b, expr = Expr.binOp "-" (Expr.literal (Value.int a)) (Expr.literal (Value.int b)) →
    result = Value.int (a - b)) ∧
  (∀ a b, expr = Expr.binOp "*" (Expr.literal (Value.int a)) (Expr.literal (Value.int b)) →
    result = Value.int (a * b)) ∧
  (∀ a b, expr = Expr.binOp "==" (Expr.literal a) (Expr.literal b) →
    result = Value.bool (a == b)) ∧
  (∀ a b, expr = Expr.binOp "!=" (Expr.literal a) (Expr.literal b) →
    result = Value.bool (a != b)) ∧
  (expr = Expr.listExpr [] → result = Value.list []) ∧
  (∀ e, expr = Expr.unaryOp "not" (Expr.literal (Value.bool e)) →
    result = Value.bool (!e)) ∧
  (∀ i, expr = Expr.unaryOp "-" (Expr.literal (Value.int i)) →
    result = Value.int (-i))

theorem evalExpr_spec (expr : Expr) (ctx : Context) :
    evalExpr_postcond expr ctx (evalExpr expr ctx) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Jinja
-- === END: FIXED_FINAL ===
