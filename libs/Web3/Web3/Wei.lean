-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Web3.Types
import Web3.Helpers

namespace Web3

/-! ## Wei / Gwei / Ether Conversions -/

def toWei (value : Nat) (unit : EthUnit) : Nat :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



def fromWei (weiAmount : Nat) (unit : EthUnit) : Nat × Nat :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def wei_conversion_postcond (value : Nat) (unit : EthUnit) : Prop :=
  fromWei (toWei value unit) unit = (value, 0) ∧
  toWei value .wei = value ∧
  (∀ w, fromWei w .wei = (w, 0)) ∧
  toWei 1 .ether = 10 ^ 18 ∧
  toWei 1 .gwei = 10 ^ 9 ∧
  toWei 1 .kwei = 10 ^ 3 ∧
  toWei 1 .mwei = 10 ^ 6 ∧
  toWei 1 .szabo = 10 ^ 12 ∧
  toWei 1 .finney = 10 ^ 15 ∧
  EthUnit.weiPerUnit .wei = 1 ∧
  EthUnit.weiPerUnit .kwei = 10 ^ 3 ∧
  EthUnit.weiPerUnit .mwei = 10 ^ 6 ∧
  EthUnit.weiPerUnit .gwei = 10 ^ 9 ∧
  EthUnit.weiPerUnit .szabo = 10 ^ 12 ∧
  EthUnit.weiPerUnit .finney = 10 ^ 15 ∧
  EthUnit.weiPerUnit .ether = 10 ^ 18

theorem wei_conversion_spec (value : Nat) (unit : EthUnit) :
    wei_conversion_postcond value unit := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Web3
-- === END: FIXED_FINAL ===
