# Boltons

## Background

Boltons is a collection of 250+ pure Python utility functions, complementing the standard library. Its most well-known module is `iterutils`, which provides list manipulation functions like chunking, deduplication, partitioning, and flattening. It also includes caching utilities (LRU cache), dictionary types, string helpers, and more. This spec focuses on the iterutils and cacheutils modules.

## Task

Complete implementation holes in explicitly editable regions in the split API files under `Boltons/` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `chunked`

- **Signature**: `def chunked (xs : List α) (size : Nat) : List (List α)`
- **Description**: Split a list into consecutive chunks of at most `size` elements. The last chunk may be shorter.
- **Postcondition** (`chunked_postcond`):
  - When `size > 0`: flattening the result recovers the original list
  - When `size > 0`: every chunk has length ≤ `size` and is non-empty
  - When `size > 0` and there are ≥ 2 chunks: all chunks except the last have length exactly `size`
- **Key constraints**: Only specified for `size > 0`. Example: `chunked [1,2,3,4,5] 2 = [[1,2],[3,4],[5]]`.

### 2. `unique`

- **Signature**: `def unique [BEq α] (xs : List α) : List α`
- **Description**: Remove duplicates from a list, preserving the order of first occurrences.
- **Postcondition** (`unique_postcond`):
  - Result has no duplicates (`Nodup`)
  - Result length ≤ input length
  - Bidirectional membership: every element of `xs` is in `result` and vice versa
  - Result is a `Sublist` of input (preserves relative order, only removes elements)
- **Key constraints**: The `Sublist` requirement means you must keep the *first* occurrence of each element and remove later duplicates, maintaining relative order.

### 3. `LRUCache.put`

- **Signature**: `def LRUCache.put [BEq α] (c : LRUCache α β) (k : α) (v : β) : LRUCache α β`
- **Description**: Insert a key-value pair into the LRU cache. If the cache exceeds `maxSize`, evict the least recently used entry.
- **Postcondition** (`LRUCache.put_postcond`):
  - The inserted pair `(k, v)` is in `result.data`
  - Result size ≤ `max c.maxSize 1` (cache respects capacity, minimum 1)
  - `maxSize` is preserved
- **Key constraints**: If `k` already exists, update its value (don't create duplicates). When evicting, remove the least recently used entry (the one furthest from the front of `data`).

## Relational Properties

- **`chunked_flatten_roundtrip`**: When `size > 0`, `flatten (chunked xs size) = xs` — chunking then flattening recovers the original list.
- **`unique_idempotent`**: `unique (unique xs) = unique xs` — deduplicating an already-deduplicated list is a no-op.
- **`LRUCache.get_after_put`**: When `maxSize > 0`, `(c.put k v).get k` returns `some v` — a value is immediately retrievable after insertion.

## Types

- **`LRUCache α β`**: An LRU cache storing key-value pairs as a list (`data : List (α × β)`) with a maximum capacity (`maxSize : Nat`). The front of the list represents most recently used.

## Hints

- For `chunked`, a recursive approach works well: take `size` elements, cons them as a chunk, recurse on the remainder.
- For `unique`, maintain a "seen" set and filter as you traverse. The `Sublist` requirement is the hardest part to prove — make sure your implementation only drops elements without reordering.
- For `flatten`, it should simply be `List.flatten` (or `List.join`).
- For `LRUCache.get`, it should find the value and also move the accessed entry to the front (MRU position). The postcondition only requires finding the value and preserving size/maxSize.
- For `LRUCache.put`, first remove any existing entry for `k`, prepend `(k, v)` to the front, then truncate if over capacity. This naturally satisfies the `get_after_put` relational spec.
- The `unique_idempotent` proof requires showing that `unique` on a `Nodup` list is the identity.

## Edit Boundaries

The split API files under `Boltons/` are divided into labeled sections:

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

- `Boltons/CacheGet.lean`
- `Boltons/CachePut.lean`
- `Boltons/Chunked.lean`
- `Boltons/Flatten.lean`
- `Boltons/Relations.lean`
- `Boltons/Types.lean`
- `Boltons/Unique.lean`
- `Boltons/Validity.lean`
