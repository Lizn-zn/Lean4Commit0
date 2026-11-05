# Hashbrown

## Background

Hashbrown is Rust's standard library hash map implementation, based on Google's SwissTable design. It provides high-performance `HashMap` and `HashSet` data structures with SIMD-accelerated probing. This spec models both as purely functional data structures using hash-based buckets, focusing on the core insert/get operations for HashMap and set difference for HashSet.

## Task

Complete implementation holes in explicitly editable regions in `Hashbrown/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `HashMap.insert`

- **Signature**: `def HashMap.insert [BEq α] [Hashable α] (m : HashMap α β) (k : α) (v : β) : HashMap α β`
- **Description**: Insert a key-value pair into the hash map. If the key already exists, overwrite its value.
- **Postcondition**: `HashMap.insert_postcond` requires:
  - `result.size' ≥ m.size'` (size never decreases)
  - `result.size' ≤ m.size' + 1` (size grows by at most 1)
  - If the map was empty (`m.size' = 0`), result has exactly 1 entry
  - `result.contains k = true` (key is present after insert)
  - `result.get k = some v` (getting the key returns the inserted value)
- **Key constraints**: The last two properties (`contains` and `get`) reference other `sorry` functions that must be implemented consistently.

### 2. `HashMap.get`

- **Signature**: `def HashMap.get [BEq α] [Hashable α] (m : HashMap α β) (k : α) : Option β`
- **Description**: Look up a key in the hash map, returning `some v` if found or `none` if absent.
- **Postcondition**: `HashMap.get_postcond` requires:
  - Empty map returns `none` (`m.isEmpty = true → result = none`)
  - If result is `some`, map has at least 1 entry and `contains k` is true
  - If `contains k` is false, result is `none`
  - If `some v` is returned, `(k, v)` is in `m.entries`
- **Key constraints**: Must be consistent with `isEmpty`, `contains`, and `entries`. The postcond creates a web of constraints tying these functions together.

### 3. `HashSet.difference`

- **Signature**: `def HashSet.difference [BEq α] [Hashable α] (a b : HashSet α) : HashSet α`
- **Description**: Compute the set difference (a \ b) — elements in `a` that are not in `b`.
- **Postcondition**: `HashSet.difference_postcond` requires:
  - `result.inner.size' ≤ a.inner.size'` (result is at most as large as a)
  - `result.inner.size' + b.inner.size' ≥ a.inner.size'` (size lower bound)
  - For every element in `result.toList`: `a.contains v = true` AND `b.contains v = false`
- **Key constraints**: The element-level property requires `contains` and `toList` to be consistent with the difference operation.

## Relational Properties

- **`HashMap.get_insert_rel`**: After inserting `(k, v)` into any map, `get k` returns `some v`. Requires `LawfulBEq α` (BEq is consistent with Eq).
- **`HashSet.difference_contains_rel`**: For any element `v`, `(a.difference b).contains v = (a.contains v && !b.contains v)`. This is the precise logical characterization of set difference. Requires `LawfulBEq α`.

## Types

- **`Hashable α`**: A type class providing `hash : α → UInt64`. Instances for `Nat`, `String`, and `Int` need implementation.
- **`HashMap α β`**: A hash map with private fields: `buckets` (list of bucket lists), `size'` (number of entries), `capacity'` (bucket count). Uses `private mk` constructor.
- **`HashSet α`**: A hash set implemented as `HashMap α Unit` (wraps a `HashMap` internally). Also uses `private mk`.

## Hints

- All structures use `private mk` — use `⟨...⟩` anonymous constructor syntax.
- `HashMap` is modeled as `List (List (α × β))` buckets. A simple implementation can use a single bucket (one-element list of lists), making the hash function trivial to work with. The spec doesn't require actual hash-based distribution — correctness matters, not performance.
- For the `Hashable` instances, any deterministic hash function works. A simple approach: `hash n := n.toUInt64` for Nat, etc. The hash values just need to be deterministic (same input → same output).
- `HashSet` wraps `HashMap α Unit` — implement `HashSet.contains` as `s.inner.contains v`, `HashSet.toList` as `s.inner.keys`, and `HashSet.difference` by filtering elements of `a` not in `b`.
- The `get_insert_rel` proof requires `LawfulBEq α` — this means `(a == b) = true ↔ a = b`. Use this to prove that looking up the just-inserted key finds it.
- Dependencies that also need implementation: `HashMap.empty`, `HashMap.isEmpty`, `HashMap.contains`, `HashMap.entries`, `HashSet.contains`, `HashSet.toList`. Implement these consistently with the main functions.
- For `HashMap.isEmpty`, return `m.size' == 0`. For `HashMap.contains`, return `(m.get k).isSome`. For `HashMap.entries`, flatten all buckets.

## Edit Boundaries

`Hashbrown/*.lean` is divided into labeled sections:

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

- `Hashbrown/Difference.lean`
- `Hashbrown/Get.lean`
- `Hashbrown/Insert.lean`
- `Hashbrown/Relations.lean`
- `Hashbrown/Types.lean`
