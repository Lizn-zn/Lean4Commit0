# JCTools

## Background

JCTools is a Java library providing lock-free concurrent queue implementations optimized for different producer-consumer patterns: SPSC (single producer, single consumer), MPSC (multi producer, single consumer), and MPMC (multi producer, multi consumer), in both bounded and unbounded variants. In this spec, concurrent queues are modeled as pure functional data structures using a `List` as the backing buffer, with concurrency abstracted away into sequential state transitions. The core operations are offer (enqueue), poll (dequeue), and drain (batch dequeue).

## Task

Complete implementation holes in explicitly editable regions in `JCTools/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `SpscQueue.offer`

- **Signature**: `def SpscQueue.offer (q : SpscQueue α) (v : α) : Option (SpscQueue α)`
- **Description**: Enqueues a value at the back of the queue. Returns `none` if the queue is full (bounded), or `some q'` with the updated queue.
- **Postcondition**:
  - If `buffer.length ≥ capacity` → returns `none` (queue full)
  - If `buffer.length < capacity` → returns `some` (success)
  - On success: `q'.buffer.length = q.buffer.length + 1`
  - On success: `q'.capacity = q.capacity`
  - On success: `v ∈ q'.buffer`
  - On success: `q'.buffer = q.buffer ++ [v]` (exact append)
- **Key constraints**: The last clause pins down the exact buffer content — the value is appended at the end (FIFO order).

### 2. `SpscQueue.poll`

- **Signature**: `def SpscQueue.poll (q : SpscQueue α) : SpscQueue α × Option α`
- **Description**: Dequeues the front element from the queue. Returns the updated queue and the dequeued value (or `none` if empty).
- **Postcondition**:
  - Empty buffer → returns `(q, none)` (unchanged queue, no value)
  - Non-empty → `result.2 = q.buffer.head?` (returns the front element)
  - On success: `result.1.buffer.length = q.buffer.length - 1`
  - On success: dequeued value is from the original buffer
  - `result.1.capacity = q.capacity` (always preserved)
  - Non-empty → `result.1.buffer = q.buffer.tail` (exact tail)
- **Key constraints**: The last clause pins down the exact remaining buffer — it's the tail of the original (first element removed).

### 3. `SpscQueue.drain`

- **Signature**: `def SpscQueue.drain (q : SpscQueue α) (n : Nat) : SpscQueue α × List α`
- **Description**: Drains up to `n` elements from the front of the queue in a batch. Returns the updated queue and the list of drained elements.
- **Postcondition**:
  - `result.2.length ≤ n` (at most n elements drained)
  - `result.2.length ≤ q.buffer.length` (can't drain more than available)
  - `result.1.buffer.length = q.buffer.length - result.2.length`
  - All drained elements come from the original buffer
  - `result.1.capacity = q.capacity`
  - `result.2 = q.buffer.take result.2.length` (exact prefix)
  - `result.1.buffer = q.buffer.drop result.2.length` (exact suffix)
- **Key constraints**: The drained elements are exactly the first `min(n, buffer.length)` elements. The remaining buffer is the corresponding suffix.

### 4. `SpscQueue.new` (helper)

- **Signature**: `def SpscQueue.new (capacity : Nat) : SpscQueue α`
- **Description**: Creates an empty queue with the given capacity.
- **Postcondition**: `result.buffer = [] ∧ result.capacity = capacity`

## Relational Properties

- **`offer_poll_roundtrip`**: When `q.buffer = []`, offering a value then polling returns that value.
- **`bounded_rejects`**: When `q.buffer.length ≥ q.capacity`, offer returns `none`.
- **`fifo_ordering`**: Offering `a` then `b` on an empty queue (capacity ≥ 2), then polling returns `a` (not `b`) — FIFO order.
- **`poll_after_offer`**: Offering a value on an empty queue (capacity ≥ 1) then polling returns that value.
- **`fifo_spec`** (standalone theorem): Same FIFO property expressed via match expression.

## Types

- **`SpscQueue α`**: A bounded FIFO queue with `buffer : List α` (the queue contents, front-to-back) and `capacity : Nat` (maximum number of elements).

## Hints

- Implement `new` as `⟨[], capacity⟩`.
- Implement `offer` by checking `q.buffer.length < q.capacity`. If yes, return `some ⟨q.buffer ++ [v], q.capacity⟩`. If no, return `none`.
- Implement `poll` by matching on `q.buffer`. If empty, return `(q, none)`. If `h :: t`, return `(⟨t, q.capacity⟩, some h)`.
- Implement `drain` by taking `min n q.buffer.length` elements: return `(⟨q.buffer.drop k, q.capacity⟩, q.buffer.take k)` where `k = min n q.buffer.length`.
- The FIFO relational proofs follow directly from the `offer` postcond (`buffer = old ++ [v]`) and `poll` postcond (`returns head, buffer = tail`). After offering `a` then `b`, the buffer is `[a, b]`, so polling returns `a`.
- For `drain`, the key insight is that `take` + `drop` partition the list exactly, and `take k` gives the first `k` elements in order.
- The `bounded_rejects` proof is just the first clause of `offer_postcond`.

## Edit Boundaries

`JCTools/*.lean` is divided into labeled sections:

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

- `JCTools/Drain.lean`
- `JCTools/Helpers.lean`
- `JCTools/Offer.lean`
- `JCTools/Poll.lean`
- `JCTools/Relations.lean`
- `JCTools/Types.lean`
