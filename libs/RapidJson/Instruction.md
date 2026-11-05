# RapidJson

## Background

RapidJson is a high-performance C++ JSON library developed by Tencent, providing both DOM and SAX APIs for JSON parsing, serialization, JSON Pointer navigation, and JSON Schema validation. This spec covers the three core operations: parsing JSON strings into a value tree, serializing values back to strings, and validating values against JSON Schema types.

## Task

Complete implementation holes in explicitly editable regions in the `RapidJson/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `parse`

- **Signature**: `def parse (input : String) : Option Value`
- **Description**: Parse a JSON string into a `Value` tree. Returns `none` for invalid JSON.
- **Postcondition**: `parse_postcond` requires 12 specific input→output mappings:
  - `""` → `none` (empty string is invalid)
  - `"null"` → `some Value.null`
  - `"true"` / `"false"` → `some (Value.bool true/false)`
  - `"0"` → `some (Value.uint 0)`, `"42"` → `some (Value.uint 42)`, `"-1"` → `some (Value.int (-1))`
  - `"\"hello\""` → `some (Value.string "hello")`, `"\"\""` → `some (Value.string "")`
  - `"[]"` → `some (Value.array [])`, `"{}"` → `some (Value.object [])`
  - `"invalid"` → `none`
- **Key constraints**: Non-negative integers should be parsed as `Value.uint`, negative integers as `Value.int`. Strings include the surrounding quotes in the input.

### 2. `serialize`

- **Signature**: `def serialize (v : Value) : String`
- **Description**: Serialize a `Value` tree to a compact JSON string (no extra whitespace).
- **Postcondition**: `serialize_postcond` requires:
  - Result is never empty
  - 13 specific value→string mappings covering all types:
    - `Value.null` → `"null"`, booleans → `"true"`/`"false"`
    - `Value.int 0` → `"0"`, `Value.int (-1)` → `"-1"`, `Value.int 42` → `"42"`
    - `Value.uint 0` → `"0"`, `Value.uint 100` → `"100"`
    - `Value.string ""` → `"\"\""`, `Value.string "hello"` → `"\"hello\""`
    - `Value.array []` → `"[]"`, `Value.object []` → `"{}"`
- **Key constraints**: Both `Value.int 0` and `Value.uint 0` must serialize to `"0"`. The serialization must be compact (no spaces).

### 3. `validate`

- **Signature**: `def validate (schema : SchemaType) (v : Value) : Bool`
- **Description**: Validate a JSON value against a schema type, returning whether the value conforms.
- **Postcondition**: `validate_postcond` requires 9 clauses (most are iff):
  - `SchemaType.any` → always `true`
  - `SchemaType.null` → `true` iff `v = Value.null`
  - `SchemaType.boolean` → `true` iff `v` is a bool
  - `SchemaType.integer none none` → `true` iff `v` is int or uint
  - `SchemaType.number none none` → `true` iff `v` is int, uint, or double
  - `SchemaType.string none none none` → `true` iff `v` is a string
  - `SchemaType.array none none none` → `true` iff `v` is an array
  - `SchemaType.object [] []` → `true` iff `v` is an object
  - `SchemaType.enum []` → always `false`
- **Key constraints**: The postcondition covers schemas with no constraints (`none`/`[]` parameters). The `integer` schema accepts both `Value.int` and `Value.uint`. The `number` schema additionally accepts `Value.double`.

## Relational Properties

- **`parse_serialize_rel`**: For any value `v`, `parse (serialize v) = some v`. This is the fundamental roundtrip property — serializing then parsing recovers the original value.

## Types

- **`Value`** — A JSON value: `null`, `bool`, `int` (signed), `uint` (unsigned), `double` (float), `string`, `array` (list of values), or `object` (list of key-value pairs). Note the distinction between `int` and `uint` — non-negative integers use `uint`.
- **`SchemaType`** — A JSON Schema type descriptor: `any`, `null`, `boolean`, `integer` (with optional min/max), `number` (with optional min/max), `string` (with optional length/pattern constraints), `array` (with optional item schema and count constraints), `object` (with required fields and property schemas), `oneOf`, or `enum`.

## Hints

- For `parse`, implement a recursive descent parser. Handle each JSON type: null, booleans, numbers (distinguish negative for `int` vs non-negative for `uint`), quoted strings, arrays (`[...]`), and objects (`{...}`). Return `none` for any parse failure.
- For `serialize`, match on the `Value` variant: null → `"null"`, booleans → `"true"`/`"false"`, integers → `toString`, strings → wrap in quotes, arrays → `[item1,item2,...]`, objects → `{"key1":val1,"key2":val2,...}`.
- For `validate`, match on the `SchemaType` and check if the value matches. The unconstrained cases (with `none`/`[]` parameters) are pure type checks.
- The roundtrip proof `parse_serialize_spec` requires that `parse` and `serialize` are consistent — `serialize` must produce output that `parse` can read back to the same value. This is the hardest proof and may require structural induction on `Value`.
- `Value.int 0` and `Value.uint 0` both serialize to `"0"`, but `parse "0"` must return `Value.uint 0` (non-negative integers default to uint).

## Edit Boundaries

`RapidJson/*.lean` is divided into labeled sections:

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

- `RapidJson/Parse.lean`
- `RapidJson/Relations.lean`
- `RapidJson/Serialize.lean`
- `RapidJson/Types.lean`
- `RapidJson/Validate.lean`

## Model scope

The formal contracts specify the included simplified JSON model; they do not establish upstream implementation equivalence.
