# JodaTime

## Background

Joda-Time is a Java library that provides a quality replacement for Java's built-in date and time classes. It offers immutable date/time types (LocalDate, LocalTime, LocalDateTime), calendar arithmetic (adding/subtracting days, months, years), date comparisons, calendar properties (leap year, month length), date differences, ISO 8601 formatting/parsing, durations, and periods. This core spec focuses on three essential date operations: adding days to a date (with month/year boundary handling), computing the length of a month (with leap year logic), and computing the number of days between two dates.

## Task

Complete implementation holes in explicitly editable regions in `JodaTime/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `LocalDate.plusDays`

- **Signature**: `def LocalDate.plusDays (d : LocalDate) (n : Int) : LocalDate`
- **Description**: Adds `n` days to a date, handling month and year boundaries correctly. Negative `n` subtracts days.
- **Postcondition**:
  - `n = 0` → result equals input (identity)
  - Result always has valid month (1-12) and day (1-31)
  - `n = 1` within month → day increments by 1 (for months with known max days, and day < max)
  - `n = 1`, Dec 31 → Jan 1 of next year
  - `n = -1`, Jan 1 → Dec 31 of previous year
  - `n = -1`, day > 1 → day decrements by 1
  - `0 < n < 28`, `d.day + n ≤ 28` → stays in same month, day = d.day + n
  - `n = 7`, `d.day + 7 ≤ 28` → stays in same month, day = d.day + 7
- **Key constraints**: Must handle month-end rollover (e.g., Jan 31 + 1 = Feb 1), year-end rollover (Dec 31 + 1 = Jan 1 next year), and year-start rollback (Jan 1 - 1 = Dec 31 previous year). The postcondition is most specific for small increments within a month.

### 2. `lengthOfMonth`

- **Signature**: `def lengthOfMonth (year : Int) (month : Nat) : Nat`
- **Description**: Returns the number of days in the given month of the given year.
- **Postcondition**:
  - Valid month (1-12) → result ≥ 28
  - Result ≤ 31
  - February → result ≤ 29
  - Months 1, 3, 5, 7, 8, 10, 12 → result = 31
  - Months 4, 6, 9, 11 → result = 30
  - February in leap year (year % 4 = 0 and (year % 100 ≠ 0 or year % 400 = 0)) → result = 29
  - February in non-leap year → result = 28
- **Key constraints**: Output is fully determined for all valid months. Leap year logic: divisible by 4, except centuries, except 400-year cycles.

### 3. `daysBetween`

- **Signature**: `def daysBetween (a b : LocalDate) : Int`
- **Description**: Computes the number of days from date `a` to date `b`. Positive when `b` is after `a`.
- **Postcondition**:
  - `a = b` → result = 0
  - `a` before `b` (by year, then month, then day) → result > 0
  - `b` before `a` → result < 0
  - Same year and month → result = b.day - a.day (exact)
  - Same year → result in range [-366, 366]
- **Key constraints**: The same-month clause pins the exact result. The antisymmetry relational spec requires `daysBetween a b = -(daysBetween b a)`.

## Relational Properties

- **`plusDays_minusDays_cancel`**: `(d.plusDays n).minusDays n = d` — adding then subtracting the same number of days recovers the original date.
- **`dayOfWeek_period_7`**: `(d.plusDays 7).dayOfWeek = d.dayOfWeek` — the day of the week has period 7.
- **`daysBetween_antisym`**: `daysBetween a b = -(daysBetween b a)` — swapping arguments negates the result.

## Types

- **`LocalDate`**: A calendar date with `year : Int`, `month : Nat` (1-12), and `day : Nat` (1-31).
- **`DayOfWeek`**: Enumeration of the seven days of the week (monday through sunday).

## Hints

- For `lengthOfMonth`, pattern match on the month. For February, check the leap year condition. This is the simplest function — implement it first as `plusDays` may use it.
- For `LocalDate.plusDays`, convert the date to an epoch day count, add `n`, then convert back. To convert to epoch days: compute total days from a reference point (e.g., year 0) accounting for leap years. To convert back: divide by 365/366 to find the year, then by month lengths to find the month and day.
- For `daysBetween`, convert both dates to epoch days and subtract: `toEpochDay(b) - toEpochDay(a)`.
- For `LocalDate.minusDays`, implement as `d.plusDays (-n)`.
- For `LocalDate.dayOfWeek`, compute `(toEpochDay(d) + offset) % 7` where the offset aligns with the known day of week for the epoch (Jan 1, 1970 was a Thursday).
- The `plusDays_minusDays_cancel` proof follows directly if `minusDays n = plusDays (-n)` and your epoch-day conversion is bijective.
- The `dayOfWeek_period_7` proof follows from `(epochDay + 7) % 7 = epochDay % 7`.
- The `daysBetween_antisym` proof follows from `(b - a) = -(a - b)`.

## Edit Boundaries

`JodaTime/*.lean` is divided into labeled sections:

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

- `JodaTime/DaysBetween.lean`
- `JodaTime/Helpers.lean`
- `JodaTime/LengthOfMonth.lean`
- `JodaTime/PlusDays.lean`
- `JodaTime/Relations.lean`
- `JodaTime/Types.lean`
- `JodaTime/Validity.lean`
