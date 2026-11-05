-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Blake3.Compress

namespace Blake3

/-! ## Hash Operation -/

/-- Extract the first 8 words (chaining value) from compression output. -/
def chainingValueFromOutput (output : List UInt32) : List UInt32 :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-- Convert a list of bytes to a list of UInt32 (little-endian). -/
def bytesToWords (bytes : List UInt8) : List UInt32 :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-- Convert a list of UInt32 to bytes (little-endian). -/
def wordsToBytes (words : List UInt32) : List UInt8 :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



/-- Pad a block to 64 bytes with zeros. -/
def padBlock (block : List UInt8) : List UInt8 :=
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



/-- Hash a byte sequence in one shot. -/
def hash (input : List UInt8) : Hash :=
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===



@[reducible]
def isHashBlockEncoding (input padded : List UInt8) (blockWords : List UInt32) : Prop :=
  padded = padBlock input ∧
  padded.length = blockLen ∧
  blockWords = bytesToWords padded ∧
  blockWords.length = 16

@[reducible]
def isHashCompressionOutput (input : List UInt8)
    (blockWords compressOut cvWords : List UInt32) : Prop :=
  compress_precond iv blockWords ∧
  compressOut = compress iv blockWords 0 input.length 0 ∧
  cvWords = chainingValueFromOutput compressOut

@[reducible]
def isHashOutputBytes (cvWords : List UInt32) (result : Hash) : Prop :=
  result.bytes = (wordsToBytes cvWords).take hashLen ∧
  result.bytes.length = hashLen

@[reducible]
def hash_postcond (input : List UInt8) (result : Hash) : Prop :=
  ∃ padded blockWords compressOut cvWords,
    isHashBlockEncoding input padded blockWords ∧
    isHashCompressionOutput input blockWords compressOut cvWords ∧
    isHashOutputBytes cvWords result

theorem hash_spec (input : List UInt8) :
    hash_postcond input (hash input) := by
  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Blake3
-- === END: FIXED_FINAL ===
