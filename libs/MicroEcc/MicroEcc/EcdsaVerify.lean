-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import MicroEcc.Validity
import Std
import Lean

import MicroEcc.EcdsaSign

namespace MicroEcc

def ecdsaVerify (curve : Curve) (pubKey : Point) (msgHash : Nat) (sig : Signature) : Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def ecdsaVerify_postcond (curve : Curve) (pubKey : Point) (msgHash : Nat) (sig : Signature)
    (result : Bool) : Prop :=
  (sig.r.val = 0 ∨ sig.s.val = 0 → result = false) ∧
  (sig.r.val ≥ curve.n ∨ sig.s.val ≥ curve.n → result = false) ∧
  (pubKey = .infinity → result = false) ∧
  (result = true → ∃ x y, pubKey = .affine x y ∧ x.val < curve.p ∧ y.val < curve.p) ∧
  (∀ px py, pubKey = .affine ⟨px⟩ ⟨py⟩ →
    sig.r.val > 0 → sig.s.val > 0 → sig.r.val < curve.n → sig.s.val < curve.n →
    let s_inv := pureModInv sig.s.val curve.n
    let u1 := (msgHash * s_inv) % curve.n
    let u2 := (sig.r.val * s_inv) % curve.n
    let gPt := some (curve.gx.val, curve.gy.val)
    let pubPt := some (px, py)
    let pt := purePointAdd curve.p curve.a.val
      (pureScalarMul curve.p curve.a.val u1 gPt)
      (pureScalarMul curve.p curve.a.val u2 pubPt)
    match pt with
    | none => result = false
    | some (rx, _) => result = (rx % curve.n == sig.r.val))

theorem ecdsaVerify_spec (curve : Curve) (pubKey : Point) (msgHash : Nat) (sig : Signature) 
    (hc : curve.Valid) :
    ecdsaVerify_postcond curve pubKey msgHash sig (ecdsaVerify curve pubKey msgHash sig) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MicroEcc
-- === END: FIXED_FINAL ===
