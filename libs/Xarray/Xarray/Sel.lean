-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Xarray.Validity
import Std
import Lean

import Xarray.Isel

namespace Xarray

def DataArray.sel (da : DataArray) (dimName : String) (label : Label) : Option DataArray :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def DataArray.sel_postcond (da : DataArray) (dimName : String) (label : Label) (result : Option DataArray) : Prop :=
  (∀ da', result = some da' →
    da'.ndim = da.ndim - 1 ∧
    da'.dims.size = da.dims.size - 1 ∧
    da'.data.size ≤ da.data.size) ∧
  (DataArray.dimIndex da dimName = none → result = none) ∧
  (∀ da', result = some da' → da'.dims.all (fun d => d.name != dimName) = true) ∧
  (da.dims.any (fun d => d.name == dimName && d.labels.any (fun l => l == label)) = true →
   result.isSome = true) ∧
  (∀ da', result = some da' →
   ∀ di, di < da.dims.size → da.dims[di]!.name = dimName →
   let pi := da.dims[di]!.labels.findIdx (fun l => l == label)
   pi < da.dims[di]!.labels.size →
   da'.data = computeIselData da di pi)


theorem DataArray.sel_spec (da : DataArray) (dimName : String) (label : Label) 
    (hvalid : da.Valid) :
    DataArray.sel_postcond da dimName label (DataArray.sel da dimName label) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Xarray
-- === END: FIXED_FINAL ===
