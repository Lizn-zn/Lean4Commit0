# MiniTorch

## Task

Complete implementation holes in explicitly editable regions in the split files under `MiniTorch/` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Layout

- `MiniTorch/Types.lean`: shared tensor/storage/optimizer types and pure shape helpers
- `MiniTorch/Helpers.lean`: shared helper operations such as `shapeSize`, `shapeToStrides`, `indexToPosition`, and tensor accessors
- `MiniTorch/PositionToIndex.lean`: `positionToIndex`
- `MiniTorch/TensorMap.lean`: `Tensor.map`
- `MiniTorch/SGDStep.lean`: `SGD.step`
- `MiniTorch/Relations.lean`: grouped roundtrip relational specs

## Core Functions

- `positionToIndex`: convert a flat storage position into a multidimensional index.
- `Tensor.map`: shape-preserving elementwise tensor mapping.
- `SGD.step`: one SGD update over parameter/gradient tensor pairs.

## Relational Properties

- `pos_idx_roundtrip_rel`
- `idx_pos_roundtrip_rel`

## Edit Boundaries

The split files under `MiniTorch/` use:

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

- `MiniTorch/Helpers.lean`
- `MiniTorch/PositionToIndex.lean`
- `MiniTorch/Relations.lean`
- `MiniTorch/SGDStep.lean`
- `MiniTorch/TensorMap.lean`
- `MiniTorch/Types.lean`
