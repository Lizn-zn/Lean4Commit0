-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # Web3
   A library for Ethereum/Web3 operations: address handling, ABI encoding,
   transactions, RLP, and contract interaction structures.

   Ported from Python's `web3.py` library.
   Original: https://github.com/ethereum/web3.py

   This is a summarized version containing only the 3 most essential
   function specs: wei_conversion, abiEncode_roundtrip, hex_roundtrip.
-/

import ByteArrayUtils

namespace Web3

structure UInt256 where
  bytes : ByteArray
  deriving Repr, BEq

structure Address where
  bytes : ByteArray
  deriving Repr, BEq

inductive EthUnit where
  | wei : EthUnit
  | kwei : EthUnit
  | mwei : EthUnit
  | gwei : EthUnit
  | szabo : EthUnit
  | finney : EthUnit
  | ether : EthUnit
  deriving Repr, BEq, DecidableEq

inductive AbiType where
  | uint : (bits : Nat) → AbiType
  | int : (bits : Nat) → AbiType
  | address : AbiType
  | bool : AbiType
  | bytes_ : (size : Nat) → AbiType
  | dynBytes : AbiType
  | string : AbiType
  | array : AbiType → AbiType
  | fixedArray : AbiType → Nat → AbiType
  | tuple : List AbiType → AbiType
  deriving Repr, BEq

inductive AbiValue where
  | uint : (bits : Nat) → UInt256 → AbiValue
  | int : (bits : Nat) → UInt256 → AbiValue
  | address : Address → AbiValue
  | bool : Bool → AbiValue
  | bytes_ : (size : Nat) → ByteArray → AbiValue
  | dynBytes : ByteArray → AbiValue
  | string : String → AbiValue
  | array : List AbiValue → AbiValue
  | fixedArray : List AbiValue → AbiValue
  | tuple : List AbiValue → AbiValue
  deriving Repr, BEq

end Web3
-- === END: FIXED_FINAL ===
