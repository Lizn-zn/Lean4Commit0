-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import BitString.SetBit

namespace BitString

/-! ## Search: find -/

def Bits.find (bs : Bits) (pattern : Bits) (start : Nat := 0) : Option Nat :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Bits.find_postcond (bs : Bits) (pattern : Bits) (start : Nat) (result : Option Nat) : Prop :=
  (∀ pos, result = some pos → pos ≤ bs.length) ∧
  (∀ pos, result = some pos → pos ≥ start) ∧
  (∀ pos, result = some pos → pos + pattern.length ≤ bs.length) ∧
  (∀ pos, result = some pos →
    ∀ j, j < pattern.length → bs.getBit (pos + j) = pattern.getBit j) ∧
  (result = none →
    ∀ p, p ≥ start → p + pattern.length ≤ bs.length →
      ∃ j, j < pattern.length ∧ bs.getBit (p + j) ≠ pattern.getBit j) ∧
  (∀ pos, result = some pos →
    ∀ p, p ≥ start → p < pos →
      p + pattern.length ≤ bs.length →
        ∃ j, j < pattern.length ∧ bs.getBit (p + j) ≠ pattern.getBit j)

theorem Bits.find_spec (bs : Bits) (pattern : Bits) (start : Nat) :
    Bits.find_postcond bs pattern start (bs.find pattern start) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end BitString
-- === END: FIXED_FINAL ===
