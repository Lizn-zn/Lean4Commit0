-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Click.Types
import Click.Helpers

namespace Click

/-! ## Parameter Type Conversion -/

def convertValue (paramType : ParamType) (raw : String) : Except String ParamValue :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def convertValue_postcond (paramType : ParamType) (raw : String) (result : Except String ParamValue) : Prop :=
  (paramType = .STRING → result = .ok (.str raw)) ∧
  (paramType = .BOOL → raw = "true" → result = .ok (.bool true)) ∧
  (paramType = .BOOL → raw = "false" → result = .ok (.bool false)) ∧
  (∀ choices, paramType = .Choice choices → raw ∈ choices → result = .ok (.str raw)) ∧
  (∀ choices, paramType = .Choice choices → raw ∉ choices → ∃ e, result = .error e) ∧
  (paramType = .INT → (∃ n : Int, result = .ok (.int n)) ∨ (∃ e, result = .error e)) ∧
  (paramType = .INT → ∀ n, result = .ok (.int n) → parseIntHelper raw = some n) ∧
  (paramType = .FLOAT → (∃ f : Float, result = .ok (.float f)) ∨ (∃ e, result = .error e)) ∧
  (∀ e f d, paramType = .Path e f d → result = .ok (.str raw)) ∧
  (∀ m, paramType = .File m → result = .ok (.str raw))

theorem convertValue_spec (paramType : ParamType) (raw : String) :
    convertValue_postcond paramType raw (convertValue paramType raw) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Click
-- === END: FIXED_FINAL ===
