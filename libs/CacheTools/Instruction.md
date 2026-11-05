# CacheTools

## Background

CacheTools is a Python library providing extensible memoizing collections with different eviction strategies (FIFO, LRU, LFU, Random Replacement, TTL). In this Lean formalization, caches are modeled as structures holding a list of key-value pairs and a maximum size. The core spec focuses on two cache types: LRU (Least Recently Used) — the most commonly used cache — and TTL (Time-To-Live) — the most distinctive, adding time-based expiration.

## Task

Complete implementation holes in explicitly editable regions in the split files under `CacheTools/` and complete the proof obligations assigned to editable regions. Helper definitions are grouped in `CacheTools/Helpers.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `LRUCache.set`

- **Signature**: `def LRUCache.set [BEq α] (cache : LRUCache α β) (key : α) (value : β) : LRUCache α β`
- **Description**: Insert or update a key-value pair in the LRU cache. If the cache is full and the key is new, evict the least recently used entry first.
- **Postcondition**: Seven requirements:
  1. `result.data.length ≤ cache.maxsize'` (never exceeds capacity)
  2. `result.maxsize' = cache.maxsize'` (maxsize preserved)
  3. If maxsize > 0, the key exists in the result
  4. `result.data.length ≥ min cache.data.length cache.maxsize'` (size doesn't shrink below minimum)
  5. If key already existed, size stays the same
  6. If key is new and maxsize > 0, size = min(old_size + 1, maxsize)
  7. If no eviction needed (room or key exists), all old keys are preserved
- **Key constraints**: For LRU, the evicted entry should be the least recently used. The `data` list represents entries ordered by recency (most recent at the end or beginning — your choice, but be consistent with `get`).

### 2. `TTLCache.set`

- **Signature**: `def TTLCache.set [BEq α] (cache : TTLCache α β) (key : α) (value : β) (now : Nat) : TTLCache α β`
- **Description**: Insert or update a key-value pair with an expiry timestamp of `now + ttl`. If full, evict an entry (expired entries first, then oldest).
- **Postcondition**: Eight requirements — same 7 as LRU cache capacity constraints, plus:
  - The inserted entry has `expiry == now + cache.ttl'` (timestamp tracking)
- **Key constraints**: Each entry stores its expiry time. The `now` parameter represents current time. TTL entries are stored as `TTLEntry` structures with `key`, `value`, and `expiry` fields.

### 3. `TTLCache.expire`

- **Signature**: `def TTLCache.expire [BEq α] (cache : TTLCache α β) (now : Nat) : TTLCache α β × List (α × β)`
- **Description**: Remove all expired entries (those with `expiry ≤ now`) from the cache. Returns the cleaned cache and a list of removed (key, value) pairs.
- **Postcondition**: Four requirements:
  1. Surviving entries ≤ original count
  2. All surviving entries have `expiry > now` (not expired)
  3. `removed.length + surviving.length = original.length` (conservation)
  4. Surviving count ≥ count of entries with `expiry > now` (no valid entries lost)
- **Key constraints**: Must remove ALL expired entries, not just some. The returned list contains the removed entries as `(key, value)` pairs.

## Relational Properties

- **`LRUCache.get_after_set_rel`**: After `set(cache, k, v)`, calling `get(_, k)` returns `some v` (provided `maxsize > 0`). This is the fundamental cache correctness property.
- **`TTLCache.get_after_set_rel`**: Same property for TTL cache — `get` at the same time as `set` returns the value.
- **`TTLCache.get_expired_rel`**: The key TTL property — after `set(cache, k, v, t_insert)`:
  - If `t_query ≥ t_insert + ttl`, then `get(_, k, t_query)` returns `none` (entry expired)
  - If `t_query < t_insert + ttl` and `maxsize > 0`, then `get` returns `some v` (entry still valid)

## Types

- **`LRUCache α β`**: A cache with `data : List (α × β)` (key-value pairs ordered by recency) and `maxsize' : Nat`. Fields are private — construct via `empty`, access via the API.
- **`TTLEntry α β`**: A cache entry with `key : α`, `value : β`, and `expiry : Nat` (the timestamp at which this entry expires).
- **`TTLCache α β`**: A cache with `data : List (TTLEntry α β)`, `maxsize' : Nat`, and `ttl' : Nat` (time-to-live duration). Fields are private.

## Hints

- For `LRUCache`, represent entries in recency order in `data`. On `get`, move the accessed entry to the most-recent position. On `set`, add/move to most-recent; if over capacity, drop the least-recent entry (head or tail of the list, depending on your convention).
- For `TTLCache.set`, first check for expired entries that can be evicted before evicting valid entries. Set `expiry = now + cache.ttl'` on the new entry.
- For `TTLCache.expire`, partition `data` into entries with `expiry > now` (keep) and `expiry ≤ now` (remove). Return both.
- For `TTLCache.get`, check expiry before returning — if `expiry ≤ now`, treat the entry as absent.
- The `LRUCache.get` function returns `(updated_cache, Option β)` — it must update recency even when just reading, which is what makes LRU different from FIFO.
- `LRUCache.empty`, `LRUCache.size`, `LRUCache.maxsize` and the TTL equivalents are straightforward — they access/initialize the private fields.
- The relational proofs tie `set` and `get` together — implement both consistently, then the proofs should follow from the implementation.

## Edit Boundaries

The split files under `CacheTools/` are divided into labeled sections:

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

- `CacheTools/Helpers.lean`
- `CacheTools/LRUSet.lean`
- `CacheTools/Relations.lean`
- `CacheTools/TTLExpire.lean`
- `CacheTools/TTLSet.lean`
- `CacheTools/Types.lean`
- `CacheTools/Validity.lean`
