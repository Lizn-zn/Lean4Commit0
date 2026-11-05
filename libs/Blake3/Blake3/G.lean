-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Blake3.Types

namespace Blake3

/-! ## Low-Level: G Mixing Function -/

/-- Right-rotate a 32-bit word. -/
def rotr32 (x : UInt32) (n : UInt32) : UInt32 :=
  (x >>> n) ||| (x <<< (32 - n))

/-- The G mixing function: mix two words into the state. -/
def g (state : List UInt32) (a b c d : Nat) (mx my : UInt32) : List UInt32 :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def g_postcond (state : List UInt32) (a b c d : Nat) (mx my : UInt32) (result : List UInt32) : Prop :=
  result.length = state.length ∧
  (∀ i, i < state.length → i ≠ a → i ≠ b → i ≠ c → i ≠ d →
    result[i]! = state[i]!) ∧
  (a < state.length → b < state.length → c < state.length → d < state.length →
    a ≠ b → a ≠ c → a ≠ d → b ≠ c → b ≠ d → c ≠ d →
    let sa1 := state[a]! + state[b]! + mx
    let sd1 := rotr32 (state[d]! ^^^ sa1) 16
    let sc1 := state[c]! + sd1
    let sb1 := rotr32 (state[b]! ^^^ sc1) 12
    let sa2 := sa1 + sb1 + my
    let sd2 := rotr32 (sd1 ^^^ sa2) 8
    let sc2 := sc1 + sd2
    let sb2 := rotr32 (sb1 ^^^ sc2) 7
    result[a]! = sa2 ∧ result[b]! = sb2 ∧ result[c]! = sc2 ∧ result[d]! = sd2)

theorem g_spec (state : List UInt32) (a b c d : Nat) (mx my : UInt32) :
    g_postcond state a b c d mx my (g state a b c d mx my) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Blake3
-- === END: FIXED_FINAL ===
