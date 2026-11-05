-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import PyJWT.Types
import PyJWT.Helpers
import PyJWT.HmacSha256

namespace PyJWT


/-! ## Core Function 2: Sign + Verify -/

def sign (algorithm : Algorithm) (key : ByteArray) (message : ByteArray)
    : ByteArray :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




def verifySignature (algorithm : Algorithm) (key : ByteArray)
    (message : ByteArray) (signature : ByteArray) : Bool :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===




@[reducible]
def sign_verify_postcond (alg : Algorithm) (key msg : ByteArray) (sig : ByteArray) (result : Bool) : Prop :=
  result = true ∧
  (alg = .HS256 → sig.size = 32) ∧
  (alg = .HS384 → sig.size = 48) ∧
  (alg = .HS512 → sig.size = 64) ∧
  (alg = .none_ → sig = ByteArray.empty) ∧
  (alg = .HS256 ∧ key = hmac256_tv_key ∧ msg = hmac256_tv_msg → sig = hmac256_tv_out) ∧
  (alg = .HS256 ∧ key = hmac256_tv2_key ∧ msg = hmac256_tv2_msg → sig = hmac256_tv2_out)


theorem sign_verify_spec (alg : Algorithm) (key msg : ByteArray) :
    sign_verify_postcond alg key msg (sign alg key msg) (verifySignature alg key msg (sign alg key msg)) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===




@[reducible]
def sign_none_postcond (key msg : ByteArray) (result : ByteArray) : Prop :=
  result = ByteArray.empty


theorem sign_none_spec (key msg : ByteArray) :
    sign_none_postcond key msg (sign .none_ key msg) := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end PyJWT
-- === END: FIXED_FINAL ===
