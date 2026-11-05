# Crossbeam

## Background

Crossbeam is a foundational Rust crate providing lock-free concurrent data structures including MPMC queues, bounded array queues, work-stealing deques, channels, and epoch-based garbage collection. This spec models these concurrent structures as pure functional state machines, capturing their sequential specification (FIFO/LIFO ordering guarantees) without modeling actual concurrency.

## Task

Complete implementation holes in explicitly editable regions in the `Crossbeam/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `Queue.pop`

- **Signature**: `def Queue.pop (q : Queue α) : Queue α × Option α`
- **Description**: Dequeues the front element from an unbounded FIFO queue, returning the updated queue and the dequeued element (or `none` if empty).
- **Postcondition**: `Queue.pop_postcond` requires:
  - If the queue is empty (`data = []`), return `none` and an empty queue
  - If the queue is non-empty, return `head?` of the data list and the `tail` as the remaining queue
- **Key constraints**: Must preserve FIFO order. The internal `data` field is a `List α` where the head is the front of the queue.

### 2. `ArrayQueue.push`

- **Signature**: `def ArrayQueue.push (q : ArrayQueue α) (v : α) : Option (ArrayQueue α)`
- **Description**: Enqueues an element into a bounded queue. Returns `none` if the queue is at capacity, or `some q'` with the element appended if there is room.
- **Postcondition**: `ArrayQueue.push_postcond` requires:
  - If `data.length ≥ capacity'`, return `none` (queue is full)
  - If `data.length < capacity'`, return `some q'` where `q'.data = q.data ++ [v]` and `q'.capacity' = q.capacity'`
- **Key constraints**: The capacity must be preserved across operations. The return type is `Option` to signal when the queue is full.

### 3. `Deque.pop`

- **Signature**: `def Deque.pop (d : Deque α) : Deque α × Option α`
- **Description**: The owner pops from the bottom of a work-stealing deque. This is LIFO (last-in, first-out) — the most recently pushed element is popped first.
- **Postcondition**: `Deque.pop_postcond` requires:
  - If the deque is empty (`data = []`), return `none` and an empty deque
  - If the deque is non-empty, return `getLast?` of the data list and `dropLast` as the remaining deque
- **Key constraints**: Unlike `Queue.pop` which returns the head (FIFO), `Deque.pop` returns the last element (LIFO). This is the key semantic difference.

## Relational Properties

- **`Queue.fifo_rel`**: After pushing v1 then v2 onto a new queue, popping yields v1 — verifying FIFO (first-in, first-out) order.
- **`Deque.pop_lifo_rel`**: After pushing v1 then v2 onto a new deque, owner pop yields v2 — verifying LIFO (last-in, first-out) order for the owner.

## Types

- **`Queue α`**: An unbounded MPMC queue modeled as a structure wrapping a `List α`. The head of the list is the front of the queue (next to be dequeued). Fields are `private`.
- **`ArrayQueue α`**: A bounded queue with a `data : List α` field and a `capacity' : Nat` field. Push fails when `data.length ≥ capacity'`. Fields are `private`.
- **`Deque α`**: A work-stealing deque modeled as a structure wrapping a `List α`. The owner pushes/pops from the end (bottom), while thieves steal from the front (top). Fields are `private`.

## Hints

- All three structures use `private mk` constructors, so you must use the `⟨...⟩` anonymous constructor syntax (e.g., `⟨[]⟩` for an empty queue).
- `Queue.new` and `Queue.push` are also `sorry` — you need to implement them for the relational spec to work. `Queue.new` should create an empty queue, `Queue.push` should append to the end.
- Similarly, `Deque.new` and `Deque.push` need implementation. `Deque.push` appends to the end of the list (the "bottom" of the deque).
- `ArrayQueue.new` needs implementation — initialize with empty data and the given capacity.
- The relational proofs (`fifo_spec`, `pop_lifo_spec`) will likely require unfolding the definitions of `new`, `push`, and `pop` together with `simp`.

## Edit Boundaries

The editable module files under `Crossbeam/` are divided into labeled sections:

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

- `Crossbeam/ArrayQueuePush.lean`
- `Crossbeam/DequePop.lean`
- `Crossbeam/Helpers.lean`
- `Crossbeam/QueuePop.lean`
- `Crossbeam/Relations.lean`
- `Crossbeam/Types.lean`
