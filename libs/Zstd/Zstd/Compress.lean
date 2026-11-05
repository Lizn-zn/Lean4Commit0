-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Zstd.Types

namespace Zstd

def compress (input : List UInt8) : List UInt8 :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def compress_postcond (input : List UInt8) (result : List UInt8) : Prop :=
  result ≠ [] ∧
  result.length ≥ 9 ∧
  result.take 4 = [0x28, 0xB5, 0x2F, 0xFD] ∧
  (result[4]? = some 0x20 ∨ result[4]? = some 0x60) ∧
  (input ≠ [] → result.length ≥ 10) ∧
  (input.length < 256 → result[5]? = some (UInt8.ofNat input.length))


theorem compress_spec (input : List UInt8) :
    compress_postcond input (compress input) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Zstd
-- === END: FIXED_FINAL ===
