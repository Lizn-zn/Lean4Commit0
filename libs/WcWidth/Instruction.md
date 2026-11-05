# WcWidth

## Background

WcWidth is a Python library for determining the display width of Unicode characters and strings in terminal emulators. Characters can be zero-width (combining marks, zero-width spaces), single-width (ASCII, most Latin), double-width (CJK ideographs, fullwidth forms), or control characters (width -1, meaning unprintable). This spec covers the three core width functions: character classification, single-character width, and string width.

## Task

Complete implementation holes in explicitly editable regions in `WcWidth/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `classify`

- **Signature**: `def classify (c : Char) : CharWidth`
- **Description**: Classify a Unicode character into one of four width categories: control, zero, narrow, or wide.
- **Postcondition**: `classify_postcond` requires (15 clauses):
  - U+0000 (null) → zero
  - U+0001–U+001F (C0 controls) → control
  - U+007F–U+009F (DEL + C1 controls) → control
  - U+0020–U+007E (ASCII printable) → narrow
  - U+4E00–U+9FFF (CJK Unified Ideographs) → wide
  - U+FF01–U+FF60 (Fullwidth Forms) → wide
  - U+0300 → zero (combining diacritical)
  - Result is always one of the four categories
  - U+0300–U+036F (Combining Diacriticals) → zero
  - U+3000–U+303F (CJK Symbols) → wide
  - U+AC00–U+D7A3 (Hangul Syllables) → wide
  - U+3400–U+4DBF (CJK Extension A) → wide
  - U+00AD (soft hyphen) → zero
  - U+200B (ZWSP) → zero
  - U+00A0–U+00FF excluding U+00AD (Latin-1 Supplement) → narrow
- **Key constraints**: Many Unicode ranges must be handled correctly. The postcondition specifies exact results for specific ranges.

### 2. `wcwidth`

- **Signature**: `def wcwidth (c : Char) : Int`
- **Description**: Return the display width of a single Unicode character: -1 for control, 0 for zero-width, 1 for narrow, 2 for wide.
- **Postcondition**: `wcwidth_postcond` requires (15 clauses):
  - Same range mappings as `classify` but to integer values (-1, 0, 1, 2)
  - Result is always in {-1, 0, 1, 2}
- **Key constraints**: Must be consistent with `classify` — the relational spec requires `wcwidth c = (classify c).toInt`.

### 3. `wcswidth`

- **Signature**: `def wcswidth (s : String) : Int`
- **Description**: Return the display width of a string. Returns -1 if any character is a control character; otherwise sums the widths of all characters.
- **Postcondition**: `wcswidth_postcond` requires (7 clauses):
  - Empty string → 0
  - Result is either -1 or ≥ 0
  - Non-negative result ≤ 2 × string length (upper bound)
  - Any control character in string → result is -1
  - No control characters and non-empty → result ≥ 0
  - All ASCII printable → result equals string length
  - Single ASCII printable character → result is 1
- **Key constraints**: Control characters are "poisonous" — a single one makes the entire string width -1. The `isControlChar` predicate uses raw codepoint ranges (U+01–U+1F, U+7F–U+9F).

## Relational Properties

- **`wcwidth_classify`**: `wcwidth c = (classify c).toInt` — the two functions must be consistent. This means you can implement one in terms of the other.
- **`wcswidth_singleton`**: For a single character `c`, if `wcwidth c ≥ 0` then `wcswidth (String.singleton c) = wcwidth c`.
- **`wcswidth_append`**: If `wcswidth s1 ≥ 0` and `wcswidth s2 ≥ 0`, then `wcswidth (s1 ++ s2) = wcswidth s1 + wcswidth s2` — string width is additive when no control characters are present.

## Types

- **`CharWidth`** — Four categories: control (-1), zero (0), narrow (1), wide (2). Has a `toInt` method (already implemented, not sorry).

## Hints

- `isControlChar` and `isAsciiPrintable` are already implemented (not `sorry`) as pure predicates using codepoint ranges. They are used in the `wcswidth` postcondition.
- `CharWidth.toInt` is already implemented (not `sorry`).
- The simplest approach: implement `classify` first using codepoint range checks, then define `wcwidth c := (classify c).toInt`, then define `wcswidth` by folding over characters.
- For `classify`, you need to handle these ranges in priority order: null (U+0000), C0 controls, C1 controls, ASCII printable, then zero-width ranges (combining marks, ZWSP, soft hyphen), then wide ranges (CJK, Hangul, fullwidth), then Latin-1 supplement, then default to narrow for remaining characters.
- The `wcswidth_append` relational spec means your `wcswidth` implementation must sum individual character widths (when no control char is present), not use some other aggregation method.

## Edit Boundaries

`WcWidth/*.lean` is divided into labeled sections:

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

- `WcWidth/Classify.lean`
- `WcWidth/Helpers.lean`
- `WcWidth/Types.lean`
- `WcWidth/Wcswidth.lean`
- `WcWidth/Wcwidth.lean`
