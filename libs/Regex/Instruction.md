# Regex

## Task

Complete implementation holes in explicitly editable regions in the split files under `Regex/` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Layout

- `Regex/Types.lean`: shared `Match` type
- `Regex/Helpers.lean`: `findFirst` plus shared helper/reference functions
- `Regex/IsMatch.lean`: `isMatch`
- `Regex/FindAll.lean`: `findAll`
- `Regex/ReplaceAll.lean`: `replaceAll`
- `Regex/Relations.lean`: grouped relational specs

## Core Functions

- `isMatch`: report whether any match exists.
- `findAll`: find all left-to-right non-overlapping matches.
- `replaceAll`: replace all matches using `findAll`.

## Relational Properties

- `replaceAll_no_match_rel`

## Edit Boundaries

The split files under `Regex/` use:

```text
-- === BEGIN: SECTION_NAME (provided|editable) ===
...
-- === END: SECTION_NAME ===
```

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `Regex/FindAll.lean`
- `Regex/Helpers.lean`
- `Regex/IsMatch.lean`
- `Regex/Relations.lean`
- `Regex/ReplaceAll.lean`
- `Regex/Types.lean`
