-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace JodaTime
/-! ## Types -/
structure LocalDate where
  year  : Int
  month : Nat  -- 1..12
  day   : Nat  -- 1..31
  deriving Repr, BEq
inductive DayOfWeek where
  | monday | tuesday | wednesday | thursday | friday | saturday | sunday
  deriving Repr, BEq
end JodaTime
-- === END: FIXED_FINAL ===
