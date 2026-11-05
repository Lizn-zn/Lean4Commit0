# Chardet

## Background

Chardet is a Python library for automatic character encoding detection. Given raw bytes, it determines the most likely encoding (UTF-8, Shift_JIS, GB2312, ISO-8859-1, etc.) and a confidence score. Detection works via multiple strategies: BOM (Byte Order Mark) detection for Unicode encodings, coding state machines for multi-byte encodings, and character frequency distribution analysis. In this Lean formalization, the core spec covers the three public-facing detection APIs.

## Task

Complete implementation holes in explicitly editable regions in the split files under `Chardet/` and complete the proof obligations assigned to editable regions. Helper predicates are grouped in `Chardet/Helpers.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `detectBom`

- **Signature**: `def detectBom (data : ByteArray) : Option Encoding`
- **Description**: Check if the byte data starts with a Unicode BOM (Byte Order Mark) and return the corresponding encoding.
- **Postcondition**: Eight requirements:
  1. Empty data → `none`
  2. Bytes `EF BB BF` → `some .utf8`
  3. Bytes `FE FF` → `some .utf16be`
  4. Bytes `00 00 FE FF` → `some .utf32be`
  5. Bytes `FF FE 00 00` → `some .utf32le`
  6. Bytes `FF FE` (not followed by `00 00`) → `some .utf16le`
  7. No BOM pattern matches → `none`
  8. Result is one of the 5 BOM encodings or `none`
- **Key constraints**: UTF-32 LE (`FF FE 00 00`) must be checked before UTF-16 LE (`FF FE`) since the latter is a prefix of the former. The `hasBomPattern` helper is provided and already implemented.

### 2. `detect`

- **Signature**: `def detect (data : ByteArray) : DetectionResult`
- **Description**: Detect the most likely character encoding of the input bytes, returning an encoding, confidence score, and optional language.
- **Postcondition**: Nine requirements:
  1. Confidence is in `[0.0, 1.0]`
  2. Empty data → confidence ≤ 0.5
  3. All printable ASCII → encoding is `ascii` or `utf8`
  4. High bytes (≥ 128) present → encoding is NOT `ascii`
  5. UTF-8 BOM → encoding = `utf8`, confidence = 1.0
  6. UTF-16 BE BOM → encoding = `utf16be`, confidence = 1.0
  7. UTF-16 LE BOM (not UTF-32 LE) → encoding = `utf16le`, confidence = 1.0
  8. Null bytes with no high bytes → encoding is `none` or `utf8`
- **Key constraints**: BOM detection should take priority — if a BOM is present, it determines the result with confidence 1.0. For non-BOM data, you need heuristics (state machines, frequency analysis) but the postconditions only require the constraints above, not specific heuristic accuracy.

### 3. `detectAll`

- **Signature**: `def detectAll (data : ByteArray) : List DetectionResult`
- **Description**: Detect all possible encodings for the input bytes, sorted by confidence descending.
- **Postcondition**: Eight requirements:
  1. Non-empty data → at least one result
  2. All results have confidence in `[0.0, 1.0]`
  3. Empty data → at most 1 result
  4. Results sorted by confidence descending (`isSortedByConfidence`)
  5. Printable ASCII → first result is `ascii` or `utf8`
  6. High bytes present → first result is NOT `ascii`
  7. UTF-8 BOM → first result is `utf8` with confidence 1.0
  8. UTF-16 BE BOM → first result is `utf16be` with confidence 1.0
- **Key constraints**: The sorting requirement uses `isSortedByConfidence` (already defined as a helper). The first result should be consistent with what `detect` would return.

## Relational Properties

- **`detectBom_detect_consistency_rel`**: If `detectBom` returns `some encoding` (BOM detected), then `detect` must either return that same encoding or have confidence = 1.0. This ensures the high-level API respects BOM detection.

## Types

- **`Encoding`**: An inductive type with 30 variants representing supported character encodings (UTF-8, UTF-16 BE/LE, UTF-32 BE/LE, ASCII, various ISO-8859-x, Windows-125x, CJK encodings, etc.).
- **`DetectionResult`**: A structure with `encoding : Option Encoding`, `confidence : Float` (0.0 to 1.0), and `language : Option String`.

## Hints

- Implement `detectBom` first — it's the simplest and most deterministic. Check bytes in order: UTF-32 patterns (4 bytes) before UTF-16 patterns (2 bytes) to avoid prefix ambiguity.
- For `detect`, start by calling `detectBom`. If a BOM is found, return immediately with confidence 1.0. Otherwise, check if all bytes are printable ASCII. For other cases, you can return a reasonable default (e.g., UTF-8 with moderate confidence) — the postconditions don't require precise heuristic detection beyond the BOM/ASCII cases.
- For `detectAll`, you can wrap `detect`'s result in a singleton list for simple cases. The sorting requirement is trivially satisfied for lists of length ≤ 1.
- Helper functions `allPrintableAscii`, `hasUtf8Bom`, `hasHighByte`, `hasNullByte`, `hasBomPattern`, `DetectionResult.headD`, and `isSortedByConfidence` are all already implemented (not `sorry`) and can be used directly.
- The `detectBom_utf16le` theorem is a standalone lemma about `detectBom` — it follows directly from the 6th clause of `detectBom_postcond`.
- Float comparisons in Lean 4 work with standard `≥`, `≤` operators. For confidence = 1.0, use the Float literal directly.

## Edit Boundaries

The split files under `Chardet/` are divided into labeled sections:

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

- `Chardet/Detect.lean`
- `Chardet/DetectAll.lean`
- `Chardet/DetectBom.lean`
- `Chardet/Helpers.lean`
- `Chardet/Relations.lean`
- `Chardet/Types.lean`
