# CJSON

## Background

cJSON is an ultralightweight JSON parser written in C. It provides functions to parse JSON strings into a tree structure, serialize JSON trees back to strings, and manipulate JSON objects and arrays. In this Lean formalization, JSON is represented as an inductive type with six variants (null, bool, number, string, array, object), and the core spec covers parsing, printing, and object construction.

## Task

Complete implementation holes in explicitly editable regions in the split files under `CJSON/` and complete the proof obligations assigned to editable regions. Helper definitions are grouped in `CJSON/Helpers.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `parse`

- **Signature**: `def parse (input : String) : Option JSON`
- **Description**: Parse a JSON string into a `JSON` value. Returns `none` for invalid input.
- **Postcondition**: Structural spec organized as:
  - rejected inputs such as empty input, unmatched brackets, bare words, and stray punctuation return `none`
  - keyword inputs map to `null` / `true` / `false`
  - empty collection/string literals map to `[]`, `{}`, and `""`
  - successful parses have a result shape consistent with the leading character of the input
  - successful parses satisfy the `parse (print r) = some r` roundtrip property
  - non-empty parsed arrays have head/tail structure
- **Key constraints**: Must handle all JSON constructors. The roundtrip property means `parse` and `print` must be implemented consistently. Number parsing must still handle negative numbers and digit-prefixed inputs.

### 2. `print`

- **Signature**: `def print (j : JSON) : String`
- **Description**: Serialize a JSON value to a compact (non-formatted) string.
- **Postcondition**: Structural spec by JSON constructor:
  - Output is never empty
  - `null` prints as `"null"`
  - booleans print as `"true"` / `"false"`
  - numbers produce a non-empty string starting with `-`, `n`, or a digit
  - strings are quoted and contain the payload
  - arrays are bracketed, print `[]` when empty, and contain the printed form of every element
  - objects are braced, print `{}` when empty, and contain every quoted key and printed value
- **Key constraints**: The format must be compatible with `parse` for the roundtrip property to hold.

### 3. `addItemToObject`

- **Signature**: `def addItemToObject (j : JSON) (key : String) (item : JSON) : JSON`
- **Description**: Add (or replace) a key-value pair in a JSON object.
- **Postcondition**: Four requirements:
  1. `getItem result key = some item` (the new item is retrievable)
  2. Result is a `JSON.object` (always produces an object)
  3. Other keys from the original object are preserved (`getItem result k = some v` for `k ≠ key`)
  4. Result object has at least as many entries as the original
- **Key constraints**: If the key already exists, it should be updated (not duplicated). If `j` is not an object, the behavior is still constrained — the result must be an object containing at least the new key.

## Relational Properties

- **`parse_print_rel`**: `parse(print(j)) = some j` — printing any JSON value and parsing it back recovers the original value. This is the fundamental correctness property tying `parse` and `print` together.
- **`addItemToObject_preserves_rel`**: Adding key1 with any item does not affect `getItem` for a different key2 that was already present. Formally: `key1 ≠ key2 → hasItem j key2 = true → getItem (addItemToObject j key1 item) key2 = getItem j key2`.

## Types

- **`JSON`**: An inductive type with six variants: `null`, `bool Bool`, `number Float`, `string String`, `array (List JSON)`, `object (List (String × JSON))`. Has `BEq` and `Repr` instances.

## Hints

- Implement `print` first since `parse_postcond` references `print` in the roundtrip clause. A simple recursive printer that handles each JSON variant works well.
- For numbers, check if the float is an integer (`n == Float.floor n`) and print without decimal point if so. Handle special values like `nan` and `inf`.
- For `parse`, implement a recursive descent parser. Handle whitespace stripping around values. For strings, handle escape sequences (`\"`, `\\`, etc.).
- `getItem` and `hasItem` are included as `sorry` stubs — implement them as simple list lookups on `JSON.object` (return `none`/`false` for non-objects). They are used in `addItemToObject`'s postcondition and the preserves relational spec.
- `containsSub` is already implemented (not `sorry`) — it checks if one string is a substring of another.
- For `addItemToObject`, if the input is `JSON.object kvs`, filter out any existing entry with the same key and append the new `(key, item)` pair. If the input is not an object, create a new singleton object.
- The roundtrip `parse(print(j)) = some j` is the hardest property to prove — it requires that your `print` format is exactly what your `parse` expects. Design them together.

## Edit Boundaries

The split files under `CJSON/` are divided into labeled sections:

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

- `CJSON/AddItemToObject.lean`
- `CJSON/Helpers.lean`
- `CJSON/Parse.lean`
- `CJSON/Print.lean`
- `CJSON/Relations.lean`
- `CJSON/Types.lean`
