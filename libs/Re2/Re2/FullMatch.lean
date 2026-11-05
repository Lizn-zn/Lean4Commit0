-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Re2.Types
import Re2.Helpers

namespace Re2


/-! ## Core Function 1: Full Match -/

def fullMatch (pattern : String) (input : String) : Bool := 
                                                            
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                            sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def fullMatch_postcond (pattern : String) (input : String) (result : Bool) : Prop :=
  (result = true ↔ ∃ s e, findFirst pattern input = some (s, e) ∧ s = 0 ∧ e = input.length)


theorem fullMatch_spec (pattern : String) (input : String) :
    fullMatch_postcond pattern input (fullMatch pattern input) := by 
                                                                     
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
                                                                     sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===




@[reducible]
def fullMatch_iff_postcond (pattern : String) (input : String) (result : Bool) : Prop :=
  (result = true ↔ ∃ s e, findFirst pattern input = some (s, e) ∧ s = 0 ∧ e = input.length)


theorem fullMatch_iff_spec (pattern : String) (input : String) :
    fullMatch_iff_postcond pattern input (fullMatch pattern input) := by 
                                                                         
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
                                                                         sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Re2
-- === END: FIXED_FINAL ===
