-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace CommonsLang

/-! ## rotate -/

def rotate (s : String) (shift : Int) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def rotate_postcond (s : String) (shift : Int) (result : String) : Prop :=
  (shift = 0 → result = s) ∧
  result.length = s.length ∧
  (s.length > 0 →
    ∀ i, i < s.length →
      result.toList[i]? = s.toList[((i : Int) - shift % s.length + s.length) % s.length |>.toNat]?)

theorem rotate_spec (s : String) (shift : Int) :
    rotate_postcond s shift (rotate s shift) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end CommonsLang
-- === END: FIXED_FINAL ===
