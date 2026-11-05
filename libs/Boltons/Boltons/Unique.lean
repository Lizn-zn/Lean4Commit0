-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Boltons.Types

namespace Boltons

/-! ## iterutils.unique -/

def unique [BEq α] (xs : List α) : List α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def unique_postcond [BEq α] [LawfulBEq α] (xs : List α) (result : List α) : Prop :=
  result.Nodup ∧ result.length ≤ xs.length ∧
  (∀ x ∈ xs, x ∈ result) ∧
  (∀ x ∈ result, x ∈ xs) ∧
  result.Sublist xs ∧
  (∀ x ∈ result, ∀ y ∈ result,
    xs.findIdx (· == x) < xs.findIdx (· == y) →
    result.findIdx (· == x) < result.findIdx (· == y))

theorem unique_spec [BEq α] [LawfulBEq α] (xs : List α) :
    unique_postcond xs (unique xs) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Boltons
-- === END: FIXED_FINAL ===
