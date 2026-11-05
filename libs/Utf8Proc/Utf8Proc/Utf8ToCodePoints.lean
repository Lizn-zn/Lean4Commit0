-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Utf8Proc.Types
import Utf8Proc.Normalize
import Utf8Proc.CodePointToUtf8

namespace Utf8Proc

def utf8ToCodePoints (bytes : List UInt8) : Option (List UInt32) :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def utf8ToCodePoints_postcond (bytes : List UInt8) (result : Option (List UInt32)) : Prop :=
  (bytes = [] → result = some []) ∧
  (∀ b, bytes = [b] → b ≤ 0x7F → result = some [b.toUInt32]) ∧
  (bytes.all (· ≤ 0x7F) → result = some (bytes.map (fun b => b.toUInt32))) ∧
  (∀ cps, result = some cps → ∀ cp ∈ cps, cp ≤ 0x10FFFF) ∧
  (∀ b, bytes = [b] → b ≥ 0x80 → result = none) ∧
  (∀ b1 b2, bytes = [b1, b2] → b1 ≥ 0xC2 → b1 ≤ 0xDF → b2 ≥ 0x80 → b2 ≤ 0xBF →
    result = some [((b1.toUInt32 &&& 0x1F) <<< 6) ||| (b2.toUInt32 &&& 0x3F)]) ∧
  (∀ b1 b2, bytes = [b1, b2] → b1 ≥ 0xC0 ∧ b1 ≤ 0xC1 → result = none) ∧
  (∀ b1 b2, bytes = [b1, b2] → b1 ≥ 0xC2 ∧ b1 ≤ 0xDF → (b2 < 0x80 ∨ b2 > 0xBF) → result = none) ∧
  (∀ b1 b2, bytes = [b1, b2] → b1 ≥ 0xE0 ∧ b1 ≤ 0xEF → result = none) ∧
  (∀ b1 b2, bytes = [b1, b2] → b1 ≥ 0xF0 → result = none) ∧
  (bytes = [0xE2, 0x82, 0xAC] → result = some [0x20AC]) ∧
  (bytes = [0xE4, 0xB8, 0x80] → result = some [0x4E00]) ∧
  (bytes = [0xF0, 0x9F, 0x98, 0x80] → result = some [0x1F600]) ∧
  (bytes = [0xED, 0xA0, 0x80] → result = none) ∧
  (bytes = [0xED, 0xBF, 0xBF] → result = none)


theorem utf8ToCodePoints_spec (bytes : List UInt8) :
    utf8ToCodePoints_postcond bytes (utf8ToCodePoints bytes) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Relational: UTF-8 roundtrip -/

@[reducible]
def utf8_roundtrip_rel (cp : UInt32) (result : Option (List UInt32)) : Prop :=
  cp ≤ 0x10FFFF → result = some [cp]


theorem utf8_roundtrip_spec (cp : UInt32) 
    (hscalar : cp < 0xD800 ∨ 0xDFFF < cp) :
    utf8_roundtrip_rel cp (utf8ToCodePoints (codePointToUtf8 cp)) := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



/-! ## Relational: normalization is idempotent -/

@[reducible]
def normalize_idempotent_rel (s : String) (form : NormForm) : Prop :=
  normalize (normalize s form) form = normalize s form


theorem normalize_idempotent_spec (s : String) (form : NormForm) :
    normalize_idempotent_rel s form := by
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Utf8Proc
-- === END: FIXED_FINAL ===
