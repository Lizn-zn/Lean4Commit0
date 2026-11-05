-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import MiniTorch.Helpers

namespace MiniTorch

def positionToIndex (position : Nat) (shape : Shape) : List Nat :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def positionToIndex_postcond (pos : Nat) (shape : Shape) (result : List Nat) : Prop :=
  result.length = shape.length ∧
  (∀ i, i < result.length → shape[i]! > 0 → result[i]! < shape[i]!) ∧
  (pos < shapeSizePure shape →
   (List.zipWith (· * ·) result (shapeToStridesPure shape)).foldl (· + ·) 0 = pos)

theorem positionToIndex_spec (pos : Nat) (shape : Shape) :
    positionToIndex_postcond pos shape (positionToIndex pos shape) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MiniTorch
-- === END: FIXED_FINAL ===
