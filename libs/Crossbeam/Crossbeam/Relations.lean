-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Crossbeam.Helpers
import Crossbeam.QueuePop
import Crossbeam.DequePop

namespace Crossbeam

/-! ## Relational: Queue FIFO order -/

@[reducible]
def Queue.fifo_rel (v1 v2 : α) (pop_result : Option α) : Prop :=
  pop_result = some v1

theorem Queue.fifo_spec (v1 v2 : α) :
    Queue.fifo_rel v1 v2 ((Queue.new.push v1).push v2 |>.pop |>.2) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: Deque pop LIFO -/

@[reducible]
def Deque.pop_lifo_rel (v1 v2 : α) (pop_result : Option α) : Prop :=
  pop_result = some v2

theorem Deque.pop_lifo_spec (v1 v2 : α) :
    Deque.pop_lifo_rel v1 v2 (((Deque.new.push v1).push v2).pop.2) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Crossbeam
-- === END: FIXED_FINAL ===
