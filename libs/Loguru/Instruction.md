# Loguru

## Background

Loguru is Python's most popular structured logging library, providing a simple yet powerful API for configuring log sinks with custom formatting, level-based filtering, and structured output. This spec models the core logging pipeline: determining whether a log record passes a filter, rendering a format template with record data, and dispatching a record to all matching sinks.

## Task

Complete implementation holes in explicitly editable regions in `Loguru/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `matchesFilter`

- **Signature**: `def matchesFilter (record : LogRecord) (filter : FilterSpec) : Bool`
- **Description**: Check whether a log record passes a filter specification. For level-based filters, the record passes if its level is at or above the filter level.
- **Postcondition**: `matchesFilter_postcond` requires:
  - CRITICAL records always pass any level filter (`record.level = .CRITICAL → result = true`)
  - TRACE filter passes all records (`filter = .byLevel .TRACE → result = true`)
  - Level comparison determines result: `Level.le filterLevel record.level = true → result = true`
  - Converse: `Level.le filterLevel record.level = false → result = false`
- **Key constraints**: The postcond fully pins down the result for `byLevel` filters via ↔. For `byModuleName` and `byLevelAndModule` filters, the postcond doesn't constrain the result (implement them reasonably). `Level.le` (already implemented) compares numeric severity values.

### 2. `renderFormat`

- **Signature**: `def renderFormat (fmt : String) (record : LogRecord) : String`
- **Description**: Render a format template string by substituting `{field}` placeholders with values from a log record.
- **Postcondition**: `renderFormat_postcond` requires:
  - Non-empty format with non-empty message → non-empty result
  - `"{message}"` → exactly `record.message`
  - `"{level} {message}"` → level name string + space + message (e.g., `"INFO hello"`)
  - If format contains `"{message}"`, result contains the message (or message is empty)
- **Key constraints**: The second test vector requires exact output — the level name must be the canonical uppercase string ("TRACE", "DEBUG", "INFO", "SUCCESS", "WARNING", "ERROR", "CRITICAL"). The format uses `{field}` syntax (not `%s` or `$field`).

### 3. `processRecord`

- **Signature**: `def processRecord (state : LoggerState) (record : LogRecord) : List (Nat × String)`
- **Description**: Dispatch a log record to all configured sinks that accept it, returning a list of (sinkId, formattedOutput) pairs.
- **Postcondition**: `processRecord_postcond` requires:
  - `result.length ≤ state.sinks.length` (at most one output per sink)
  - All outputs are non-empty (`∀ p ∈ result, p.2.length > 0`)
  - Every sink with no filter that accepts the record's level must produce output (`sink.filter = none ∧ Level.le sink.level record.level = true → ∃ p ∈ result, p.1 = sink.sinkId`)
- **Key constraints**: The third condition ensures completeness: if a sink should accept the record (no filter + level passes), it must appear in the output. The formatted string for each sink depends on its `formatStr` — use `renderFormat` internally.

## Relational Properties

- **`matchesFilter_monotone_rel`**: If a record passes a level filter at level `l2`, and `l1 ≤ l2`, then the record also passes a level filter at level `l1`. This is the monotonicity property: lowering the filter threshold never causes a previously-passing record to fail.

## Types

- **`Level`**: Log severity — `TRACE`(5), `DEBUG`(10), `INFO`(20), `SUCCESS`(25), `WARNING`(30), `ERROR`(40), `CRITICAL`(50). Has `toNat` and `le` (already implemented).
- **`LogRecord`**: A log entry with `level`, `message`, `moduleName`, `funcName`, `lineNo`, `fileName`, `time`, `extra`, `exception`, process/thread info.
- **`FilterSpec`**: A filter — `byLevel` (minimum level), `byModuleName` (module prefix), or `byLevelAndModule` (both).
- **`SinkConfig`**: Sink configuration with `formatStr`, optional `filter`, minimum `level`, `colorize`, `serialize`, `backtrace`, `diagnose`, `sinkId`.
- **`LoggerState`**: Logger state with `sinks` (list of SinkConfig), `nextSinkId`, `extra` context data, `startTime`.
- **`Timestamp`**: Date/time with year through microsecond fields.
- **`ExtraData`**: Alias for `List (String × String)` — key-value context data.
- **`ExceptionInfo`**: Exception with `typeName`, `message`, and traceback `frames`.

## Hints

- Already implemented helpers (not `sorry`):
  - `Level.toNat` — maps each level to its numeric severity
  - `Level.le` — compares two levels by numeric severity (`a.toNat ≤ b.toNat`)
  - `String.containsSubstr` — checks substring presence using `splitOn`
- For `matchesFilter` with `.byLevel lvl`: simply return `Level.le lvl record.level`.
- For `renderFormat`: scan for `{...}` patterns. Replace `{message}` with `record.message`, `{level}` with the level name string, `{name}` with `record.moduleName`, etc. For unrecognized fields, either leave them or return the field name.
- For `processRecord`: iterate over `state.sinks`. For each sink, check if the record should be logged (level check + optional filter). If yes, format the record using `renderFormat sink.formatStr record` and include `(sink.sinkId, formattedOutput)` in the result.
- The `matchesFilter_monotone` proof follows from the transitivity of `Level.le` (which is `≤` on `Nat`): if `l1.toNat ≤ l2.toNat` and `l2.toNat ≤ record.level.toNat`, then `l1.toNat ≤ record.level.toNat`.

## Edit Boundaries

`Loguru/*.lean` is divided into labeled sections:

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

- `Loguru/Helpers.lean`
- `Loguru/MatchesFilter.lean`
- `Loguru/ProcessRecord.lean`
- `Loguru/Relations.lean`
- `Loguru/RenderFormat.lean`
- `Loguru/Types.lean`
