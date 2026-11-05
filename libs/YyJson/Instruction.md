# YyJson

## Background

YyJson is a fast JSON library (originally in C) providing immutable and mutable document APIs. It supports parsing JSON strings into a document tree, serializing documents back to JSON, accessing nested values, mutation operations, JSON Pointer (RFC 6901), JSON Patch (RFC 6902), and Merge Patch (RFC 7396). This spec covers the core pipeline: parsing, serialization, and object field access.

## Task

Complete implementation holes in explicitly editable regions in `YyJson/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `read`

- **Signature**: `def read (input : String) : Option Doc`
- **Description**: Parse a JSON string into a document. Returns `none` for invalid or empty input.
- **Postcondition**: `read_postcond` requires (8 clauses):
  - Empty string → `none`
  - `"null"` → `some { root := Val.null }`
  - `"true"` → `some { root := Val.bool true }`
  - `"false"` → `some { root := Val.bool false }`
  - If result is `some d`, root is non-null unless input is `"null"`
  - Input starting with `[` → root is an array
  - Input starting with `{` → root is an object
  - Input starting with `"` → root is a string
- **Key constraints**: The parser must handle all JSON value types. The postcondition checks structural properties (first character determines root type) rather than exact parsing of complex structures.

### 2. `write`

- **Signature**: `def write (d : Doc) : String`
- **Description**: Serialize a document to a compact (minified) JSON string.
- **Postcondition**: `write_postcond` requires (9 clauses):
  - Output is never empty
  - Null root → `"null"`
  - Bool root → `"true"` or `"false"`
  - Array root → starts with `[`, ends with `]`
  - Object root → starts with `{`, ends with `}`
  - String root → starts with `"`, ends with `"`
  - Int root → `toString n`
  - Empty array → `"[]"`
  - Empty object → `"{}"`
- **Key constraints**: Integer serialization must match Lean's `toString`. String values must be quoted. Arrays and objects must have matching brackets.

### 3. `Val.objGet`

- **Signature**: `def Val.objGet (v : Val) (key : String) : Option Val`
- **Description**: Look up a value by key in a JSON object. Returns `none` if the value is not an object or the key is not found.
- **Postcondition**: `Val.objGet_postcond` requires (5 clauses):
  - Non-object value → `none`
  - If key exists in the object's entries, result is not `none`
  - Empty object → `none`
  - If result is `some val`, then `(key, val)` is in the entries
  - If no entry has the key, result is `none`
- **Key constraints**: The result must come from the actual key-value pairs in the object. When multiple entries have the same key, return the first match.

## Relational Properties

- **`read_write`**: For any value `v`, `read (write { root := v })` succeeds and recovers `v`. Specifically: the written string is non-empty, parsing succeeds (result ≠ none), and the parsed document's root equals `v`.

## Types

- **`ValType`** — JSON value type tags: null, bool, int, real, str, arr, obj
- **`Val`** — JSON value: null, bool (Bool), int (Int), real (Float), str (String), arr (List Val), obj (List (String × Val))
- **`Doc`** — A JSON document wrapping a root Val

## Hints

- For `read`, implement a recursive descent JSON parser. Handle the simple cases first (null, true, false), then strings, numbers, arrays, and objects.
- For `write`, recursively serialize each Val variant. Null/bool/int have exact string outputs. Strings need quoting. Arrays join elements with `,` inside `[]`. Objects format as `{"key":value,...}`.
- For `Val.objGet`, iterate through the `List (String × Val)` entries and return the first matching value. Return `none` for non-object values.
- The `read_write` roundtrip spec is the strongest constraint — your `read` must be able to parse the output of your `write`. Ensure consistent formatting (e.g., no trailing commas, proper quoting).
- Note that `Val.real` uses `Float` — JSON floating-point serialization/parsing can be tricky. The postconditions don't constrain float formatting specifically, but the roundtrip must work.

## Edit Boundaries

`YyJson/*.lean` is divided into labeled sections:

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

- `YyJson/ObjGet.lean`
- `YyJson/Read.lean`
- `YyJson/Types.lean`
- `YyJson/Write.lean`
