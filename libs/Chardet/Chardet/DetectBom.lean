-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Chardet.Helpers

namespace Chardet

def detectBom (data : ByteArray) : Option Encoding :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def detectBom_postcond (data : ByteArray) (result : Option Encoding) : Prop :=
  (data = ByteArray.empty → result = none) ∧
  (data.size ≥ 3 ∧ data.get! 0 = 0xEF ∧ data.get! 1 = 0xBB ∧ data.get! 2 = 0xBF →
    result = some .utf8) ∧
  (data.size ≥ 2 ∧ data.get! 0 = 0xFE ∧ data.get! 1 = 0xFF →
    result = some .utf16be) ∧
  (data.size ≥ 4 ∧ data.get! 0 = 0x00 ∧ data.get! 1 = 0x00 ∧
    data.get! 2 = 0xFE ∧ data.get! 3 = 0xFF ∧ (data.size - 4) % 4 = 0 →
    result = some .utf32be) ∧
  (data.size ≥ 4 ∧ data.get! 0 = 0x00 ∧ data.get! 1 = 0x00 ∧
    data.get! 2 = 0xFE ∧ data.get! 3 = 0xFF ∧ (data.size - 4) % 4 ≠ 0 →
    result = none) ∧
  (data.size ≥ 4 ∧ data.get! 0 = 0xFF ∧ data.get! 1 = 0xFE ∧
    data.get! 2 = 0x00 ∧ data.get! 3 = 0x00 ∧ (data.size - 4) % 4 = 0 →
    result = some .utf32le) ∧
  (data.size ≥ 4 ∧ data.get! 0 = 0xFF ∧ data.get! 1 = 0xFE ∧
    data.get! 2 = 0x00 ∧ data.get! 3 = 0x00 ∧ (data.size - 4) % 4 ≠ 0 →
    result = some .utf16le) ∧
  (data.size ≥ 2 ∧ data.get! 0 = 0xFF ∧ data.get! 1 = 0xFE ∧
    (data.size < 4 ∨ data.get! 2 ≠ 0x00 ∨ data.get! 3 ≠ 0x00) →
    result = some .utf16le) ∧
  (hasBomPattern data = false → result = none) ∧
  (result = none ∨ result = some .utf8 ∨ result = some .utf16be ∨
   result = some .utf16le ∨ result = some .utf32be ∨ result = some .utf32le)

theorem detectBom_spec (data : ByteArray) :
    detectBom_postcond data (detectBom data) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



theorem detectBom_utf16le (data : ByteArray)
    (h : data.size ≥ 2 ∧ data.get! 0 = 0xFF ∧ data.get! 1 = 0xFE)
    (hNot32 : data.size < 4 ∨ data.get! 2 ≠ 0x00 ∨ data.get! 3 ≠ 0x00) :
    detectBom data = some .utf16le := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Chardet
-- === END: FIXED_FINAL ===
