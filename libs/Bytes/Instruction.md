# Bytes

## Background

Bytes is a Rust crate providing efficient byte buffer abstractions for network programming and serialization. It offers three core types: `Bytes` (an immutable byte sequence), `BytesMut` (a mutable byte buffer with capacity management), and `BufReader` (a cursor-based reader over byte data). This spec models these as pure functional operations on byte lists (`List UInt8`).

## Task

Complete implementation holes in explicitly editable regions in the split files under `Bytes/` and complete the proof obligations assigned to editable regions. The helper definitions are grouped together in `Bytes/Helpers.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `Bytes.splitAt`

- **Signature**: `def Bytes.splitAt (b : Bytes) (pos : Nat) : Bytes × Bytes`
- **Description**: Split an immutable byte sequence at position `pos`, returning a pair of (prefix of length `pos`, remaining suffix).
- **Postcondition** (`Bytes.splitAt_postcond`):
  - When `pos ≤ b.len`: prefix length + suffix length = total length
  - When `pos ≤ b.len`: concatenating prefix and suffix data recovers original data
  - When `pos ≤ b.len`: prefix length = `pos`
  - Always: prefix data = `b.data.take pos` and suffix data = `b.data.drop pos`
- **Key constraints**: The last two conditions hold unconditionally (even when `pos > b.len`, `take`/`drop` handle it gracefully).

### 2. `BytesMut.putU32Le`

- **Signature**: `def BytesMut.putU32Le (b : BytesMut) (v : UInt32) : BytesMut`
- **Description**: Append a 32-bit unsigned integer to the buffer in little-endian byte order (least significant byte first).
- **Postcondition** (`BytesMut.putU32Le_postcond`):
  - Result length = original length + 4
  - Result data = original data ++ [byte0, byte1, byte2, byte3] where:
    - byte0 = `v % 256` (least significant)
    - byte1 = `(v / 256) % 256`
    - byte2 = `(v / 65536) % 256`
    - byte3 = `(v / 16777216) % 256` (most significant)
- **Key constraints**: The byte decomposition uses `UInt8.ofNat` with specific mod/div arithmetic. The `len` postcondition depends on `BytesMut.len` returning `data.length`.

### 3. `BufReader.getU8`

- **Signature**: `def BufReader.getU8 (r : BufReader) : Option (UInt8 × BufReader)`
- **Description**: Read a single byte at the current cursor position and return it along with an advanced reader. Returns `none` if no bytes remain.
- **Postcondition** (`BufReader.getU8_postcond`):
  - When remaining = 0: returns `none`
  - On success `(v, r')`: remaining decreases by 1
  - On success `(v, r')`: `v` equals `r.data[r.pos]`
  - On success `(v, r')`: new reader has same data but `pos + 1`
- **Key constraints**: `remaining` is defined as `data.length - pos`. The reader is immutable — `getU8` doesn't modify `data`, only advances `pos`.

## Types

- **`Bytes`**: An immutable byte sequence wrapping `data : List UInt8`.
- **`BytesMut`**: A mutable byte buffer with `data : List UInt8` and `capacity' : Nat`. In this pure functional model, capacity is tracked but not enforced (the buffer always grows as needed).
- **`BufReader`**: A cursor-based reader with `data : List UInt8` and `pos : Nat`. Reading advances `pos` without modifying `data`.

## Hints

- `Bytes.splitAt` is straightforward: construct the pair using `List.take` and `List.drop`. The proof mostly follows from standard list lemmas (`List.take_append_drop`, etc.).
- `BytesMut.putU32Le`: construct the 4 bytes using the exact arithmetic from the postcondition. For the `len` proof, you'll need to show that appending a 4-element list increases length by 4.
- `BufReader.getU8`: check if `pos < data.length`; if so, return `(data[pos], { data, pos := pos + 1 })`; otherwise return `none`. The `remaining` helper needs to be implemented as `data.length - pos`.
- `Bytes.len`, `BytesMut.len`, and `BufReader.remaining` are helper functions whose postconditions are trivial — they just return the corresponding field/computation. Implement them first as other postconditions depend on them.

## Edit Boundaries

The split files under `Bytes/` are divided into labeled sections:

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

- `Bytes/GetU8.lean`
- `Bytes/Helpers.lean`
- `Bytes/PutU32Le.lean`
- `Bytes/SplitAt.lean`
- `Bytes/Types.lean`
