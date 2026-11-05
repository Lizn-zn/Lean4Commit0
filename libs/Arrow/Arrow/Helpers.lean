-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Arrow

/-- Original benchmark substring algorithm, namespaced to avoid the existing
    global String.containsSubstr declaration. -/
def containsSubstr (s sub : String) : Bool :=
  if sub == "" then true
  else (s.splitOn sub).length > 1

/-! ## Helpers -/

/-- Whether a year is a leap year. -/
def isLeapYearInt (y : Int) : Bool :=
  y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)

/-- Days in a given month (1-indexed). -/
def daysInMonth (y : Int) (m : Nat) : Nat :=
  if m == 2 then (if isLeapYearInt y then 29 else 28)
  else if m == 4 || m == 6 || m == 9 || m == 11 then 30
  else 31

/-- Days in a given year. -/
def daysInYear (y : Int) : Nat :=
  if isLeapYearInt y then 366 else 365

/-- Day-of-year for a given month and day (1-indexed, Jan 1 = 1). -/
def dayOfYear (y : Int) (m d : Nat) : Nat :=
  let rec go (i : Nat) (acc : Nat) : Nat :=
    if i >= m then acc + d
    else go (i + 1) (acc + daysInMonth y i)
  go 1 0

/-- Sum of daysInYear for years [from, from+1, ..., from+fuel-1], stopping at `stop`. -/
def sumYearDays (from_ : Int) (stop : Int) (fuel : Nat) : Int :=
  match fuel with
  | 0 => 0
  | fuel' + 1 =>
    if from_ >= stop then 0
    else ↑(daysInYear from_) + sumYearDays (from_ + 1) stop fuel'

/-- Total days from 1970-01-01 to a given date (y, m, d).
    Positive when the date is on or after epoch, negative before. -/
def daysSinceEpoch (y : Int) (m d : Nat) : Int :=
  let yearDays : Int :=
    if y > 1970 then sumYearDays 1970 y (y - 1970).toNat
    else if y < 1970 then -sumYearDays y 1970 (1970 - y).toNat
    else 0
  yearDays + ↑(dayOfYear y m d) - 1

end Arrow
-- === END: FIXED_FINAL ===
