-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Boltons.Types

namespace Boltons

/-! ## iterutils.chunked -/

def chunked (xs : List α) (size : Nat) : List (List α) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def chunked_postcond (xs : List α) (size : Nat) (result : List (List α)) : Prop :=
  (size > 0 → result.flatten = xs) ∧
  (size > 0 → ∀ chunk ∈ result, chunk.length ≤ size) ∧
  (size > 0 → ∀ chunk ∈ result, chunk ≠ []) ∧
  (size > 0 ∧ result.length ≥ 2 →
    ∀ chunk ∈ result.dropLast, chunk.length = size)

theorem chunked_spec (xs : List α) (size : Nat) :
    chunked_postcond xs size (chunked xs size) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Boltons
-- === END: FIXED_FINAL ===
