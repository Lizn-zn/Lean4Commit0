-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Arrow.Helpers

namespace Arrow
/-! ## Types -/

/-- A datetime with timezone offset. All fields are stored explicitly. -/
structure ArrowDateTime where
  year        : Int
  month       : Nat    -- 1..12
  day         : Nat    -- 1..31
  hour        : Nat    -- 0..23
  minute      : Nat    -- 0..59
  second      : Nat    -- 0..59
  microsecond : Nat    -- 0..999999
  tzOffset    : Int    -- minutes from UTC (e.g., -300 for EST)
  deriving Repr, BEq

/-- Calendar-field validity under the supplied Gregorian calendar model.
    Year and timezone offset remain unrestricted, as in the original type. -/
def ArrowDateTime.Valid (dt : ArrowDateTime) : Prop :=
  1 ≤ dt.month ∧ dt.month ≤ 12 ∧
  1 ≤ dt.day ∧ dt.day ≤ daysInMonth dt.year dt.month ∧
  dt.hour ≤ 23 ∧ dt.minute ≤ 59 ∧ dt.second ≤ 59 ∧
  dt.microsecond ≤ 999999

/-- A shift descriptor specifying how much to add/subtract from each field. -/
structure ShiftSpec where
  years   : Int := 0
  months  : Int := 0
  weeks   : Int := 0
  days    : Int := 0
  hours   : Int := 0
  minutes : Int := 0
  seconds : Int := 0
  deriving Repr, BEq

end Arrow
-- === END: FIXED_FINAL ===
