# Parsel

## Background

This Lean task models a small HTML/XML selector core inspired by `parsel`: selector parsing, selector matching, and DOM queries.

## Task

Complete implementation holes in explicitly editable regions in the split Lean files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Edit Boundaries

`libs/Parsel` is split into:

- `Parsel.lean`
- `Parsel/Types.lean`
- `Parsel/Helpers.lean`
- `Parsel/ParseCssSelector.lean`
- `Parsel/MatchSelectorList.lean`
- `Parsel/QuerySelectorAll.lean`

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash and should remain unchanged.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Revised release contract (v3)

Every template placeholder is now an explicit editable obligation, including the former provided/unmarked holes. All types, declaration headers, predicates and non-hole support source are protected. Read the validity assumptions in the theorem statements; they are part of this revised task, not the historical experiment. The optional PROOF_IMPORTS regions permit only Mathlib, Batteries, Std or Lean imports. Use local helper definitions inside implementation/proof bodies when needed.

The default root checker reconstructs an authenticated fresh task tree, builds it, checks required declarations and exact trusted types, and audits transitive axioms of all task-module declarations. A compiling template with sorry is not solved. The verdict concerns the published simplified Lean model. All original paper results remain associated with the preserved experiment version.

Current task modules (relative to this library directory):

- `Parsel/Helpers.lean`
- `Parsel/MatchSelectorList.lean`
- `Parsel/ParseCssSelector.lean`
- `Parsel/QuerySelectorAll.lean`
- `Parsel/Types.lean`

## Published model limits (v3)

Selector success covers the explicit simple-selector families in the revised predicate. General CSS selector completeness is outside the task.
