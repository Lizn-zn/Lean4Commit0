-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Lz4.Types
import Lz4.Helpers
import Lz4.CompressBlock
import Lz4.DecompressBlock
import Lz4.MatchLength

namespace Lz4

/-! ## Relational: block compress/decompress roundtrip -/

@[reducible]
def block_roundtrip_rel (input : List UInt8) (block : Block) (decompressed : Option (List UInt8)) : Prop :=
  decompressed = some input

theorem block_roundtrip_spec (input : List UInt8) :
    block_roundtrip_rel input (compressBlock input) (decompressBlock (compressBlock input)) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: matchLength is symmetric -/

@[reducible]
def matchLength_symmetric_rel (a b : List UInt8) : Prop :=
  matchLength a b = matchLength b a

theorem matchLength_symmetric_spec (a b : List UInt8) :
    matchLength_symmetric_rel a b := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Lz4
-- === END: FIXED_FINAL ===
