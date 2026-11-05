# DashMap

## Background

DashMap is a Rust crate providing a concurrent hash map with sharded locking for high-performance parallel access. In this spec, the concurrent map is modeled as a pure functional data structure — a list of (key, value) pairs — with sequential specification equivalence. The core operations are insert, get, and remove, along with algebraic properties that relate them (e.g., getting a key after inserting it returns the inserted value).

## Task

Complete implementation holes in explicitly editable regions in the `DashMap/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `DashMap.insert`

- **Signature**: `def DashMap.insert [BEq α] (m : DashMap α β) (k : α) (v : β) : DashMap α β`
- **Description**: Inserts a key-value pair into the map. If the key already exists, its value is replaced.
- **Postcondition**:
  - Result length ≤ original length + 1
  - The key `k` exists in the result with value `v`
  - All entries with key `k` in the result have value `v` (uniqueness)
  - All entries from the original map with keys ≠ `k` are preserved
- **Key constraints**: Must handle both the "new key" and "existing key" cases. When the key exists, replace rather than duplicate.

### 2. `DashMap.get`

- **Signature**: `def DashMap.get [BEq α] (m : DashMap α β) (k : α) : Option β`
- **Description**: Looks up a key in the map, returning its value if found.
- **Postcondition**:
  - Empty map → returns `none`
  - If result is `some v`, then a pair with key `k` and value `v` exists in the data
  - If any pair with key `k` exists in the data, result is `some`
  - If no pair with key `k` exists, result is `none`
- **Key constraints**: Uses `BEq` for key comparison (`==`). Must search the entire list.

### 3. `DashMap.remove`

- **Signature**: `def DashMap.remove [BEq α] (m : DashMap α β) (k : α) : DashMap α β × Option β`
- **Description**: Removes a key from the map, returning the updated map and the removed value (if any).
- **Postcondition**:
  - Result map length ≤ original length
  - If a value was removed (isSome), result map is strictly smaller
  - Empty map → returns (empty, none)
  - If key existed → returns some value
  - If key didn't exist → returns none and map is unchanged
  - No entry in result has key `k`
  - All result entries come from the original map
  - All original entries with keys ≠ `k` are preserved
- **Key constraints**: This has the richest postcondition (8 clauses). Must filter out ALL entries matching `k`, preserve everything else, and return the removed value.

## Relational Properties

- **`get_insert`**: `(m.insert k v).get k = some v` — getting a key immediately after inserting it returns the inserted value.
- **`get_insert_other`**: If `k ≠ k'`, then `(m.insert k v).get k' = m.get k'` — inserting a key doesn't affect lookups of different keys.
- **`get_remove`**: `(m.remove k).1.get k = none` — getting a key after removing it returns none.
- **`get_remove_other`**: If `k ≠ k'`, then `(m.remove k).1.get k' = m.get k'` — removing a key doesn't affect lookups of different keys.

## Types

- **`DashMap α β`**: A map from keys of type `α` to values of type `β`, represented internally as `List (α × β)`. The constructor and `data` field are private — use `new`, `insert`, `get`, `remove` to manipulate.

## Hints

- The `data` field is private but accessible within the `DashMap` namespace. Implement `new` as `⟨[]⟩`, `insert` by filtering out old entries for `k` then prepending `(k, v)`, `get` by finding the first matching entry, and `remove` by partitioning on key equality.
- Key comparison uses `BEq` (`==`), not `DecidableEq`. The relational specs require `LawfulBEq` which gives you `BEq.eq_of_beq` and `BEq.beq_iff_eq`.
- For the relational proofs, you'll need to reason about how `insert`/`remove` modify the `data` list and how `get` searches it. The `LawfulBEq` instance is critical for connecting `==` to `=`.
- The `get_insert_other` and `get_remove_other` proofs need the hypothesis `(k == k') = false` to show non-interference.
- Consider implementing `insert` as: filter out entries where `pair.1 == k`, then cons `(k, v)`. This makes the postconditions and relational proofs more straightforward.

## Edit Boundaries

The editable module files under `DashMap/` are divided into labeled sections:

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

- `DashMap/Get.lean`
- `DashMap/Helpers.lean`
- `DashMap/Insert.lean`
- `DashMap/Relations.lean`
- `DashMap/Remove.lean`
- `DashMap/Types.lean`
