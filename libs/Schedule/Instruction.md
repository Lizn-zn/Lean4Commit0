# Schedule

## Background

Schedule is a Python library for human-friendly job scheduling. It lets you define periodic tasks with natural language-like syntax (e.g., "every 10 minutes", "every day at 10:30"). This spec models the scheduling as pure data structures: jobs have an interval, time unit, and next-run timestamp; the scheduler manages a collection of jobs. The 3 core functions cover computing when a job runs next, checking if it's due, and adding jobs to the scheduler.

## Task

Complete implementation holes in explicitly editable regions in the split files under `Schedule/` and complete the proof obligations assigned to editable regions. Shared helpers are grouped in `Schedule/Helpers.lean`.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `computeNextRun`

- **Signature**: `def computeNextRun (j : Job) (refTime : Nat) : Nat`
- **Description**: Compute the next run timestamp for a job, starting from a reference time. The interval is multiplied by the unit's duration in seconds.
- **Postcondition**: `computeNextRun_postcond` requires:
  - `result = refTime + j.interval * unitMultiplier j.unit`
- **Key constraints**: `unitMultiplier` converts time units to seconds: second=1, minute=60, hour=3600, day=86400, week=604800. Day-of-week units (monday through sunday) also use 86400 (one day). The formula is a simple multiplication — no special handling for day-of-week scheduling in this postcondition.

### 2. `isDue`

- **Signature**: `def isDue (j : Job) (now : Nat) : Bool`
- **Description**: Check whether a job is due to run at the current time.
- **Postcondition**: `isDue_postcond` requires:
  - `result = true ↔ now ≥ j.nextRun`
- **Key constraints**: This is a biconditional — the job is due if and only if the current time has reached or passed the job's scheduled next-run time. A simple comparison.

### 3. `Scheduler.addJob`

- **Signature**: `def Scheduler.addJob (s : Scheduler) (j : Job) : Scheduler`
- **Description**: Add a job to the scheduler's job list.
- **Postcondition**: `Scheduler.addJob_postcond` requires:
  - The added job is in `result.jobs`
  - `result.jobs.length = s.jobs.length + 1`
  - `result.currentTime = s.currentTime` (time is preserved)
  - All existing jobs are preserved: `∀ job ∈ s.jobs, job ∈ result.jobs`
- **Key constraints**: The job is always added (no deduplication). The scheduler's current time must not change.

## Types

- **`TimeUnit`** — Scheduling unit: second, minute, hour, day, week, or a specific day of week (monday through sunday)
- **`Job`** — A scheduled task: interval (how many units between runs), unit (TimeUnit), optional atTime string (e.g., "10:30"), optional lastRun timestamp, nextRun timestamp, optional tag for grouping
- **`Scheduler`** — A collection of jobs plus the current time

## Hints

- **`unitMultiplier`** is already implemented (not sorry) — it maps each `TimeUnit` to its duration in seconds. Use it directly.
- For `computeNextRun`, the implementation is simply `refTime + j.interval * unitMultiplier j.unit`.
- For `isDue`, the implementation is `decide (now ≥ j.nextRun)` or equivalently `now ≥ j.nextRun` (Nat comparison returns Bool).
- For `Scheduler.addJob`, append or prepend the job to `s.jobs` and keep `s.currentTime`. Using `{ s with jobs := j :: s.jobs }` or `{ s with jobs := s.jobs ++ [j] }` both work — the postcondition doesn't constrain order among existing jobs relative to the new one.

## Edit Boundaries

The editable module files under `Schedule/` are divided into labeled sections:

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

- `Schedule/AddJob.lean`
- `Schedule/ComputeNextRun.lean`
- `Schedule/Helpers.lean`
- `Schedule/IsDue.lean`
- `Schedule/Types.lean`
