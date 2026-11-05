-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import CommonsLang.Helpers

namespace CommonsLang

/-! ## countMatches -/

def countMatches (s sub : String) : Nat :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def countMatches_postcond (s sub : String) (result : Nat) : Prop :=
  (sub = "" → result = 0) ∧
  (s = "" → result = 0) ∧
  (sub.length > 0 → s.length > 0 → result ≤ s.length / sub.length) ∧
  (sub.length > 0 → result = countNonOverlap s.toList sub.toList)

theorem countMatches_spec (s sub : String) :
    countMatches_postcond s sub (countMatches s sub) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end CommonsLang
-- === END: FIXED_FINAL ===
