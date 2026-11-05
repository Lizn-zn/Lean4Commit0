-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Deprecated

/-! ## Types -/

/-- Reason for deprecation. -/
inductive DeprecatedAction where
  | warning  : DeprecatedAction
  | error    : DeprecatedAction
  deriving Repr, BEq, DecidableEq

/-- Version information for when something was deprecated. -/
structure VersionInfo where
  major : Nat
  minor : Nat
  patch : Nat
  deriving Repr, BEq, Ord

instance : ToString VersionInfo where
  toString v := s!"{v.major}.{v.minor}.{v.patch}"

/-- Deprecation metadata for a declaration. -/
structure DeprecationInfo where
  reason : String
  since : Option VersionInfo := none
  removedIn : Option VersionInfo := none
  replacement : Option String := none
  action : DeprecatedAction := .warning
  deriving Repr, BEq

/-- A registry tracking all deprecated declarations. -/
structure DeprecationRegistry where
  entries : List (String × DeprecationInfo)
  deriving Repr

end Deprecated
-- === END: FIXED_FINAL ===
