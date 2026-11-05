-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import PyJWT.Types
import PyJWT.Helpers
import PyJWT.HmacSha256
import PyJWT.SignVerify
import PyJWT.Base64Url
import PyJWT.Encode
import PyJWT.Decode

namespace PyJWT


@[reducible]
def jwt_roundtrip_rel (payload : Json) (key : String) (alg : Algorithm)
    (headers : List (String × Json))
    (enc_result : Except JWTError String) (dec_result : Except JWTError Json) : Prop :=
  enc_result.isOk →
  ∃ token, enc_result = .ok token ∧ dec_result = .ok payload


theorem jwt_roundtrip_spec (payload : Json) (key : String)
    (alg : Algorithm) (headers : List (String × Json))
    (henc : (encode payload key alg headers).isOk) :
    ∃ token, encode payload key alg headers = .ok token ∧
    decode token key { verifySig := true, verifyExp := false,
                       verifyNbf := false, algorithms := [alg] } = .ok payload := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end PyJWT
-- === END: FIXED_FINAL ===
