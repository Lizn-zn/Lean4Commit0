-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Kryo.Types
import Kryo.Helpers
import Kryo.WriteVarInt

namespace Kryo

/-! ## Core Function 2: serialize -/
def serialize (value : KryoValue) : List UInt8 :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def serialize_postcond (value : KryoValue) (result : List UInt8) : Prop :=
  result.length ≥ 1 ∧
  (value = .null → result = [typeTagNull]) ∧
  (∀ b, value = .bool b → result.head? = some typeTagBool ∧ result.length = 2 ∧
    result = [typeTagBool, if b then 1 else 0]) ∧
  (∀ n, value = .int n → result.head? = some typeTagInt ∧ result.length = 5 ∧
    result = [typeTagInt] ++ intToBytes4 n) ∧
  (∀ n, value = .long n → result.head? = some typeTagLong ∧ result.length = 9 ∧
    result = [typeTagLong] ++ intToBytes8 n) ∧
  (∀ f, value = .float f → result = [typeTagFloat] ++ float32BytesBE f) ∧
  (∀ f, value = .double f → result = [typeTagDouble] ++ float64BytesBE f) ∧
  (∀ c, value = .char c → result.head? = some typeTagChar ∧ result.length = 2 ∧
    result = [typeTagChar, (c.toNat % 256).toUInt8]) ∧
  (∀ s, value = .string s → result.head? = some typeTagString ∧ result.length ≥ 2 + s.length ∧
    (s.length < 128 → result.getD 1 0 = s.length.toUInt8) ∧
    (s.toList.all (fun c => c.toNat < 128) = true →
      result = [typeTagString, s.length.toUInt8] ++ s.toList.map (fun c => c.toNat.toUInt8))) ∧
  (∀ items, value = .array items → result.head? = some typeTagArray ∧ result.length ≥ 2 ∧
    (items.length < 128 → result.getD 1 0 = items.length.toUInt8) ∧
    (items.length > 0 → result.length ≥ 2 + items.length) ∧
    (items.length > 0 → result.getD 2 0 = kryoTypeTag (items.getD 0 .null))) ∧
  (∀ fields, value = .object fields → result.head? = some typeTagObject ∧ result.length ≥ 2 ∧
    (fields.length < 128 → result.getD 1 0 = fields.length.toUInt8) ∧
    (fields.length > 0 → result.length ≥ 2 + fields.length) ∧
    (fields.length > 0 → (fields.getD 0 ("", .null)).1.length < 128 →
      result.getD 2 0 = (fields.getD 0 ("", .null)).1.length.toUInt8))

theorem serialize_spec (value : KryoValue) :
    serialize_postcond value (serialize value) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Kryo
-- === END: FIXED_FINAL ===
