-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Seaborn

/-! ## Types -/

/-- A histogram bin: [lo, hi) with a count. -/
structure Bin where
  lo : Float
  hi : Float
  count : Nat
  deriving Repr, Inhabited

/-- Result of a linear regression fit. -/
structure LinearRegressionResult where
  slope : Float
  intercept : Float
  rSquared : Float
  deriving Repr

end Seaborn
-- === END: FIXED_FINAL ===
