-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import SqlParse.Types

namespace SqlParse

/-! ## Tokenize -/

def tokenize (sql : String) : List Token :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def tokenize_postcond (sql : String) (result : List Token) : Prop :=
  (sql ≠ "" → result ≠ []) ∧
  String.join (result.map Token.value) = sql ∧
  (sql = "" → result = []) ∧
  (∀ t ∈ result, t.value ≠ "") ∧
  (∀ t ∈ result, t.ttype = .whitespace → ∀ c ∈ t.value.toList, c = ' ' ∨ c = '\t') ∧
  (∀ t ∈ result, t.ttype = .newline → ∀ c ∈ t.value.toList, c = '\n' ∨ c = '\r') ∧
  (sql.any (· = ' ') ∧ sql.any (· ≠ ' ') →
   result.length ≥ 2 ∨
   result.any (fun t => t.ttype = .stringSingle ∨ t.ttype = .commentSingle ∨ t.ttype = .commentMulti))

theorem tokenize_spec (sql : String) :
    tokenize_postcond sql (tokenize sql) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SqlParse
-- === END: FIXED_FINAL ===
