-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Stb.Types
import Stb.Helpers
import Stb.SetPixel

namespace Stb

def getPixel (img : Image) (x y : Nat) : Option Color :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def getPixel_postcond (img : Image) (x y : Nat) (result : Option Color) : Prop :=
  (x ≥ img.width ∨ y ≥ img.height → result = none) ∧
  (x < img.width ∧ y < img.height ∧ img.channels ≥ 3 ∧ img.data.length = img.width * img.height * img.channels →
    let idx := (y * img.width + x) * img.channels
    match listGetOpt img.data idx, listGetOpt img.data (idx + 1), listGetOpt img.data (idx + 2) with
    | some r, some g, some b =>
      if img.channels ≥ 4 then
        match listGetOpt img.data (idx + 3) with
        | some a => result = some ⟨r, g, b, a⟩
        | none => result.isSome = true
      else
        result = some ⟨r, g, b, 255⟩
    | _, _, _ => result.isSome = true)


theorem getPixel_spec (img : Image) (x y : Nat) :
    getPixel_postcond img x y (getPixel img x y) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def getPixel_after_setPixel_rel (img : Image) (x y : Nat) (c : Color) (result : Option Color) : Prop :=
  x < img.width ∧ y < img.height → result = some c


theorem getPixel_after_setPixel_spec (img : Image) (x y : Nat) (c : Color) 
    (hchannels : img.channels ≥ 4) (hdata : img.data.length = img.width * img.height * img.channels) :
    getPixel_after_setPixel_rel img x y c (getPixel (setPixel img x y c) x y) := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Stb
-- === END: FIXED_FINAL ===
