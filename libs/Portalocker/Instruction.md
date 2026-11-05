# Portalocker

## Background

Portalocker is a Python library for cross-platform file locking, supporting shared (read) and exclusive (write) locks, reentrant locks, and read-write locks. This spec models locks as pure state machines — no actual OS-level file locking, but the same acquire/release semantics. The 3 core functions cover the basic lock acquire/release cycle and reentrant lock acquisition.

## Task

Complete implementation holes in explicitly editable regions in the `Portalocker/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `Lock.acquire`

- **Signature**: `def Lock.acquire (lock : Lock) (holder : LockHolderId) (lockType : LockType := .exclusive) (blocking : Bool := true) : Option Lock`
- **Description**: Attempt to acquire a lock. Returns `some` with the updated lock on success, `none` if the lock cannot be acquired.
- **Postcondition**: `Lock.acquire_postcond` requires (9 clauses):
  - Unlocked lock → always succeeds
  - Exclusively held lock → always fails (regardless of holder)
  - Shared lock + shared request → succeeds (adds holder to list)
  - Shared lock + exclusive request → fails
  - On success: result is held by the requesting holder
  - On success: lock name is preserved
  - State transitions: unlocked+shared → `sharedBy [holder]`, unlocked+exclusive → `exclusiveBy holder`, shared+shared → append holder
- **Key constraints**: An exclusively locked lock blocks ALL acquire attempts, even from the same holder (that's what RLock is for). Shared locks allow additional shared acquires but block exclusive ones.

### 2. `Lock.release`

- **Signature**: `def Lock.release (lock : Lock) (holder : LockHolderId) : Option Lock`
- **Description**: Release a lock held by the given holder. Returns `some` with the updated lock on success, `none` if the holder doesn't hold the lock.
- **Postcondition**: `Lock.release_postcond` requires (8 clauses):
  - Unlocked lock → fails
  - Exclusive lock held by this holder → succeeds, state becomes unlocked
  - Exclusive lock held by different holder → fails
  - Lock name preserved
  - Shared lock with holder present → succeeds
  - Shared lock without holder → fails
  - Shared release: if no other holders remain → unlocked; otherwise → sharedBy remaining
- **Key constraints**: For shared locks, release removes only the specified holder using `List.filter (· != holder)`. If the filtered list is empty, the lock becomes unlocked.

### 3. `RLock.acquire`

- **Signature**: `def RLock.acquire (lock : RLock) (holder : LockHolderId) : Option RLock`
- **Description**: Acquire a reentrant lock. Unlike `Lock.acquire`, the same holder can acquire it multiple times, incrementing the count each time.
- **Postcondition**: `RLock.acquire_postcond` requires:
  - Unheld lock (holder = none) → succeeds
  - Same holder → succeeds, count incremented by 1
  - Different holder → fails
  - On first acquire: holder is set, count = 1, name preserved
  - On re-acquire: holder stays the same, name preserved
- **Key constraints**: This is the key difference from `Lock` — the same holder can acquire multiple times. Each acquire increments `count`. A different holder is always rejected.

## Relational Properties

- **`acquire_release_rel`**: Acquiring an exclusive lock on a new lock, then releasing it, returns the original new lock. Tests the acquire→release roundtrip.
- **`double_acquire_exclusive_rel`**: Acquiring an exclusive lock twice (by any two holders) on a new lock always fails on the second acquire. Tests exclusive mutual exclusion.
- **`shared_allows_multiple_rel`**: Acquiring a shared lock twice (by any two holders) on a new lock always succeeds. Tests that shared locks permit concurrency.

## Types

- **`LockType`** — `shared` (read, multiple holders allowed) or `exclusive` (write, single holder)
- **`LockHolderId`** = `Nat` — identifies who holds a lock
- **`LockState`** — `unlocked`, `sharedBy (holders : List LockHolderId)`, or `exclusiveBy (holder : LockHolderId)`
- **`Lock`** — A named lock with a state
- **`RLock`** — A reentrant lock with name, optional holder, and acquire count

## Hints

- **`Lock.isLocked`** and **`Lock.isHeldBy`** are infrastructure functions referenced by postconditions — implement them first. `isLocked` checks `state ≠ .unlocked`; `isHeldBy` checks if the holder appears in shared holders or is the exclusive holder.
- **`Lock.new`** and **`RLock.new`** are straightforward constructors — `Lock.new name` should return `{ name, state := .unlocked }` and `RLock.new name` should return `{ name, holder := none, count := 0 }`.
- For the relational proofs, you'll need to unfold the definitions and show that the `>>=` chains produce the expected results. Since `Lock.new` creates an unlocked lock and `Lock.acquire` on an unlocked lock always succeeds, these proofs follow from the function implementations.
- The `blocking` parameter in `Lock.acquire` is not used in the postcondition — in a pure model without actual blocking, it has no effect on the result.

## Edit Boundaries

`Portalocker/*.lean` is divided into labeled sections:

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

- `Portalocker/Acquire.lean`
- `Portalocker/Helpers.lean`
- `Portalocker/RLockAcquire.lean`
- `Portalocker/Relations.lean`
- `Portalocker/Release.lean`
- `Portalocker/Types.lean`
