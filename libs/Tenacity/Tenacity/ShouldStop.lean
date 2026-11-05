-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Tenacity.Types
import Tenacity.ComputeWait

namespace Tenacity

def shouldStop (strategy : StopStrategy) (state : RetryState α) : Bool :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def shouldStop_postcond (strategy : StopStrategy) (state : RetryState α) (result : Bool) : Prop :=
  result = shouldStopExpected strategy state


theorem shouldStop_spec (strategy : StopStrategy) (state : RetryState α) :
    shouldStop_postcond strategy state (shouldStop strategy state) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def shouldStop_afterDelay_postcond (delay : Nat) (state : RetryState α) (result : Bool) : Prop :=
  (state.currentTime - state.startTime ≥ delay → result = true) ∧
  (state.currentTime - state.startTime < delay → result = false)


theorem shouldStop_afterDelay_spec (delay : Nat) (state : RetryState α) :
    shouldStop_afterDelay_postcond delay state (shouldStop (.afterDelay delay) state) := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def shouldStop_never_rel (state : RetryState α) (result : Bool) : Prop :=
  result = false


theorem shouldStop_never_spec (state : RetryState α) :
    shouldStop_never_rel state (shouldStop .never state) := by

  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===



def shouldRetryExpected (condition : RetryCondition) (outcome : Except String String) : Bool :=
  match condition with
  | .retryIfException =>
    match outcome with
    | .error _ => true
    | .ok _ => false
  | .retryIfResult pred =>
    match outcome with
    | .error _ => false
    | .ok v => pred v
  | .retryAny conditions => anyRetry conditions outcome
  | .retryAll conditions => allRetry conditions outcome
where
  anyRetry : List RetryCondition → Except String String → Bool
    | [], _ => false
    | c :: rest, o => shouldRetryExpected c o || anyRetry rest o
  allRetry : List RetryCondition → Except String String → Bool
    | [], _ => true
    | c :: rest, o => shouldRetryExpected c o && allRetry rest o


end Tenacity
-- === END: FIXED_FINAL ===
