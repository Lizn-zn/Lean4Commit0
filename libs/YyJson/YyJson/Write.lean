-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import YyJson.Types

namespace YyJson

def write (d : Doc) : String :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def write_postcond (d : Doc) (result : String) : Prop :=
  result ≠ "" ∧
  (d.root = Val.null → result = "null") ∧
  (∀ b, d.root = Val.bool b → (b = true → result = "true") ∧ (b = false → result = "false")) ∧
  (∀ xs, d.root = Val.arr xs → result.front = '[' ∧ result.back = ']') ∧
  (∀ kvs, d.root = Val.obj kvs → result.front = '{' ∧ result.back = '}') ∧
  (∀ s, d.root = Val.str s → result.front = '"' ∧ result.back = '"') ∧
  (∀ n, d.root = Val.int n → result = toString n) ∧
  (∀ xs, d.root = Val.arr xs → xs = [] → result = "[]") ∧
  (∀ kvs, d.root = Val.obj kvs → kvs = [] → result = "{}") ∧
  (∀ r : Float, d.root = Val.real r →
    result ≠ "null" ∧ result ≠ "true" ∧ result ≠ "false" ∧
    result.front ≠ '"' ∧ result.front ≠ '[' ∧ result.front ≠ '{')


theorem write_spec (d : Doc) :
    write_postcond d (write d) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end YyJson
-- === END: FIXED_FINAL ===
