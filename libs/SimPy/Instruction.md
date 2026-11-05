# SimPy

## Background

SimPy is a process-based discrete-event simulation framework for Python. It provides an event-driven simulation environment where processes interact through events, timeouts, and shared resources. This spec models the simulation as pure data structures: an environment with a sorted event queue, events with states and callbacks, and resources with capacity constraints. The 3 core functions cover the simulation loop (stepping through events), event scheduling, and resource acquisition.

## Task

Complete implementation holes in explicitly editable regions in:

- `SimPy/Helpers.lean`
- `SimPy/Step.lean`
- `SimPy/Schedule.lean`
- `SimPy/Request.lean`

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `Environment.step`

- **Signature**: `def Environment.step (env : Environment) : Option Environment`
- **Description**: Process the next scheduled event — pop the earliest event from the queue, advance simulation time, and process it. Returns `none` if the queue is empty.
- **Postcondition**: `Environment.step_postcond` requires:
  - `result = none ↔ env.eventQueue = []` (none iff no events)
  - On success: `env.now ≤ env'.now` (time never goes backward)
  - On success: `env'.eventQueue.length < env.eventQueue.length` (queue strictly shrinks)
- **Extra theorems**:
  - `step_advances_to_earliest`: the new time equals the first event's time
  - `step_preserves_queue_order`: if queue was sorted, it remains sorted
- **Key constraints**: The queue is assumed sorted by (time, priority, insertion order). Step must pop the first element and advance `now` to that event's time.

### 2. `Environment.schedule`

- **Signature**: `def Environment.schedule (env : Environment) (eventId : EventId) (priority : EventPriority := .normal) (delay : SimTime := 0.0) : Environment`
- **Description**: Insert a new event into the queue at time `env.now + delay` with the given priority.
- **Postcondition**: `Environment.schedule_postcond` requires:
  - `result.now = env.now` (scheduling doesn't advance time)
  - The scheduled event exists in `result.eventQueue` with correct eventId, time, and priority
  - `result.eventQueue.length = env.eventQueue.length + 1`
- **Extra theorem**: `schedule_preserves_order`: if queue was sorted, it remains sorted after insertion
- **Key constraints**: Must insert the event in the correct sorted position to maintain the queue invariant. The `insertionOrder` field in `ScheduledEvent` breaks ties.

### 3. `Resource.request`

- **Signature**: `def Resource.request (r : Resource) (env : Environment) : Resource × Environment × EventId`
- **Description**: Request access to a resource. If capacity is available, the requester is added to users immediately. If full, the requester is added to the waiting queue.
- **Postcondition**: `Resource.request_postcond` requires:
  - If `users.length < capacity`: `result.users.length = users.length + 1` (immediate grant)
  - If `users.length ≥ capacity`: users unchanged, `result.queue.length = queue.length + 1` (queued)
  - `result.capacity = r.capacity` (capacity preserved)
- **Extra theorem**: `request_spec`: if `count ≤ capacity` before, then `count ≤ capacity` after (invariant maintained)
- **Key constraints**: The function must also create an event in the environment (returning a new EventId). The resource's capacity must never be exceeded.

## Types

- **`SimTime`** = `Float` — simulation time
- **`EventPriority`** — urgent, normal, or low
- **`EventId`** = `Nat` — unique event identifier
- **`EventResult`** — ok (with value) or err (with message)
- **`EventState`** — pending, triggered (with result), or processed (with result)
- **`Event`** — an event: id, state, list of callback event ids
- **`ScheduledEvent`** — a queued event: time, priority, event id, insertion order (for tie-breaking)
- **`Process`** — a simulation process: id, name, current step, alive flag
- **`Environment`** — simulation state: current time, sorted event queue, events, processes, next id counter
- **`Resource`** — a shared resource: capacity, list of current users, waiting queue

## Hints

- **`eventQueueSorted`** is already implemented (not sorry) — it defines the sorting invariant: events are ordered by (time, priority, insertion order) using `List.Pairwise`.
- **`Resource.count`** must be implemented — it returns `r.users.length`.
- For `Environment.step`, pop the head of `eventQueue`, set `env.now` to that event's time, and return the updated environment with the remaining queue.
- For `Environment.schedule`, create a `ScheduledEvent` with `time = env.now + delay`, then insert it into `eventQueue` maintaining sorted order. Increment `insertionCounter` for tie-breaking.
- For `Resource.request`, check if `users.length < capacity`. If so, add the new event id to `users`. Otherwise, add to `queue`. In both cases, create a new event in the environment.
- The `step_preserves_queue_order` and `schedule_preserves_order` theorems require showing that removing the head / inserting in sorted position preserves the `Pairwise` property.

## Edit Boundaries

The editable task files are divided into labeled sections:

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

- `SimPy/Helpers.lean`
- `SimPy/Request.lean`
- `SimPy/Schedule.lean`
- `SimPy/Step.lean`
- `SimPy/Types.lean`
- `SimPy/Validity.lean`
