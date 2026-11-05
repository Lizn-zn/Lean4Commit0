# XxHash

## Background

XxHash is a fast non-cryptographic hash function library providing xxHash32 (32-bit) and xxHash64 (64-bit) algorithms. It supports both one-shot hashing (entire input at once) and streaming hashing (incremental updates). This spec covers the two one-shot hash functions and the core avalanche mixing step, with a relational property connecting the streaming and one-shot APIs.

## Task

Complete implementation holes in explicitly editable regions in `XxHash/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `xxh32Avalanche`

- **Signature**: `def xxh32Avalanche (h : UInt32) : UInt32`
- **Description**: The finalization mixing function for xxHash32. Applies a sequence of XOR, shift, and multiply operations to achieve good hash distribution (avalanche effect).
- **Postcondition**: `xxh32Avalanche_postcond` requires exact formula:
  - step1 = h XOR (h >>> 15)
  - step2 = step1 * Prime2
  - step3 = step2 XOR (step2 >>> 13)
  - step4 = step3 * Prime3
  - result = step4 XOR (step4 >>> 16)
- **Key constraints**: Must use the exact constants `xxh32Prime2` and `xxh32Prime3`. The formula is deterministic — there's exactly one correct implementation.

### 2. `xxh32`

- **Signature**: `def xxh32 (data : List UInt8) (seed : UInt32) : UInt32`
- **Description**: Compute the 32-bit xxHash of a byte sequence with a given seed.
- **Postcondition**: `xxh32_postcond` requires (8 clauses):
  - Empty data → `xxh32Avalanche (seed + xxh32Prime5)`
  - Empty data with seed 0 → `xxh32Avalanche xxh32Prime5`
  - `[0]` with seed 0 → 3479547966
  - `[1, 2, 3]` with seed 0 → 4120672452
  - `[72, 101, 108, 108, 111]` ("Hello") with seed 0 → 4060533391
  - `[255]` with seed 0 → 2528958668
  - `[0, 0, 0, 0]` with seed 0 → 148298089
  - Empty data with seed 42 → 3586027192
- **Key constraints**: The test vectors are exact — the implementation must produce these specific hash values. The empty-data formula uses `xxh32Avalanche`.

### 3. `xxh64`

- **Signature**: `def xxh64 (data : List UInt8) (seed : UInt64) : UInt64`
- **Description**: Compute the 64-bit xxHash of a byte sequence with a given seed.
- **Postcondition**: `xxh64_postcond` requires (6 clauses):
  - `[]` with seed 0 → 17241709254077376921
  - `[]` with seed 42 → 11002672306508523268
  - `[0]` with seed 0 → 16804241149081757544
  - `[1, 2, 3]` with seed 0 → 8376154270085342629
  - `[72, 101, 108, 108, 111]` ("Hello") with seed 0 → 753694413698530628
  - `[255]` with seed 0 → 10764519495013463364
- **Key constraints**: Same as xxh32 — exact test vectors must be matched. Uses 64-bit prime constants.

## Relational Properties

- **`streaming_oneshot`**: `(XXH32State.create seed).update(data).digest = xxh32 data seed` — the streaming API (create → update → digest) produces the same result as the one-shot `xxh32` function for any data and seed.

## Types

- **`XXH32State`** — Streaming state for incremental xxHash32 computation: total length, four accumulator lanes (v1–v4), a buffer for incomplete blocks, and buffered size.

## Hints

- All prime constants (`xxh32Prime1`–`xxh32Prime5`, `xxh64Prime1`–`xxh64Prime5`) are already defined with exact values (not `sorry`).
- `rotl32` (rotate left for UInt32) is already implemented (not `sorry`).
- For `xxh32Avalanche`, directly translate the formula from the postcondition — it's a chain of XOR-shift-multiply operations.
- For `xxh32`, the algorithm has two phases:
  1. **Accumulation** (for data ≥ 16 bytes): Initialize 4 accumulators from seed, process 16-byte blocks using rounds, then merge accumulators.
  2. **Finalization**: Add total length, process remaining bytes (4-byte and 1-byte chunks), then apply `xxh32Avalanche`.
  - For data < 16 bytes, skip accumulation, start with `seed + xxh32Prime5 + length`, then process remaining bytes.
- For `xxh64`, similar structure but with 64-bit operations, 32-byte blocks, and different mixing constants.
- The streaming API (`XXH32State.create/update/digest`) must implement the same algorithm incrementally. The `streaming_oneshot` relational spec ensures consistency.
- The test vectors in the postconditions are the canonical xxHash values — verify against the reference C implementation if unsure.

## Edit Boundaries

`XxHash/*.lean` is divided into labeled sections:

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

- `XxHash/Helpers.lean`
- `XxHash/Xxh32.lean`
- `XxHash/Xxh32Avalanche.lean`
- `XxHash/Xxh64.lean`
