# Tabulate

## Background

Tabulate is a Python library for pretty-printing tabular data in various formats including plain text, grid, pipe, HTML, LaTeX, CSV, and more. It automatically computes column widths, aligns content, and adds format-specific decorations (borders, separators, HTML tags). This spec covers the core pipeline: the main `tabulate` function, column width computation, and HTML-specific formatting.

## Task

Complete implementation holes in explicitly editable regions in `Tabulate/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `tabulate`

- **Signature**: `def tabulate (data : List (List String)) (headers : List String := []) (fmt : TableFormat := .simple) (colAlign : List Alignment := []) : String`
- **Description**: Format tabular data as a string in the specified table format. This is the main entry point of the library.
- **Postcondition**: `tabulate_postcond` requires (8 clauses):
  - All non-empty cells from data appear as substrings in the result
  - All non-empty headers appear as substrings in the result
  - Non-empty data produces at least as many lines as rows
  - Grid format → result contains `|` and `+`
  - HTML format → result contains `<table>`
  - LaTeX format → result contains `\begin{tabular}`
  - Pipe format → result contains `|`
  - Empty data and empty headers → empty result
- **Key constraints**: The function must handle all `TableFormat` variants. Each format has specific structural requirements checked in the postcondition.

### 2. `computeColumnWidths`

- **Signature**: `def computeColumnWidths (data : List (List String)) (headers : List String) : List Nat`
- **Description**: Compute the minimum width needed for each column to fit all data cells and headers.
- **Postcondition**: `computeColumnWidths_postcond` requires (3 clauses):
  - Each width is at least as large as the corresponding header's length
  - Each width is at least as large as the longest cell in that column across all rows
  - Each width equals the length of some actual content (header or cell) — no unnecessary padding
- **Key constraints**: The third clause ensures widths are tight — each width must equal the maximum content length in that column.

### 3. `formatHtml`

- **Signature**: `def formatHtml (data : List (List String)) (headers : List String) : String`
- **Description**: Format tabular data as an HTML table with proper `<table>`, `<tr>`, `<td>`, and `<th>` tags.
- **Postcondition**: `formatHtml_postcond` requires (8 clauses):
  - Non-empty data → contains `<table>` and `</table>`
  - Non-empty data → contains `<tr>` and `</tr>`
  - Non-empty data → contains `<td` or `<th>`
  - Non-empty headers with data → contains `<th>`
  - Cell content preserved (for cells without HTML special chars `<`, `>`, `&`)
  - Header content preserved (for headers without HTML special chars)
  - Non-empty data → contains `<tbody>`
  - Number of `<tr>` splits ≥ data.length + 1
- **Key constraints**: Content preservation is conditional on the cell not containing HTML special characters (`<`, `>`, `&`), since those may be escaped.

## Relational Properties

- **`tabulate_grid`**: When using grid format, the output starts and ends with `+`, contains `+`/`-`/`|` separators, has sufficient line count (data.length + 2), and preserves all cell/header content.
- **`computeColumnWidths_length`**: The result list length equals `max headers.length (max row length across data)`, and all widths cover their respective content.

## Types

- **`TableFormat`** — Output format: plain, simple, grid, pipe, orgtbl, rst, mediawiki, html, latex, tsv, csv
- **`Alignment`** — Cell alignment: left, center, right, decimal
- **`FormatConfig`** — Configuration for a format: separator strings, column separator, padding

## Hints

- `String.containsSubstr` is already implemented (not `sorry`) — it checks substring containment via `splitOn`.
- For `tabulate`, you need to handle multiple formats. Start with generating the content rows, then wrap with format-specific decorations. The postcondition checks format-specific markers, so ensure each format branch includes its required elements.
- For `computeColumnWidths`, iterate over all rows and headers to find the maximum string length in each column position. The third postcondition clause requires that each width equals some actual content length (not just ≥).
- For `formatHtml`, build proper HTML structure: `<table>`, optional `<thead>` with `<th>` for headers, `<tbody>` with `<tr>`/`<td>` for data rows, `</table>`.
- The `tabulate_grid` relational spec tests `tabulate data headers .grid` directly, so your `tabulate` implementation must handle `.grid` format correctly.

## Edit Boundaries

`Tabulate/*.lean` is divided into labeled sections:

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

- `Tabulate/ComputeColumnWidths.lean`
- `Tabulate/FormatHtml.lean`
- `Tabulate/Helpers.lean`
- `Tabulate/Tabulate.lean`
- `Tabulate/Types.lean`
