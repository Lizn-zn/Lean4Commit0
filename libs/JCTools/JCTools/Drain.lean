-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import JCTools.Types
import JCTools.Helpers
import JCTools.Offer
import JCTools.Poll

namespace JCTools

/-! ## Core Function 3: SpscQueue.drain -/
def SpscQueue.drain (q : SpscQueue α) (n : Nat) : SpscQueue α × List α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def SpscQueue.drain_postcond (q : SpscQueue α) (n : Nat) (result : SpscQueue α × List α) : Prop :=
  result.2.length ≤ n ∧ result.2.length ≤ q.buffer.length ∧
  result.1.buffer.length = q.buffer.length - result.2.length ∧
  (∀ v, v ∈ result.2 → v ∈ q.buffer) ∧
  result.1.capacity = q.capacity ∧
  result.2 = q.buffer.take result.2.length ∧
  result.1.buffer = q.buffer.drop result.2.length ∧
  (n ≤ q.buffer.length → result.2.length = n) ∧
  (q.buffer.length < n → result.2.length = q.buffer.length)

theorem SpscQueue.drain_spec (q : SpscQueue α) (n : Nat) :
    SpscQueue.drain_postcond q n (q.drain n) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end JCTools
-- === END: FIXED_FINAL ===
