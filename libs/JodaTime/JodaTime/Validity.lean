-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import JodaTime.Types

namespace JodaTime

def LocalDate.Valid (d : LocalDate) : Prop :=
  1 ≤ d.month ∧ d.month ≤ 12 ∧ 1 ≤ d.day ∧
  d.day ≤ (if d.month = 2 then
    if d.year % 4 = 0 ∧ (d.year % 100 ≠ 0 ∨ d.year % 400 = 0) then 29 else 28
    else if d.month ∈ [4,6,9,11] then 30 else 31)

end JodaTime
-- === END: FIXED_FINAL ===
