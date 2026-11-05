-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Miniz.Types

namespace Miniz

/-! ## DEFLATE format definitions (RFC 1951) -/

def bitsOfByte (b : UInt8) : List Bit :=
  List.range 8 |>.map fun i => (b.toNat / (2 ^ i)) % 2 == 1

def encodeLE16 (n : Nat) : List Bit :=
  List.range 16 |>.map fun i => (n / (2 ^ i)) % 2 == 1

def encodeRawBlock (data : List UInt8) : List Bit :=
  [true, false, false]
  ++ List.replicate 5 false
  ++ encodeLE16 data.length
  ++ encodeLE16 (65535 - data.length)
  ++ (data.map bitsOfByte).flatten

def fixedHuffmanCode (sym : Nat) : List Bit :=
  let (code, nbits) :=
    if sym ≤ 143 then (0x30 + sym, 8)
    else if sym ≤ 255 then (0x190 + (sym - 144), 9)
    else if sym ≤ 279 then (sym - 256, 7)
    else if sym ≤ 287 then (0xC0 + (sym - 280), 8)
    else (0, 0)
  (List.range nbits).reverse.map fun i => (code / (2 ^ i)) % 2 == 1

def encodeFixedHuffmanBlock (data : List UInt8) : List Bit :=
  [true, true, false]
  ++ (data.map fun b => fixedHuffmanCode b.toNat).flatten
  ++ fixedHuffmanCode 256

end Miniz
-- === END: FIXED_FINAL ===
