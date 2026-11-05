-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import MicroEcc.Validity
import Std
import Lean

import MicroEcc.Helpers

namespace MicroEcc

def pointAdd (curve : Curve) (p1 p2 : Point) : Point :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def pointAdd_postcond (curve : Curve) (p1 p2 : Point) (result : Point) : Prop :=
  (p1 = .infinity → result = p2) ∧
  (p2 = .infinity → result = p1) ∧
  (∀ x y, p1 = .affine x y → p2 = .affine x ⟨(curve.p - y.val) % curve.p⟩ →
    result = .infinity) ∧
  (∀ rx ry, result = .affine rx ry → rx.val < curve.p ∧ ry.val < curve.p) ∧
  (∀ x1 y1 x2 y2 rx ry, p1 = .affine x1 y1 → p2 = .affine x2 y2 →
    result = .affine rx ry → x1.val ≠ x2.val →
    let dx := (x2.val + curve.p - x1.val) % curve.p
    let dy := (y2.val + curve.p - y1.val) % curve.p
    (dy * dy) % curve.p = ((rx.val + x1.val + x2.val) % curve.p * (dx * dx % curve.p)) % curve.p ∧
    ((ry.val + y1.val) % curve.p * dx) % curve.p = (dy * ((x1.val + curve.p - rx.val) % curve.p)) % curve.p) ∧
  (∀ x1 y1 rx ry, p1 = .affine x1 y1 → p2 = .affine x1 y1 →
    result = .affine rx ry → y1.val % curve.p ≠ 0 →
    let num := (3 * x1.val * x1.val + curve.a.val) % curve.p
    let den := (2 * y1.val) % curve.p
    (num * num) % curve.p = ((rx.val + 2 * x1.val) % curve.p * (den * den % curve.p)) % curve.p ∧
    ((ry.val + y1.val) % curve.p * den) % curve.p = (num * ((x1.val + curve.p - rx.val) % curve.p)) % curve.p)

theorem pointAdd_spec (curve : Curve) (p1 p2 : Point) 
    (hc : curve.Valid) (hp : p1.Valid curve) (hq : p2.Valid curve) :
    pointAdd_postcond curve p1 p2 (pointAdd curve p1 p2) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MicroEcc
-- === END: FIXED_FINAL ===
