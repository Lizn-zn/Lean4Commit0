# Lz4

## Background

LZ4 is a fast lossless compression algorithm implemented in C, widely used for real-time compression scenarios. It works by encoding data as a sequence of tokens, where each token contains a run of literal bytes followed by a match copy (referencing earlier data at a given offset and length). The minimum match length is 4 bytes, and match offsets can reach up to 65535 bytes back. This core spec focuses on the block-level compression algorithm: compressing bytes to a token block, decompressing a token block back to bytes, and the fundamental match-length computation.

## Task

Complete implementation holes in explicitly editable regions in `Lz4/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `compressBlock`

- **Signature**: `def compressBlock (input : List UInt8) : Block`
- **Description**: Compresses an input byte list into an LZ4 block (a sequence of tokens). Each token contains literal bytes and optionally a match copy referencing earlier data.
- **Postcondition** (9 clauses):
  - Empty input → empty token list
  - Non-empty input → at least one token
  - All match offsets ≤ `maxDistance` (65535)
  - `t.literals.length = t.literalLength` for all tokens (consistency)
  - Sum of `(literalLength + matchLength)` across tokens = `input.length` (total size preserved)
  - Match tokens have `matchLength ≥ minMatch` (4)
  - Total literal bytes ≤ input length
  - First token's literals = input prefix of that length
- **Key constraints**: The total-size-equals-input constraint is critical — it ensures the token sequence fully accounts for every byte. The first-token prefix constraint anchors the compression to the actual input data.

### 2. `decompressBlock`

- **Signature**: `def decompressBlock (block : Block) : Option (List UInt8)`
- **Description**: Decompresses an LZ4 token block back to the original byte list. Processes tokens left-to-right, copying literals then performing match copies from earlier output.
- **Postcondition** (6 clauses):
  - Empty tokens → `some []`
  - Tokens with content → non-empty output
  - Output length ≥ sum of literal lengths
  - Output length = sum of `(literalLength + matchLength)` (exact)
  - First token's literals appear at output start
  - Match copy correctness: for the first token with a match, `out[matchStart + i] = out[matchStart + i - matchOffset]` for each byte
- **Key constraints**: The match copy is self-referential — it copies from the output being built, not from the input. When `matchOffset < matchLength`, this creates repeating patterns (e.g., offset=1 repeats a single byte).

### 3. `matchLength`

- **Signature**: `def matchLength (a b : List UInt8) : Nat`
- **Description**: Computes the length of the longest common prefix of two byte lists.
- **Postcondition** (3 clauses):
  - `result ≤ min a.length b.length` (upper bound)
  - `a.take result = b.take result` (prefix equality)
  - If `result < min lengths`, then `a[result] ≠ b[result]` (maximality)
- **Key constraints**: The maximality condition ensures the result is the *longest* common prefix, not just any common prefix. This is what makes the spec strong.

## Relational Properties

- **`block_roundtrip`**: `decompressBlock (compressBlock input) = some input` — compressing then decompressing a block recovers the original input exactly.
- **`matchLength_symmetric`**: `matchLength a b = matchLength b a` — the longest common prefix length is the same regardless of argument order.

## Types

- **`Token`**: An LZ4 compression token with `literalLength : Nat` (number of literal bytes), `literals : List UInt8` (the literal bytes), `matchOffset : Nat` (how far back to copy, 0 if no match), `matchLength : Nat` (how many bytes to copy, 0 if no match).
- **`Block`**: A compressed block containing `tokens : List Token`.

## Hints

- **Constants**: `minMatch = 4` (minimum match length), `maxDistance = 65535` (maximum match offset). Both are pre-defined.
- For `matchLength`, iterate through both lists simultaneously, counting matching bytes until a mismatch or end-of-list. This is a simple zip-and-compare.
- For `compressBlock`, a simple strategy: scan the input left-to-right. At each position, look backward for a match of length ≥ 4. If found, emit literals accumulated so far + the match (offset, length). If not, accumulate the byte as a literal. At the end, emit remaining literals as a final literal-only token (matchLength=0, matchOffset=0).
- For `decompressBlock`, process tokens left-to-right. For each token: append its literals to the output, then copy `matchLength` bytes from `matchOffset` positions back in the output. Handle the self-referential case where `matchOffset < matchLength` by copying byte-by-byte (each byte reads from the growing output).
- The `block_roundtrip` proof requires that `compressBlock` produces a valid token sequence that `decompressBlock` can correctly reconstruct. The key invariant is that the total literal + match bytes equal the input length, and each match offset references valid earlier data.
- The `matchLength_symmetric` proof follows from the commutativity of equality: `a[i] = b[i] ↔ b[i] = a[i]`.

## Edit Boundaries

`Lz4/*.lean` is divided into labeled sections:

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

- `Lz4/CompressBlock.lean`
- `Lz4/DecompressBlock.lean`
- `Lz4/Helpers.lean`
- `Lz4/MatchLength.lean`
- `Lz4/Relations.lean`
- `Lz4/Types.lean`
- `Lz4/Validity.lean`
