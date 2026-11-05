# BitString

## Background

BitString is a Python library for creating, manipulating, and analyzing binary data at the bit level. In this Lean formalization, a bit string is represented as a `Bits` structure containing a `ByteArray` (the underlying storage) and a `length : Nat` (the number of valid bits). Bits are indexed MSB-first within each byte — bit 0 is the most significant bit of byte 0.

## Task

Complete implementation holes in explicitly editable regions in the `BitString/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `Bits.getBit`

- **Signature**: `def Bits.getBit (bs : Bits) (i : Nat) : Option Bool`
- **Description**: Read the bit at index `i` from a bit string. Returns `none` if the index is out of bounds.
- **Postcondition**: If `i ≥ bs.length`, returns `none`. If `i < bs.length`, returns `some (Bits.extractBit bs.data i)`.
- **Key constraints**: The result must exactly match `extractBit`, which uses MSB-first bit ordering within each byte (bit 0 is bit 7 of byte 0, bit 8 is bit 7 of byte 1, etc.).

### 2. `Bits.setBit`

- **Signature**: `def Bits.setBit (bs : Bits) (i : Nat) (value : Bool) : Option Bits`
- **Description**: Set the bit at index `i` to `value`, returning a new bit string. Returns `none` if the index is out of bounds.
- **Postcondition**: If `i ≥ bs.length`, returns `none`. If `i < bs.length`, returns `some bs'` where:
  - `bs'.length = bs.length`
  - `bs'.getBit i = some value` (the target bit is set)
  - For all `j ≠ i` with `j < bs.length`, `bs'.getBit j = bs.getBit j` (other bits unchanged)
- **Key constraints**: The postcondition references `getBit`, so `getBit` must be implemented correctly first. The new bit string must preserve all bits except the one being set.

### 3. `Bits.find`

- **Signature**: `def Bits.find (bs : Bits) (pattern : Bits) (start : Nat := 0) : Option Nat`
- **Description**: Find the first occurrence of `pattern` in `bs` starting from position `start`. Returns `none` if no match is found.
- **Postcondition**: Six requirements:
  1. If `some pos`, then `pos < bs.length`
  2. If `some pos`, then `pos ≥ start`
  3. If `some pos`, then `pos + pattern.length ≤ bs.length`
  4. If `some pos`, then for all `j < pattern.length`, `bs.getBit (pos + j) = pattern.getBit j` (bit-by-bit match)
  5. If `none`, then no position `p ≥ start` with `p + pattern.length ≤ bs.length` is a valid match (completeness)
  6. If `some pos`, then no earlier position `p` with `start ≤ p < pos` is a valid match (minimality / first match)
- **Key constraints**: Must return the *first* match, not just any match. The completeness clause requires proving that no match exists when returning `none`. Pattern matching is verified bit-by-bit using `getBit`.

## Types

- **`Bits`**: The core type — a `ByteArray` plus a `length : Nat` indicating how many bits are valid. The underlying byte array may have padding bits in the last byte beyond `length`. Uses `BEq` for equality.

## Hints

- **`Bits.extractBit`** is already implemented (not `sorry`) and computes the bit value from the byte array using MSB-first ordering. Use it directly in `getBit`.
- For `getBit`, the implementation is straightforward: check bounds, then call `extractBit`.
- For `setBit`, you need to modify a single bit in the byte array. Compute `byteIdx = i / 8` and `bitIdx = 7 - (i % 8)`, then set or clear that bit using bitwise OR/AND operations on the byte.
- For `find`, a simple linear scan from `start` works: at each position, check if all bits match the pattern using `getBit`. The proof of minimality requires showing no earlier position matched.
- The proofs for `setBit` will need to reason about `getBit` applied to the modified byte array — you'll likely need lemmas about how modifying one byte doesn't affect `extractBit` at positions in other bytes, and how the bit manipulation within the same byte only affects the target bit.

## Edit Boundaries

`BitString/*.lean` is divided into labeled sections:

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

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `BitString/Find.lean`
- `BitString/GetBit.lean`
- `BitString/SetBit.lean`
- `BitString/Types.lean`
