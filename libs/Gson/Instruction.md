# Gson

## Background

Gson is Google's Java library for converting between Java objects and JSON. It provides JSON parsing (string to structured data), serialization (structured data to string), and manipulation (navigating, querying, and modifying JSON trees). This core spec focuses on the three essential operations: parsing JSON strings, serializing JSON elements back to strings, and adding key-value pairs to JSON objects.

## Task

Complete implementation holes in explicitly editable regions in `Gson/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `parse`

- **Signature**: `def parse (s : String) : Option JsonElement`
- **Description**: Parses a JSON string into a `JsonElement`. Returns `none` for invalid input.
- **Postcondition**: 20 concrete test cases:
  - `"null"` → `jsonNull`, `"true"` → `jsonBool true`, `"false"` → `jsonBool false`
  - `"0"`, `"1"`, `"42"`, `"-1"`, `"100"` → corresponding `jsonInt` values
  - `"\"hello\""`, `"\"\""`, `"\"abc\""` → corresponding `jsonString` values
  - `"[]"` → `jsonArray []`, `"{}"` → `jsonObject []`
  - `"[1,2,3]"` → `jsonArray [jsonInt 1, jsonInt 2, jsonInt 3]`
  - `"[null]"` → `jsonArray [jsonNull]`
  - `""`, `"invalid"`, `"NULL"`, `"TRUE"`, `"FALSE"` → `none`
- **Key constraints**: JSON is case-sensitive (`null` ≠ `NULL`). Empty string is invalid. Must handle nested arrays and objects.

### 2. `toCompactString`

- **Signature**: `def toCompactString (e : JsonElement) : String`
- **Description**: Serializes a `JsonElement` to its compact JSON string representation (no extra whitespace).
- **Postcondition**: `parse result = some e` — the serialized string, when parsed back, recovers the original element exactly.
- **Key constraints**: This is a very strong spec — the output must be valid JSON that round-trips perfectly through `parse`. Must handle all `JsonElement` constructors (null, bool, int, float, string, array, object).

### 3. `JsonElement.add`

- **Signature**: `def JsonElement.add (obj : JsonElement) (key : String) (value : JsonElement) : JsonElement`
- **Description**: Adds (or updates) a key-value pair in a JSON object.
- **Postcondition**: When `obj = jsonObject entries`:
  - Result is a `jsonObject entries'`
  - `entries'.find? (fun (k, _) => k == key) = some (key, value)` — the key maps to the new value
  - For all other keys `k ≠ key`, entries from the original are preserved in the result
- **Key constraints**: Must handle both inserting a new key and updating an existing one. Only applies when the input is a `jsonObject`.

### 4. `JsonElement.has` (helper)

- **Signature**: `def JsonElement.has (obj : JsonElement) (key : String) : Bool`
- **Description**: Checks if a JSON object contains a given key. Returns `false` for non-object elements.
- **Key constraints**: No separate postcondition theorem, but referenced by the `add_then_has` relational spec.

## Relational Properties

- **`parse_toCompactString_roundtrip`**: `parse (toCompactString e) = some e` — serializing then parsing recovers the original element. (Same as `toCompactString`'s postcondition, stated as a relational property.)
- **`add_then_has`**: `has (add obj key value) key = true` — after adding a key-value pair, `has` returns true for that key.

## Types

- **`JsonElement`**: The core JSON type with 7 constructors:
  - `jsonNull` — JSON null
  - `jsonBool b` — JSON boolean
  - `jsonInt n` — JSON integer (modeled as `Int`)
  - `jsonFloat f` — JSON floating-point number
  - `jsonString s` — JSON string
  - `jsonArray elems` — JSON array (list of elements)
  - `jsonObject entries` — JSON object (list of key-value pairs, where keys are `String`)

## Hints

- For `parse`, implement a recursive descent parser. Handle the simple cases first (null, true, false), then numbers, strings (between quotes), arrays (between `[]`), and objects (between `{}`). For the concrete test cases, the parser must handle: no whitespace in compact form, comma-separated array elements, colon-separated key-value pairs.
- For `toCompactString`, pattern match on `JsonElement`:
  - `jsonNull` → `"null"`, `jsonBool true` → `"true"`, `jsonBool false` → `"false"`
  - `jsonInt n` → `toString n`, `jsonFloat f` → appropriate float representation
  - `jsonString s` → `"\"" ++ s ++ "\""` (with proper escaping if needed)
  - `jsonArray elems` → `"[" ++ comma-separated recursive calls ++ "]"`
  - `jsonObject entries` → `"{" ++ comma-separated "key":value pairs ++ "}"`
- The roundtrip proof is the hardest part — `parse` and `toCompactString` must agree perfectly on the format. Design them together.
- For `JsonElement.add`, filter out existing entries with the same key, then append `(key, value)`. Or prepend and rely on `find?` returning the first match. Either way, ensure `find?` on the result returns `(key, value)`.
- For `JsonElement.has`, check if any entry in the object's list has a matching key. Return `false` for non-object inputs.

## Edit Boundaries

`Gson/*.lean` is divided into labeled sections:

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

- `Gson/Helpers.lean`
- `Gson/JsonElementAdd.lean`
- `Gson/Parse.lean`
- `Gson/Relations.lean`
- `Gson/ToCompactString.lean`
- `Gson/Types.lean`
