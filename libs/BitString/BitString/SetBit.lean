-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import BitString.GetBit

namespace BitString

/-! ## Bit Access: setBit -/

def Bits.setBit (bs : Bits) (i : Nat) (value : Bool) : Option Bits :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Bits.setBit_postcond (bs : Bits) (i : Nat) (value : Bool) (result : Option Bits) : Prop :=
  (i ≥ bs.length → result = none) ∧
  (i < bs.length → ∃ bs', result = some bs' ∧ bs'.length = bs.length ∧
    bs'.getBit i = some value ∧
    (∀ j, j ≠ i → j < bs.length → bs'.getBit j = bs.getBit j))

theorem Bits.setBit_spec (bs : Bits) (i : Nat) (value : Bool) :
    Bits.setBit_postcond bs i value (bs.setBit i value) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end BitString
-- === END: FIXED_FINAL ===
