-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Xarray.Types

namespace Xarray

def DataArray.Valid (da : DataArray) : Prop :=
  (da.dims.toList.map Dimension.name).Nodup ∧
  da.shape.size = da.dims.size ∧
  (∀ i, i < da.dims.size → da.shape[i]! = da.dims[i]!.labels.size) ∧
  da.data.size = da.shape.foldl (· * ·) 1 ∧ da.data.all Float.isFinite = true ∧
  ∀ d ∈ da.dims.toList, d.labels.toList.Pairwise (fun a b => (a == b) = false)

def DataArray.sumReference (da : DataArray) : Float :=
  match da.data.toList with
  | [] => 0.0
  | x :: xs => xs.foldl (· + ·) x

end Xarray
-- === END: FIXED_FINAL ===
