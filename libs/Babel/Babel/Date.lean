-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Babel.Number

namespace Babel

/-! ## Date Formatting -/

def formatDate (loc : LocaleData) (d : SimpleDate) (formatStr : String := "medium") : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def formatDate_postcond (loc : LocaleData) (d : SimpleDate) (formatStr : String) (result : String) : Prop :=
  (formatStr.length > 0 → d.month ≥ 1 ∧ d.month ≤ 12 → d.day ≥ 1 ∧ d.day ≤ 31 → result.length > 0) ∧
  (formatStr.length > 0 → d.month ≥ 1 ∧ d.month ≤ 12 → d.day ≥ 1 ∧ d.day ≤ 31 → result.any Char.isDigit = true) ∧
  (formatStr.length > 0 → d.month ≥ 1 ∧ d.month ≤ 12 → d.day ≥ 1 ∧ d.day ≤ 31 → result.length ≥ 4) ∧
  (formatStr = "" → result = "") ∧
  (d.year = 2024 ∧ d.month = 3 ∧ d.day = 15 ∧ formatStr = "long" →
    containsSub result "March" = true ∧ containsSub result "15" = true ∧ containsSub result "2024" = true) ∧
  (d.year = 2024 ∧ d.month = 12 ∧ d.day = 31 ∧ formatStr = "long" →
    containsSub result "December" = true ∧ containsSub result "31" = true ∧ containsSub result "2024" = true) ∧
  (d.year = 2024 ∧ d.month = 9 ∧ d.day = 1 ∧ formatStr = "long" →
    containsSub result "September" = true ∧ containsSub result "2024" = true) ∧
  (d.year = 1999 ∧ d.month = 6 ∧ d.day = 1 ∧ formatStr = "long" →
    containsSub result "June" = true ∧ containsSub result "1999" = true) ∧
  (d.year = 2024 ∧ d.month = 3 ∧ d.day = 15 ∧ formatStr = "full" →
    containsSub result "Friday" = true ∧ containsSub result "March" = true ∧ containsSub result "2024" = true) ∧
  (d.year = 2024 ∧ d.month = 2 ∧ d.day = 29 ∧ formatStr = "full" →
    containsSub result "Thursday" = true ∧ containsSub result "February" = true ∧ containsSub result "2024" = true) ∧
  (d.year = 2024 ∧ d.month = 1 ∧ d.day = 15 ∧ formatStr = "medium" →
    containsSub result "Jan" = true ∧ containsSub result "15" = true ∧ containsSub result "2024" = true) ∧
  (d.year = 2024 ∧ d.month = 7 ∧ d.day = 4 ∧ formatStr = "medium" →
    containsSub result "Jul" = true ∧ containsSub result "4" = true ∧ containsSub result "2024" = true) ∧
  (d.month = 0 → result = "") ∧
  (d.month > 12 → result = "") ∧
  (d.day = 0 → result = "") ∧
  (formatStr = "long" → d.month ≥ 1 ∧ d.month ≤ 12 → d.day ≥ 1 ∧ d.day ≤ 31 →
    containsSub result (toString d.year) = true) ∧
  (formatStr = "full" → d.month ≥ 1 ∧ d.month ≤ 12 → d.day ≥ 1 ∧ d.day ≤ 31 →
    containsSub result (toString d.year) = true) ∧
  (formatStr = "medium" → d.month ≥ 1 ∧ d.month ≤ 12 → d.day ≥ 1 ∧ d.day ≤ 31 →
    containsSub result (toString d.year) = true) ∧
  (formatStr = "long" → d.month ≥ 1 ∧ d.month ≤ 12 → d.day ≥ 1 ∧ d.day ≤ 31 →
    result.length ≥ 8) ∧
  (formatStr = "full" → d.month ≥ 1 ∧ d.month ≤ 12 → d.day ≥ 1 ∧ d.day ≤ 31 →
    result.length ≥ 12)

theorem formatDate_spec (loc : LocaleData) (d : SimpleDate) (formatStr : String := "medium") :
    formatDate_postcond loc d formatStr (formatDate loc d formatStr) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Babel
-- === END: FIXED_FINAL ===
