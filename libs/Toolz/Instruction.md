# Toolz

## Background

Toolz is a Python functional programming utility library organized into three modules: functoolz (function composition and transformation), itertoolz (lazy iterator operations like grouping, partitioning, and windowing), and dicttoolz (dictionary merging, mapping, and association). This spec models the three most representative functions — one from each module — as pure functions over Lean 4 types.

## Task

Complete implementation holes in explicitly editable regions in `Toolz/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `compose`

- **Signature**: `def compose (f : β → γ) (g : α → β) : α → γ`
- **Description**: Composes two functions, returning a new function that applies `g` first, then `f`.
- **Postcondition**: `∀ x, result x = f (g x)` — the composed function produces the same result as applying `g` then `f`.
- **Key constraints**: Must return a function (not just evaluate at a point). The result must satisfy the equation for ALL inputs `x`.

### 2. `groupBy`

- **Signature**: `def groupBy (xs : List α) (key : α → β) [BEq β] : List (β × List α)`
- **Description**: Groups elements of a list by a key function, returning a list of (key, elements) pairs.
- **Postcondition**: (1) Total element count is preserved: flattening all groups' element lists gives the same length as the input. (2) Every element in a group has a key that `BEq`-equals the group's key.
- **Key constraints**: Every input element must appear in exactly one group (total coverage, no loss). Groups are keyed by `BEq` equality, not propositional equality.

### 3. `merge`

- **Signature**: `def merge [BEq α] (dicts : List (List (α × β))) : List (α × β)`
- **Description**: Merges multiple association lists (dictionaries) into a single one. When keys collide, later dictionaries take precedence.
- **Postcondition**: (1) Every (key, value) in the result comes from one of the input dicts. (2) Every key from any input dict appears in the result. (3) Key uniqueness: no two entries in the result share the same key (by `BEq`).
- **Key constraints**: The result must have unique keys. When multiple dicts contain the same key, the result should contain the value from the last dict (later takes precedence). The postcondition verifies uniqueness via index-based comparison.

## Relational Properties

- **`compose_assoc_rel`**: Function composition is associative: `compose f (compose g h) x = compose (compose f g) h x` for all `x`.
- **`groupBy_complete_rel`**: Every input element appears in some group in the result (completeness beyond just length preservation).

## Types

No custom types — all functions operate on standard Lean types (`List`, `Prod`, functions).

- `List (β × List α)` is used as the return type for `groupBy` — an association list mapping keys to groups of elements.
- `List (α × β)` is used as the dictionary type for `merge` — an association list of key-value pairs.

## Hints

- For `compose`: the implementation is simply `fun x => f (g x)`. The proof should follow by `rfl` or `funext`.
- For `groupBy`: iterate through the input list, maintaining an accumulator of `(key, elements)` pairs. For each element, compute its key, find the matching group (by `BEq`), and append to it (or create a new group). The order of elements within each group should match their order in the input.
- For `merge`: concatenate all dicts, then deduplicate by key, keeping the last occurrence (since later dicts take precedence). Alternatively, iterate through all dicts in order, inserting/updating entries in an accumulator. The key uniqueness constraint means you must replace (not duplicate) entries with matching keys.
- The `groupBy_complete_rel` proof requires showing that every element `x ∈ xs` ends up in some group. This follows from the construction if every element is placed into a group during iteration.
- The `compose_assoc_rel` proof follows directly from the definition of `compose` — both sides reduce to `f (g (h x))`.

## Edit Boundaries

`Toolz/*.lean` is divided into labeled sections:

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

- `Toolz/Compose.lean`
- `Toolz/GroupBy.lean`
- `Toolz/Merge.lean`
