-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Tenacity.Types

namespace Tenacity

def computeWait (strategy : WaitStrategy) (state : RetryState α) : Nat :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def computeWait_postcond (strategy : WaitStrategy) (state : RetryState α) (result : Nat) : Prop :=
  (∀ n, strategy = .fixed n → result = n) ∧
  (∀ base mult mx, strategy = .exponential base mult mx →
    result = min (mult * base ^ state.attemptNumber) mx) ∧
  (∀ st inc, strategy = .incrementing st inc →
    result = st + inc * (state.attemptNumber - 1)) ∧
  (∀ mn mx, strategy = .random mn mx → mn ≤ mx → result ≥ mn ∧ result ≤ mx)


theorem computeWait_spec (strategy : WaitStrategy) (state : RetryState α) :
    computeWait_postcond strategy state (computeWait strategy state) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



def shouldStopExpected (strategy : StopStrategy) (state : RetryState α) : Bool :=
  match strategy with
  | .afterAttempt n => decide (state.attemptNumber >= n)
  | .afterDelay d => decide (state.currentTime - state.startTime >= d)
  | .never => false
  | .any strategies => anyStop strategies state
  | .all strategies => allStop strategies state
where
  anyStop : List StopStrategy → RetryState α → Bool
    | [], _ => false
    | s :: rest, st => shouldStopExpected s st || anyStop rest st
  allStop : List StopStrategy → RetryState α → Bool
    | [], _ => true
    | s :: rest, st => shouldStopExpected s st && allStop rest st


end Tenacity
-- === END: FIXED_FINAL ===
