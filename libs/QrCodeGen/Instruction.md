# QrCodeGen

## Background

QrCodeGen is a QR code generator library (ported from C) that implements the ISO 18004 standard. It covers the full QR code pipeline: data encoding into bitstreams, Reed-Solomon error correction over GF(256), module placement on a 2D grid, masking to optimize readability, and format/version information embedding. This spec focuses on byte encoding, mask application, and the top-level encode function.

## Task

Complete implementation holes in explicitly editable regions in the `QrCodeGen/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `encodeByte`

- **Signature**: `def encodeByte (data : List UInt8) : List Bool`
- **Description**: Encodes a list of bytes into a bitstream, with each byte expanded to 8 bits in MSB-first order.
- **Postcondition**: (1) Output length = `data.length * 8`. (2) For each byte at index `i` and bit position `k` (0-7), the bit at `result[i*8 + (7-k)]` equals `(data[i] / 2^k) % 2 == 1`.
- **Key constraints**: Bits are MSB-first — bit 7 (most significant) of byte `i` goes to position `i*8+0`, bit 0 (least significant) goes to position `i*8+7`. The formula uses `7-k` to reverse the bit order.

### 2. `applyMask`

- **Signature**: `def applyMask (g : Grid) (mask : MaskPattern) (functionPattern : Grid) : Grid`
- **Description**: Applies a QR mask pattern to a grid, XOR-ing data modules with the mask formula while preserving function pattern modules (finder patterns, timing patterns, etc.) unchanged.
- **Postcondition**: (1) Output size = input size. (2) Where `functionPattern` is `true`, output equals input (preserved). (3) Where `functionPattern` is `false` and position is in bounds, output = `xor(input, maskFormula(mask.index, row, col))`.
- **Key constraints**: Function pattern modules must never be masked. The `maskFormula` helper is already implemented and returns `true` when a module should be flipped. The mask is its own inverse (applying twice restores the original).

### 3. `encode`

- **Signature**: `def encode (text : String) (ecl : ErrorCorrectionLevel := .medium) : Option QrCode`
- **Description**: The top-level API that generates a complete QR code from text input with a specified error correction level.
- **Postcondition**: On success: version ∈ [1, 40], size = 4*version + 17, ECL matches input, grid dimensions = size, 7 finder pattern corner modules are dark (true), always-dark module at (size-8, 8) is true. Text of length ≤ 1 always succeeds (returns `some`).
- **Key constraints**: The full QR pipeline: select encoding mode → select version → encode data → compute ECC → place function patterns → place data bits → select and apply mask → place format info. Short text must always fit in at least version 1.

## Relational Properties

- **`applyMask_idempotent_rel`**: Applying the same mask twice restores the original grid: `applyMask (applyMask g mask fp) mask fp = g`. This works because XOR is self-inverse.

## Types

- **`ErrorCorrectionLevel`**: Four levels — `low` (~7% recovery), `medium` (~15%), `quartile` (~25%), `high` (~30%).
- **`Grid`**: A 2D grid of boolean modules (`true` = black, `false` = white) with a `size` field and `modules : List (List Bool)`.
- **`QrCode`**: A complete QR code with `version` (1-40), `ecl`, `size` (= 4*version+17), and `modules : Grid`.
- **`MaskPattern`**: Wraps an `index : Nat` (0-7) identifying one of the 8 QR mask patterns.

## Hints

- `maskFormula` is already fully implemented (not `sorry`). It implements the 8 standard QR mask formulas from ISO 18004. Use it directly.
- For `encodeByte`, iterate over each byte and extract 8 bits MSB-first. For byte value `b`, bit `k` is `(b.toNat / 2^k) % 2`. Output them in order from `k=7` down to `k=0`.
- For `applyMask`, iterate over all grid positions. If the function pattern is `true` at that position, keep the original value. Otherwise, XOR the value with `maskFormula mask.index row col`.
- The `applyMask_idempotent_rel` proof follows from `xor (xor a b) b = a` — since function pattern modules are preserved and data modules are XOR'd, applying twice cancels out.
- For `encode`, this is the most complex function. A valid (but simple) approach: always use byte mode, select the smallest version that fits, encode data + ECC, build the grid with function patterns, place data, apply the best mask, and place format info. The finder patterns are 7x7 squares at three corners with specific dark/light patterns.
- The QR size formula `4 * version + 17` means version 1 = 21x21, version 2 = 25x25, etc.

## Edit Boundaries

`QrCodeGen/*.lean` is divided into labeled sections:

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

- `QrCodeGen/ApplyMask.lean`
- `QrCodeGen/Encode.lean`
- `QrCodeGen/EncodeByte.lean`
- `QrCodeGen/Helpers.lean`
- `QrCodeGen/Relations.lean`
- `QrCodeGen/Types.lean`
- `QrCodeGen/Validity.lean`
