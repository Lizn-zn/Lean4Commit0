-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace MoreItertools

/-! ## Selecting -/

def uniqueEverseen [BEq α] (xs : List α) : List α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def uniqueEverseen_postcond [BEq α] [LawfulBEq α] [Inhabited α] (xs : List α) (result : List α) : Prop :=
  result.Nodup ∧
  (∀ x ∈ result, x ∈ xs) ∧
  (∀ x ∈ xs, x ∈ result) ∧
  result.Sublist xs ∧
  (∀ i j : Nat, i < j → j < result.length →
    xs.findIdx (· == result[i]!) < xs.findIdx (· == result[j]!))

theorem uniqueEverseen_spec [BEq α] [LawfulBEq α] [Inhabited α] (xs : List α) :
    uniqueEverseen_postcond xs (uniqueEverseen xs) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MoreItertools
-- === END: FIXED_FINAL ===
