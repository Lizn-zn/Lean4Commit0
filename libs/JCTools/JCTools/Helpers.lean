-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import JCTools.Types

namespace JCTools

def SpscQueue.new (capacity : Nat) : SpscQueue α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def SpscQueue.new_postcond (capacity : Nat) (result : SpscQueue α) : Prop :=
  result.buffer = [] ∧ result.capacity = capacity

theorem SpscQueue.new_spec (capacity : Nat) :
    SpscQueue.new_postcond capacity (SpscQueue.new (α := α) capacity) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end JCTools
-- === END: FIXED_FINAL ===
