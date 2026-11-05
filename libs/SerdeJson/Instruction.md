# SerdeJson

## Background

serde_json is Rust's most widely-used JSON library, providing serialization (Rust values → JSON strings) and deserialization (JSON strings → Rust values). This spec models a JSON value type (RFC 8259), a compact serializer, a parser, and JSON Pointer navigation (RFC 6901) as pure functions. The key specification is the roundtrip property: serializing any JSON value and parsing it back must recover the original value.

## Task

Complete implementation holes in explicitly editable regions in:

- `SerdeJson/ToStringCompact.lean`
- `SerdeJson/Parse.lean`
- `SerdeJson/Pointer.lean`
- `SerdeJson/Relations.lean`

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `toStringCompact`

- **Signature**: `def toStringCompact (v : JsonValue) : String`
- **Description**: Serializes a JSON value into its compact string representation with no extra whitespace (matching standard JSON format).
- **Postcondition**: No individual postcondition — specified entirely through the roundtrip property with `parse`.
- **Key constraints**: Must produce valid JSON that `parse` can round-trip. Null → `"null"`, bools → `"true"`/`"false"`, numbers → numeric literal, strings → `"..."`  with proper escaping, arrays → `[...]` with comma-separated elements, objects → `{...}` with `"key":value` pairs.

### 2. `parse`

- **Signature**: `def parse (input : String) : Option JsonValue`
- **Description**: Parses a JSON string into a `JsonValue`. Returns `none` for invalid JSON.
- **Postcondition**: No individual postcondition — specified entirely through the roundtrip property with `toStringCompact`.
- **Key constraints**: Must handle all JSON types: null, booleans, numbers, strings (with escape sequences), arrays, and objects. Must be the exact inverse of `toStringCompact` for valid JSON produced by it.

### 3. `pointer`

- **Signature**: `def pointer (v : JsonValue) (path : String) : Option JsonValue`
- **Description**: Navigates a JSON value using a JSON Pointer path string (RFC 6901), e.g., `"/foo/0/bar"` navigates into object key "foo", then array index 0, then object key "bar".
- **Postcondition**: (1) Empty path `""` returns the value itself. (2) Null/bool/number/string with non-empty path → `none`. (3) Non-empty path not starting with `"/"` → `none`. (4) Single-level object: `"/key"` on an object looks up `key` via `List.lookup`. (5) Single-level array: `"/i"` on an array looks up index `i` via `xs[i]?`.
- **Key constraints**: Path segments are separated by `/`. The first character must be `/` for non-empty paths. For multi-level paths, recursively navigate through each segment. Array indices are parsed from the path segment as natural numbers.

## Relational Properties

- **`parse_toStringCompact_rel`**: For any JSON value `v`, `parse (toStringCompact v) = some v`. This is the fundamental correctness property — serialization and deserialization are inverses.

## Types

- **`JsonValue`**: An inductive type representing JSON values with 6 variants: `null`, `bool Bool`, `number Float`, `string String`, `array (List JsonValue)`, `object (List (String × JsonValue))`. Objects are modeled as association lists of key-value pairs.

## Hints

- Design `toStringCompact` and `parse` together to ensure roundtrip correctness. A simple recursive approach works for both.
- For `toStringCompact`: handle each `JsonValue` variant with a match. Strings need JSON escaping (at minimum: `\` → `\\`, `"` → `\"`, newline → `\n`, tab → `\t`). Arrays join elements with `,`. Objects produce `"key":value` pairs joined with `,`.
- For `parse`: implement a recursive descent parser. You can tokenize first (split into tokens like `{`, `}`, `:`, strings, numbers, etc.) or parse character-by-character. Handle whitespace between tokens.
- For `pointer`: split the path by `/` (skipping the leading `/`), then for each segment: if the current value is an object, look up the segment as a key; if it's an array, parse the segment as a natural number index. Use `List.lookup` for objects and `xs[i]?` for arrays.
- The roundtrip proof (`parse_toStringCompact_rel`) is the hardest part — it requires `parse` and `toStringCompact` to be perfectly consistent. Key subtlety: number formatting must be parsed back correctly. Object key ordering must be preserved.
- `List.lookup` is used for object key lookups in the `pointer_postcond`. It searches an association list by key and returns the first matching value.

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

## Revised release contract (v3)

Every template placeholder is now an explicit editable obligation, including the former provided/unmarked holes. All types, declaration headers, predicates and non-hole support source are protected. Read the validity assumptions in the theorem statements; they are part of this revised task, not the historical experiment. The optional PROOF_IMPORTS regions permit only Mathlib, Batteries, Std or Lean imports. Use local helper definitions inside implementation/proof bodies when needed.

The default root checker reconstructs an authenticated fresh task tree, builds it, checks required declarations and exact trusted types, and audits transitive axioms of all task-module declarations. A compiling template with sorry is not solved. The verdict concerns the published simplified Lean model. All original paper results remain associated with the preserved experiment version.

Current task modules (relative to this library directory):

- `SerdeJson/Parse.lean`
- `SerdeJson/Pointer.lean`
- `SerdeJson/Relations.lean`
- `SerdeJson/ToStringCompact.lean`
- `SerdeJson/Types.lean`

## Published model limits (v3)

JSON pointer lookup uses the raw-key simplified model in the Lean predicates; RFC escape decoding is not required.
