# SmallVec

## Background

SmallVec is a Rust crate providing a vector type that stores a small number of elements inline (on the stack) before falling back to heap allocation. This spec models it as a list with an `inlineCap` field tracking the inline capacity threshold. The 3 core functions cover the fundamental vector mutations: appending, indexed insertion, and slice extraction.

## Task

Complete implementation holes in explicitly editable regions in:

- `SmallVec/Push.lean`
- `SmallVec/Insert.lean`
- `SmallVec/Drain.lean`

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `push`

- **Signature**: `def SmallVec.push (v : SmallVec α) (x : α) : SmallVec α`
- **Description**: Append an element to the end of the vector.
- **Postcondition**: `SmallVec.push_postcond` requires:
  - `result.data = v.data ++ [x]` (element appended)
  - `result.data.length = v.data.length + 1` (length increases by 1)
  - `result.inlineCap = v.inlineCap` (inline capacity preserved)
- **Key constraints**: The element is always appended at the end. The `inlineCap` field must not change.

### 2. `insert`

- **Signature**: `def SmallVec.insert (v : SmallVec α) (i : Nat) (x : α) : SmallVec α`
- **Description**: Insert an element at the given index, shifting subsequent elements right.
- **Postcondition**: `SmallVec.insert_postcond` requires:
  - When `i ≤ v.data.length`: `result.data = v.data.take i ++ [x] ++ v.data.drop i`
  - `result.inlineCap = v.inlineCap` (always preserved)
- **Key constraints**: The postcondition only specifies behavior when `i ≤ v.data.length` (valid index). The `inlineCap` preservation is unconditional.

### 3. `drain`

- **Signature**: `def SmallVec.drain (v : SmallVec α) (start «end» : Nat) : SmallVec α × List α`
- **Description**: Extract a slice [start, end) from the vector, removing those elements and returning them alongside the modified vector.
- **Postcondition**: `SmallVec.drain_postcond` requires (when `start ≤ stop ≤ v.data.length`):
  - `result.2 = (v.data.drop start).take (stop - start)` (extracted elements are the correct slice)
  - `result.1.data = v.data.take start ++ v.data.drop stop` (remaining elements are everything outside the range)
  - `result.1.inlineCap = v.inlineCap` (inline capacity preserved)
- **Key constraints**: The postcondition is conditional on valid bounds (`start ≤ stop ≤ length`). The extracted list is the second component of the pair, the modified vector is the first.

## Types

- **`SmallVec α`** — A vector with `data : List α` (the elements) and `inlineCap : Nat` (the inline capacity threshold). In this pure model, `inlineCap` doesn't affect behavior — it's metadata tracking when the vector would switch from stack to heap allocation.

## Hints

- Since `SmallVec` is modeled as a plain list with a capacity field, the implementations are straightforward list operations:
  - `push`: `{ data := v.data ++ [x], inlineCap := v.inlineCap }`
  - `insert`: `{ data := v.data.take i ++ [x] ++ v.data.drop i, inlineCap := v.inlineCap }`
  - `drain`: `({ data := v.data.take start ++ v.data.drop stop, inlineCap := v.inlineCap }, (v.data.drop start).take (stop - start))`
- The proofs should follow directly from the definitions — unfold the function and the postcondition, then use `simp` or `rfl`.
- For `drain`, handle the out-of-bounds case (when the precondition doesn't hold) — the postcondition is an implication, so any behavior is acceptable when bounds are invalid.

## Edit Boundaries

The editable task files are divided into labeled sections:

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

- `SmallVec/Drain.lean`
- `SmallVec/Insert.lean`
- `SmallVec/Push.lean`
- `SmallVec/Types.lean`
