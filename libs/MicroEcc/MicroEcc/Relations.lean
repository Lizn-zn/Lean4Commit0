-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import MicroEcc.Validity
import Std
import Lean

import MicroEcc.EcdsaVerify

namespace MicroEcc

@[reducible]
def pointAdd_comm_rel (curve : Curve) (p1 p2 : Point) (r1 r2 : Point) : Prop :=
  r1 = r2

theorem pointAdd_comm_spec (curve : Curve) (p1 p2 : Point) 
    (hc : curve.Valid) (hp : p1.Valid curve) (hq : p2.Valid curve) :
    pointAdd_comm_rel curve p1 p2 (pointAdd curve p1 p2) (pointAdd curve p2 p1) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def verify_after_sign_rel (curve : Curve) (privKey : Nat) (msgHash : Nat) (k : Nat)
    (signResult : Option Signature) (verifyResult : Bool) : Prop :=
  ∀ sig, signResult = some sig → verifyResult = true

theorem verify_after_sign_spec (curve : Curve) (privKey : Nat) (msgHash : Nat) (k : Nat) 
    (hc : curve.Valid) 
    (hinput : ecdsaSign_precond curve privKey msgHash k)
    (horder : pureScalarMul curve.p curve.a.val curve.n (some (curve.gx.val, curve.gy.val)) = none) :
    verify_after_sign_rel curve privKey msgHash k
      (ecdsaSign curve privKey msgHash k)
      (match ecdsaSign curve privKey msgHash k with
       | some sig => ecdsaVerify curve (publicKeyFromPrivate curve privKey) msgHash sig
       | none => false) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MicroEcc
-- === END: FIXED_FINAL ===
