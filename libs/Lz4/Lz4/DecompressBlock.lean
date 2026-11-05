-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Lz4.Validity
import Std
import Lean

import Lz4.Types
import Lz4.Helpers
import Lz4.CompressBlock

namespace Lz4

/-! ## Core Function 2: decompressBlock -/
def decompressBlock (block : Block) : Option (List UInt8) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def decompressBlock_postcond (block : Block) (result : Option (List UInt8)) : Prop :=
  (block.tokens = [] → result = some []) ∧
  ((block.tokens.any (fun t => t.literalLength > 0 ∨ t.matchLength > 0)) →
    ∀ out, result = some out → out ≠ []) ∧
  (∀ out, result = some out →
    out.length ≥ (block.tokens.map (·.literalLength)).foldl (· + ·) 0) ∧
  (∀ out, result = some out →
    out.length = (block.tokens.map (fun t => t.literalLength + t.matchLength)).foldl (· + ·) 0) ∧
  (∀ out t ts, result = some out → block.tokens = t :: ts →
    out.take t.literalLength = t.literals) ∧
  (∀ out t ts, result = some out → block.tokens = t :: ts →
    t.matchLength ≥ minMatch → t.matchOffset > 0 → t.matchOffset ≤ t.literalLength →
    let matchStart := t.literalLength
    ∀ i, i < t.matchLength →
      out[matchStart + i]? = out[matchStart + i - t.matchOffset]?) ∧
  ((∀ t, t ∈ block.tokens → t.matchLength = 0) →
    result = some (block.tokens.flatMap (·.literals))) ∧
  (∀ t ts, block.tokens = t :: ts →
    t.matchLength ≥ minMatch → t.matchOffset > t.literalLength → result = none)

theorem decompressBlock_spec (block : Block) 
    (hvalid : Block.Valid block) :
    decompressBlock_postcond block (decompressBlock block) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Lz4
-- === END: FIXED_FINAL ===
