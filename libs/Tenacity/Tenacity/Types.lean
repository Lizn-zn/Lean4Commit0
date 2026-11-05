-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Tenacity

structure RetryState (α : Type) where
  attemptNumber : Nat
  startTime     : Nat
  currentTime   : Nat
  outcome       : Option (Except String α)


inductive WaitStrategy where
  | fixed        : Nat → WaitStrategy
  | random       : (min : Nat) → (max : Nat) → WaitStrategy
  | exponential  : (base : Nat) → (multiplier : Nat) → (max : Nat) → WaitStrategy
  | incrementing : (start : Nat) → (increment : Nat) → WaitStrategy
  | chain        : List WaitStrategy → WaitStrategy
  deriving Repr, BEq


inductive StopStrategy where
  | afterAttempt : Nat → StopStrategy
  | afterDelay   : Nat → StopStrategy
  | any          : List StopStrategy → StopStrategy
  | all          : List StopStrategy → StopStrategy
  | never        : StopStrategy
  deriving Repr, BEq


inductive RetryCondition where
  | retryIfException  : RetryCondition
  | retryIfResult     : (String → Bool) → RetryCondition
  | retryAny          : List RetryCondition → RetryCondition
  | retryAll          : List RetryCondition → RetryCondition


end Tenacity
-- === END: FIXED_FINAL ===
