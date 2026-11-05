-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import CJSON.Helpers

namespace CJSON

def print (j : JSON) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def isPrintedNull (j : JSON) (result : String) : Prop :=
  j = JSON.null → result = "null"

@[reducible]
def isPrintedBool (j : JSON) (result : String) : Prop :=
  (j = JSON.bool true → result = "true") ∧
  (j = JSON.bool false → result = "false")

@[reducible]
def isPrintedNumber (j : JSON) (result : String) : Prop :=
  ∀ n, j = JSON.number n →
    result.length > 0 ∧
    (result.front = '-' ∨ result.front = 'n' ∨ result.front.isDigit)

@[reducible]
def isPrintedString (j : JSON) (result : String) : Prop :=
  ∀ s, j = JSON.string s →
    result.front = '"' ∧
    result.back = '"' ∧
    (containsSub result s = true ∨ s = "")

@[reducible]
def isPrintedArray (j : JSON) (result : String) : Prop :=
  ∀ xs, j = JSON.array xs →
    result.front = '[' ∧
    result.back = ']' ∧
    (xs = [] → result = "[]") ∧
    (∀ x ∈ xs, containsSub result (print x) = true)

@[reducible]
def isPrintedObject (j : JSON) (result : String) : Prop :=
  ∀ kvs, j = JSON.object kvs →
    result.front = '{' ∧
    result.back = '}' ∧
    (kvs = [] → result = "{}") ∧
    (∀ k v, (k, v) ∈ kvs →
      containsSub result ("\"" ++ k ++ "\"") = true ∧
      containsSub result (print v) = true)

@[reducible]
def print_postcond (j : JSON) (result : String) : Prop :=
  result ≠ "" ∧
  isPrintedNull j result ∧
  isPrintedBool j result ∧
  isPrintedNumber j result ∧
  isPrintedString j result ∧
  isPrintedArray j result ∧
  isPrintedObject j result

theorem print_spec (j : JSON) :
    print_postcond j (print j) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end CJSON
-- === END: FIXED_FINAL ===
