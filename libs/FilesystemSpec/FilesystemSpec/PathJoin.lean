-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import FilesystemSpec.Types
import FilesystemSpec.Helpers

namespace FilesystemSpec

/-! ## Core Function 1: pathJoin -/

def pathJoin (base : String) (child : String) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def pathJoin_postcond (base : String) (child : String) (result : String) : Prop :=
  (child.front = '/' → result = child) ∧
  (base = "" → result = child) ∧
  (base ≠ "" → child = "" → result = base) ∧
  (base ≠ "" → child ≠ "" → child.front ≠ '/' →
    (base.back = '/' → result = base ++ child) ∧
    (base.back ≠ '/' → result = base ++ "/" ++ child))

theorem pathJoin_spec (base : String) (child : String) :
    pathJoin_postcond base child (pathJoin base child) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end FilesystemSpec
-- === END: FIXED_FINAL ===
