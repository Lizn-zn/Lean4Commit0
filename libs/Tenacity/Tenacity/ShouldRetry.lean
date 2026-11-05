-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Tenacity.Types
import Tenacity.ShouldStop

namespace Tenacity

def shouldRetry (condition : RetryCondition) (outcome : Except String String) : Bool :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def shouldRetry_postcond (condition : RetryCondition) (outcome : Except String String)
    (result : Bool) : Prop :=
  result = shouldRetryExpected condition outcome


theorem shouldRetry_spec (condition : RetryCondition) (outcome : Except String String) :
    shouldRetry_postcond condition outcome (shouldRetry condition outcome) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Tenacity
-- === END: FIXED_FINAL ===
