-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import XxHash.Xxh32

namespace XxHash

def xxh64 (data : List UInt8) (seed : UInt64) : UInt64 :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




def xxh64Avalanche (h : UInt64) : UInt64 :=
  let h := h ^^^ (h >>> 33)
  let h := h * xxh64Prime2
  let h := h ^^^ (h >>> 29)
  let h := h * xxh64Prime3
  h ^^^ (h >>> 32)


@[reducible]
def xxh64_postcond (data : List UInt8) (seed : UInt64) (result : UInt64) : Prop :=
  (data = [] → result = xxh64Avalanche (seed + xxh64Prime5)) ∧
  (∀ b : UInt8, data = [b] →
    let h := seed + xxh64Prime5 + 1
    let h := h ^^^ (b.toUInt64 * xxh64Prime5)
    let h := rotl64 h 11 * xxh64Prime1
    result = xxh64Avalanche h) ∧
  (data = [1, 2, 3, 4, 5, 6, 7, 8] ∧ seed = 0 → result = 9316896406413536788) ∧
  (data = [0x61, 0x62, 0x63] ∧ seed = 0 → result = 4952883123889572249) ∧
  (data = [0x61, 0x62, 0x63] ∧ seed = 42 → result = 1423657621850124518) ∧
  (data = (List.range 32).map UInt8.ofNat ∧ seed = 0 → result = 14696824831085589172) ∧
  (data = (List.range 40).map UInt8.ofNat ∧ seed = 0 → result = 17715543491017654761) ∧
  (data = (List.range 40).map UInt8.ofNat ∧ seed = 42 → result = 191197390694726650)


theorem xxh64_spec (data : List UInt8) (seed : UInt64) :
    xxh64_postcond data seed (xxh64 data seed) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===




structure XXH32State where
  totalLen     : Nat
  largeLen     : Bool
  v1           : UInt32
  v2           : UInt32
  v3           : UInt32
  v4           : UInt32
  buffer       : List UInt8
  bufferedSize : Nat
  deriving Repr, BEq


def XXH32State.create (seed : UInt32) : XXH32State :=

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===




def XXH32State.update (state : XXH32State) (input : List UInt8) : XXH32State :=

  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===




def XXH32State.digest (state : XXH32State) : UInt32 :=

  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===




@[reducible]
def streaming_oneshot_rel (data : List UInt8) (seed : UInt32) (streamResult oneshotResult : UInt32) : Prop :=
  streamResult = oneshotResult


theorem streaming_oneshot_spec (data : List UInt8) (seed : UInt32) :
    streaming_oneshot_rel data seed
      ((XXH32State.create seed).update data).digest
      (xxh32 data seed) := by

  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end XxHash
-- === END: FIXED_FINAL ===
