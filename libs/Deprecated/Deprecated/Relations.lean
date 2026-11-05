-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Deprecated.Lookup
import Deprecated.Register

namespace Deprecated

/-! ## Relational: register then lookup -/

@[reducible]
def register_lookup_rel (reg : DeprecationRegistry) (name : String) (info : DeprecationInfo)
    (result : Option DeprecationInfo) : Prop :=
  result = some info

theorem register_lookup_spec (reg : DeprecationRegistry) (name : String) (info : DeprecationInfo) :
    register_lookup_rel reg name info ((reg.register name info).lookup name) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Deprecated
-- === END: FIXED_FINAL ===
