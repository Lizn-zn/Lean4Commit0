-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import XxHash.Xxh32Avalanche

namespace XxHash

def xxh32 (data : List UInt8) (seed : UInt32) : UInt32 :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def xxh32_postcond (data : List UInt8) (seed : UInt32) (result : UInt32) : Prop :=
  (data = [] → result = xxh32Avalanche (seed + xxh32Prime5)) ∧
  (∀ b : UInt8, data = [b] →
    let h := seed + xxh32Prime5 + 1
    let h := h + b.toUInt32 * xxh32Prime5
    let h := rotl32 h 11 * xxh32Prime1
    result = xxh32Avalanche h) ∧
  (data = [1, 2, 3, 4] ∧ seed = 0 → result = 4271296924) ∧
  (data = [1, 2, 3, 4] ∧ seed = 42 → result = 1432275538) ∧
  (data = [0x61, 0x62, 0x63] ∧ seed = 0 → result = 852579327) ∧
  (data = [0x61, 0x62, 0x63] ∧ seed = 42 → result = 21474302) ∧
  (data = (List.range 16).map UInt8.ofNat ∧ seed = 0 → result = 3072866292) ∧
  (data = (List.range 20).map UInt8.ofNat ∧ seed = 0 → result = 2190180764) ∧
  (data = (List.range 20).map UInt8.ofNat ∧ seed = 42 → result = 690511448) ∧
  (data = (List.range 32).map UInt8.ofNat ∧ seed = 0 → result = 2198290881)


theorem xxh32_spec (data : List UInt8) (seed : UInt32) :
    xxh32_postcond data seed (xxh32 data seed) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end XxHash
-- === END: FIXED_FINAL ===
