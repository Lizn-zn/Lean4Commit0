-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Stb.Types
import Stb.Helpers

namespace Stb

def decodePng (input : List UInt8) : Option Image :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def decodePng_postcond (input : List UInt8) (result : Option Image) : Prop :=
  (∀ img, result = some img →
    img.width > 0 ∧ img.height > 0 ∧
    img.data.length = img.width * img.height * img.channels ∧
    img.channels ≥ 1 ∧ img.channels ≤ 4) ∧
  (input.length < 8 ∨ input.take 8 ≠ pngSignature → result = none) ∧
  (result.isSome = true → input.length ≥ 8 ∧ input.take 8 = pngSignature) ∧
  (∀ img, result = some img → input.length ≥ 29 →
    match input[16]?, input[17]?, input[18]?, input[19]?,
          input[20]?, input[21]?, input[22]?, input[23]? with
    | some w0, some w1, some w2, some w3,
      some h0, some h1, some h2, some h3 =>
      img.width = readBE32 w0 w1 w2 w3 ∧ img.height = readBE32 h0 h1 h2 h3
    | _, _, _, _, _, _, _, _ => True)


theorem decodePng_spec (input : List UInt8) :
    decodePng_postcond input (decodePng input) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Stb
-- === END: FIXED_FINAL ===
