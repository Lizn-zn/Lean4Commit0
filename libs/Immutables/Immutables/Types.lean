-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Immutables

/-! ## Types -/

structure ImmutableList (α : Type) where
  data : List α
  deriving Repr, BEq

structure ImmutableMap (α β : Type) [BEq α] where
  data : List (α × β)
  deriving Repr

structure ImmutableSet (α : Type) [BEq α] where
  data : List α
  deriving Repr


end Immutables
-- === END: FIXED_FINAL ===
