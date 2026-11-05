-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace MoreItertools

/-! ## Grouping -/

def chunked (xs : List α) (n : Nat) : List (List α) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def chunked_precond (n : Nat) : Prop := n > 0

@[reducible]
def chunked_postcond (xs : List α) (n : Nat) (result : List (List α)) : Prop :=
  result.flatten = xs ∧
  (∀ chunk ∈ result, chunk.length ≤ n) ∧
  (∀ chunk ∈ result, chunk ≠ []) ∧
  (xs = [] → result = []) ∧
  (xs ≠ [] → result ≠ []) ∧
  (∀ i, i + 1 < result.length → (result[i]!).length = n)

theorem chunked_spec (xs : List α) (n : Nat) (hn : chunked_precond n) :
    chunked_postcond xs n (chunked xs n) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MoreItertools
-- === END: FIXED_FINAL ===
