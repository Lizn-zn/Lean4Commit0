-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # MiniTorch
   Pedagogical deep learning library — summarized to 3 core functions.

   Ported from Python's `minitorch` library.
   Original: https://github.com/minitorch/minitorch
-/

namespace MiniTorch

abbrev Shape := List Nat
abbrev Strides := List Nat

def shapeSizePure (shape : Shape) : Nat :=
  match shape with
  | [] => 1
  | d :: ds => d * shapeSizePure ds

def shapeToStridesPure (shape : Shape) : Strides :=
  let n := shape.length
  (List.range n).map fun i =>
    (shape.drop (i + 1)).foldl (· * ·) 1

structure Storage where
  data : Array Float
  deriving Repr

structure Tensor where
  storage : Storage
  shape : Shape
  strides : Strides
  offset : Nat := 0
  deriving Repr

structure SGD where
  learningRate : Float
  deriving Repr

end MiniTorch
-- === END: FIXED_FINAL ===
