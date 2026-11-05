-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import MiniTorch.SGDStep

namespace MiniTorch

@[reducible]
def pos_idx_roundtrip_rel (idx : List Nat) (shape : Shape) (result : List Nat) : Prop :=
  idx.length = shape.length →
  (∀ i, i < idx.length → idx[i]! < shape[i]!) →
  result = idx

theorem pos_idx_roundtrip_spec (idx : List Nat) (shape : Shape)
    (hlen : idx.length = shape.length)
    (hbounds : ∀ i, i < idx.length → idx[i]! < shape[i]!) :
    pos_idx_roundtrip_rel idx shape
      (positionToIndex (indexToPosition idx (shapeToStrides shape)) shape) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def idx_pos_roundtrip_rel (pos : Nat) (shape : Shape) (result : Nat) : Prop :=
  pos < shapeSize shape → result = pos

theorem idx_pos_roundtrip_spec (pos : Nat) (shape : Shape) (hpos : pos < shapeSize shape) :
    idx_pos_roundtrip_rel pos shape
      (indexToPosition (positionToIndex pos shape) (shapeToStrides shape)) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MiniTorch
-- === END: FIXED_FINAL ===
