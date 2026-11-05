# ProgressBar

## Background

progressbar2 is a Python library for displaying customizable progress bars in the terminal. It supports various widgets (percentage, ETA, transfer speed, counters), bar styles, and format templates. This spec covers the core rendering pipeline: drawing the visual bar, composing the full progress bar output, and computing the estimated time of completion.

## Task

Complete implementation holes in explicitly editable regions in the `ProgressBar/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `renderBar`

- **Signature**: `def renderBar (chars : BarChars) (width : Nat) (fillRatio : Float) : String`
- **Description**: Render a progress bar of the given width, filled to `fillRatio` (0.0 to 1.0) using the specified fill characters.
- **Postcondition**: `renderBar_postcond` requires (given `0 ≤ fillRatio ≤ 1`):
  - Output length equals `width`
  - Width 0 produces empty string
  - The first `filledCount` characters are all `chars.filled`
  - The remaining characters are all `chars.empty`
  - `filledCount = (min 1.0 (max 0.0 fillRatio) * width.toFloat).toUInt64.toNat`
- **Key constraints**: The filled count is computed by multiplying the ratio by the width and truncating to a natural number. The theorem has a precondition `hr : 0 ≤ fillRatio ∧ fillRatio ≤ 1`.

### 2. `renderProgressBar`

- **Signature**: `def renderProgressBar (fmt : FormatSpec) (ctx : RenderContext) : String`
- **Description**: Render a complete progress bar by processing each segment in the format spec — literal strings are included as-is, widget segments are rendered using the context.
- **Postcondition**: `renderProgressBar_postcond` requires:
  - Non-empty segments produce non-empty output
  - Empty segments produce empty string
  - Every literal string from the format spec appears in the output
  - Output length is at least the sum of literal segment lengths (`fmt.literalWidth`)
- **Key constraints**: This function must process both `FormatSegment.literal` and `FormatSegment.widget` segments. Widget rendering can produce any non-empty string — the postcondition only constrains literals and overall length.

### 3. `computeETA`

- **Signature**: `def computeETA (elapsed : Duration) (ratio : Float) : Option Duration`
- **Description**: Compute the estimated time remaining based on elapsed time and completion ratio. Uses the formula: `remaining = elapsed * (1 - ratio) / ratio`.
- **Postcondition**: `computeETA_postcond` requires:
  - `ratio ≤ 0` → `none` (no progress, can't estimate)
  - `ratio ≥ 1` → `some 0` (already done)
  - `0 < ratio < 1` → `some ((elapsed.toFloat * (1.0 - ratio) / ratio).toUInt64.toNat)`
- **Key constraints**: `Duration` is `Nat` (milliseconds). The formula converts to `Float` for computation, then truncates back to `Nat` via `.toUInt64.toNat`. The three cases are exhaustive.

## Types

- **`Duration`** = `Nat` — time in milliseconds
- **`Timestamp`** = `Nat` — milliseconds since epoch
- **`ProgressState`** — current progress: `current` count, optional `total`, start/current timestamps
- **`BarChars`** — characters for rendering: `filled` (default `#`), `empty` (default `-`), `leftEnd`/`rightEnd` (default `|`), optional `partials`
- **`Widget`** — a component in the progress bar (bar, counter, percentage, timer, ETA, etc.)
- **`FormatSegment`** — either `literal` text or a `widget` to render
- **`FormatSpec`** — a list of format segments defining the progress bar layout
- **`RenderContext`** — rendering parameters: progress state, terminal width, smoothed rate, etc.

## Hints

- **`String.containsSubstr`** is declared at the top as `sorry` — implement as a substring check. Used by `renderProgressBar_postcond`.
- **`FormatSpec.literalWidth`** is already implemented (not sorry) — it folds over segments summing literal string lengths. Use it directly in proofs.
- For `renderBar`, construct a string of `filledCount` filled characters followed by `width - filledCount` empty characters. `String.mk` from a `List Char` is the natural approach.
- For `renderProgressBar`, map each segment to a string (literals pass through, widgets can produce placeholder text) and join them. The key proof obligation is that all literals appear in the joined result.
- For `computeETA`, the implementation is a direct match on the ratio range — three cases with the exact formula given in the postcondition.

## Edit Boundaries

`ProgressBar/*.lean` is divided into labeled sections:

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

- `ProgressBar/ComputeETA.lean`
- `ProgressBar/Helpers.lean`
- `ProgressBar/RenderBar.lean`
- `ProgressBar/RenderProgressBar.lean`
- `ProgressBar/Types.lean`
