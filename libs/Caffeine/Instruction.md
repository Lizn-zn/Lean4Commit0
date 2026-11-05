# Caffeine

## Background

Caffeine is a Java high-performance caching library. Its key innovation is the W-TinyLfu admission policy, which uses a Count-Min Sketch (frequency sketch) to estimate access frequency and decides whether a new entry should be admitted to the cache by comparing its frequency against the entry it would evict. This spec models the cache as a purely functional data structure with three segments (window, probation, protected) following the W-TinyLfu architecture.

## Task

Complete implementation holes in explicitly editable regions in the split files under `Caffeine/` and complete the proof obligations assigned to editable regions. Helper definitions are grouped in `Caffeine/Helpers.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `Cache.get`

- **Signature**: `def Cache.get [BEq α] (cache : Cache α β) (key : α) : Cache α β × Option β`
- **Description**: Look up a key in the cache. Returns the updated cache (with statistics updated) and the value if found.
- **Postcondition** (`Cache.get_postcond`):
  - Total of hitCount + missCount increases by exactly 1
  - Estimated size of returned cache ≤ maxSize
  - On miss (result = none): missCount increments by 1
  - On hit (result ≠ none): hitCount increments by 1
- **Key constraints**: The returned cache must have updated statistics. The size invariant must hold even after a get (get may trigger lazy cleanup).

### 2. `Cache.put`

- **Signature**: `def Cache.put [BEq α] (cache : Cache α β) (key : α) (value : β) : Cache α β`
- **Description**: Insert a key-value pair into the cache, evicting entries if necessary to stay within maxSize.
- **Postcondition** (`Cache.put_postcond`):
  - Estimated size of result ≤ maxSize
  - When maxSize > 0: `(Cache.get result key).2 = some value` — the inserted value is immediately retrievable
- **Key constraints**: The second condition means your `put` and `get` must be consistent. If maxSize is 0, the cache cannot hold anything.

### 3. `admit`

- **Signature**: `def admit (sketch : FrequencySketch) (candidateHash : UInt64) (victimHash : UInt64) : Bool`
- **Description**: The W-TinyLfu admission decision. Compares the estimated frequency of a candidate entry against a victim entry to decide if the candidate should be admitted.
- **Postcondition** (`admit_postcond`):
  - If candidate frequency > victim frequency: returns true (admit)
  - If candidate frequency ≤ victim frequency: returns false (reject)
- **Key constraints**: This is a pure comparison of `FrequencySketch.frequency` values. No randomness or probabilistic admission in this spec.

## Relational Properties

- **`get_after_put_rel`**: When maxSize > 0, `(Cache.get (Cache.put cache k v) k).2 = some v` — a value is immediately retrievable after insertion.
- **`put_preserves_other_rel`**: When `k ≠ k'`, the original value for `k'` is present, and the cache is not full, putting `k` does not affect `k'`'s value.

## Types

- **`Cache α β`**: The main cache structure with three entry lists (`window`, `probation`, `protected'`), `maxSize`, a `FrequencySketch`, `CacheStats`, `ExpirationConfig`, and `EvictionPolicy`. Fields are private — interact via `get`/`put`/`estimatedSize`/`getStats`.
- **`FrequencySketch`**: A Count-Min Sketch storing 4-bit counters packed into `UInt8` values. Each entry stores two 4-bit counters (low nibble and high nibble), so frequencies are bounded by 15.
- **`CacheStats`**: Hit/miss/eviction/load counters.
- **`CacheEntry α β`**: A cache entry with key, value, access/write times, frequency, and weight.
- **`EvictionPolicy`**: One of LRU, LFU, TinyLfu, or WindowTinyLfu.
- **`ExpirationConfig`**: Optional TTLs for write-based expiration, access-based expiration, and refresh-after-write.

## Hints

- `Cache.estimatedSize` should return the total count of entries across all three segments: `window.length + probation.length + protected'.length`.
- `Cache.getStats` simply returns `cache.stats`.
- `FrequencySketch.frequency` implements a Count-Min Sketch lookup. Each hash maps to multiple table positions; the frequency is the minimum of the 4-bit counters at those positions. For the postcondition, you mainly need: result ≤ 15, all-zero table → 0, and the result comes from some table entry's nibble.
- For `Cache.put`, the key challenge is eviction: after inserting, if size exceeds maxSize, evict entries. The `get_after_put_rel` requires the newly inserted entry to survive eviction (which it should, since it's the most recently used).
- For `Cache.get`, search all three segments (window, probation, protected') for the key. Update stats accordingly.
- The `admit` function is trivially a frequency comparison — the complexity is in `FrequencySketch.frequency`, not in `admit` itself.

## Edit Boundaries

The split files under `Caffeine/` are divided into labeled sections:

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

- `Caffeine/Admit.lean`
- `Caffeine/CacheGet.lean`
- `Caffeine/CachePut.lean`
- `Caffeine/Helpers.lean`
- `Caffeine/Relations.lean`
- `Caffeine/Types.lean`
