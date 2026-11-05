-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace MoreItertools

/-! ## Windowing -/

def windowed (xs : List α) (n : Nat) : List (List α) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def windowed_precond (n : Nat) : Prop := n > 0

@[reducible]
def windowed_postcond (xs : List α) (n : Nat) (result : List (List α)) : Prop :=
  (xs.length ≥ n → result.length = xs.length - n + 1) ∧
  (∀ w ∈ result, w.length = n) ∧
  (∀ i, i < result.length → result[i]! = (xs.drop i).take n)

theorem windowed_spec (xs : List α) (n : Nat) (hn : windowed_precond n) (hlen : xs.length ≥ n) :
    windowed_postcond xs n (windowed xs n) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MoreItertools
-- === END: FIXED_FINAL ===
