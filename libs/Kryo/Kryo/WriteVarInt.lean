-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Kryo.Types
import Kryo.Helpers

namespace Kryo

/-! ## Core Function 1: writeVarInt -/
def writeVarInt (out : Output) (n : Nat) : Output :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def writeVarInt_postcond (out : Output) (n : Nat) (result : Output) : Prop :=
  result.buffer.length > out.buffer.length ∧
  result.position = out.position + (result.buffer.length - out.buffer.length) ∧
  (n < 128 → result.buffer.length = out.buffer.length + 1) ∧
  (n < 128 → result.buffer = out.buffer ++ [n.toUInt8]) ∧
  (128 ≤ n ∧ n < 16384 → result.buffer.length = out.buffer.length + 2) ∧
  (16384 ≤ n ∧ n < 2097152 → result.buffer.length = out.buffer.length + 3) ∧
  (2097152 ≤ n ∧ n < 268435456 → result.buffer.length = out.buffer.length + 4) ∧
  (268435456 ≤ n → result.buffer.length = out.buffer.length + 5) ∧
  (128 ≤ n ∧ n < 16384 →
    result.buffer.getD out.buffer.length 0 = (n % 128).toUInt8 ||| 128 ∧
    result.buffer.getD (out.buffer.length + 1) 0 = (n / 128).toUInt8)

theorem writeVarInt_spec (out : Output) (n : Nat) :
    writeVarInt_postcond out n (writeVarInt out n) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Kryo
-- === END: FIXED_FINAL ===
