-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Stb.Types
import Stb.Helpers

namespace Stb

def setPixel (img : Image) (x y : Nat) (c : Color) : Image :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def setPixel_postcond (img : Image) (x y : Nat) (c : Color) (result : Image) : Prop :=
  result.width = img.width ∧ result.height = img.height ∧
  result.channels = img.channels ∧
  result.data.length = img.data.length ∧
  (x < img.width ∧ y < img.height ∧ img.channels ≥ 3 ∧
   img.data.length = img.width * img.height * img.channels →
    let idx := (y * img.width + x) * img.channels
    listGetOpt result.data idx = some c.r ∧
    listGetOpt result.data (idx + 1) = some c.g ∧
    listGetOpt result.data (idx + 2) = some c.b ∧
    (img.channels ≥ 4 → listGetOpt result.data (idx + 3) = some c.a)) ∧
  (img.data.length = img.width * img.height * img.channels ∧ img.channels > 0 →
    ∀ i, i < img.data.length →
      let px := i / img.channels
      let targetPx := y * img.width + x
      (px ≠ targetPx ∨ ¬(x < img.width ∧ y < img.height)) →
        listGetOpt result.data i = listGetOpt img.data i) ∧
  (x ≥ img.width ∨ y ≥ img.height → result.data = img.data) ∧
  (img.channels < 3 → result.data = img.data)


theorem setPixel_spec (img : Image) (x y : Nat) (c : Color) :
    setPixel_postcond img x y c (setPixel img x y c) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Stb
-- === END: FIXED_FINAL ===
