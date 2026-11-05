-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import SimPy.Validity
import Std
import Lean

import SimPy.Helpers

namespace SimPy

def Environment.step (env : Environment) : Option Environment :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Environment.step_postcond (env : Environment) (result : Option Environment) : Prop :=
  (result = none ↔ env.eventQueue = []) ∧
  (∀ env', result = some env' →
    env.now ≤ env'.now ∧
    env'.eventQueue.length < env.eventQueue.length ∧
    match env.eventQueue with
    | se :: _ => env'.now = se.time
    | [] => True)

theorem Environment.step_spec (env : Environment) 
    (hvalid : env.Valid) :
    Environment.step_postcond env env.step := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



theorem Environment.step_advances_to_earliest (env : Environment)
    (env' : Environment) (h : env.step = some env') 
    (hvalid : env.Valid) :
    match env.eventQueue with
    | [] => False
    | se :: _ => env'.now = se.time := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



theorem Environment.step_preserves_queue_order (env : Environment)
    (env' : Environment)
    (h : env.step = some env')
    (hs : eventQueueSorted env.eventQueue) 
    (hvalid : env.Valid) :
    eventQueueSorted env'.eventQueue := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SimPy
-- === END: FIXED_FINAL ===
