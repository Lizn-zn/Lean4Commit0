-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Regex.IsMatch

namespace Regex

def findAll (pattern : String) (input : String) : List Match :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def findAll_postcond (pattern input : String) (result : List Match) : Prop :=
  List.Pairwise (fun a b => a.«end» ≤ b.start) result ∧
  (∀ m ∈ result, m.start ≤ m.«end» ∧ m.«end» ≤ input.length) ∧
  (result = [] → isMatch pattern input = false) ∧
  (result ≠ [] → isMatch pattern input = true) ∧
  result = refindAll pattern input

theorem findAll_spec (pattern input : String) :
    findAll_postcond pattern input (findAll pattern input) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Regex
-- === END: FIXED_FINAL ===
