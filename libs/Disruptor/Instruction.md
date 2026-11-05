# Disruptor

## Background

The LMAX Disruptor is a high-performance Java library for inter-thread messaging, built around a ring buffer data structure. It uses sequence numbers to track producer and consumer positions, enabling lock-free communication patterns. In this spec, the ring buffer is modeled as a purely functional data structure with a list of optional entries, a power-of-2 buffer size, a bitmask for fast modular indexing, and a cursor sequence tracking the next write position.

## Task

Complete implementation holes in explicitly editable regions in the `Disruptor/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `RingBuffer.create`

- **Signature**: `def RingBuffer.create (capacity : Nat) : RingBuffer α`
- **Description**: Creates a new ring buffer with capacity rounded up to the nearest power of 2.
- **Postcondition**:
  - `bufferSize` is a power of 2 (∃ k, bufferSize = 2^k)
  - `mask = bufferSize - 1`
  - `cursor = Sequence.initial` (value 0)
  - `entries.length = bufferSize`
- **Key constraints**: The precondition requires `capacity > 0`. The actual buffer size must be a power of 2 (round up if needed). All entries should be initialized to `none`.

### 2. `RingBuffer.publish`

- **Signature**: `def RingBuffer.publish (rb : RingBuffer α) (event : α) : RingBuffer α`
- **Description**: Publishes an event to the ring buffer at the current cursor position, then advances the cursor.
- **Postcondition**:
  - Cursor advances by 1: `result.cursor.value = rb.cursor.value + 1`
  - Buffer size and mask are preserved
  - Entry at `cursor % bufferSize` is set to `some event`
  - All other entries remain unchanged
  - Entries list length is preserved
- **Key constraints**: The event is written at index `rb.cursor.value % rb.bufferSize`. Must use `List.set` or equivalent to update a single position without affecting others.

### 3. `RingBuffer.get`

- **Signature**: `def RingBuffer.get (rb : RingBuffer α) (s : Sequence) : Option α`
- **Description**: Retrieves the event at the given sequence number's position in the ring buffer.
- **Postcondition**: `result = rb.entries[s.value % rb.bufferSize]?`
- **Key constraints**: Uses modular arithmetic to map sequence number to buffer index. Returns `none` if the index is out of bounds (via `List.get?`).

## Relational Properties

- **`publish_get`**: If the ring buffer has entries (length > 0), then `get (publish rb event) rb.cursor = some event` — reading at the cursor position after publishing retrieves the published event.
- **`no_overwrite_before_consumed`**: If the gap between cursor and gating sequence is less than buffer size, and the two positions map to different indices, then publishing doesn't change the value at the gating sequence's position.
- **`mask_eq`**: For a ring buffer created with valid capacity, `mask = bufferSize - 1`.

## Types

- **`Sequence`**: A wrapper around `Nat` representing a position in the ring buffer. Has `value : Nat`.
- **`RingBuffer α`**: The core data structure with `entries : List (Option α)` (the slots), `bufferSize : Nat` (always a power of 2), `mask : Nat` (= bufferSize - 1, for fast modular indexing), and `cursor : Sequence` (next write position).

## Hints

- `Sequence.initial` returns `{ value := 0 }` and `Sequence.next` returns `{ value := s.value + 1 }` — both are already implemented and can be used directly.
- For `create`, compute the next power of 2 ≥ capacity. A simple approach: find the smallest `k` such that `2^k ≥ capacity`. Initialize entries with `List.replicate (2^k) none`.
- For `publish`, compute the write index as `rb.cursor.value % rb.bufferSize`, use `List.set` to update that position, then advance the cursor. Note that `List.set` preserves list length and doesn't affect other indices.
- For `get`, simply return `rb.entries[s.value % rb.bufferSize]?` (which is `List.get?`).
- The `publish_get` proof connects publish's write at `cursor % bufferSize` with get's read at the same index. You'll need to reason about `List.get?_set` or similar lemmas.
- The `no_overwrite_before_consumed` proof relies on the fact that `publish` only modifies index `cursor % bufferSize`, so any other index is unchanged.
- The `RingBuffer` constructor is private — use the anonymous constructor syntax `⟨entries, bufferSize, mask, cursor⟩` within the namespace.

## Edit Boundaries

The editable module files under `Disruptor/` are divided into labeled sections:

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

- `Disruptor/Create.lean`
- `Disruptor/Get.lean`
- `Disruptor/Helpers.lean`
- `Disruptor/Publish.lean`
- `Disruptor/Relations.lean`
- `Disruptor/Types.lean`
- `Disruptor/Validity.lean`
