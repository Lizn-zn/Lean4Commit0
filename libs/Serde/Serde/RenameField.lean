-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Serde.Helpers

namespace Serde

/-- Rename a field in a struct value. -/
def renameField (v : Value) (oldName newName : String) : Value :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def renameField_postcond (v : Value) (oldName newName : String) (result : Value) : Prop :=
  structGetField result newName = structGetField v oldName ∧
  (oldName ≠ newName → structGetField result oldName = none) ∧
  (∀ f : String, f ≠ oldName → f ≠ newName → structGetField result f = structGetField v f)

theorem renameField_spec (v : Value) (old new_ : String) :
    renameField_postcond v old new_ (renameField v old new_) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Serde
-- === END: FIXED_FINAL ===
