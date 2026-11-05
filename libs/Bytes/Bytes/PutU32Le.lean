-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Bytes.Helpers

namespace Bytes

/-- Append a 32-bit integer (little-endian). -/
def BytesMut.putU32Le (b : BytesMut) (v : UInt32) : BytesMut :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def BytesMut.putU32Le_postcond (b : BytesMut) (v : UInt32) (result : BytesMut) : Prop :=
  result.len = b.len + 4 ∧
  result.data = b.data ++ [UInt8.ofNat (v.toNat % 256),
                            UInt8.ofNat (v.toNat / 256 % 256),
                            UInt8.ofNat (v.toNat / 65536 % 256),
                            UInt8.ofNat (v.toNat / 16777216 % 256)]

theorem BytesMut.putU32Le_spec (b : BytesMut) (v : UInt32) :
    BytesMut.putU32Le_postcond b v (b.putU32Le v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Bytes
-- === END: FIXED_FINAL ===
