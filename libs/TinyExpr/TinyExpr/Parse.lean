-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import TinyExpr.Types

namespace TinyExpr

def parse (input : String) : Option Expr :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def parse_postcond (input : String) (result : Option Expr) : Prop :=
  (input = "" → result = none) ∧
  (∀ e, result = some e → input ≠ "") ∧
  (input = "0" → result = some (Expr.num 0.0)) ∧
  (input = "1" → result = some (Expr.num 1.0)) ∧
  (input = "2+3" → ∃ e, result = some e) ∧
  (input = "42" → result = some (Expr.num 42.0)) ∧
  (input = "3.14" → result = some (Expr.num 3.14)) ∧
  (input = "!!!" → result = none) ∧
  (input = "()" → result = none) ∧
  (input = "2" → result = some (Expr.num 2.0)) ∧
  (input = "3" → result = some (Expr.num 3.0)) ∧
  (input = "4" → result = some (Expr.num 4.0)) ∧
  (input = "5" → result = some (Expr.num 5.0)) ∧
  (input = "6" → result = some (Expr.num 6.0)) ∧
  (input = "7" → result = some (Expr.num 7.0)) ∧
  (input = "8" → result = some (Expr.num 8.0)) ∧
  (input = "9" → result = some (Expr.num 9.0)) ∧
  (input = "1+2" → result = some (Expr.binary .add (Expr.num 1.0) (Expr.num 2.0))) ∧
  (input = "5-3" → result = some (Expr.binary .sub (Expr.num 5.0) (Expr.num 3.0))) ∧
  (input = "2*3" → result = some (Expr.binary .mul (Expr.num 2.0) (Expr.num 3.0))) ∧
  (input = "6/2" → result = some (Expr.binary .div (Expr.num 6.0) (Expr.num 2.0)))


theorem parse_spec (input : String) :
    parse_postcond input (parse input) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end TinyExpr
-- === END: FIXED_FINAL ===
