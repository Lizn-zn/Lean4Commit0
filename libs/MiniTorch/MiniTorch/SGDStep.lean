-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import MiniTorch.TensorMap

namespace MiniTorch

def SGD.step (opt : SGD) (params : List (Tensor × Tensor)) : List Tensor :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def SGD.step_postcond (opt : SGD) (params : List (Tensor × Tensor))
    (result : List Tensor) : Prop :=
  result.length = params.length ∧
  (∀ r pg, (r, pg) ∈ List.zip result params →
    r.shape = pg.1.shape ∧
    ∀ idx, idx.length = pg.1.shape.length →
      (∀ i, i < idx.length → idx[i]! < pg.1.shape[i]!) →
      ∀ pv gv, pg.1.get idx = some pv →
               pg.2.get idx = some gv →
               r.get idx = some (pv - opt.learningRate * gv))

theorem SGD.step_spec (opt : SGD) (params : List (Tensor × Tensor)) :
    SGD.step_postcond opt params (opt.step params) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MiniTorch
-- === END: FIXED_FINAL ===
