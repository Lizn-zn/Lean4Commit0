-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Deprecated.Types

namespace Deprecated

/-- Register a deprecation. -/
def DeprecationRegistry.register (reg : DeprecationRegistry)
    (name : String) (info : DeprecationInfo) : DeprecationRegistry :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def DeprecationRegistry.register_postcond (reg : DeprecationRegistry)
    (name : String) (info : DeprecationInfo) (result : DeprecationRegistry) : Prop :=
  (name, info) ∈ result.entries ∧
  (∀ n i, (n, i) ∈ reg.entries → (n, i) ∈ result.entries) ∧
  result.entries.length = reg.entries.length + 1 ∧
  (∀ n i, (n, i) ∈ result.entries → (n, i) = (name, info) ∨ (n, i) ∈ reg.entries)

theorem DeprecationRegistry.register_spec (reg : DeprecationRegistry)
    (name : String) (info : DeprecationInfo) :
    DeprecationRegistry.register_postcond reg name info (reg.register name info) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Deprecated
-- === END: FIXED_FINAL ===
