-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Miniz.Types
import Miniz.Helpers

namespace Miniz

/-! ## Deflate / Inflate -/

def inflate (bits : List Bit) : Option (List UInt8) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def inflate_postcond (bits : List Bit) (result : Option (List UInt8)) : Prop :=
  (bits.length < 3 → result = none) ∧
  (∀ data : List UInt8, data.length ≤ 65535 →
    bits = encodeRawBlock data → result = some data) ∧
  (∀ data : List UInt8,
    bits = encodeFixedHuffmanBlock data → result = some data) ∧
  (∀ out, result = some out → out.length * 8 ≤ bits.length * 258)

theorem inflate_spec (bits : List Bit) :
    inflate_postcond bits (inflate bits) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Miniz
-- === END: FIXED_FINAL ===
