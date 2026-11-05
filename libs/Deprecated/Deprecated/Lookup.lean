-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Deprecated.Types

namespace Deprecated

/-! ## Deprecation Registry -/

/-- Look up deprecation info for a declaration. -/
def DeprecationRegistry.lookup (reg : DeprecationRegistry) (name : String)
    : Option DeprecationInfo :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def DeprecationRegistry.lookup_postcond (reg : DeprecationRegistry) (name : String)
    (result : Option DeprecationInfo) : Prop :=
  (reg.entries = [] → result = none) ∧
  (∀ info, result = some info → (name, info) ∈ reg.entries) ∧
  ((∀ info, (name, info) ∉ reg.entries) → result = none) ∧
  ((∃ info, (name, info) ∈ reg.entries) → result.isSome = true)

theorem DeprecationRegistry.lookup_spec (reg : DeprecationRegistry) (name : String) :
    DeprecationRegistry.lookup_postcond reg name (reg.lookup name) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Deprecated
-- === END: FIXED_FINAL ===
