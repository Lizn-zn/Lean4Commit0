-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Crossbeam.Types

namespace Crossbeam

def ArrayQueue.push (q : ArrayQueue α) (v : α) : Option (ArrayQueue α) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def ArrayQueue.push_postcond (q : ArrayQueue α) (v : α) (result : Option (ArrayQueue α)) : Prop :=
  (q.data.length ≥ q.capacity' → result = none) ∧
  (q.data.length < q.capacity' → ∃ q', result = some q' ∧ q'.data = q.data ++ [v] ∧ q'.capacity' = q.capacity')

theorem ArrayQueue.push_spec (q : ArrayQueue α) (v : α) :
    ArrayQueue.push_postcond q v (q.push v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Crossbeam
-- === END: FIXED_FINAL ===
