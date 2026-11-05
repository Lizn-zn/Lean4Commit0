-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Lz4.Types
import Lz4.Helpers

namespace Lz4

/-! ## Core Function 1: compressBlock -/
def compressBlock (input : List UInt8) : Block :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def compressBlock_postcond (input : List UInt8) (result : Block) : Prop :=
  (input = [] → result.tokens = []) ∧
  (input ≠ [] → result.tokens ≠ []) ∧
  (∀ t, t ∈ result.tokens → t.matchOffset ≤ maxDistance) ∧
  (∀ t, t ∈ result.tokens → t.literals.length = t.literalLength) ∧
  (result.tokens.map (fun t => t.literalLength + t.matchLength)).foldl (· + ·) 0 = input.length ∧
  (∀ t, t ∈ result.tokens → t.matchLength > 0 → t.matchLength ≥ minMatch) ∧
  (result.tokens.flatMap (fun t => t.literals)).length ≤ input.length ∧
  (∀ t ts, result.tokens = t :: ts →
    input.take t.literalLength = t.literals) ∧
  (∀ t, t ∈ result.tokens → t.matchLength ≥ minMatch → t.matchOffset > 0 → True)

theorem compressBlock_spec (input : List UInt8) :
    compressBlock_postcond input (compressBlock input) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Lz4
-- === END: FIXED_FINAL ===
