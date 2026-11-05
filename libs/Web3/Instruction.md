# Web3

## Background

Web3.py is a Python library for interacting with the Ethereum blockchain. This spec models the core data structures and algorithms as pure types — no actual blockchain I/O. It covers Ethereum unit conversions (Wei/Gwei/Ether), ABI encoding/decoding for smart contract interaction, and hexadecimal encoding/decoding for Ethereum's data format.

## Task

Complete implementation holes in explicitly editable regions in the split files under `Web3/` and complete the proof obligations assigned to editable regions.

Helpers are grouped in `Web3/Helpers.lean`. The three core API groups live in:

- `Web3/Wei.lean`
- `Web3/Abi.lean`
- `Web3/Hex.lean`

Relational specs are grouped in `Web3/Relations.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `wei_conversion` (toWei / fromWei / EthUnit.weiPerUnit)

- **Signatures**:
  - `def toWei (value : Nat) (unit : EthUnit) : Nat`
  - `def fromWei (weiAmount : Nat) (unit : EthUnit) : Nat × Nat`
  - `def EthUnit.weiPerUnit : EthUnit → Nat`
- **Description**: Convert between Ethereum denomination units. `toWei` converts a value in the given unit to Wei (the smallest unit). `fromWei` converts Wei to the given unit, returning (quotient, remainder).
- **Postcondition**: `wei_conversion_postcond` requires (16 clauses):
  - `fromWei (toWei value unit) unit = (value, 0)` — roundtrip
  - `toWei value .wei = value` — Wei identity
  - `fromWei w .wei = (w, 0)` for all w — Wei fromWei identity
  - Exact constants: 1 ether = 10^18, 1 gwei = 10^9, 1 kwei = 10^3, 1 mwei = 10^6, 1 szabo = 10^12, 1 finney = 10^15
  - All `weiPerUnit` values pinned for all 7 units
- **Key constraints**: The conversion constants must be exact powers of 10. `fromWei` returns (quotient, remainder) where remainder is always 0 when converting a round number back.

### 2. `abiEncode_roundtrip` (abiEncode / abiDecode)

- **Signatures**:
  - `def abiEncode (values : List AbiValue) : ByteArray`
  - `def abiDecode (types : List AbiType) (data : ByteArray) : Option (List AbiValue)`
- **Description**: ABI-encode a list of values into bytes, and decode bytes back into values given expected types. Used for smart contract function calls.
- **Postcondition**: `abiEncode_roundtrip_postcond` requires (5 clauses):
  - `abiDecode types (abiEncode values) = some values` — roundtrip
  - `uint256(1)` encodes as 31 zero bytes followed by 0x01 (big-endian)
  - `uint256(1)` first byte is 0x00
  - `bool true` encoding ≠ `bool false` encoding
  - `bool(true)` last byte (index 31) is 1
- **Key constraints**: ABI encoding uses 32-byte slots. Integers are big-endian padded to 32 bytes. Three roundtrip theorems must hold: for uint256, address, and bool types.

### 3. `hex_roundtrip` (toHex / fromHex)

- **Signatures**:
  - `def toHex (data : ByteArray) : String`
  - `def fromHex (s : String) : Option ByteArray`
- **Description**: Encode bytes to a "0x"-prefixed hex string, and decode hex strings back to bytes.
- **Postcondition**: `hex_roundtrip_postcond` requires (3 clauses):
  - `fromHex (toHex data) = some data` — roundtrip
  - `(toHex data).startsWith "0x" = true` — always has "0x" prefix
  - `(toHex data).length = 2 + 2 * data.size` — each byte becomes 2 hex chars
- **Key constraints**: `toHex` must produce lowercase hex. `fromHex` must accept both cases. Invalid hex chars (e.g., "0xgg") must return `none`.

## Relational Properties

- **`hex_string_roundtrip`**: After `fromHex s = some data`, `toHex data = "0x" ++ (s.replace "0x" "").toLower`. Also pins specific values: `fromHex "0xff" = some ⟨#[0xFF]⟩`, `fromHex "0xgg" = none`, `toHex ⟨#[0xFF]⟩ = "0xff"`, etc.

## Types

- **`UInt256`** — 256-bit unsigned integer (ByteArray wrapper), used in ABI encoding
- **`Address`** — 20-byte Ethereum address (ByteArray wrapper)
- **`EthUnit`** — 7 denomination units: wei, kwei, mwei, gwei, szabo, finney, ether
- **`AbiType`** — Solidity types: uint(bits), int(bits), address, bool, bytes(size), dynBytes, string, array, fixedArray, tuple
- **`AbiValue`** — ABI-encoded values corresponding to each AbiType

## Hints

- `UInt256.ofNat` is infrastructure (`sorry`) — needed for the abiEncode postcond which references `UInt256.ofNat 1`.
- For `toWei`, simply multiply: `value * unit.weiPerUnit`.
- For `fromWei`, use Euclidean division: `(weiAmount / unit.weiPerUnit, weiAmount % unit.weiPerUnit)`.
- For `EthUnit.weiPerUnit`, return the exact power of 10 for each unit (match on the unit).
- For `abiEncode`, each value occupies 32 bytes. Integers are big-endian left-padded with zeros. Bools encode as uint256 (0 or 1). Addresses are left-padded to 32 bytes.
- For `toHex`, convert each byte to 2 lowercase hex digits and prepend "0x".
- For `fromHex`, strip "0x" prefix, then parse pairs of hex digits. Return `none` for invalid characters or odd-length strings.
- The `hex_string_roundtrip` relational spec pins many concrete values — use these as test cases during development.

## Edit Boundaries

The split files under `Web3/` are divided into labeled sections:

```text
-- === BEGIN: SECTION_NAME (provided|editable) ===
...
-- === END: SECTION_NAME ===
```

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash and should remain unchanged.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Revised release contract (v3)

Every template placeholder is now an explicit editable obligation, including the former provided/unmarked holes. All types, declaration headers, predicates and non-hole support source are protected. Read the validity assumptions in the theorem statements; they are part of this revised task, not the historical experiment. The optional PROOF_IMPORTS regions permit only Mathlib, Batteries, Std or Lean imports. Use local helper definitions inside implementation/proof bodies when needed.

The default root checker reconstructs an authenticated fresh task tree, builds it, checks required declarations and exact trusted types, and audits transitive axioms of all task-module declarations. A compiling template with sorry is not solved. The verdict concerns the published simplified Lean model. All original paper results remain associated with the preserved experiment version.

Current task modules (relative to this library directory):

- `Web3/Abi.lean`
- `Web3/Helpers.lean`
- `Web3/Hex.lean`
- `Web3/Relations.lean`
- `Web3/Types.lean`
- `Web3/Wei.lean`
