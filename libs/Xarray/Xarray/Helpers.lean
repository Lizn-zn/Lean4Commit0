-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Xarray.Types

namespace Xarray

def DataArray.ndim (da : DataArray) : Nat :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




def DataArray.size (da : DataArray) : Nat :=

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===




def DataArray.dimIndex (da : DataArray) (dimName : String) : Option Nat :=

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===




@[reducible]
def DataArray.basic_postcond (da : DataArray) : Prop :=
  da.ndim = da.dims.size ∧ da.size = da.data.size


theorem DataArray.basic_spec (da : DataArray) :
    DataArray.basic_postcond da := by

  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===




/-! ## Supporting: computeIselData helper (pure, no sorry) -/

-- Compute the expected data array after selecting dim `di` at position `pos`.
-- Uses row-major (C-order) flat indexing. No sorry references.
def computeIselData (da : DataArray) (di : Nat) (pos : Nat) : Array Float :=
  let nDims := da.shape.size
  let dimSize := if di < nDims then da.shape[di]! else 1
  let strideAfter : Nat := Id.run do
    let mut s := 1
    for j in List.range (nDims - di - 1) do
      if di + 1 + j < nDims then
        s := s * da.shape[di + 1 + j]!
    return s
  let strideBefore : Nat := Id.run do
    let mut s := 1
    for j in List.range di do
      if j < nDims then
        s := s * da.shape[j]!
    return s
  Id.run do
    let mut result : Array Float := #[]
    for outer in List.range strideBefore do
      for inner in List.range strideAfter do
        let idx := outer * dimSize * strideAfter + pos * strideAfter + inner
        if idx < da.data.size then
          result := result.push da.data[idx]!
    return result


end Xarray
-- === END: FIXED_FINAL ===
