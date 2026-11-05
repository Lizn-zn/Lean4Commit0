-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Re2.Types
import Re2.Helpers
import Re2.FullMatch

namespace Re2


/-! ## Core Function 2: Find All Matches -/

def findAll (pattern : String) (input : String) : List (Nat × Nat) := 
                                                                      
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                      sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def findAll_postcond (pattern : String) (input : String) (result : List (Nat × Nat)) : Prop :=
  List.Pairwise (fun a b => a.2 ≤ b.1) result ∧
  (∀ m ∈ result, m.1 ≤ m.2 ∧ m.2 ≤ input.length) ∧
  (findFirst pattern input = none → result = []) ∧
  (findFirst pattern input ≠ none → result ≠ []) ∧
  (result ≠ [] → result.head? = findFirst pattern input) ∧
  (pattern = "" → result.length = input.length + 1) ∧
  (∀ s e, result.getLast? = some (s, e) →
    e = input.length ∨ findFirst pattern (input.drop e).toString = none) ∧
  -- No match is skipped between consecutive matches (for patterns that don't match empty string)
  (findFirst pattern "" = none →
    List.Pairwise (fun a b =>
      b.1 ≤ a.2 ∨ findFirst pattern (((input.drop a.2).take (b.1 - a.2)).toString) = none) result)


theorem findAll_spec (pattern : String) (input : String) :
    findAll_postcond pattern input (findAll pattern input) := by 
                                                                 
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
                                                                 sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===




@[reducible]
def findAll_valid_postcond (pattern : String) (input : String) (result : List (Nat × Nat)) : Prop :=
  ∀ m ∈ result,
    m.1 ≤ m.2 ∧ m.2 ≤ input.length ∧
    fullMatch pattern ((input.drop m.1).take (m.2 - m.1)).toString = true


theorem findAll_valid_spec (pattern : String) (input : String) :
    findAll_valid_postcond pattern input (findAll pattern input) := by 
                                                                       
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
                                                                       sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Re2
-- === END: FIXED_FINAL ===
