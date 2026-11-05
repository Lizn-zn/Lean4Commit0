# NetworkX

## Background

This Lean task models a small pure graph core inspired by `networkx`: graph queries, edge insertion, shortest paths, and connected components.

## Task

Complete implementation holes in explicitly editable regions in the split Lean files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Edit Boundaries

`libs/NetworkX` is split into:

- `NetworkX.lean`
- `NetworkX/Types.lean`
- `NetworkX/Helpers.lean`
- `NetworkX/AddEdge.lean`
- `NetworkX/ShortestPath.lean`
- `NetworkX/ConnectedComponents.lean`

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash and should remain unchanged.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `NetworkX/AddEdge.lean`
- `NetworkX/ConnectedComponents.lean`
- `NetworkX/Helpers.lean`
- `NetworkX/ShortestPath.lean`
- `NetworkX/Types.lean`
- `NetworkX/Validity.lean`
