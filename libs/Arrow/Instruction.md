# Arrow

## Background

Arrow is a Python library that provides a sensible, human-friendly approach to creating, manipulating, formatting, and converting dates, datetimes, and timestamps. It offers a single `Arrow` datetime type that wraps year/month/day/hour/minute/second/microsecond fields plus a timezone offset, and provides operations like construction from Unix timestamps, datetime arithmetic (shifting by years/months/days/hours/etc.), and ISO 8601 formatting.

## Task

Complete implementation holes in explicitly editable regions in `Arrow/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `fromTimestamp`

- **Signature**: `def fromTimestamp (timestamp : Nat) (tzOffsetMinutes : Int := 0) : ArrowDateTime`
- **Description**: Create an `ArrowDateTime` from a Unix timestamp (seconds since 1970-01-01 00:00:00 UTC), adjusted by a timezone offset in minutes.
- **Postcondition**: The result must have:
  - `tzOffset` equal to `tzOffsetMinutes`
  - All fields in valid ranges (month 1-12, day 1-31, hour 0-23, minute 0-59, second 0-59)
  - `microsecond = 0` (Nat timestamp has no sub-second precision)
  - Time-of-day consistency: `(timestamp + tzOffsetMinutes * 60) % 86400 = hour * 3600 + minute * 60 + second`
  - Day valid for its month: `day ≤ daysInMonth year month`
  - Date consistency: `(timestamp + tzOffsetMinutes * 60) / 86400 = daysSinceEpoch year month day`
- **Key constraints**: Must correctly handle timezone offsets (can be negative). The `daysSinceEpoch` helper defines the canonical mapping from dates to day-counts.

### 2. `ArrowDateTime.shift`

- **Signature**: `def ArrowDateTime.shift (dt : ArrowDateTime) (spec : ShiftSpec) : ArrowDateTime`
- **Revision precondition**: the correctness theorem `shift_spec` now takes `hvalid : ArrowDateTime.Valid dt`. This requires month 1–12, day 1 through `daysInMonth`, hour ≤23, minute/second ≤59, and microsecond ≤999999. Year and timezone offset retain the original unrestricted integer domain. The function remains total; its correctness contract is asserted only for valid input dates.
- **Description**: Shift a datetime by the amounts specified in a `ShiftSpec` (years, months, weeks, days, hours, minutes, seconds). Year/month shifts are calendar-based; day/hour/minute/second shifts are absolute-time-based.
- **Postcondition**: The result must satisfy:
  - Zero shift returns the original datetime unchanged
  - Timezone offset and microsecond are preserved
  - Year-only shifts change year exactly and preserve month
  - Year/month shifts maintain total-months consistency: `result.year * 12 + result.month = dt.year * 12 + dt.month + years * 12 + months`
  - Non-zero single-field shifts must actually change the result
  - Day/week-only shifts preserve time fields (hour, minute, second)
  - Same-month day shifts change day by exactly the shift amount
  - Total-seconds consistency (when years=0, months=0): the absolute second count via `daysSinceEpoch` must shift by exactly the specified amounts
  - All result fields in valid ranges
- **Key constraints**: Year/month arithmetic is separate from day/time arithmetic. Day clamping may occur (e.g., Jan 31 + 1 month → Feb 28). The total-seconds consistency formula is the strongest constraint.

### 3. `ArrowDateTime.isoformat`

- **Signature**: `def ArrowDateTime.isoformat (dt : ArrowDateTime) : String`
- **Description**: Format an `ArrowDateTime` as an ISO 8601 string (e.g., "2024-01-15T09:30:00").
- **Postcondition**: The result must:
  - Be non-empty and at least 19 characters long
  - Contain the "T" separator
  - Contain the year as a substring
  - Contain zero-padded month, day, hour, minute, and second as substrings
- **Key constraints**: Fields less than 10 must be zero-padded (e.g., month 3 → "03").

## Supporting Function

### `ArrowDateTime.timestamp`

- **Signature**: `def ArrowDateTime.timestamp (dt : ArrowDateTime) : Int`
- **Description**: Compute the Unix timestamp (seconds since epoch) for the datetime, accounting for timezone offset.
- **Postcondition**:
  - `(result + tzOffset * 60) % 86400 = hour * 3600 + minute * 60 + second`
  - `(result + tzOffset * 60) / 86400 = daysSinceEpoch year month day`
- **Key constraints**: This is the inverse of `fromTimestamp`. The two postconditions together fully determine the timestamp from the datetime fields.

## Relational Properties

- **`shift_zero_rel`**: Shifting by zero in all fields returns the original datetime unchanged.
- **`shift_inverse_rel`**: Shifting by +n days then -n days returns to the original datetime.
- **`timestamp_fromTimestamp_roundtrip_rel`**: Computing the timestamp of a `fromTimestamp` result recovers the original timestamp value.

## Types

- **`ArrowDateTime`**: A record with `year` (Int), `month`/`day`/`hour`/`minute`/`second`/`microsecond` (Nat), and `tzOffset` (Int, in minutes from UTC). This is the central type.
- **`ShiftSpec`**: A record with `years`/`months`/`weeks`/`days`/`hours`/`minutes`/`seconds` (all Int, default 0). Specifies how much to shift each field.

## Hints

- The helper functions `isLeapYearInt`, `daysInMonth`, `daysInYear`, `dayOfYear`, `sumYearDays`, and `daysSinceEpoch` are already fully implemented (no `sorry`) and can be used directly.
- `daysSinceEpoch` is the key building block — it converts a (year, month, day) triple to a day count from the Unix epoch. Both `fromTimestamp` and `shift` rely on it for their strongest postconditions.
- For `fromTimestamp`, you need to reverse `daysSinceEpoch`: given a day count, find the (year, month, day). One approach: iterate years from 1970 forward/backward consuming days, then iterate months.
- For `shift`, handle year/month shifts first (calendar arithmetic), then convert day/hour/minute/second shifts to total seconds and use `daysSinceEpoch` for the conversion back.
- For `isoformat`, construct the string by concatenating zero-padded fields with appropriate separators.
- `timestamp` is essentially `daysSinceEpoch * 86400 + hour * 3600 + minute * 60 + second - tzOffset * 60`.

## Edit Boundaries

`Arrow/*.lean` is divided into labeled sections:

```text
-- === BEGIN: SECTION_NAME (provided|editable) ===
...
-- === END: SECTION_NAME ===
```

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash and should remain unchanged.

Checking commands:

- `./check_hash.sh`
- `./check.sh --compile`
- `./check.sh`

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `Arrow/Construct.lean`
- `Arrow/Helpers.lean`
- `Arrow/IsoFormat.lean`
- `Arrow/Shift.lean`
- `Arrow/Timestamp.lean`
- `Arrow/Types.lean`
