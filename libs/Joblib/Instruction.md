# Joblib

## Background

Joblib is a Python library for lightweight pipelining, providing transparent disk-caching of functions, parallel computing helpers, and efficient serialization. This spec models three core aspects: an in-memory function result cache (store results keyed by function name + argument hash), batch execution planning (splitting work into groups based on strategy), and hex conversion utilities (used for hash digest representation).

## Task

Complete implementation holes in explicitly editable regions in `Joblib/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `MemoryCache.store`

- **Signature**: `def MemoryCache.store (cache : MemoryCache) (key : CacheKey) (resultData : Array Float) : MemoryCache`
- **Description**: Store a function result in the cache, keyed by function name and argument hash. If the key already exists, it should be updated.
- **Postcondition**: `MemoryCache_store_postcond` requires:
  - An entry with the given key exists in `result.entries` (`any (fun e => e.key == key)`)
  - `result.entries.size ≤ cache.entries.size + 1` (at most one new entry)
  - `result.maxSizeBytes = cache.maxSizeBytes` (max size preserved)
  - An entry with both matching key AND matching resultData exists
- **Key constraints**: Both the key and data must be findable in the result. If updating an existing key, the size should not increase (≤ original + 1 covers both insert and update cases).

### 2. `planExecution`

- **Signature**: `def planExecution (batch : Batch) (strategy : ExecutionStrategy) : Array (Array Nat)`
- **Description**: Plan how to execute a batch of delayed computations by splitting them into groups of indices. Sequential strategy puts one item per group; chunked strategy groups items by chunk size.
- **Postcondition**: `planExecution_postcond` requires:
  - Total number of indices across all groups equals `batch.size` (partition property)
  - Sequential strategy with non-empty batch → `result.size = batch.size` (one group per item)
  - Empty batch → empty result
  - All indices are valid: every index in every group is `< batch.size`
- **Key constraints**: The groups must form a complete partition of `[0, batch.size)`. For `ExecutionStrategy.sequential`, each group contains exactly one index. For `ExecutionStrategy.chunked size`, each group has at most `size` elements (except possibly the last).

### 3. `natToHex`

- **Signature**: `def natToHex (n : Nat) : String`
- **Description**: Convert a natural number to its lowercase hexadecimal string representation.
- **Postcondition**: `natToHex_postcond` requires:
  - Result is non-empty (`length > 0`)
  - 7 concrete test vectors: 0→"0", 1→"1", 15→"f", 16→"10", 255→"ff", 256→"100", 42→"2a"
- **Key constraints**: Use lowercase hex digits (a-f, not A-F). No leading zeros (except for `n = 0` which returns `"0"`).

## Relational Properties

- **`MemoryCache_store_lookup_rel`**: After storing `(key, data)` into a cache, looking up `key` returns `some entry` where `entry.key = key`. This verifies that store and lookup are consistent.
- **`hex_roundtrip_rel`**: For any natural number `n`, `hexToNat (natToHex n) = some n`. Converting to hex and back recovers the original number.

## Types

- **`HashDigest`**: Alias for `String` — a hex-encoded hash value.
- **`CacheKey`**: A cache key with `funcName : String` and `argHash : HashDigest`.
- **`CacheEntry`**: A cached result with `key`, `resultHash`, `resultData : Array Float`, `timestamp : Nat`, `sizeBytes : Nat`.
- **`MemoryCache`**: An in-memory cache with `entries : Array CacheEntry`, `maxSizeBytes : Nat`, `currentTime : Nat`.
- **`Delayed`**: A delayed computation recipe with `funcName : String` and `argHashes : Array HashDigest`.
- **`Batch`**: Alias for `Array Delayed`.
- **`ExecutionStrategy`**: Either `sequential` (one at a time) or `chunked size` (groups of given size).

## Hints

- For `MemoryCache.store`: create a `CacheEntry` with the given key and data, then either replace an existing entry with the same key or append. Set `timestamp` to `cache.currentTime` and `sizeBytes` to `resultData.size * 8` (or similar). Remember to preserve `maxSizeBytes`.
- For `planExecution` with `sequential`: create one singleton array per batch item, e.g., `#[#[0], #[1], ..., #[n-1]]`. For `chunked size`: group consecutive indices into chunks of the given size.
- For `natToHex`: repeatedly divide by 16, mapping remainders to hex digits. Build the string from least significant to most significant digit, then reverse. Handle `n = 0` as a special case returning `"0"`.
- `MemoryCache.lookup` and `MemoryCache.remove` are also `sorry` — implement them consistently with `store`:
  - `lookup`: scan entries for matching key, return the first match
  - `remove`: filter out entries with matching key
- `hexToNat` is also `sorry` — implement it as the inverse of `natToHex`: parse each hex character to its value (0-15), accumulate with base 16. Return `none` for empty strings or invalid hex characters.
- The `store_lookup_rel` proof requires `store` and `lookup` to be consistent — if `store` appends/updates an entry with the key, `lookup` must find it.

## Edit Boundaries

`Joblib/*.lean` is divided into labeled sections:

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

- `Joblib/Helpers.lean`
- `Joblib/NatToHex.lean`
- `Joblib/PlanExecution.lean`
- `Joblib/Relations.lean`
- `Joblib/Store.lean`
- `Joblib/Types.lean`
