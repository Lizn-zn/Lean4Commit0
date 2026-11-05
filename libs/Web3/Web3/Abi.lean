-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Web3.Types
import Web3.Helpers

namespace Web3

/-! ## ABI Encoding -/

def abiEncode (values : List AbiValue) : ByteArray :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



def abiDecode (types : List AbiType) (data : ByteArray) : Option (List AbiValue) :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def abiEncode_roundtrip_postcond (types : List AbiType) (values : List AbiValue)
    (result : Option (List AbiValue)) : Prop :=
  result = some values ∧
  (abiEncode [.uint 256 (UInt256.ofNat 1)]).data[31]! = 1 ∧
  (abiEncode [.uint 256 (UInt256.ofNat 1)]).data[0]! = 0 ∧
  abiEncode [.bool true] ≠ abiEncode [.bool false] ∧
  (abiEncode [.bool true]).data[31]! = 1

theorem abiEncode_uint256_roundtrip_spec (v : UInt256) :
    abiEncode_roundtrip_postcond [.uint 256] [.uint 256 v]
      (abiDecode [.uint 256] (abiEncode [.uint 256 v])) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



theorem abiEncode_address_roundtrip_spec (addr : Address) :
    abiEncode_roundtrip_postcond [.address] [.address addr]
      (abiDecode [.address] (abiEncode [.address addr])) := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



theorem abiEncode_bool_roundtrip_spec (b : Bool) :
    abiEncode_roundtrip_postcond [.bool] [.bool b]
      (abiDecode [.bool] (abiEncode [.bool b])) := by
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Web3
-- === END: FIXED_FINAL ===
