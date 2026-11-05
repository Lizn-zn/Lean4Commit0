-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace CommonsLang

/-! ## leftPad -/

def leftPad (s : String) (size : Nat) (pad : Char := ' ') : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def leftPad_postcond (s : String) (size : Nat) (pad : Char) (result : String) : Prop :=
  (size ≥ s.length → result.length = size) ∧
  (size < s.length → result = s) ∧
  (size > s.length →
    (∀ i, i < size - s.length → result.toList[i]? = some pad) ∧
    (∀ i, i < s.length → result.toList[i + (size - s.length)]? = s.toList[i]?)) ∧
  (size = s.length → result = s)

theorem leftPad_spec (s : String) (size : Nat) (pad : Char := ' ') :
    leftPad_postcond s size pad (leftPad s size pad) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end CommonsLang
-- === END: FIXED_FINAL ===
