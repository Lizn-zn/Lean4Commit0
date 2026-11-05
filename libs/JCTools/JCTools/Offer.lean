-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import JCTools.Types
import JCTools.Helpers

namespace JCTools

/-! ## Core Function 1: SpscQueue.offer -/
def SpscQueue.offer (q : SpscQueue α) (v : α) : Option (SpscQueue α) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def SpscQueue.offer_postcond (q : SpscQueue α) (v : α) (result : Option (SpscQueue α)) : Prop :=
  (q.buffer.length ≥ q.capacity → result = none) ∧
  (q.buffer.length < q.capacity → result.isSome = true) ∧
  (∀ q', result = some q' → q'.buffer.length = q.buffer.length + 1) ∧
  (∀ q', result = some q' → q'.capacity = q.capacity) ∧
  (∀ q', result = some q' → v ∈ q'.buffer) ∧
  (∀ q', result = some q' → q'.buffer = q.buffer ++ [v])

theorem SpscQueue.offer_spec (q : SpscQueue α) (v : α) :
    SpscQueue.offer_postcond q v (q.offer v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end JCTools
-- === END: FIXED_FINAL ===
