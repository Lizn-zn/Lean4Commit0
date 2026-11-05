-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import XxHash.Helpers

namespace XxHash

def xxh32Avalanche (h : UInt32) : UInt32 :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def xxh32Avalanche_postcond (h : UInt32) (result : UInt32) : Prop :=
  let step1 := h ^^^ (h >>> 15)
  let step2 := step1 * xxh32Prime2
  let step3 := step2 ^^^ (step2 >>> 13)
  let step4 := step3 * xxh32Prime3
  result = step4 ^^^ (step4 >>> 16)


theorem xxh32Avalanche_spec (h : UInt32) :
    xxh32Avalanche_postcond h (xxh32Avalanche h) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end XxHash
-- === END: FIXED_FINAL ===
