-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Web3.Types

namespace Web3

/-! ## Hex Utilities -/

def toHex (data : ByteArray) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



def fromHex (s : String) : Option ByteArray :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def hex_roundtrip_postcond (data : ByteArray) : Prop :=
  fromHex (toHex data) = some data ∧
  (toHex data).startsWith "0x" = true ∧
  (toHex data).length = 2 + 2 * data.size

theorem hex_roundtrip_spec (data : ByteArray) :
    hex_roundtrip_postcond data := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def hex_empty_postcond : Prop :=
  toHex ByteArray.empty = "0x" ∧
  fromHex "0x" = some ByteArray.empty

theorem hex_empty_spec :
    hex_empty_postcond := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Web3
-- === END: FIXED_FINAL ===
