# Serde

## Background

Serde is Rust's most fundamental serialization/deserialization framework. It defines a universal data model (`Value`) and type classes (`Serialize`/`Deserialize`) for converting between Rust types and this data model. It also provides "serde attributes" for customizing serialization behavior (field renaming, flattening, defaults). This spec covers the core workflow: serializing Option types, deserializing Option types, and applying field rename transformations, plus roundtrip properties proving serialize→deserialize identity.

## Task

Complete implementation holes in explicitly editable regions in:

- `Serde/Helpers.lean`
- `Serde/SerializeOption.lean`
- `Serde/DeserializeOption.lean`
- `Serde/RenameField.lean`
- `Serde/Relations.lean`

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `serializeOption`

- **Signature**: `def serializeOption [Serialize α] (o : Option α) : Value`
- **Description**: Serialize an `Option α` value into the Serde data model. `none` becomes `Value.none`, `some a` becomes `Value.some (Serialize.serialize a)`.
- **Postcondition**: `serializeOption_postcond` requires:
  - `o = none` → `result = Value.none`
  - `o = some a` → `result = Value.some (Serialize.serialize a)`
- **Key constraints**: Must use the `Serialize` instance for `α` to serialize the inner value. The two cases are exhaustive.

### 2. `deserializeOption`

- **Signature**: `def deserializeOption [Deserialize α] (v : Value) : Option (Option α)`
- **Description**: Deserialize a `Value` into `Option (Option α)`. The outer `Option` represents deserialization success/failure; the inner `Option` represents the actual value.
- **Postcondition**: `deserializeOption_postcond` requires:
  - `v = Value.none` → `result = some none` (successfully deserialized as None)
  - `v = Value.some inner` → if inner deserializes to `none`, result is `some none`; if inner deserializes to `some a`, result is `some (some a)`
- **Key constraints**: Uses the `Deserialize` instance for `α` to deserialize the inner value. When the inner deserialization fails, the result is `some none` (not `none`), meaning "successfully deserialized as an absent value."

### 3. `renameField`

- **Signature**: `def renameField (v : Value) (oldName newName : String) : Value`
- **Description**: Rename a field in a Serde struct value — the `#[serde(rename = "...")]` attribute behavior.
- **Postcondition**: `renameField_postcond` requires:
  - `structGetField result newName = structGetField v oldName` (new name gets old value)
  - If `oldName ≠ newName`: `structGetField result oldName = none` (old field removed)
  - For all other fields `f ≠ oldName ∧ f ≠ newName`: `structGetField result f = structGetField v f` (preserved)
- **Key constraints**: If the old field doesn't exist, the rename is a no-op for that field. If `oldName = newName`, the value is unchanged. The rename must not affect unrelated fields.

## Relational Properties

- **`roundtrip_rel`** (3 theorems): `roundtrip b = some b` for Bool, `roundtrip n = some n` for Int, `roundtrip s = some s` for String. These prove that serializing then deserializing a primitive value recovers the original. The `roundtrip` function is `Deserialize.deserialize (Serialize.serialize a)`.

## Types

- **`Value`** — The universal Serde data model: bool, int, float, char, string, bytes, none, some (wrapping a Value), unit, seq (list), map (key-value pairs), newtype (named wrapper), struct (named fields), enum (variant with optional payload)
- **`Serialize α`** — Type class: `serialize : α → Value`
- **`Deserialize α`** — Type class: `deserialize : Value → Option α`

## Hints

- **Primitive Serialize instances** are already implemented (not sorry): `Bool → Value.bool`, `Int → Value.int`, etc.
- **Primitive deserialize functions** (`deserializeBool`, `deserializeInt`, etc.) must be implemented — they're straightforward pattern matches (e.g., `deserializeBool (Value.bool b) = some b`, otherwise `none`).
- **`structGetField`** and **`structFields`** must be implemented — they're list lookups on struct field lists. `structGetField (Value.struct name fields) field` looks up `field` in `fields`.
- **`roundtrip`** must be implemented as `Deserialize.deserialize (Serialize.serialize a)`.
- For `serializeOption`, match on the Option: `none` → `Value.none`, `some a` → `Value.some (Serialize.serialize a)`.
- For `deserializeOption`, match on the Value: `Value.none` → `some none`, `Value.some inner` → apply `Deserialize.deserialize` to inner and wrap.
- For `renameField`, look up the old field in the struct, remove it, and insert with the new name. If the value isn't a struct, return it unchanged.

## Edit Boundaries

The editable task files are divided into labeled sections:

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

- `Serde/DeserializeOption.lean`
- `Serde/Helpers.lean`
- `Serde/Relations.lean`
- `Serde/RenameField.lean`
- `Serde/SerializeOption.lean`
- `Serde/Types.lean`
