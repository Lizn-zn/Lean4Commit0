# Kryo

## Background

Kryo is a fast, efficient binary serialization framework for Java. It supports variable-length integer encoding (varint), type-tagged serialization of primitive and composite values, type registration with sequential IDs, and reference tracking for detecting cycles in object graphs. This core spec focuses on three essential operations: variable-length integer encoding (Kryo's signature optimization), high-level value serialization (converting a KryoValue to bytes), and deserialization (converting bytes back to a KryoValue), with a roundtrip property connecting the latter two.

## Task

Complete implementation holes in explicitly editable regions in `Kryo/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `writeVarInt`

- **Signature**: `def writeVarInt (out : Output) (n : Nat) : Output`
- **Description**: Encodes a natural number using variable-length encoding, appending 1-5 bytes to the output buffer. Small numbers use fewer bytes.
- **Postcondition**:
  - Buffer grows (length strictly increases)
  - Position advances by the number of bytes written
  - `n < 128` → 1 byte, buffer = old ++ [n as UInt8]
  - `128 ≤ n < 16384` → 2 bytes
  - `16384 ≤ n < 2097152` → 3 bytes
  - `2097152 ≤ n < 268435456` → 4 bytes
  - `268435456 ≤ n` → 5 bytes
- **Key constraints**: For the single-byte case, the exact byte value is `n.toUInt8`. For multi-byte cases, only the length is specified (not the exact byte content except for 1-byte). Use standard varint encoding: 7 bits per byte, high bit as continuation flag.

### 2. `serialize`

- **Signature**: `def serialize (value : KryoValue) : List UInt8`
- **Description**: Serializes a KryoValue to a byte list with a type tag prefix followed by the encoded value.
- **Postcondition**:
  - Result length ≥ 1
  - `null` → `[0]` (just the null tag)
  - `bool b` → `[1, if b then 1 else 0]` (tag + 1 byte, exact)
  - `int n` → `[2] ++ intToBytes4 n` (tag + 4 big-endian bytes, exact)
  - `long n` → `[3] ++ intToBytes8 n` (tag + 8 big-endian bytes, exact)
  - `float f` → tag 4, length 5 (tag + 4 IEEE bytes)
  - `double f` → tag 5, length 9 (tag + 8 IEEE bytes)
  - `char c` → `[6, c.toNat % 256]` (tag + 1 byte, exact)
  - `string s` → tag 7, length ≥ 2 + s.length
  - `array items` → tag 8, length ≥ 2
  - `object fields` → tag 9, length ≥ 2
- **Key constraints**: The exact byte sequences for null, bool, int, long, and char are fully specified using the pre-implemented `intToBytes4`/`intToBytes8` helpers. Float/double byte content is not fully pinned (only length and tag).

### 3. `deserialize`

- **Signature**: `def deserialize (bytes : List UInt8) : Option KryoValue`
- **Description**: Deserializes a byte list back into a KryoValue by reading the type tag and decoding the payload.
- **Postcondition**:
  - Empty bytes → `none`
  - If result is `some`, bytes must be non-empty
  - Null tag (0) → `some .null`
  - Each result type variant must have the correct tag as first byte (bool→1, int→2, long→3, float→4, double→5, char→6, string→7)
- **Key constraints**: The postcondition is mostly one-directional (result type → correct tag), except for the null case which is bidirectional. The roundtrip relational spec provides the stronger constraint.

## Relational Properties

- **`serialize_deserialize_roundtrip`**: `deserialize (serialize v) = some v` — serializing then deserializing any KryoValue recovers the original value exactly.

## Types

- **`KryoValue`**: A serializable value with 10 variants: `null`, `bool`, `int` (32-bit), `long` (64-bit), `float`, `double`, `char`, `string`, `array` (list of values), `object` (list of key-value pairs).
- **`Output`**: A write buffer with `buffer : List UInt8` and `position : Nat`.
- **`Input`**: A read buffer with `buffer : List UInt8` and `position : Nat`.

## Hints

- **`Output.empty`** and **`Input.fromBytes`** are pre-implemented and can be used directly.
- **`intToBytes4`** and **`intToBytes8`** are pre-implemented: they convert `Int` to big-endian 4/8-byte lists with two's complement encoding. Use them directly in `serialize` for int/long.
- **Type tag constants** (`typeTagNull` through `typeTagObject`, values 0-9) are pre-defined.
- For `writeVarInt`, implement standard varint: emit 7 bits per byte with the high bit set as a continuation flag. The last byte has high bit 0. For `n < 128`, this is just `[n.toUInt8]`.
- For `serialize`, pattern match on the `KryoValue` variant. Prepend the type tag byte, then encode the payload:
  - `null` → `[0]`
  - `bool b` → `[1, if b then 1 else 0]`
  - `int n` → `[2] ++ intToBytes4 n`
  - `long n` → `[3] ++ intToBytes8 n`
  - `float f` / `double f` → use IEEE 754 bit representation (4 or 8 bytes)
  - `char c` → `[6, (c.toNat % 256).toUInt8]`
  - `string s` → `[7]` ++ varint-encoded length ++ UTF-8 bytes
  - `array items` → `[8]` ++ varint-encoded count ++ recursively serialized items
  - `object fields` → `[9]` ++ varint-encoded count ++ recursively serialized key-value pairs
- For `deserialize`, read the first byte as the type tag, then decode the remaining bytes accordingly. Return `none` for empty input or unrecognized tags.
- The roundtrip proof requires `serialize` and `deserialize` to be exact inverses. Design them together.

## Edit Boundaries

`Kryo/*.lean` is divided into labeled sections:

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

- `Kryo/Deserialize.lean`
- `Kryo/Helpers.lean`
- `Kryo/Relations.lean`
- `Kryo/Serialize.lean`
- `Kryo/Types.lean`
- `Kryo/Validity.lean`
- `Kryo/WriteVarInt.lean`
