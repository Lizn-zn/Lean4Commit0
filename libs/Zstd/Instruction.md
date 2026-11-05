# Zstd

## Background

Zstd (Zstandard) is Facebook's fast real-time compression algorithm. This spec models the complete compression pipeline as pure functional operations: LZ77-style matching to find repeated sequences, Huffman and FSE entropy coding, block and frame formatting, and dictionary support. The core spec covers the top-level compress/decompress functions and the LZ77 sequence parsing that forms the foundation of the compression algorithm.

## Task

Complete implementation holes in explicitly editable regions in `Zstd/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `compress`

- **Signature**: `def compress (input : List UInt8) : List UInt8`
- **Description**: Compress input data into a valid Zstd frame.
- **Postcondition**: `compress_postcond` requires (3 clauses):
  - Output is non-empty
  - Output length ≥ 9 (minimum frame size: 4 bytes magic + at least 5 bytes header/blocks)
  - First 4 bytes are the Zstd magic number: `[0x28, 0xB5, 0x2F, 0xFD]`
- **Key constraints**: Even empty input must produce a valid frame with the magic number. The minimum size of 9 bytes accounts for magic (4) + frame header (1+) + at least one block header (3) + optional checksum.

### 2. `decompress`

- **Signature**: `def decompress (compressed : List UInt8) : Option (List UInt8)`
- **Description**: Decompress a Zstd frame back to the original data. Returns `none` for invalid input.
- **Postcondition**: `decompress_postcond` requires (3 clauses):
  - Empty input → `none`
  - Input shorter than 4 bytes → `none`
  - Input ≥ 4 bytes but first 4 bytes ≠ Zstd magic number → `none`
- **Key constraints**: The postcondition only specifies rejection conditions. The roundtrip property (compress then decompress recovers the input) is specified separately as a relational spec.

### 3. `parseSequences`

- **Signature**: `def parseSequences (input : List UInt8) (windowSize : Nat) : List Sequence`
- **Description**: Parse input data into LZ77-style sequences. Each sequence contains literal bytes followed by a back-reference (offset + match length).
- **Postcondition**: `parseSequences_postcond` requires:
  - `reconstructFromSequences result = input` — the sequences must exactly reconstruct the original input
- **Key constraints**: This is the strongest postcondition — it requires exact reconstruction. The `windowSize` parameter limits how far back matches can reference.

## Relational Properties

- **`compress_decompress`**: `decompress (compress input) = some input` — the fundamental correctness property. Compressing any input and then decompressing must recover the exact original data.

## Types

- **`Sequence`** — An LZ77 sequence: `literals` (literal bytes to copy), `literalLength` (count of literals), `matchLength` (length of back-reference match), `offset` (distance back to the match source)

## Hints

- `reconstructFromSequences` is infrastructure (`sorry`) that must be implemented. It replays the sequences to reconstruct the original data: for each sequence, emit the literal bytes, then copy `matchLength` bytes from `offset` positions back in the already-emitted output.
- For `parseSequences`, the simplest valid implementation is to emit one sequence per byte with `literals = [byte], literalLength = 1, matchLength = 0, offset = 0` (no back-references). This satisfies the postcondition but produces no compression. A better implementation finds repeated patterns.
- For `compress`, build a valid Zstd frame: magic number (4 bytes) + frame header + blocks + optional checksum. The simplest approach is to use a single raw (uncompressed) block.
- For `decompress`, validate the magic number, parse the frame header and blocks, and reconstruct the data.
- The Zstd magic number is `0xFD2FB528` in little-endian, which gives bytes `[0x28, 0xB5, 0x2F, 0xFD]`.
- The roundtrip proof requires that your `decompress` can correctly parse whatever format your `compress` produces. Design them together.

## Edit Boundaries

`Zstd/*.lean` is divided into labeled sections:

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

- `Zstd/Compress.lean`
- `Zstd/Decompress.lean`
- `Zstd/Helpers.lean`
- `Zstd/ParseSequences.lean`
- `Zstd/Types.lean`

## Model scope

This is an internal simplified framing/roundtrip model. External Zstandard interoperability and compression ratios are not measured.
