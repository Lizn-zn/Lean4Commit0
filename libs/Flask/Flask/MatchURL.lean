-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Flask.Types
import Flask.Helpers

namespace Flask

/-! ## Core Function 1: matchURL -/

def matchURL (pattern : URLPattern) (path : String) : Option (List (String × String)) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def matchURL_postcond_param (paramName value : String) : Prop :=
  matchURL ⟨[PatternSegment.literal "users", PatternSegment.parameter paramName]⟩
    ("/users/" ++ value)
  = some [(paramName, value)]

theorem matchURL_param_spec (paramName value : String) :
    matchURL_postcond_param paramName value := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Flask
-- === END: FIXED_FINAL ===
