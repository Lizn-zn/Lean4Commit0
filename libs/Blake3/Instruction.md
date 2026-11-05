# Blake3

## Background

BLAKE3 is a cryptographic hash function designed for speed and security. It is based on a Merkle tree structure built from a compression function, which itself is built from the G mixing function. The compression function processes 64-byte blocks using 7 rounds of column and diagonal mixing. For short inputs (≤ 1 chunk = 1024 bytes), hashing is a straightforward chain of compress calls; for longer inputs, a binary tree of chaining values is merged. This formalization models BLAKE3 as pure functions on lists of bytes/words.

## Task

Complete implementation holes in explicitly editable regions in `Blake3/G.lean`, `Blake3/Compress.lean`, and `Blake3/Hash.lean`, and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `g`

- **Signature**: `def g (state : List UInt32) (a b c d : Nat) (mx my : UInt32) : List UInt32`
- **Description**: The G mixing function — mixes two message words (`mx`, `my`) into four positions (`a`, `b`, `c`, `d`) of the 16-word state vector.
- **Postcondition**: Three requirements:
  1. `result.length = state.length` (length preserved)
  2. All indices other than `a`, `b`, `c`, `d` are unchanged
  3. When all four indices are in bounds, the values at `a`, `b`, `c`, `d` follow the exact BLAKE3 G formula:
     - `sa1 = state[a] + state[b] + mx`
     - `sd1 = rotr32(state[d] XOR sa1, 16)`
     - `sc1 = state[c] + sd1`
     - `sb1 = rotr32(state[b] XOR sc1, 12)`
     - `sa2 = sa1 + sb1 + my`
     - `sd2 = rotr32(sd1 XOR sa2, 8)`
     - `sc2 = sc1 + sd2`
     - `sb2 = rotr32(sb1 XOR sc2, 7)`
     - `result[a] = sa2, result[b] = sb2, result[c] = sc2, result[d] = sd2`
- **Key constraints**: All arithmetic is modular 32-bit (UInt32 wraps automatically). The rotation amounts are fixed: 16, 12, 8, 7.

### 2. `compress`

- **Signature**: `def compress (chainingValue : List UInt32) (blockWords : List UInt32) (counter : Nat) (bLen : Nat) (flags : UInt32) : List UInt32`
- **Description**: The full BLAKE3 compression function. Initializes a 16-word state from the chaining value, IV, counter, block length, and flags, then runs 7 rounds of mixing (using the message permutation schedule), and XORs the two halves.
- **Postcondition**: Relational spec. There must exist an initial 16-word state with the expected `cv ++ iv ++ counter ++ bLen ++ flags` layout, a 7-step round-state chain following the message schedule, and a final 16-word feed-forward output where the low half XORs the two halves of the final state and the high half XORs the final high half with `cv`.
- **Key constraints**: Precondition requires `cv.length = 8` and `bw.length = 16`. The counter is a 64-bit value split into low/high 32-bit words in the initial state. Each of the 7 rounds permutes the message words according to `msgSchedule` before applying column and diagonal G calls. After all rounds, `result[i] = state[i] XOR state[i+8]` for i in 0..7 and `result[i+8] = state[i+8] XOR cv[i]` for i in 0..7.

### 3. `hash`

- **Signature**: `def hash (input : List UInt8) : Hash`
- **Description**: Hash a byte sequence in one shot, producing a 32-byte BLAKE3 hash.
- **Postcondition**: Relational spec. There must exist a padded 64-byte block encoding of the input, a 16-word block encoding via `bytesToWords`, a compression output obtained from `compress`, and a final byte output obtained by `chainingValueFromOutput` followed by `wordsToBytes` and truncation to `hashLen`.
- **Key constraints**: The summarized task models the one-shot hash pipeline through block padding, block-word encoding, one compression call, chaining-value extraction, and final byte serialization.

## Types

- **`Hash`**: A wrapper around `List UInt8` representing a 32-byte hash output.
- **`Hasher`**: (defined in full spec but not used in core) The incremental hashing state.

## Hints

- **`rotr32`** is already implemented: `(x >>> n) ||| (x <<< (32 - n))`. Use it directly in `g`.
- **`iv`** and **`msgSchedule`** are provided as constants. The IV is the standard BLAKE3 initialization vector. The message schedule defines the permutation for each of the 7 rounds.
- For `g`, use `List.set` to update the state at positions a, b, c, d. Be careful with the order of updates — each step depends on the previous one.
- For `round_`, apply `g` for the 4 column mixes (0,4,8,12), (1,5,9,13), (2,6,10,14), (3,7,11,15) then the 4 diagonal mixes (0,5,10,15), (1,6,11,12), (2,7,8,13), (3,4,9,14), using consecutive pairs of message words.
- For `compress`, initialize state as `cv ++ [iv[0], iv[1], iv[2], iv[3], counter_low, counter_high, bLen, flags]`, apply 7 rounds with permuted messages, then XOR the halves.
- For `hash`, you'll need the helper functions `bytesToWords`, `wordsToBytes`, `padBlock`, and `chainingValueFromOutput` — the spec now talks about how these pieces compose rather than giving concrete golden outputs.
- BLAKE3 flag constants: `CHUNK_START = 1`, `CHUNK_END = 2`, `ROOT = 8`. For single-chunk inputs, the first block gets `CHUNK_START`, the last gets `CHUNK_END`, and if it's also the root, OR in `ROOT`.
- The main `compress` spec is now structural rather than test-vector based: prove the state initialization, round chain, and final feed-forward relations.

## Edit Boundaries

The API files are divided into labeled sections:

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

- `Blake3/Compress.lean`
- `Blake3/G.lean`
- `Blake3/Hash.lean`
- `Blake3/Types.lean`

## Model scope

This task verifies its published simplified hash model; it does not establish cryptographic security or official BLAKE3 test-vector compatibility.
