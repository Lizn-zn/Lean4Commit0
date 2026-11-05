# Pypdf

## Background

Pypdf is a Python library for reading and manipulating PDF documents. Its most common use cases are extracting text from PDFs, merging/splitting pages, and accessing document metadata. This spec covers the three core operations: extracting text from content stream operators, merging two pages, and parsing PDF rectangle objects.

## Task

Complete implementation holes in explicitly editable regions in the `Pypdf/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `extractTextFromOps`

- **Signature**: `def extractTextFromOps (ops : List ContentOp) : String`
- **Description**: Extract all text content from a list of PDF content stream operators by concatenating strings from `Tj` (show text) and `TJ` (show text with positioning) operators.
- **Postcondition**: `extractTextFromOps_postcond` requires:
  - `result = opsText ops` — the result must exactly match the pure helper function `opsText`
- **Key constraints**: Only `Tj` and `TJ` operators contribute text. `Tj` carries a single string; `TJ` carries a list of `PdfObject` where only `.str` items contribute text (numeric items for positioning are ignored). All other operators (BT, ET, Tm, Td, etc.) produce no text.

### 2. `Page.merge`

- **Signature**: `def Page.merge (base : Page) (overlay_ : Page) (mode : MergeMode := .overlay) : Page`
- **Description**: Merge two PDF pages by combining their content streams. In overlay mode, the overlay's content appears on top; in underlay mode, it appears behind.
- **Postcondition**: `Page.merge_postcond` requires:
  - Overlay mode: `result.contents = base.contents ++ overlay_.contents`
  - Underlay mode: `result.contents = overlay_.contents ++ base.contents`
  - `result.mediaBox = base.mediaBox` (base page's dimensions are preserved)
  - `result.rotation = base.rotation` (base page's rotation is preserved)
- **Key constraints**: The merge only affects the content stream ordering. The base page's mediaBox and rotation are always used in the result, regardless of mode.

### 3. `parseRectangle`

- **Signature**: `def parseRectangle (obj : PdfObject) : Option Rectangle`
- **Description**: Parse a `PdfObject` into a `Rectangle` if it is an array of exactly 4 float values, otherwise return `none`.
- **Postcondition**: `parseRectangle_postcond` requires (11 clauses):
  - `null` → `none`
  - `boolean true/false` → `none`
  - `integer n` → `none`
  - `str s` → `none`
  - `array [real x1, real y1, real x2, real y2]` → `some ⟨x1, y1, x2, y2⟩`
  - `name s` → `none`
  - `dict d` → `none`
  - `stream d b` → `none`
  - `ref n g` → `none`
  - `real f` → `none`
- **Key constraints**: Only a 4-element array of `.real` values produces a rectangle. All other `PdfObject` variants (including arrays of wrong length or with non-real elements) must return `none`.

## Types

- **`PdfObject`** — A PDF object: null, boolean, integer, real (float), string, name (/Foo), array, dict (key-value pairs), stream (dict + bytes), or indirect reference (obj# + gen#)
- **`Rectangle`** — Four float coordinates: x1, y1 (lower-left), x2, y2 (upper-right)
- **`ContentOp`** — A PDF content stream operator: text operators (Tj, TJ, Tm, Td, Tf, etc.), graphics state (q, Q, cm), and drawing operators (re, m, l, Do)
- **`Page`** — A PDF page: mediaBox, optional crop/trim/bleed/art boxes, rotation, content operators, annotations, resources
- **`MergeMode`** — How to combine pages: `overlay` (new on top) or `underlay` (new behind)
- **`Rotation`** — Page rotation: 0, 90, 180, or 270 degrees
- **`AnnotationType`** — PDF annotation types: text, link, highlight, etc.

## Hints

- **`opsText`** and **`tjArrayText`** are already implemented (not sorry) — use them directly. `extractTextFromOps` should produce the same result as `opsText`. The simplest implementation is `def extractTextFromOps := opsText`.
- For `Page.merge`, construct a new `Page` with contents from both pages (ordered by mode), keeping the base page's mediaBox, rotation, and other fields. You'll need to decide what to do with annotations and resources — the postcondition only constrains contents, mediaBox, and rotation.
- For `parseRectangle`, match on the `PdfObject` and only accept `PdfObject.array [.real x1, .real y1, .real x2, .real y2]`. All other patterns return `none`. The proof requires showing each clause holds — a `cases` or `match` approach works well.

## Edit Boundaries

`Pypdf/*.lean` is divided into labeled sections:

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

- `Pypdf/ExtractTextFromOps.lean`
- `Pypdf/Helpers.lean`
- `Pypdf/PageMerge.lean`
- `Pypdf/ParseRectangle.lean`
- `Pypdf/Types.lean`
