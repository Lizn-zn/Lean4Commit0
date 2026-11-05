-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace Tenacity

def computeExponentialWait (base multiplier maxWait attemptNumber : Nat) : Nat :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def computeExponentialWait_postcond (base multiplier maxWait attemptNumber : Nat) (result : Nat) : Prop :=
  result = min (multiplier * base ^ attemptNumber) maxWait


theorem computeExponentialWait_spec (base multiplier maxWait attemptNumber : Nat) :
    computeExponentialWait_postcond base multiplier maxWait attemptNumber
      (computeExponentialWait base multiplier maxWait attemptNumber) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def exponential_wait_increases_rel (base multiplier maxWait n : Nat)
    (r1 r2 : Nat) : Prop :=
  base > 1 → multiplier > 0 → n > 0 → multiplier * base ^ (n + 1) ≤ maxWait → r1 < r2


theorem exponential_wait_increases_spec (base multiplier maxWait : Nat)
    (hbase : base > 1) (hmult : multiplier > 0) (n : Nat) (hn : n > 0)
    (hmax : multiplier * base ^ (n + 1) ≤ maxWait) :
    exponential_wait_increases_rel base multiplier maxWait n
      (computeExponentialWait base multiplier maxWait n)
      (computeExponentialWait base multiplier maxWait (n + 1)) := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Tenacity
-- === END: FIXED_FINAL ===
