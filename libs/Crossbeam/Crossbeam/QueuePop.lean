-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Crossbeam.Types

namespace Crossbeam

def Queue.pop (q : Queue α) : Queue α × Option α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Queue.pop_postcond (q : Queue α) (result : Queue α × Option α) : Prop :=
  (q.data = [] → result.2 = none ∧ result.1.data = []) ∧
  (q.data ≠ [] → result.2 = q.data.head? ∧ result.1.data = q.data.tail)

theorem Queue.pop_spec (q : Queue α) :
    Queue.pop_postcond q (q.pop) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Crossbeam
-- === END: FIXED_FINAL ===
