# Marshmallow

## Background

Marshmallow is a Python library for object serialization, deserialization, and validation. It uses schema definitions (collections of typed fields with metadata) to convert between complex data types and simple dictionaries, with built-in validation for required fields, type checking, and handling of missing/unknown fields. This core spec focuses on the three essential operations: serializing data through a schema (dump), deserializing data through a schema (load), and validating data against a schema without conversion.

## Task

Complete implementation holes in explicitly editable regions in `Marshmallow/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `Schema.dump`

- **Signature**: `def Schema.dump (s : Schema) (data : Value) (registry : SchemaRegistry := .empty) : Except ValidationError Value`
- **Description**: Serializes a `Value.dict` through a schema, producing a new dict with only the schema's dump-enabled fields, applying any dataKey renaming.
- **Postcondition** (4 clauses):
  - Fields with `dump = false` are excluded from the output dict
  - Fields with `dump = true` that are present in the input appear in the output (using `dataKey` if set, otherwise `name`)
  - Successful result is always a `Value.dict`
  - Required fields with `missing = raise` that are absent from input → error
- **Key constraints**: Precondition requires input is a `Value.dict`. The `dataKey` option allows the serialized key name to differ from the field name.

### 2. `Schema.load`

- **Signature**: `def Schema.load (s : Schema) (data : Value) (registry : SchemaRegistry := .empty) : Except ValidationError Value`
- **Description**: Deserializes a `Value.dict` through a schema, producing a new dict with the schema's load-enabled fields, applying dataKey resolution in reverse.
- **Postcondition** (4 clauses):
  - Fields with `load = false` are excluded from the output dict
  - Required fields with `missing = raise` that are absent → error
  - Successful result is always a `Value.dict`
  - Fields with `load = true` present in input (looked up by `dataKey` or `name`) appear in output under `name`
- **Key constraints**: Load reads from the input using `dataKey` (if set) but writes to the output using `name`. This is the inverse of dump's key mapping.

### 3. `Schema.validate`

- **Signature**: `def Schema.validate (s : Schema) (data : Value) : Except ValidationError Unit`
- **Description**: Validates data against a schema without performing conversion. Checks that all required fields are present and no unknown fields exist (when `unknown = raise`).
- **Postcondition** (2 bidirectional clauses):
  - If validation succeeds → all required fields with `missing = raise` exist in the input dict
  - If all required fields present AND `unknown = raise` AND all input keys match schema fields → validation succeeds
- **Key constraints**: The second clause makes the postcondition bidirectional — not just "success implies valid" but also "valid implies success". Unknown field handling depends on `schema.options.unknown`.

## Relational Properties

- **`dump_load_roundtrip`**: When all fields have `dump = true` and `load = true`, `load(dump(data)) = data` — serializing then deserializing recovers the original.
- **`load_dump_roundtrip`**: When all fields have `dump = true` and `load = true`, `dump(load(data)) = data` — deserializing then serializing recovers the original.
- **`missing_optional_default`**: When a field has `missing = useDefault dflt` and the field is absent from input, `load` produces the default value for that field in the result.

## Types

- **`Value`**: A dynamically-typed value: null, bool, int, float, str, list, or dict (list of key-value pairs).
- **`ValidationError`**: A collection of `FieldError`s, each with a field name and list of error messages.
- **`MissingBehavior`**: How to handle missing fields: `raise` (error), `useDefault val` (use default), `exclude` (skip).
- **`FieldMeta`**: Field metadata: `name`, optional `dataKey` (serialized key name), `required`, `allowNone`, `missing` behavior, `dump`/`load` flags.
- **`Field`**: A typed field definition (string, integer, float, boolean, dateTime, date, list, nested, dict, email, url, uuid, enum, constant, raw, method) with associated `FieldMeta`.
- **`UnknownFields`**: How to handle unknown fields: `raise` (error), `exclude` (ignore), `include` (pass through).
- **`Schema`**: A schema with `name`, `fields` (list of Field), and `options` (SchemaOptions including unknown field handling).
- **`SchemaRegistry`**: A registry mapping schema names to schemas (for nested field resolution).

## Hints

- **`Field.getMeta`** is already implemented — it extracts the `FieldMeta` from any `Field` variant.
- **`SchemaRegistry.empty`** is pre-implemented as `{ schemas := [] }`.
- For `Schema.dump`, iterate over `s.fields`. For each field with `dump = true`, look up the field's value in the input dict (by `name`), and write it to the output dict (using `dataKey` if set, otherwise `name`). Skip fields with `dump = false`. For required fields with `missing = raise`, return an error if absent.
- For `Schema.load`, iterate over `s.fields`. For each field with `load = true`, look up the value in the input dict by `dataKey` (or `name` if no dataKey), and write it to the output dict under `name`. Handle missing fields according to `MissingBehavior`: `raise` → error, `useDefault dflt` → use the default, `exclude` → skip.
- For `Schema.validate`, check that all required+raise fields are present in the input. If `options.unknown = raise`, also check that no input keys are outside the schema's field names.
- The roundtrip proofs require dump and load to be exact inverses when all fields have both `dump = true` and `load = true`. Ensure the dataKey mapping is correctly inverted between dump and load.
- The `missing_optional_default` proof requires that when `missing = useDefault dflt`, load inserts `(name, dflt)` into the result when the field is absent from input.

## Edit Boundaries

`Marshmallow/*.lean` is divided into labeled sections:

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

- `Marshmallow/Dump.lean`
- `Marshmallow/Helpers.lean`
- `Marshmallow/Load.lean`
- `Marshmallow/Relations.lean`
- `Marshmallow/Types.lean`
- `Marshmallow/Validate.lean`
