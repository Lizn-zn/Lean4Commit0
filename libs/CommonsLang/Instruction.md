# CommonsLang

## Background

Apache Commons Lang is one of the most widely-used Java utility libraries, providing helper functions for strings, numbers, arrays, and booleans. The `StringUtils` class is its most important component. This spec focuses on three core string operations: left-padding, cyclic rotation, and non-overlapping substring counting.

## Task

Complete implementation holes in explicitly editable regions in the `CommonsLang/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `leftPad`

- **Signature**: `def leftPad (s : String) (size : Nat) (pad : Char := ' ') : String`
- **Description**: Pads a string on the left side to reach the target size, using the given pad character. If the string is already at or above the target size, it is returned unchanged.
- **Postcondition**: `leftPad_postcond` requires:
  - If `size ≥ s.length`, the result has exactly `size` characters
  - If `size < s.length`, the result equals the original string (no truncation)
  - If `size > s.length`, the first `size - s.length` characters are the pad character, and the remaining characters are the original string in order
  - If `size = s.length`, the result equals the original string
- **Key constraints**: No truncation when the string is already long enough. The pad characters must appear at the correct indices.

### 2. `rotate`

- **Signature**: `def rotate (s : String) (shift : Int) : String`
- **Description**: Cyclically rotates the characters of a string by the given shift amount. A positive shift moves characters to the right (wrapping around), and a negative shift moves them to the left.
- **Postcondition**: `rotate_postcond` requires:
  - If `shift = 0`, the result equals the original string
  - The result has the same length as the original
  - For non-empty strings, each character at index `i` in the result equals the character at index `((i - shift % len + len) % len)` in the original (using integer modular arithmetic)
- **Key constraints**: The shift is an `Int` (can be negative). The modular index formula uses integer arithmetic — be careful with `Int` to `Nat` conversion via `.toNat`.

### 3. `countMatches`

- **Signature**: `def countMatches (s sub : String) : Nat`
- **Description**: Counts the number of non-overlapping occurrences of a substring within a string, scanning left to right.
- **Postcondition**: `countMatches_postcond` requires:
  - If `sub` is empty, result is 0
  - If `s` is empty, result is 0
  - If both are non-empty, result ≤ `s.length / sub.length`
  - If `sub` is non-empty, result equals `countNonOverlap s.toList sub.toList`
- **Key constraints**: The counting is non-overlapping (after a match, skip past the entire matched substring). The `countNonOverlap` helper is already implemented as a `partial def` — your implementation of `countMatches` must produce the same result.

## Relational Properties

- **`rotate_full_rel`**: Rotating a string by its own length produces the original string (`rotate s s.length = s`).

## Types

No custom types are needed — all functions operate on `String`, `Nat`, `Int`, `Char`, and `List Char`.

## Hints

- The `countNonOverlap` helper function is already implemented (not `sorry`) and defines the expected counting behavior. Your `countMatches` implementation must agree with it.
- For `leftPad`, constructing the result as `(List.replicate (size - s.length) pad) ++ s.toList` converted back to a string is a natural approach.
- For `rotate`, converting to `List Char`, splitting at the right index, and concatenating the two halves is simpler than computing each index individually.
- For proving `rotate_full_spec`, you'll need to show that the rotation formula with `shift = s.length` reduces to the identity.

## Edit Boundaries

The editable module files under `CommonsLang/` are divided into labeled sections:

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

- `CommonsLang/CountMatches.lean`
- `CommonsLang/Helpers.lean`
- `CommonsLang/LeftPad.lean`
- `CommonsLang/Relations.lean`
- `CommonsLang/Rotate.lean`
