-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import TinyExpr.Types

namespace TinyExpr

def eval (e : Expr) (env : Env) : Option Float :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def eval_postcond (e : Expr) (env : Env) (result : Option Float) : Prop :=
  (∀ n, e = Expr.num n → result = some n) ∧
  (∀ name, e = Expr.var name →
    (env.find? (fun p => p.1 == name) = none → result = none) ∧
    (∀ v, env.find? (fun p => p.1 == name) = some (name, v) → result = some v)) ∧
  (∀ op n, e = Expr.unary op (Expr.num n) → result = eval (Expr.unary op (Expr.num n)) env) ∧
  (∀ op n m, e = Expr.binary op (Expr.num n) (Expr.num m) →
    result = eval (Expr.binary op (Expr.num n) (Expr.num m)) env) ∧
  (∀ op name, e = Expr.unary op (Expr.var name) →
    env.find? (fun p => p.1 == name) = none → result = none) ∧
  (∀ op name r, e = Expr.binary op (Expr.var name) r →
    env.find? (fun p => p.1 == name) = none → result = none) ∧
  (∀ n, e = Expr.num n → result.isSome = true) ∧
  (∀ op n, e = Expr.unary op (Expr.num n) → result.isSome = true) ∧
  (∀ op n m, e = Expr.binary op (Expr.num n) (Expr.num m) → result.isSome = true) ∧
  (∀ n m, e = Expr.binary .add (Expr.num n) (Expr.num m) → result = some (n + m)) ∧
  (∀ n m, e = Expr.binary .sub (Expr.num n) (Expr.num m) → result = some (n - m)) ∧
  (∀ n m, e = Expr.binary .mul (Expr.num n) (Expr.num m) → result = some (n * m)) ∧
  (∀ n, e = Expr.unary .neg (Expr.num n) → result = some (-n))


theorem eval_spec (e : Expr) (env : Env) :
    eval_postcond e env (eval e env) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end TinyExpr
-- === END: FIXED_FINAL ===
