# Rayon

## Background

Rayon is a Rust library for data parallelism, providing work-stealing parallel iterators that allow transforming sequential computations into parallel ones with minimal code changes. This spec models parallel iterator operations as pure sequential list functions — the spec captures the *what* (results must match sequential execution) rather than the *how* (parallel scheduling). A `ParIter α` is simply a wrapper around `List α`.

## Task

Complete implementation holes in explicitly editable regions in the `Rayon/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `ParIter.map`

- **Signature**: `def ParIter.map (it : ParIter α) (f : α → β) : ParIter β`
- **Description**: Applies a function to each element of the parallel iterator, producing a new iterator with the transformed elements.
- **Postcondition**: `result.data = it.data.map f` — the result's underlying list is exactly `List.map f` applied to the input's list.
- **Key constraints**: Must preserve order and apply `f` to every element.

### 2. `ParIter.reduce`

- **Signature**: `def ParIter.reduce (it : ParIter α) (identity : α) (f : α → α → α) : α`
- **Description**: Reduces all elements to a single value using an identity element and an associative binary operation.
- **Postcondition**: `result = it.data.foldl f identity` — the result must equal a left fold of the operation over the data starting from the identity.
- **Key constraints**: The operation `f` is assumed associative (for parallel correctness), but the spec requires matching sequential `foldl` exactly.

### 3. `join`

- **Signature**: `def join (f : Unit → α) (g : Unit → β) : α × β`
- **Description**: Executes two closures (potentially in parallel) and returns both results as a pair.
- **Postcondition**: `result = (f (), g ())` — the result is simply the pair of both closures evaluated.
- **Key constraints**: Both closures must be evaluated. The spec is deterministic (no observable parallelism effects).

### Supporting Functions

- **`ParIter.fromList`**: Wraps a list into a `ParIter`. Postcond: `result.data = xs`.
- **`ParIter.collect`**: Extracts the list from a `ParIter`. Postcond: `result = it.data`.

## Relational Properties

- **`collect_fromList_rel`**: Constructing a parallel iterator from a list and collecting it back produces the original list: `(ParIter.fromList xs).collect = xs`.
- **`reduce_sum_rel`**: Parallel summation via reduce matches sequential summation via foldl: `(ParIter.fromList xs).reduce 0 (· + ·) = xs.foldl (· + ·) 0`.

## Types

- **`ParIter α`**: A parallel iterator, modeled as a simple wrapper around `List α` with a single `data` field. All parallel semantics are captured by postconditions that equate results to sequential list operations.

## Hints

- All implementations are trivial wrappers around list operations: `fromList xs = { data := xs }`, `collect it = it.data`, `map it f = { data := it.data.map f }`, `reduce it id f = it.data.foldl f id`, `join f g = (f (), g ())`.
- The proofs should follow directly from the implementations — most are `rfl` or `simp` after unfolding.
- The `collect_fromList_rel` proof chains the postconditions of `fromList` and `collect`.
- The `reduce_sum_rel` proof chains `fromList` (to get `data = xs`) with `reduce` (to get `foldl`).
- The key insight is that this spec is intentionally simple: parallel iterators are modeled as plain lists, so "parallel = sequential" is the entire specification.

## Edit Boundaries

`Rayon/*.lean` is divided into labeled sections:

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

## Revised release contract (v3)

Every template placeholder is now an explicit editable obligation, including the former provided/unmarked holes. All types, declaration headers, predicates and non-hole support source are protected. Read the validity assumptions in the theorem statements; they are part of this revised task, not the historical experiment. The optional PROOF_IMPORTS regions permit only Mathlib, Batteries, Std or Lean imports. Use local helper definitions inside implementation/proof bodies when needed.

The default root checker reconstructs an authenticated fresh task tree, builds it, checks required declarations and exact trusted types, and audits transitive axioms of all task-module declarations. A compiling template with sorry is not solved. The verdict concerns the published simplified Lean model. All original paper results remain associated with the preserved experiment version.

Current task modules (relative to this library directory):

- `Rayon/Collect.lean`
- `Rayon/FromList.lean`
- `Rayon/Join.lean`
- `Rayon/Map.lean`
- `Rayon/Reduce.lean`
- `Rayon/Relations.lean`
- `Rayon/Types.lean`
