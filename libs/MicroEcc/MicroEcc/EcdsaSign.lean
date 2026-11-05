-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import MicroEcc.Validity
import Std
import Lean

import MicroEcc.PointAdd

namespace MicroEcc

def ecdsaSign (curve : Curve) (privKey : Nat) (msgHash : Nat) (k : Nat) :
    Option Signature :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def ecdsaSign_precond (curve : Curve) (privKey : Nat) (msgHash : Nat) (k : Nat) : Prop :=
  1 ≤ privKey ∧ privKey ≤ curve.n - 1 ∧ 1 ≤ k ∧ k ≤ curve.n - 1

@[reducible]
def ecdsaSign_postcond (curve : Curve) (privKey : Nat) (msgHash : Nat) (k : Nat)
    (result : Option Signature) : Prop :=
  (∀ sig, result = some sig → sig.r.val < curve.n ∧ sig.s.val < curve.n ∧
    sig.r.val > 0 ∧ sig.s.val > 0 ∧
    (sig.s.val * k) % curve.n = (msgHash + sig.r.val * privKey) % curve.n) ∧
  (let gPt := some (curve.gx.val, curve.gy.val)
   let rPt := pureScalarMul curve.p curve.a.val k gPt
   match rPt with
   | none => result = none
   | some (rx, _) =>
     let r := rx % curve.n
     if r = 0 then result = none
     else
       let k_inv := pureModInv k curve.n
       let s := (k_inv * (msgHash + r * privKey)) % curve.n
       if s = 0 then result = none
       else result = some ⟨⟨r⟩, ⟨s⟩⟩)

theorem ecdsaSign_spec (curve : Curve) (privKey : Nat) (msgHash : Nat) (k : Nat)
    (h : ecdsaSign_precond curve privKey msgHash k) 
    (hc : curve.Valid) :
    ecdsaSign_postcond curve privKey msgHash k (ecdsaSign curve privKey msgHash k) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MicroEcc
-- === END: FIXED_FINAL ===
