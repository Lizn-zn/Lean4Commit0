-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import SimPy.Validity
import Std
import Lean

import SimPy.Step

namespace SimPy

def Environment.schedule (env : Environment) (eventId : EventId)
    (priority : EventPriority := .normal) (delay : SimTime := 0.0)
    : Environment :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Environment.schedule_postcond (env : Environment) (eid : EventId)
    (pri : EventPriority) (delay : SimTime) (result : Environment) : Prop :=
  result.now = env.now ∧
  (∃ se ∈ result.eventQueue, se.eventId = eid ∧ se.time = env.now + delay ∧ se.priority = pri) ∧
  result.eventQueue.length = env.eventQueue.length + 1

theorem Environment.schedule_spec (env : Environment) (eid : EventId)
    (pri : EventPriority) (delay : SimTime) 
    (hvalid : env.Valid) (hdelay : delay.isFinite = true ∧ 0 ≤ delay ∧ (env.now + delay).isFinite = true) :
    Environment.schedule_postcond env eid pri delay (env.schedule eid pri delay) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



theorem Environment.schedule_preserves_order (env : Environment)
    (eid : EventId) (pri : EventPriority) (delay : SimTime)
    (h : eventQueueSorted env.eventQueue) 
    (hvalid : env.Valid) (hdelay : delay.isFinite = true ∧ 0 ≤ delay ∧ (env.now + delay).isFinite = true) :
    eventQueueSorted (env.schedule eid pri delay).eventQueue := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SimPy
-- === END: FIXED_FINAL ===
