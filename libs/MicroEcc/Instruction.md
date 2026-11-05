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

## Revised release contract (v3)

Every template placeholder is now an explicit editable obligation, including the former provided/unmarked holes. All types, declaration headers, predicates and non-hole support source are protected. Read the validity assumptions in the theorem statements; they are part of this revised task, not the historical experiment. The optional PROOF_IMPORTS regions permit only Mathlib, Batteries, Std or Lean imports. Use local helper definitions inside implementation/proof bodies when needed.

The default root checker reconstructs an authenticated fresh task tree, builds it, checks required declarations and exact trusted types, and audits transitive axioms of all task-module declarations. A compiling template with sorry is not solved. The verdict concerns the published simplified Lean model. All original paper results remain associated with the preserved experiment version.

Current task modules (relative to this library directory):

- `MicroEcc/EcdsaSign.lean`
- `MicroEcc/EcdsaVerify.lean`
- `MicroEcc/Helpers.lean`
- `MicroEcc/PointAdd.lean`
- `MicroEcc/Relations.lean`
- `MicroEcc/Types.lean`
- `MicroEcc/Validity.lean`
