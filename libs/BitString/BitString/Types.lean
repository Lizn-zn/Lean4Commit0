-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # BitString (Core Summary)
   A library for creating, manipulating, and analyzing binary data.

   Ported from Python's `bitstring` library.
   Original: https://github.com/scott-griffiths/bitstring

   This is a summarized version containing only the 3 most essential
   function specs: Bits.getBit, Bits.setBit, and Bits.find.

   ## Task
   Implement all functions marked with `sorry` and prove all theorems.
   Success criterion: `lake env lean libs/BitString/BitString.lean` passes with no `sorry` remaining.
-/

namespace BitString

/-! ## Core BitArray Type -/

structure Bits where
  data : ByteArray
  length : Nat
  deriving BEq

instance : Repr Bits where
  reprPrec b _ := s!"Bits(length={b.length})"

/-! ## Bit Access Helpers -/

-- Helper: extract bit value from byte array at position i (MSB-first within each byte)
def Bits.extractBit (data : ByteArray) (i : Nat) : Bool :=
  let byteIdx := i / 8
  let bitIdx := 7 - (i % 8)
  if byteIdx < data.size then
    (data.get! byteIdx).toNat &&& (1 <<< bitIdx) != 0
  else
    false

end BitString
-- === END: FIXED_FINAL ===
