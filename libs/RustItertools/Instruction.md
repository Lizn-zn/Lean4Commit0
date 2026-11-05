# RustItertools

## Background

itertools is Rust's most popular iterator extension crate, providing additional adaptors and functions for working with iterators: combinations, permutations, grouping, merging, zipping, folding, and more. This spec models these as pure list functions. The 3 core functions represent three distinct categories: combinatorics, merging, and accumulation.

## Task

Complete implementation holes in explicitly editable regions in the split files under `RustItertools/` and complete the proof obligations assigned to editable regions. Shared helpers are grouped in `RustItertools/Helpers.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `combinations`

- **Signature**: `def combinations (xs : List α) (k : Nat) : List (List α)`
- **Description**: Generate all k-element combinations from the list (without replacement, order-independent). For example, `combinations [1,2,3] 2` produces `[[1,2], [1,3], [2,3]]`.
- **Precondition**: `k ≤ xs.length`
- **Postcondition**: `combinations_postcond` requires:
  - Every combination has exactly `k` elements
  - The total number of combinations equals `Nat.choose xs.length k` (the binomial coefficient)
- **Key constraints**: Order within each combination doesn't matter (these are sets, not permutations). The total count must match the mathematical formula exactly.

### 2. `interleave`

- **Signature**: `def interleave (xs ys : List α) : List α`
- **Description**: Interleave two lists by alternating elements: take one from `xs`, one from `ys`, one from `xs`, etc. When one list is exhausted, append the remainder of the other.
- **Postcondition**: `interleave_postcond` requires (5 clauses):
  - `result.length = xs.length + ys.length` (no elements lost or added)
  - `xs = []` → `result = ys` (left identity)
  - `ys = []` → `result = xs` (right identity)
  - For `i < min xs.length ys.length`: element at position `2*i` equals `xs[i]`
  - For `i < min xs.length ys.length`: element at position `2*i+1` equals `ys[i]`
- **Key constraints**: The alternating pattern is only guaranteed for indices within the shorter list's range. After the shorter list is exhausted, the remaining elements from the longer list follow. Uses `List.get` with explicit bounds proofs.

### 3. `scanLeft`

- **Signature**: `def scanLeft (xs : List α) (init : β) (f : β → α → β) : List β`
- **Description**: Like `foldl` but collects all intermediate accumulator values. The result starts with `init` and each subsequent element is `f` applied to the previous accumulator and the current input element.
- **Postcondition**: `scanLeft_postcond` requires (3 clauses):
  - `result.length = xs.length + 1` (one more than input, since init is included)
  - `result.head? = some init` (first element is the initial value)
  - For each `i < xs.length`: `result[i+1] = f result[i] xs[i]` (recurrence relation)
- **Key constraints**: The recurrence relation uses `List.get` with explicit bounds proofs. For `xs = [a, b, c]` and `init = z`, the result is `[z, f z a, f (f z a) b, f (f (f z a) b) c]`.

## Types

No custom types — all functions operate on standard `List α` with standard typeclasses.

## Hints

- **`Nat.choose`** is already implemented (not sorry) — it computes the binomial coefficient using the standard recursive definition: `C(n,0) = 1`, `C(0,k+1) = 0`, `C(n+1,k+1) = C(n,k) + C(n,k+1)`. Use this directly in proofs.
- For `combinations`, a recursive approach works well: for each element, either include it (and choose k-1 from the rest) or exclude it (and choose k from the rest). The count proof follows from the recurrence of `Nat.choose`.
- For `interleave`, alternate between taking from `xs` and `ys`. A recursive definition: `interleave (x::xs) ys = x :: interleave ys xs` with `interleave [] ys = ys`. The position proofs require showing that the alternating indices correctly index into the original lists.
- For `scanLeft`, build the result incrementally: start with `[init]`, then for each element `x` in `xs`, append `f (last accumulator) x`. A recursive or fold-based implementation works. The recurrence proof is the key — it must show each element is `f` of the previous.

## Edit Boundaries

The editable module files under `RustItertools/` are divided into labeled sections:

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

- `RustItertools/Combinations.lean`
- `RustItertools/Helpers.lean`
- `RustItertools/Interleave.lean`
- `RustItertools/ScanLeft.lean`

## Published model limits (v3)

The combinations contract checks output lengths, binomial cardinality and element membership. It does not establish position-wise no-replacement completeness or multiplicities. The formal task is this weaker collection contract.
