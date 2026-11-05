-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace JCTools
/-! ## Types -/
structure SpscQueue (α : Type) where
  buffer   : List α
  capacity : Nat
  deriving Repr
end JCTools
-- === END: FIXED_FINAL ===
