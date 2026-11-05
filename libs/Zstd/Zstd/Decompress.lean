-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Zstd.Types

namespace Zstd

def decompress (compressed : List UInt8) : Option (List UInt8) :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def decompress_postcond (compressed : List UInt8) (result : Option (List UInt8)) : Prop :=
  (compressed = [] → result = none) ∧
  (compressed.length < 4 → result = none) ∧
  (compressed.length ≥ 4 → compressed.take 4 ≠ [0x28, 0xB5, 0x2F, 0xFD] → result = none) ∧
  (compressed = [0x28, 0xB5, 0x2F, 0xFD, 0x20, 0x00, 0x01, 0x00, 0x00] → result = some []) ∧
  (compressed = [0x28, 0xB5, 0x2F, 0xFD, 0x20, 0x01, 0x09, 0x00, 0x00, 0x00] → result = some [0x00]) ∧
  (compressed = [0x28, 0xB5, 0x2F, 0xFD, 0x20, 0x01, 0x09, 0x00, 0x00, 0x01] → result = some [0x01]) ∧
  (compressed = [0x28, 0xB5, 0x2F, 0xFD, 0x20, 0x02, 0x11, 0x00, 0x00, 0x48, 0x69] → result = some [0x48, 0x69]) ∧
  (compressed.length ≥ 9 → compressed.take 4 = [0x28, 0xB5, 0x2F, 0xFD] →
   compressed[4]? = some 0x20 →
   match result with
   | some output => output.length = ((compressed[5]?).getD (0 : UInt8)).toNat
   | none => True)


theorem decompress_spec (compressed : List UInt8) :
    decompress_postcond compressed (decompress compressed) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Zstd
-- === END: FIXED_FINAL ===
