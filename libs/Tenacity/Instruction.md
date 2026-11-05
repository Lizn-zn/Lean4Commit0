# Tenacity

## Background

Tenacity is a Python retry library that provides configurable retry behavior for operations that may fail. It supports multiple wait strategies (fixed, exponential backoff, incrementing, random), stop conditions (after N attempts, after N seconds, composite any/all), and retry conditions (on exceptions, on result predicates, composite any/all). This spec models these as pure functions over algebraic data types.

## Task

Complete implementation holes in explicitly editable regions in `Tenacity/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `computeWait`

- **Signature**: `def computeWait (strategy : WaitStrategy) (state : RetryState α) : Nat`
- **Description**: Computes the wait time (in seconds) for the next retry based on the wait strategy and current retry state.
- **Postcondition**: (1) `fixed n` → result = n. (2) `exponential base mult mx` → result = min(mult * base^attemptNumber, mx). (3) `incrementing st inc` → result = st + inc * (attemptNumber - 1). (4) `random mn mx` → mn ≤ result ≤ mx.
- **Key constraints**: Pattern match on `WaitStrategy`. The `chain` variant exists in the type but has no postcondition constraint — implement it reasonably (e.g., use the first strategy). The `random` variant must return a value in [min, max] — a deterministic choice like `min` suffices for the spec.

### 2. `shouldStop`

- **Signature**: `def shouldStop (strategy : StopStrategy) (state : RetryState α) : Bool`
- **Description**: Determines whether retrying should stop based on the stop strategy and current state.
- **Postcondition**: Result must exactly equal `shouldStopExpected strategy state` — the reference implementation provided in the file.
- **Key constraints**: `afterAttempt n` stops when `attemptNumber ≥ n`. `afterDelay d` stops when `currentTime - startTime ≥ d`. `never` returns false. `any` returns true if any sub-strategy says stop. `all` returns true only if all sub-strategies say stop. Additional specs verify: afterDelay semantics and `.never` always returns false.

### 3. `shouldRetry`

- **Signature**: `def shouldRetry (condition : RetryCondition) (outcome : Except String String) : Bool`
- **Description**: Determines whether to retry based on the retry condition and the outcome of the last attempt.
- **Postcondition**: Result must exactly equal `shouldRetryExpected condition outcome` — the reference implementation provided in the file.
- **Key constraints**: `retryIfException` retries on `.error`, not on `.ok`. `retryIfResult pred` retries when `.ok v` and `pred v` is true. `retryAny` retries if any sub-condition says retry. `retryAll` retries only if all sub-conditions say retry.

## Relational Properties

- **`exponential_wait_increases_rel`**: When `base > 1`, `multiplier > 0`, and `mult * base^(n+1) ≤ maxWait`, the exponential wait at attempt `n+1` is strictly greater than at attempt `n`.
- **`shouldStop_afterDelay_postcond`**: `shouldStop (.afterDelay delay)` returns true iff elapsed time ≥ delay.
- **`shouldStop_never_rel`**: `shouldStop .never` always returns false.

## Types

- **`RetryState α`**: Current state of a retry loop with `attemptNumber`, `startTime`, `currentTime`, and `outcome : Option (Except String α)`.
- **`WaitStrategy`**: Algebraic type for wait strategies — `fixed`, `random`, `exponential`, `incrementing`, `chain`.
- **`StopStrategy`**: Algebraic type for stop conditions — `afterAttempt`, `afterDelay`, `any`, `all`, `never`.
- **`RetryCondition`**: Algebraic type for retry conditions — `retryIfException`, `retryIfResult`, `retryAny`, `retryAll`.

## Hints

- The simplest approach for `shouldStop` and `shouldRetry` is to implement them identically to `shouldStopExpected` and `shouldRetryExpected` respectively — the postconditions require exact equality. Then the proofs reduce to `rfl` or simple unfolding.
- `shouldStopExpected` and `shouldRetryExpected` are already implemented (not `sorry`) and serve as the reference specifications. Study their structure.
- For `computeWait`: the `random` postcond only requires `result ∈ [min, max]`. Returning `min` (or `(min + max) / 2`) satisfies this without needing actual randomness. Handle the edge case where `min > max` sensibly.
- `computeExponentialWait` is a standalone function used in the relational spec — implement it as `min (multiplier * base ^ attemptNumber) maxWait`.
- The `exponential_wait_increases_rel` proof requires showing `base^n < base^(n+1)` when `base > 1`, which follows from `Nat.pow_lt_pow_right`.

## Edit Boundaries

`Tenacity/*.lean` is divided into labeled sections:

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

- `Tenacity/ComputeExponentialWait.lean`
- `Tenacity/ComputeWait.lean`
- `Tenacity/ShouldRetry.lean`
- `Tenacity/ShouldStop.lean`
- `Tenacity/Types.lean`
