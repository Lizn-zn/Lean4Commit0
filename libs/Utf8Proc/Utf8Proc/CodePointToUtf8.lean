-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Utf8Proc.Types

namespace Utf8Proc

def codePointToUtf8 (cp : UInt32) : List UInt8 :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def codePointToUtf8_postcond (cp : UInt32) (result : List UInt8) : Prop :=
  (cp ≤ 0x7F → result = [cp.toUInt8]) ∧
  (cp > 0x7F ∧ cp ≤ 0x7FF →
    result = [((0xC0 : UInt32) ||| (cp >>> 6)).toUInt8,
              ((0x80 : UInt32) ||| (cp &&& 0x3F)).toUInt8]) ∧
  (cp > 0x7FF ∧ cp ≤ 0xFFFF →
    result = [((0xE0 : UInt32) ||| (cp >>> 12)).toUInt8,
              ((0x80 : UInt32) ||| ((cp >>> 6) &&& 0x3F)).toUInt8,
              ((0x80 : UInt32) ||| (cp &&& 0x3F)).toUInt8]) ∧
  (cp > 0xFFFF ∧ cp ≤ 0x10FFFF →
    result = [((0xF0 : UInt32) ||| (cp >>> 18)).toUInt8,
              ((0x80 : UInt32) ||| ((cp >>> 12) &&& 0x3F)).toUInt8,
              ((0x80 : UInt32) ||| ((cp >>> 6) &&& 0x3F)).toUInt8,
              ((0x80 : UInt32) ||| (cp &&& 0x3F)).toUInt8])


theorem codePointToUtf8_spec (cp : UInt32) (h : cp ≤ 0x10FFFF) 
    (hscalar : cp < 0xD800 ∨ 0xDFFF < cp) :
    codePointToUtf8_postcond cp (codePointToUtf8 cp) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/-! ## Supporting: utf8ToCodePoints (for roundtrip rel) -/


end Utf8Proc
-- === END: FIXED_FINAL ===
