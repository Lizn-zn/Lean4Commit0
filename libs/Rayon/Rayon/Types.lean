-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Rayon


/-! ## Parallel Iterator -/

/-- A parallel iterator, modeled as a list for specification. -/
structure ParIter (α : Type) where
  data : List α
  deriving Repr

end Rayon
-- === END: FIXED_FINAL ===
