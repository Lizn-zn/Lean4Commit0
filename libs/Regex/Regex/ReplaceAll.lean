-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Regex.FindAll

namespace Regex

def replaceAll (pattern : String) (input : String) (replacement : String) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def replaceAll_postcond (pattern input replacement : String) (result : String) : Prop :=
  (findAll pattern input = [] → result = input) ∧
  result = applyReplacements input (findAll pattern input) replacement

theorem replaceAll_spec (pattern input replacement : String) :
    replaceAll_postcond pattern input replacement (replaceAll pattern input replacement) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Regex
-- === END: FIXED_FINAL ===
