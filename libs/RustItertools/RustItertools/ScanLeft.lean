-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace RustItertools

/-! ## Core Function 3: Scan Left -/

/-- Left fold collecting all intermediate results. -/
def scanLeft (xs : List α) (init : β) (f : β → α → β) : List β :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def scanLeft_postcond (xs : List α) (init : β) (f : β → α → β) (result : List β) : Prop :=
  result.length = xs.length + 1 ∧
  result.head? = some init ∧
  (∀ (i : Nat) (h1 : i < xs.length) (h2 : i < result.length) (h3 : i + 1 < result.length),
    result.get ⟨i + 1, h3⟩ = f (result.get ⟨i, h2⟩) (xs.get ⟨i, h1⟩))

theorem scanLeft_spec (xs : List α) (init : β) (f : β → α → β) :
    scanLeft_postcond xs init f (scanLeft xs init f) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end RustItertools
-- === END: FIXED_FINAL ===
