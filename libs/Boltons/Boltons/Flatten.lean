-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Boltons.Types

namespace Boltons

/-! ## iterutils.flatten -/

def flatten (xs : List (List α)) : List α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def flatten_postcond (xs : List (List α)) (result : List α) : Prop :=
  result = xs.flatten

theorem flatten_spec (xs : List (List α)) :
    flatten_postcond xs (flatten xs) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Boltons
-- === END: FIXED_FINAL ===
