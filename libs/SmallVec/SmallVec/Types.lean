-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # SmallVec
   Stack-optimized small vector.

   Summarized from the full spec to 3 core functions: push, insert, drain.
   Original: https://github.com/servo/rust-smallvec
-/

namespace SmallVec

/-! ## Types -/

/-- A small vector with inline capacity `n`. Modeled as a plain list. -/
structure SmallVec (α : Type) where
  data       : List α
  inlineCap  : Nat
  deriving Repr

end SmallVec
-- === END: FIXED_FINAL ===
