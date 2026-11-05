-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Lz4.Types

namespace Lz4

def Block.Valid (block : Block) : Prop :=
  ∀ t ∈ block.tokens, t.literalLength = t.literals.length ∧
    (t.matchLength ≠ 0 → 4 ≤ t.matchLength ∧ 0 < t.matchOffset ∧ t.matchOffset ≤ t.literalLength)

end Lz4
-- === END: FIXED_FINAL ===
