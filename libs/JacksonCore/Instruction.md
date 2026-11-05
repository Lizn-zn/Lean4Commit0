# JacksonCore

## Background

JacksonCore is Java's foundational low-level JSON processing library, providing three ways to work with JSON: a streaming parser (JsonParser) that reads tokens one at a time, a streaming generator (JsonGenerator) that writes JSON incrementally, and a tree model (TreeNode) for in-memory JSON manipulation. This spec models all three as pure state machines without actual I/O.

## Task

Complete implementation holes in explicitly editable regions in `JacksonCore/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `JsonParser.nextToken`

- **Signature**: `def JsonParser.nextToken (p : JsonParser) : Option (JsonToken × JsonParser)`
- **Description**: Advance the streaming parser to the next JSON token, returning the token and the updated parser state, or `none` if no more tokens are available.
- **Postcondition**: `JsonParser.nextToken_postcond` requires:
  - On success: position strictly advances, stays within input length, input string is preserved, `currentToken` is updated to the returned token, `closed` flag is unchanged
  - Closed parser returns `none`
  - Parser at or past end of input returns `none`
  - Token correctness: the token kind matches the first non-whitespace character at the current position (via `tokenMatchesChar`) — e.g., `{` → `startObject`, `"` → string or field name, digit/minus → number
- **Key constraints**: The `tokenMatchesChar` helper maps characters to expected token kinds. `skipWS` (already implemented) finds the first non-whitespace position. The parser must consume at least one character per `nextToken` call.

### 2. `TreeNode.navigate`

- **Signature**: `def TreeNode.navigate (t : TreeNode) (ptr : JsonPointer) : Option TreeNode`
- **Description**: Navigate a JSON tree using a JsonPointer (a list of path segments), returning the node at the target location or `none` if the path is invalid.
- **Postcondition**: `TreeNode.navigate_postcond` requires:
  - Empty pointer (`segments = []`) returns the node itself
  - Navigating from `null` with non-empty path returns `none`
  - For a single segment on an object: look up the field name; if found and no more segments, return the value
  - For two segments: navigate into nested objects (field lookup) or arrays (integer index parsing via `toNat?`)
  - For a single segment on an array: parse the segment as a natural number index; return the element if in bounds, `none` if out of bounds or not a number
  - Non-container nodes with non-empty path return `none`
- **Key constraints**: Array indices are parsed from segment strings using `String.toNat?`. The postcond explicitly covers 1-segment and 2-segment paths. For deeper paths, the implementation should handle them recursively even though the postcond doesn't explicitly constrain them.

### 3. `JsonGenerator.writeStartObject`

- **Signature**: `def JsonGenerator.writeStartObject (g : JsonGenerator) : JsonGenerator`
- **Description**: Write the start of a JSON object (`{`) to the generator's output buffer and increase the nesting depth.
- **Postcondition**: `JsonGenerator.writeStartObject_postcond` requires:
  - `result.depth = g.depth + 1` (nesting depth increases by exactly 1)
  - `result.output = g.output ++ ["{"]` (exactly one `"{"` string is appended)
  - `result.closed = g.closed` (closed flag is unchanged)
- **Key constraints**: The output is a `List String` where each element is a JSON fragment. The postcond is precise — the output must be exactly the previous output with `"{"` appended.

## Relational Properties

- **`generate_parse_roundtrip_rel`**: Generating JSON from a `TreeNode` via `toGenerator`, flushing the generator, creating a parser from the output, and parsing back to a `TreeNode` via `fromParser` recovers the original tree. This is the fundamental correctness property tying all three components together.

## Types

- **`JsonToken`**: Token types produced by the parser — `startObject`, `endObject`, `startArray`, `endArray`, `fieldName`, `valueString`, `valueInt`, `valueFloat`, `valueTrue`, `valueFalse`, `valueNull`, `notAvailable`.
- **`JsonParser`**: Streaming parser state — `input` (source string), `position` (current offset), `currentToken`, `currentValue`, `context` (nesting), `depth`, `closed`.
- **`JsonGenerator`**: Streaming writer state — `output` (list of JSON fragments), `context`, `depth`, `closed`.
- **`JsonPointer`**: A JSON Pointer (RFC 6901) as a list of `segments`. E.g., `/foo/0/bar` → `["foo", "0", "bar"]`.
- **`TreeNode`**: A JSON value — `null`, `bool`, `int`, `float`, `string`, `array` (list of TreeNode), or `object` (list of key-value pairs).
- **`ParserContext`**: Nesting context with `type` (root/object/array), `index`, and optional `parent`.

## Hints

- Already implemented helpers (not `sorry`):
  - `skipWS` — skips whitespace characters from a position in a string
  - `isNumberStart` — checks if a character starts a JSON number (`-` or digit)
  - `tokenMatchesChar` — maps a character to the expected token kind (used in nextToken postcond)
- For `JsonParser.nextToken`: skip whitespace, examine the first character, and produce the appropriate token. For strings/field names, scan to the closing `"`. For numbers, scan digits. Update position past the consumed characters.
- For `TreeNode.navigate`: recurse through `ptr.segments`. For each segment, if current node is an object, find the field; if array, parse index. Base case: empty segments returns the current node.
- For `JsonGenerator.writeStartObject`: straightforward — increment depth and append `"{"` to output.
- For the roundtrip proof: `TreeNode.toGenerator` must produce valid JSON that `TreeNode.fromParser` can parse back. Implement `flush` as `String.join g.output`. Ensure `toGenerator` writes complete, well-formed JSON for each TreeNode variant.
- Dependencies that need implementation: `JsonParser.create`, `JsonGenerator.create`, `JsonGenerator.flush`, `JsonGenerator.close`, `TreeNode.toGenerator`, `TreeNode.fromParser`.

## Edit Boundaries

`JacksonCore/*.lean` is divided into labeled sections:

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

- `JacksonCore/Helpers.lean`
- `JacksonCore/Navigate.lean`
- `JacksonCore/NextToken.lean`
- `JacksonCore/Relations.lean`
- `JacksonCore/Types.lean`
- `JacksonCore/WriteStartObject.lean`
