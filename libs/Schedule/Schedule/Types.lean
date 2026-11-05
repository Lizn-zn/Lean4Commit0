-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Schedule

/-! ## Types -/

/-- Time unit for scheduling intervals. -/
inductive TimeUnit where
  | second    : TimeUnit
  | minute    : TimeUnit
  | hour      : TimeUnit
  | day       : TimeUnit
  | week      : TimeUnit
  | monday    : TimeUnit
  | tuesday   : TimeUnit
  | wednesday : TimeUnit
  | thursday  : TimeUnit
  | friday    : TimeUnit
  | saturday  : TimeUnit
  | sunday    : TimeUnit
  deriving Repr, BEq, DecidableEq

/-- A scheduled job. All times are in abstract seconds from epoch. -/
structure Job where
  interval : Nat
  unit     : TimeUnit
  atTime   : Option String
  lastRun  : Option Nat
  nextRun  : Nat
  tag      : Option String
  deriving Repr, BEq

/-- A scheduler holding a collection of jobs and the current time. -/
structure Scheduler where
  jobs        : List Job
  currentTime : Nat
  deriving Repr, BEq

end Schedule
-- === END: FIXED_FINAL ===
