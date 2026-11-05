-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Mathlib.Data.Nat.Prime.Defs
import MicroEcc.Types

namespace MicroEcc

def Point.Valid (curve : Curve) : Point → Prop
  | .infinity => True
  | .affine x y => x.val < curve.p ∧ y.val < curve.p ∧
      (y.val * y.val) % curve.p = (x.val*x.val*x.val + curve.a.val*x.val + curve.b.val) % curve.p

def Curve.Valid (curve : Curve) : Prop :=
  curve.p.Prime ∧ 3 < curve.p ∧ curve.n.Prime ∧ curve.n < 2^256 ∧
  curve.a.val < curve.p ∧ curve.b.val < curve.p ∧
  (4*curve.a.val^3 + 27*curve.b.val^2) % curve.p ≠ 0 ∧
  Point.Valid curve (.affine curve.gx curve.gy)

end MicroEcc
-- === END: FIXED_FINAL ===
