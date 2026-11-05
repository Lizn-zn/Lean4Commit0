# Watchdog

## Background

Watchdog is a Python library for monitoring file system events. This spec models it as pure functional diffs on file system snapshots — computing created/deleted/modified events between two states, filtering events by patterns, and coalescing (debouncing) events within time windows. No actual file system I/O is involved.

## Task

Complete implementation holes in explicitly editable regions in `Watchdog/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `diff`

- **Signature**: `def diff (oldState newState : FileSystemState) : List WatchEvent`
- **Description**: Compute the list of file system change events between two snapshots. Detects created, deleted, and modified files by comparing entries.
- **Postcondition**: `diff_postcond` requires (6 clauses):
  - Same state → empty result
  - All events have valid types (created, deleted, modified, or moved)
  - Both states empty → empty result
  - Every path in newState but not oldState produces a created event (completeness)
  - Every path in oldState but not newState produces a deleted event (completeness)
  - Every path in both states with different contentHash produces a modified event (completeness)
- **Key constraints**: The diff must be complete — every change must be detected. Paths are compared by membership in the entries list. Content changes are detected via `contentHash` comparison.

### 2. `filterEvents`

- **Signature**: `def filterEvents (filter : EventFilter) (events : List WatchEvent) : List WatchEvent`
- **Description**: Filter a list of events according to include/exclude patterns and directory ignore settings.
- **Postcondition**: `filterEvents_postcond` requires (4 clauses):
  - Result length ≤ input length
  - Empty filter (no patterns, ignoreDirectories = false) → return all events unchanged
  - Every result event comes from the input (subset)
  - Every event that passes `applyFilter` is in the result (completeness)
- **Key constraints**: The empty filter identity is important — no filtering means all events pass through. Uses `applyFilter` to check individual events.

### 3. `coalesceEvents`

- **Signature**: `def coalesceEvents (events : List (Nat × WatchEvent)) (windowMs : Nat) : List (Nat × WatchEvent)`
- **Description**: Coalesce (debounce) timestamped events within a time window. Multiple events for the same file within the window are merged into one.
- **Postcondition**: `coalesceEvents_postcond` requires (6 clauses):
  - Result length ≤ input length
  - Empty input → empty result
  - All result events come from the input (subset)
  - Zero window → return all events unchanged (no coalescing)
  - Every input event's file path is represented in the result (path coverage)
  - Any two result events with the same filePath must be separated by more than windowMs (time separation guarantee)
- **Key constraints**: The 6th clause is the key invariant — after coalescing, no two events for the same path can be closer than `windowMs` apart. The `Nat` in the pair is the timestamp in milliseconds.

## Relational Properties

- **`diff_self`**: `diff state state = []` — comparing a state to itself produces no events.
- **`diff_symmetric`**: `(diffCreated a b).length = (diffDeleted b a).length` — the number of files created going from a→b equals the number deleted going from b→a.

## Types

- **`FileType`** — file or directory
- **`FileEvent`** — Event kind: created, deleted, modified, moved (with src/dest paths)
- **`WatchEvent`** — An event with its kind, file path, and whether it's a directory
- **`FileEntry`** — A file system entry with type and content hash (UInt64) for change detection
- **`FileSystemState`** — A snapshot: list of (path, FileEntry) pairs
- **`EventFilter`** — Filter config: include/exclude glob patterns, ignore directories flag, case sensitivity

## Hints

- `applyFilter` is infrastructure (`sorry`) — it checks a single event against the filter's patterns. When all patterns are empty and `ignoreDirectories = false`, it should return `true`.
- `diffCreated` and `diffDeleted` are infrastructure (`sorry`) — they compute just the created or deleted events respectively. Used by the `diff_symmetric` relational spec.
- For `diff`, iterate over both states' entries. A path in new but not old → created. In old but not new → deleted. In both with different `contentHash` → modified. Use `FileEntry.fileType` to set `isDirectory` on events.
- For `filterEvents`, filter the events list by `applyFilter`. The postcondition requires both soundness and completeness with respect to `applyFilter`.
- For `coalesceEvents`, group events by `filePath`, then within each group keep only events that are more than `windowMs` apart. The subset property means you can only keep events from the original list, not create new ones.

## Edit Boundaries

`Watchdog/*.lean` is divided into labeled sections:

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

- `Watchdog/CoalesceEvents.lean`
- `Watchdog/Diff.lean`
- `Watchdog/FilterEvents.lean`
- `Watchdog/Helpers.lean`
- `Watchdog/Types.lean`
- `Watchdog/Validity.lean`
