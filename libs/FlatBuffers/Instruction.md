# FlatBuffers

## Background

FlatBuffers is Google's cross-platform zero-copy serialization library, designed for performance-critical applications like games and real-time systems. Unlike Protocol Buffers, FlatBuffers allows direct access to serialized data without parsing/unpacking. Data is stored in a binary format with strict alignment requirements, using vtables for optional field access and little-endian encoding throughout.

## Task

Complete implementation holes in explicitly editable regions in `FlatBuffers/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `serialize`

- **Signature**: `def serialize (schema : Schema) (v : Value) : Option (List UInt8)`
- **Description**: Serialize a `Value` according to a `Schema` into a FlatBuffer binary format (list of bytes). Returns `none` for invalid input (e.g., `Value.null`).
- **Postcondition**: `serialize_postcond` requires:
  - On success, the buffer is non-empty
  - Buffer length is a multiple of 4 (alignment invariant)
  - Buffer length is at least 4 bytes (room for root offset)
  - `Value.null` always returns `none`
  - The first 4 bytes (little-endian UInt32) encode a valid root offset that is less than the buffer length
  - If the value is a table, the buffer is at least 12 bytes (root offset + vtable offset + minimal vtable)
- **Key constraints**: The root offset is stored as a little-endian 32-bit integer in the first 4 bytes. The 4-byte alignment must hold for the entire buffer. Tables require additional overhead for vtables.

### 2. `Builder.addFieldInt`

- **Signature**: `def Builder.addFieldInt (b : Builder) (fieldIdx : Nat) (val : Int) (default : Int) : Builder`
- **Description**: Add an integer field to the table currently being built. If the value equals the default, nothing is written (FlatBuffers' key space optimization).
- **Postcondition**: `Builder.addFieldInt_postcond` requires:
  - Buffer never shrinks: `result.buffer.length ≥ b.buffer.length`
  - Builder remains unfinished: `result.finished = false`
  - If `val ≠ default`: buffer grows by exactly 4 bytes (one 32-bit int)
  - If `val = default`: buffer size stays the same (field is skipped)
- **Key constraints**: The default-value optimization is central to FlatBuffers' efficiency — fields with default values occupy zero space in the buffer. The `fieldIdx` identifies which slot in the vtable this field corresponds to.

### 3. `alignTo`

- **Signature**: `def alignTo (offset alignment : Nat) : Nat`
- **Description**: Round up an offset to the next multiple of the given alignment. This is the fundamental alignment primitive used throughout FlatBuffers for ensuring data is properly aligned in memory.
- **Postcondition**: `alignTo_postcond` requires:
  - Result is at least `offset` (never rounds down)
  - When `alignment > 0`, result is divisible by `alignment`
  - When `alignment > 0`, result is strictly less than `offset + alignment` (minimal alignment — doesn't skip past the next boundary)
- **Key constraints**: The three properties together uniquely determine the result: it's the smallest value ≥ `offset` that is a multiple of `alignment`. When `alignment = 0`, only the first constraint applies.

## Relational Properties

- **`serialize_deserialize_rel`**: Serializing a value and then deserializing the resulting buffer recovers the original value exactly. This is the fundamental correctness property of any serialization library.
- **`alignTo_idempotent_rel`**: Aligning an already-aligned value produces the same value. Formally: `alignment > 0 → alignTo (alignTo offset alignment) alignment = alignTo offset alignment`.

## Types

- **`ScalarType`**: Enumeration of FlatBuffers scalar types: `bool`, `int8/16/32/64`, `uint8/16/32/64`, `float32/64`.
- **`FieldType`**: Type of a field — can be a scalar, string, vector (of another FieldType), table/struct/enum/union reference.
- **`FieldDef`**: A field definition with name, type, optional default value, and deprecated flag.
- **`TableDef`**: A table schema with name and list of field definitions.
- **`StructDef`**: A struct schema with name and list of (name, ScalarType) pairs.
- **`EnumDef`**: An enum with name and list of (name, value) pairs.
- **`Schema`**: The complete schema: lists of tables, structs, enums, and a root type name.
- **`Value`**: A runtime value — bool, int, float, string, vector (of Values), table (name + field values), struct, or null.
- **`Builder`**: The serialization state: `buffer` (bytes written so far), `vtables` (for deduplication), and `finished` flag.

## Hints

- For `alignTo`, the standard formula is: `((offset + alignment - 1) / alignment) * alignment`. Handle `alignment = 0` as a special case (return `offset`).
- For `Builder.addFieldInt`, the implementation is straightforward: if `val = default`, return the builder unchanged; otherwise, append 4 bytes (the little-endian encoding of `val`) to the buffer.
- For `serialize`, you need to build a complete FlatBuffer:
  1. Create a Builder
  2. Recursively write the value (strings and vectors first, then tables with vtables)
  3. Call finish with the root table offset
  4. Return the buffer bytes
  - The root offset (first 4 bytes, little-endian) must point to the root table within the buffer
- `deserialize` is also `sorry` — implement it consistently with `serialize` for the roundtrip proof.
- The `alignTo_idempotent` proof follows directly from the postcondition: if `result % alignment = 0` and `result ≥ result`, then `alignTo result alignment = result`.

## Edit Boundaries

`FlatBuffers/*.lean` is divided into labeled sections:

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

- `FlatBuffers/AlignTo.lean`
- `FlatBuffers/BuilderAddFieldInt.lean`
- `FlatBuffers/Relations.lean`
- `FlatBuffers/Serialize.lean`
- `FlatBuffers/Types.lean`

## Published model limits (v3)

Serialization success is required for the explicit primitive domain, including bounded int32 values. General FlatBuffers schema interoperability is not implied.
