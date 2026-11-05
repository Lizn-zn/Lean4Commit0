-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import BitString.Types

namespace BitString

/-! ## Bit Access: getBit -/

def Bits.getBit (bs : Bits) (i : Nat) : Option Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Bits.getBit_postcond (bs : Bits) (i : Nat) (result : Option Bool) : Prop :=
  (i ≥ bs.length → result = none) ∧
  (i < bs.length → result = some (Bits.extractBit bs.data i))

theorem Bits.getBit_spec (bs : Bits) (i : Nat) :
    Bits.getBit_postcond bs i (bs.getBit i) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end BitString
-- === END: FIXED_FINAL ===
