-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import MicroEcc.Validity
import Std
import Lean

import MicroEcc.Types

namespace MicroEcc

@[reducible]
def pureModInv (a p : Nat) : Nat :=
  if p ≤ 2 then 0 else (Nat.pow a (p - 2)) % p

@[reducible]
def purePointAdd (p a : Nat) (pt1 pt2 : Option (Nat × Nat)) : Option (Nat × Nat) :=
  match pt1, pt2 with
  | none, _ => pt2
  | _, none => pt1
  | some (x1, y1), some (x2, y2) =>
    if x1 == x2 && (y1 + y2) % p == 0 then none
    else
      let lam :=
        if x1 == x2 then
          ((3 * x1 * x1 + a) * pureModInv ((2 * y1) % p) p) % p
        else
          (((y2 + p - y1) % p) * pureModInv ((x2 + p - x1) % p) p) % p
      let x3 := (lam * lam + p + p - x1 - x2) % p
      let y3 := (lam * ((x1 + p - x3) % p) + p - y1) % p
      some (x3, y3)

def pureScalarMul (p a : Nat) (k : Nat) (pt : Option (Nat × Nat)) : Option (Nat × Nat) :=
  if k == 0 then none
  else
    let rec go (k : Nat) (acc addend : Option (Nat × Nat)) (fuel : Nat) : Option (Nat × Nat) :=
      match fuel with
      | 0 => acc
      | fuel' + 1 =>
        if k == 0 then acc
        else
          let acc' := if k % 2 == 1 then purePointAdd p a acc addend else acc
          go (k / 2) acc' (purePointAdd p a addend addend) fuel'
    go k none pt 256

def scalarMul (curve : Curve) (k : Nat) (pt : Point) : Point :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



def publicKeyFromPrivate (curve : Curve) (privKey : Nat) : Point :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def publicKeyFromPrivate_rel (curve : Curve) (privKey : Nat) (result : Point) : Prop :=
  result = scalarMul curve privKey (.affine ⟨curve.gx.val⟩ ⟨curve.gy.val⟩)

theorem publicKeyFromPrivate_spec (curve : Curve) (privKey : Nat)
    (h : 1 ≤ privKey ∧ privKey ≤ curve.n - 1) 
    (hc : curve.Valid) :
    publicKeyFromPrivate_rel curve privKey (publicKeyFromPrivate curve privKey) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MicroEcc
-- === END: FIXED_FINAL ===
