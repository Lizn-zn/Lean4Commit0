-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Xarray.Validity
import Std
import Lean

import Xarray.Sel
import Xarray.SumAll
import Xarray.Map

namespace Xarray

def DataArray.meanAll (da : DataArray) : Float :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def DataArray.meanAll_postcond (da : DataArray) (result : Float) : Prop :=
  (da.data.size = 0 → result = 0.0) ∧
  (da.data.size = 1 → da.data[0]? = some result) ∧
  (da.data.size > 0 → result = da.sumReference / Float.ofNat da.data.size)


theorem DataArray.meanAll_spec (da : DataArray) 
    (hfinite : da.data.all Float.isFinite = true) :
    DataArray.meanAll_postcond da (DataArray.meanAll da) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===




@[reducible]
def DataArray.sel_isel_rel (da : DataArray) (dimName : String) (pos : Nat) (label : Label) : Prop :=
  ∀ di, DataArray.dimIndex da dimName = some di →
    di < da.dims.size →
    (da.dims[di]!).labels.size > pos →
    (da.dims[di]!).labels[pos]! = label →
    DataArray.sel da dimName label = DataArray.isel da dimName pos


theorem DataArray.sel_isel_rel_spec (da : DataArray) (dimName : String) (pos : Nat) (label : Label) 
    (hvalid : da.Valid) :
    DataArray.sel_isel_rel da dimName pos label := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===




@[reducible]
def DataArray.sumAll_meanAll_rel (da : DataArray) : Prop :=
  da.data.size > 0 →
    DataArray.meanAll da = DataArray.sumAll da / Float.ofNat da.data.size


theorem DataArray.sumAll_meanAll_rel_spec (da : DataArray) 
    (hfinite : da.data.all Float.isFinite = true) :
    DataArray.sumAll_meanAll_rel da := by

  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===




@[reducible]
def DataArray.map_id_postcond (da : DataArray) (result : DataArray) : Prop :=
  result.data = da.data ∧ result.shape = da.shape ∧ result.dims = da.dims


theorem DataArray.map_id_spec (da : DataArray) :
    DataArray.map_id_postcond da (DataArray.map da id) := by

  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Xarray
-- === END: FIXED_FINAL ===
