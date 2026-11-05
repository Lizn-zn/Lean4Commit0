-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Web3.Hex

namespace Web3

/-! ## Relational Specs -/

@[reducible]
def hex_string_roundtrip_rel (s : String) (data : ByteArray) (reencoded : String) : Prop :=
  reencoded = "0x" ++ (s.replace "0x" "").toLower ∧
  fromHex "0x" = some ByteArray.empty ∧
  fromHex "0xff" = some ⟨#[0xFF]⟩ ∧
  fromHex "0x00" = some ⟨#[0x00]⟩ ∧
  fromHex "0xgg" = none ∧
  fromHex "0xdeadbeef" = some ⟨#[0xDE, 0xAD, 0xBE, 0xEF]⟩ ∧
  toHex ⟨#[0xFF]⟩ = "0xff" ∧
  toHex ⟨#[0xDE, 0xAD]⟩ = "0xdead"

theorem hex_string_roundtrip_spec (s : String) (data : ByteArray) (h : fromHex s = some data) :
    hex_string_roundtrip_rel s data (toHex data) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Web3
-- === END: FIXED_FINAL ===
