-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Pydantic.Types

namespace Pydantic


/-! ## Infrastructure: ModelInstance.get (used by validate postcond) -/

/-- Get a field value from a model instance. -/
def ModelInstance.get (inst : ModelInstance) (field : String) : Option Value :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def ModelInstance.get_postcond (inst : ModelInstance) (field : String) (result : Option Value) : Prop :=
  (∃ v, (field, v) ∈ inst.data ∧ result = some v) ∨
  (result = none ∧ ∀ v, (field, v) ∉ inst.data)


theorem ModelInstance.get_spec (inst : ModelInstance) (field : String) :
    ModelInstance.get_postcond inst field (inst.get field) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Pydantic
-- === END: FIXED_FINAL ===
