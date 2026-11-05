-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Arrow.Construct

namespace Arrow

/-! ## Shifting -/

def ArrowDateTime.shift (dt : ArrowDateTime) (spec : ShiftSpec) : ArrowDateTime :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def ArrowDateTime.shift_postcond (dt : ArrowDateTime) (spec : ShiftSpec)
    (result : ArrowDateTime) : Prop :=
  (spec = { years := 0, months := 0, weeks := 0, days := 0,
            hours := 0, minutes := 0, seconds := 0 } → result = dt) ∧
  result.tzOffset = dt.tzOffset ∧
  -- Microsecond is preserved (no microsecond in ShiftSpec)
  result.microsecond = dt.microsecond ∧
  -- Non-zero year shift changes the year exactly and preserves month
  (spec.years ≠ 0 ∧ spec.months = 0 ∧ spec.weeks = 0 ∧ spec.days = 0 ∧
   spec.hours = 0 ∧ spec.minutes = 0 ∧ spec.seconds = 0 →
   result.year = dt.year + spec.years ∧ result.month = dt.month) ∧
  -- Year/month shift: total months must be consistent
  (spec.weeks = 0 ∧ spec.days = 0 ∧ spec.hours = 0 ∧
   spec.minutes = 0 ∧ spec.seconds = 0 →
   result.year * 12 + ↑result.month = dt.year * 12 + ↑dt.month + spec.years * 12 + spec.months) ∧
  -- Non-zero single-field shift must change the result
  (spec.years = 0 ∧ spec.months = 0 ∧ spec.weeks = 0 ∧ spec.days ≠ 0 ∧
   spec.hours = 0 ∧ spec.minutes = 0 ∧ spec.seconds = 0 →
   result ≠ dt) ∧
  (spec.years = 0 ∧ spec.months = 0 ∧ spec.weeks = 0 ∧ spec.days = 0 ∧
   spec.hours ≠ 0 ∧ spec.minutes = 0 ∧ spec.seconds = 0 →
   result ≠ dt) ∧
  (spec.years = 0 ∧ spec.months = 0 ∧ spec.weeks = 0 ∧ spec.days = 0 ∧
   spec.hours = 0 ∧ spec.minutes ≠ 0 ∧ spec.seconds = 0 →
   result ≠ dt) ∧
  (spec.years = 0 ∧ spec.months = 0 ∧ spec.weeks = 0 ∧ spec.days = 0 ∧
   spec.hours = 0 ∧ spec.minutes = 0 ∧ spec.seconds ≠ 0 →
   result ≠ dt) ∧
  -- For day/week-only shifts, time fields are preserved
  (spec.years = 0 ∧ spec.months = 0 ∧ spec.hours = 0 ∧
   spec.minutes = 0 ∧ spec.seconds = 0 →
   result.hour = dt.hour ∧ result.minute = dt.minute ∧ result.second = dt.second) ∧
  -- Stronger: whenever no hour/minute/second shift, time fields are always preserved
  (spec.hours = 0 ∧ spec.minutes = 0 ∧ spec.seconds = 0 →
   result.hour = dt.hour ∧ result.minute = dt.minute ∧ result.second = dt.second) ∧
  -- Day preserved for year/month-only shifts when day is valid in the target month
  (spec.weeks = 0 ∧ spec.days = 0 ∧ spec.hours = 0 ∧ spec.minutes = 0 ∧ spec.seconds = 0 ∧
   dt.day ≤ daysInMonth result.year result.month →
   result.day = dt.day) ∧
  -- For day-only shifts that stay in the same month/year, day changes by exactly the shift
  (spec.years = 0 ∧ spec.months = 0 ∧ spec.weeks = 0 ∧ spec.days ≠ 0 ∧
   spec.hours = 0 ∧ spec.minutes = 0 ∧ spec.seconds = 0 ∧
   result.month = dt.month ∧ result.year = dt.year →
   (↑result.day : Int) - ↑dt.day = spec.days) ∧
  -- For hour-only shifts that stay in the same day, hour changes by exactly the shift
  (spec.years = 0 ∧ spec.months = 0 ∧ spec.weeks = 0 ∧ spec.days = 0 ∧
   spec.hours ≠ 0 ∧ spec.minutes = 0 ∧ spec.seconds = 0 ∧
   result.day = dt.day ∧ result.month = dt.month ∧ result.year = dt.year →
   (↑result.hour : Int) - ↑dt.hour = spec.hours) ∧
  -- Total-seconds consistency for day/week/hour/minute/second shifts (years=0, months=0)
  (spec.years = 0 ∧ spec.months = 0 →
    daysSinceEpoch result.year result.month result.day * 86400 +
      ↑result.hour * 3600 + ↑result.minute * 60 + ↑result.second =
    daysSinceEpoch dt.year dt.month dt.day * 86400 +
      ↑dt.hour * 3600 + ↑dt.minute * 60 + ↑dt.second +
      spec.weeks * 7 * 86400 + spec.days * 86400 +
      spec.hours * 3600 + spec.minutes * 60 + spec.seconds) ∧
  -- Valid field ranges on result
  result.month ≥ 1 ∧ result.month ≤ 12 ∧
  result.day ≥ 1 ∧ result.day ≤ 31 ∧
  result.hour ≤ 23 ∧
  result.minute ≤ 59 ∧
  result.second ≤ 59 ∧
  result.microsecond ≤ 999999

theorem ArrowDateTime.shift_spec (dt : ArrowDateTime) (spec : ShiftSpec)
    (hvalid : ArrowDateTime.Valid dt) :
    ArrowDateTime.shift_postcond dt spec (dt.shift spec) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Arrow
-- === END: FIXED_FINAL ===
