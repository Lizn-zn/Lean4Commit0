-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace RustItertools

/-! ## Core Function 2: Interleave -/

/-- Interleave two lists element by element. -/
def interleave (xs ys : List α) : List α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def interleave_postcond (xs ys : List α) (result : List α) : Prop :=
  result.length = xs.length + ys.length ∧
  (xs = [] → result = ys) ∧
  (ys = [] → result = xs) ∧
  (∀ (i : Nat), i < min xs.length ys.length →
    (hx : i < xs.length) → (h1 : 2 * i < result.length) →
    result.get ⟨2 * i, h1⟩ = xs.get ⟨i, hx⟩) ∧
  (∀ (i : Nat), i < min xs.length ys.length →
    (hy : i < ys.length) → (h1 : 2 * i + 1 < result.length) →
    result.get ⟨2 * i + 1, h1⟩ = ys.get ⟨i, hy⟩) ∧
  (∀ (j : Nat), j < xs.length - ys.length →
    (hx : ys.length + j < xs.length) →
    (hr : 2 * ys.length + j < result.length) →
    result.get ⟨2 * ys.length + j, hr⟩ = xs.get ⟨ys.length + j, hx⟩) ∧
  (∀ (j : Nat), j < ys.length - xs.length →
    (hy : xs.length + j < ys.length) →
    (hr : 2 * xs.length + j < result.length) →
    result.get ⟨2 * xs.length + j, hr⟩ = ys.get ⟨xs.length + j, hy⟩)

theorem interleave_spec (xs ys : List α) :
    interleave_postcond xs ys (interleave xs ys) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end RustItertools
-- === END: FIXED_FINAL ===
