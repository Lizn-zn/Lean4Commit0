-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # MicroEcc
   Elliptic curve cryptography for embedded systems (ECDH and ECDSA).

   Ported from C's `micro-ecc` library.
   Original: https://github.com/kmackay/micro-ecc

   Summarized to 3 core functions: pointAdd, ecdsaSign, ecdsaVerify.
-/

namespace MicroEcc

structure FieldElement where
  val : Nat
  deriving Repr, BEq

inductive Point where
  | infinity : Point
  | affine : (x : FieldElement) → (y : FieldElement) → Point
  deriving Repr, BEq

structure Curve where
  p : Nat
  a : FieldElement
  b : FieldElement
  gx : FieldElement
  gy : FieldElement
  n : Nat
  h : Nat
  deriving Repr, BEq

structure Signature where
  r : FieldElement
  s : FieldElement
  deriving Repr, BEq

end MicroEcc
-- === END: FIXED_FINAL ===
