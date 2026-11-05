-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Deprecated.Types

namespace Deprecated

/-! ## Version Comparison -/

/-- Compare two versions, returning an `Ordering`. -/
def VersionInfo.compare (v1 v2 : VersionInfo) : Ordering :=
  Ord.compare v1 v2

end Deprecated
-- === END: FIXED_FINAL ===
