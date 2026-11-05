# MicroEcc

## Task

Complete implementation holes in explicitly editable regions in the split files under `MicroEcc/` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Layout

- `MicroEcc/Types.lean`: shared types
- `MicroEcc/Helpers.lean`: pure helper/reference functions plus `scalarMul` and `publicKeyFromPrivate`
- `MicroEcc/PointAdd.lean`: `pointAdd`
- `MicroEcc/EcdsaSign.lean`: `ecdsaSign`
- `MicroEcc/EcdsaVerify.lean`: `ecdsaVerify`
- `MicroEcc/Relations.lean`: grouped relational specs

## Core Functions

- `pointAdd`: elliptic-curve affine point addition with infinity, inverse, distinct-point, and doubling cases.
- `ecdsaSign`: ECDSA signing using the pure scalar-multiplication and modular-inverse reference helpers in the postcondition.
- `ecdsaVerify`: ECDSA verification using the same pure helpers.

## Relational Properties

- `pointAdd_comm_rel`
- `verify_after_sign_rel`
- `publicKeyFromPrivate_rel`

## Edit Boundaries

The split files under `MicroEcc/` use:

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

- `MicroEcc/EcdsaSign.lean`
- `MicroEcc/EcdsaVerify.lean`
- `MicroEcc/Helpers.lean`
- `MicroEcc/PointAdd.lean`
- `MicroEcc/Relations.lean`
- `MicroEcc/Types.lean`
- `MicroEcc/Validity.lean`
