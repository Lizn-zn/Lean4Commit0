-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import QrCodeGen.Types
import QrCodeGen.Helpers

namespace QrCodeGen


/-! ## encodeByte -/

def encodeByte (data : List UInt8) : List Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def encodeByte_postcond (data : List UInt8) (result : List Bool) : Prop :=
  result.length = data.length * 8 ∧
  (∀ i, i < data.length →
    ∀ k, k < 8 →
      result.getD (i * 8 + (7 - k)) false =
        ((data.getD i 0).toNat / (2^k) % 2 == 1))


theorem encodeByte_spec (data : List UInt8) :
    encodeByte_postcond data (encodeByte data) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end QrCodeGen
-- === END: FIXED_FINAL ===
