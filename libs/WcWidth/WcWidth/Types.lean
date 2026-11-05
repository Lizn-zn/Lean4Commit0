-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace WcWidth

inductive CharWidth where
  | control    : CharWidth
  | zero       : CharWidth
  | narrow     : CharWidth
  | wide       : CharWidth
  deriving Repr, BEq, DecidableEq

/- Convert CharWidth to its integer width value. -/

end WcWidth
-- === END: FIXED_FINAL ===
