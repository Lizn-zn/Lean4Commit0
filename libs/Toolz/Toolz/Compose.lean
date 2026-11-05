-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace Toolz

def compose (f : β → γ) (g : α → β) : α → γ :=
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def compose_postcond (f : β → γ) (g : α → β) (result : α → γ) : Prop :=
  ∀ x, result x = f (g x)


theorem compose_spec (f : β → γ) (g : α → β) :
    compose_postcond f g (compose f g) := by
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/-! ## groupBy (itertoolz) -/


end Toolz
-- === END: FIXED_FINAL ===
