-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Stb.Types
import Stb.Helpers

namespace Stb

def resize (img : Image) (newWidth newHeight : Nat) : Image :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def resize_postcond (img : Image) (newWidth newHeight : Nat) (result : Image) : Prop :=
  result.width = newWidth ∧ result.height = newHeight ∧
  result.channels = img.channels ∧
  result.data.length = newWidth * newHeight * img.channels ∧
  (newWidth = img.width ∧ newHeight = img.height ∧
   img.data.length = img.width * img.height * img.channels →
    result.data = img.data) ∧
  (img.width > 0 ∧ img.height > 0 ∧ newWidth > 0 ∧ newHeight > 0 ∧
   img.data.length = img.width * img.height * img.channels →
    ∀ y, y < newHeight →
      ∀ x, x < newWidth →
        ∀ c, c < img.channels →
          let srcX := x * img.width / newWidth
          let srcY := y * img.height / newHeight
          listGetOpt result.data ((y * newWidth + x) * img.channels + c) =
          listGetOpt img.data ((srcY * img.width + srcX) * img.channels + c))


theorem resize_spec (img : Image) (w h : Nat) :
    resize_postcond img w h (resize img w h) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Stb
-- === END: FIXED_FINAL ===
