# Nom

## Background

This Lean task models a small parser-combinator core inspired by Rust's `nom`: exact tags, parser pairing, and repeated parsing with `many0`.

## Task

Complete implementation holes in explicitly editable regions in the split Lean files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Edit Boundaries

`libs/Nom` is split into:

- `Nom.lean`
- `Nom/Types.lean`
- `Nom/Tag.lean`
- `Nom/Pair.lean`
- `Nom/Many0.lean`

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash and should remain unchanged.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `Nom/Many0.lean`
- `Nom/Pair.lean`
- `Nom/Tag.lean`
- `Nom/Types.lean`
