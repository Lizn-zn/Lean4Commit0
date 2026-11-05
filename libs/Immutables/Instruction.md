# Immutables

## Background

Immutables is a Java library for generating immutable value objects and persistent collections. It provides ImmutableList (ordered, indexed), ImmutableMap (key-value lookup), ImmutableSet (unique elements with set operations), ImmutableMultimap (key to multiple values), and a builder pattern for constructing collections. This core spec focuses on one representative function from each of the three main collection types: sorting a list, computing a set union, and looking up a map key.

## Task

Complete implementation holes in explicitly editable regions in `Immutables/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `ImmutableList.sorted`

- **Signature**: `def ImmutableList.sorted [Ord α] (l : ImmutableList α) : ImmutableList α`
- **Description**: Returns a new immutable list with the same elements sorted in non-descending order.
- **Postcondition**:
  - `result.data.length = l.data.length` — length preserved
  - `∀ x, x ∈ result.data ↔ x ∈ l.data` — elements preserved (bidirectional)
  - `List.Pairwise (fun a b => Ord.compare a b ≠ .gt) result.data` — result is sorted
- **Key constraints**: Must be a permutation of the input (same elements, same length). The ordering is defined by `Ord.compare` — adjacent elements must not be in descending order.

### 2. `ImmutableSet.union`

- **Signature**: `def ImmutableSet.union [BEq α] (a b : ImmutableSet α) : ImmutableSet α`
- **Description**: Returns the union of two immutable sets — a new set containing all elements from both.
- **Postcondition**:
  - If an element is in the result, it's in `a` or `b` (soundness)
  - If an element is in `a`, it's in the result (completeness for `a`)
  - If an element is in `b`, it's in the result (completeness for `b`)
- **Key constraints**: Uses `BEq` (`==`) for element comparison via `List.any`. All three directions of the membership property must hold.

### 3. `ImmutableMap.get`

- **Signature**: `def ImmutableMap.get [BEq α] (m : ImmutableMap α β) (k : α) : Option β`
- **Description**: Looks up a key in the immutable map, returning its value or `none`.
- **Postcondition**:
  - `result = none ↔ m.data.find? (fun pair => pair.1 == k) = none` — none iff not found
  - If `result = some v`, there exists a pair in `m.data` with matching key and that value
- **Key constraints**: The `none` case is a biconditional (iff), which is stronger than a one-directional implication. Uses `BEq` for key comparison.

### 4. `ImmutableSet.contains` (helper)

- **Signature**: `def ImmutableSet.contains [BEq α] (s : ImmutableSet α) (v : α) : Bool`
- **Description**: Checks if a value is in the set.
- **Postcondition**: `result = true ↔ s.data.any (· == v) = true`

### 5. `ImmutableMap.containsKey` (helper)

- **Signature**: `def ImmutableMap.containsKey [BEq α] (m : ImmutableMap α β) (k : α) : Bool`
- **Description**: Checks if a key exists in the map.
- **Postcondition**: `result = m.data.any (fun p => p.1 == k)`

## Relational Properties

- **`ImmutableSet.union_contains`**: `(a.union b).contains v = (a.contains v || b.contains v)` — union membership equals the disjunction of individual memberships. Requires `LawfulBEq`.
- **`ImmutableMap.containsKey_get`**: `containsKey k = true ↔ (get k).isSome = true` — a key is contained iff get returns some value.

## Types

- **`ImmutableList α`**: An immutable list wrapping `data : List α`. Supports indexed access and sorting.
- **`ImmutableMap α β`**: An immutable map wrapping `data : List (α × β)`. Keys use `BEq` for comparison.
- **`ImmutableSet α`**: An immutable set wrapping `data : List α`. Elements use `BEq` for comparison.

## Hints

- For `ImmutableList.sorted`, use a sorting algorithm (e.g., merge sort or insertion sort) that preserves elements and produces a sorted list. `List.mergeSort` may be available in Lean 4's standard library. The key proof obligation is `List.Pairwise` on the result.
- For `ImmutableSet.union`, concatenate the two data lists and deduplicate (or use a smarter merge). The postcondition uses `List.any (· == v)` for membership, so duplicates in the internal list are acceptable — but the three-way membership property must hold.
- For `ImmutableMap.get`, search `m.data` for the first pair where `pair.1 == k`. Use `List.find?` with the key comparison. The biconditional `none ↔ find? = none` means your implementation must agree exactly with `List.find?` on when to return `none`.
- For `ImmutableSet.contains`, implement as `s.data.any (· == v)` — the postcondition is an exact equality.
- For `ImmutableMap.containsKey`, implement as `m.data.any (fun p => p.1 == k)`.
- The `union_contains` relational proof requires `LawfulBEq` — you can use `BEq.eq_of_beq` and `beq_iff_eq` to convert between `==` and `=`.

## Edit Boundaries

`Immutables/*.lean` is divided into labeled sections:

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

- `Immutables/Get.lean`
- `Immutables/Helpers.lean`
- `Immutables/Relations.lean`
- `Immutables/Sorted.lean`
- `Immutables/Types.lean`
- `Immutables/Union.lean`
