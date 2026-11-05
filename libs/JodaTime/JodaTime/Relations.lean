-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import JodaTime.Validity
import Std
import Lean

import JodaTime.Types
import JodaTime.Helpers
import JodaTime.PlusDays
import JodaTime.LengthOfMonth
import JodaTime.DaysBetween

namespace JodaTime

/-! ## Relational: plusDays then minusDays cancel -/

@[reducible]
def plusDays_minusDays_cancel_rel (d : LocalDate) (n : Int) (result : LocalDate) : Prop :=
  result = d

theorem plusDays_minusDays_cancel_spec (d : LocalDate) (n : Int) 
    (hvalid : LocalDate.Valid d) :
    plusDays_minusDays_cancel_rel d n ((d.plusDays n).minusDays n) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: dayOfWeek has period 7 -/

@[reducible]
def dayOfWeek_period_7_rel (d : LocalDate) (result : DayOfWeek) : Prop :=
  result = d.dayOfWeek

theorem dayOfWeek_period_7_spec (d : LocalDate) 
    (hvalid : LocalDate.Valid d) :
    dayOfWeek_period_7_rel d ((d.plusDays 7).dayOfWeek) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Relational: daysBetween antisymmetry -/

@[reducible]
def daysBetween_antisym_postcond (a b : LocalDate) (r1 r2 : Int) : Prop :=
  r1 = -r2

theorem daysBetween_antisym_spec (a b : LocalDate) 
    (ha : LocalDate.Valid a) (hb : LocalDate.Valid b) :
    daysBetween_antisym_postcond a b (daysBetween a b) (daysBetween b a) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end JodaTime
-- === END: FIXED_FINAL ===
