# SortedContainers

## Task

Complete implementation holes in explicitly editable regions in the split files under `SortedContainers/` and complete the proof obligations assigned to editable regions.

Helpers are grouped in `SortedContainers/Helpers.lean`. The three core APIs each live in their own file:

- `SortedContainers/SortedListAdd.lean`
- `SortedContainers/SortedDictSet.lean`
- `SortedContainers/SortedSetAdd.lean`

Relational specs are grouped in `SortedContainers/Relations.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Edit Boundaries

The split files under `SortedContainers/` are divided into labeled sections:

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

- `SortedContainers/Helpers.lean`
- `SortedContainers/Relations.lean`
- `SortedContainers/SortedDictSet.lean`
- `SortedContainers/SortedListAdd.lean`
- `SortedContainers/SortedSetAdd.lean`
- `SortedContainers/Types.lean`
