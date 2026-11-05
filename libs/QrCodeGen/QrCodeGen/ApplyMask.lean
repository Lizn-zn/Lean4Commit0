-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import QrCodeGen.Validity
import Std
import Lean

import QrCodeGen.Types
import QrCodeGen.Helpers
import QrCodeGen.EncodeByte

namespace QrCodeGen


def applyMask (g : Grid) (mask : MaskPattern) (functionPattern : Grid) : Grid :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def applyMask_postcond (g : Grid) (mask : MaskPattern) (functionPattern : Grid) (result : Grid) : Prop :=
  result.size = g.size ∧
  result.modules.length = g.size ∧
  (∀ row col, (functionPattern.modules.getD row []).getD col false = true →
    (result.modules.getD row []).getD col false =
    (g.modules.getD row []).getD col false) ∧
  (∀ row col, row < g.size → col < g.size →
    (functionPattern.modules.getD row []).getD col false = false →
    (result.modules.getD row []).getD col false =
      xor ((g.modules.getD row []).getD col false) (maskFormula mask.index row col))


theorem applyMask_spec (g : Grid) (mask : MaskPattern) (functionPattern : Grid) 
    (hg : g.Valid) (hf : functionPattern.Valid) (hsize : functionPattern.size = g.size) :
    applyMask_postcond g mask functionPattern (applyMask g mask functionPattern) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end QrCodeGen
-- === END: FIXED_FINAL ===
