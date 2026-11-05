-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Deprecated.Types
import Deprecated.Helpers

namespace Deprecated

/-! ## isRemoved -/

/-- Check if a deprecated declaration should be treated as an error. -/
def isRemoved (info : DeprecationInfo) (currentVersion : VersionInfo) : Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def isRemoved_postcond (info : DeprecationInfo) (currentVersion : VersionInfo) (result : Bool) : Prop :=
  (info.removedIn = none → result = false) ∧
  (∀ rv, info.removedIn = some rv → VersionInfo.compare currentVersion rv = .lt → result = false) ∧
  (∀ rv, info.removedIn = some rv → VersionInfo.compare currentVersion rv ≠ .lt → result = true)

theorem isRemoved_spec (info : DeprecationInfo) (currentVersion : VersionInfo) :
    isRemoved_postcond info currentVersion (isRemoved info currentVersion) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Deprecated
-- === END: FIXED_FINAL ===
