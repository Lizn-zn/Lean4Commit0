-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Blake3.G

namespace Blake3

/-! ## Compression Function -/

/-- One round of BLAKE3 compression. -/
def round_ (state : List UInt32) (msg : List UInt32) : List UInt32 :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-- The full BLAKE3 compression function. -/
def compress (chainingValue : List UInt32) (blockWords : List UInt32)
    (counter : Nat) (bLen : Nat) (flags : UInt32) : List UInt32 :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def compress_precond (cv : List UInt32) (bw : List UInt32) : Prop :=
  cv.length = 8 ∧ bw.length = 16

@[reducible]
def isCompressInitState (cv : List UInt32)
    (counter bLen : Nat) (flags : UInt32) (state : List UInt32) : Prop :=
  state =
    cv ++
      [iv[0]!, iv[1]!, iv[2]!, iv[3]!,
       UInt32.ofNat counter,
       UInt32.ofNat (counter / 2^32),
       UInt32.ofNat bLen,
       flags]

@[reducible]
def isRoundMsgPermutation (bw permuted : List UInt32) (roundIdx : Nat) : Prop :=
  roundIdx < msgSchedule.length ∧
  permuted = (msgSchedule[roundIdx]!).map (fun i => bw[i]!)

@[reducible]
def isCompressRoundChain (initState : List UInt32)
    (bw : List UInt32) (roundStates : List (List UInt32)) : Prop :=
  roundStates.length = msgSchedule.length ∧
  (∀ i, i < msgSchedule.length →
    isRoundMsgPermutation bw (msgSchedule[i]!.map (fun j => bw[j]!)) i) ∧
  (∀ i, i < msgSchedule.length →
    roundStates[i]! =
      round_
        (if i = 0 then initState else roundStates[i - 1]!)
        ((msgSchedule[i]!).map (fun j => bw[j]!)))

@[reducible]
def isCompressFinalOutput (cv finalState result : List UInt32) : Prop :=
  finalState.length = 16 ∧
  result.length = 16 ∧
  (∀ i, i < 8 →
    result[i]! = (finalState[i]! ^^^ finalState[i + 8]!)) ∧
  (∀ i, i < 8 →
    result[i + 8]! = (finalState[i + 8]! ^^^ cv[i]!))

@[reducible]
def compress_postcond (cv : List UInt32) (bw : List UInt32)
    (counter bLen : Nat) (flags : UInt32) (result : List UInt32) : Prop :=
  ∃ initState roundStates,
    isCompressInitState cv counter bLen flags initState ∧
    isCompressRoundChain initState bw roundStates ∧
    isCompressFinalOutput cv (roundStates[msgSchedule.length - 1]!) result

theorem compress_spec (cv : List UInt32) (bw : List UInt32)
    (counter bLen : Nat) (flags : UInt32)
    (h : compress_precond cv bw) :
    compress_postcond cv bw counter bLen flags (compress cv bw counter bLen flags) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Blake3
-- === END: FIXED_FINAL ===
