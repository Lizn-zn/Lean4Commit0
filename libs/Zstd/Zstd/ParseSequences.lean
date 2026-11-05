-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Zstd.Helpers
import Zstd.Compress
import Zstd.Decompress

namespace Zstd

def parseSequences (input : List UInt8) (windowSize : Nat) : List Sequence :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def parseSequences_postcond (input : List UInt8) (windowSize : Nat) (result : List Sequence) : Prop :=
  reconstructFromSequences result = input ∧
  result.all (fun s => s.literalLength = s.literals.length) ∧
  (result.foldl (fun acc s => acc + s.literalLength + s.matchLength) 0) = input.length ∧
  result.all (fun s => s.matchLength = 0 ∨ s.matchLength ≥ 3) ∧
  result.all (fun s => s.matchLength = 0 ∨ s.offset ≤ windowSize)


theorem parseSequences_spec (input : List UInt8) (windowSize : Nat) :
    parseSequences_postcond input windowSize (parseSequences input windowSize) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===




@[reducible]
def compress_decompress_rel (input : List UInt8) (compressed : List UInt8) (decompressed : Option (List UInt8)) : Prop :=
  decompressed = some input


theorem compress_decompress_spec (input : List UInt8) :
    compress_decompress_rel input (compress input) (decompress (compress input)) := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Zstd
-- === END: FIXED_FINAL ===
