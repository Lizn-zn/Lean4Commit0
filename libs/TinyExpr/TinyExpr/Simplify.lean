-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import TinyExpr.Types
import TinyExpr.Parse
import TinyExpr.Eval

namespace TinyExpr

def simplify (e : Expr) : Expr :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def simplify_postcond (e : Expr) (result : Expr) : Prop :=
  (∀ n, e = Expr.num n → result = Expr.num n) ∧
  (∀ name, e = Expr.var name → result = Expr.var name) ∧
  (∀ env, eval (simplify e) env = eval e env) ∧
  (∀ op n m, e = Expr.binary op (Expr.num n) (Expr.num m) →
    ∃ v, result = Expr.num v) ∧
  (∀ sub, e = Expr.binary .add (Expr.num 0.0) sub → result = sub ∨ ∃ v, result = Expr.num v) ∧
  (∀ sub, e = Expr.binary .add sub (Expr.num 0.0) → result = sub ∨ ∃ v, result = Expr.num v) ∧
  (∀ sub, e = Expr.binary .mul (Expr.num 1.0) sub → result = sub ∨ ∃ v, result = Expr.num v) ∧
  (∀ sub, e = Expr.binary .mul sub (Expr.num 1.0) → result = sub ∨ ∃ v, result = Expr.num v) ∧
  (∀ name, e = Expr.binary .add (Expr.num 0.0) (Expr.var name) → result = Expr.var name) ∧
  (∀ name, e = Expr.binary .add (Expr.var name) (Expr.num 0.0) → result = Expr.var name) ∧
  (∀ name, e = Expr.binary .mul (Expr.num 1.0) (Expr.var name) → result = Expr.var name) ∧
  (∀ name, e = Expr.binary .mul (Expr.var name) (Expr.num 1.0) → result = Expr.var name)


theorem simplify_spec (e : Expr) :
    simplify_postcond e (simplify e) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def parse_roundtrip_rel (parsed : Option Expr) (evaluated : Option Float) : Prop :=
  ∃ e, parsed = some e ∧ evaluated = some 5.0


theorem parse_roundtrip_spec :
    parse_roundtrip_rel (parse "2+3") (parse "2+3" >>= fun e => eval e []) := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def simplify_preserves_eval_rel (e : Expr) (env : Env) : Prop :=
  eval (simplify e) env = eval e env


theorem simplify_preserves_eval_spec (e : Expr) (env : Env) :
    simplify_preserves_eval_rel e env := by

  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



@[reducible]
def eval_num_rel (n : Float) (env : Env) : Prop :=
  eval (Expr.num n) env = some n


theorem eval_num_spec (n : Float) (env : Env) :
    eval_num_rel n env := by

  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end TinyExpr
-- === END: FIXED_FINAL ===
