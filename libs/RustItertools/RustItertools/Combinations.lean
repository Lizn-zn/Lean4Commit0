-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import RustItertools.Helpers

namespace RustItertools

/-! ## Core Function 1: Combinations -/

/-- All k-combinations of a list (without replacement, order-independent). -/
def combinations (xs : List α) (k : Nat) : List (List α) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def combinations_precond (xs : List α) (k : Nat) : Prop :=
  k ≤ xs.length

@[reducible]
def combinations_postcond (xs : List α) (k : Nat) (result : List (List α)) : Prop :=
  (∀ c ∈ result, c.length = k) ∧
  result.length = Nat.choose xs.length k ∧
  (∀ c ∈ result, ∀ e ∈ c, e ∈ xs)

theorem combinations_spec (xs : List α) (k : Nat) (h : combinations_precond xs k) :
    combinations_postcond xs k (combinations xs k) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end RustItertools
-- === END: FIXED_FINAL ===
