-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Crossbeam.Types

namespace Crossbeam

/-- Owner pops from the bottom (LIFO for owner). -/
def Deque.pop (d : Deque α) : Deque α × Option α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Deque.pop_postcond (d : Deque α) (result : Deque α × Option α) : Prop :=
  (d.data = [] → result.2 = none ∧ result.1.data = []) ∧
  (d.data ≠ [] → result.2 = d.data.getLast? ∧ result.1.data = d.data.dropLast)

theorem Deque.pop_spec (d : Deque α) :
    Deque.pop_postcond d (d.pop) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Crossbeam
-- === END: FIXED_FINAL ===
