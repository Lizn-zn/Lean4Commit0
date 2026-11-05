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

namespace PyJWT


/-! ## Relational: JWT encode/decode roundtrip -/

def encode (payload : Json) (key : String) (algorithm : Algorithm := .HS256)
    (headers : List (String × Json) := []) : Except JWTError String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-- The supported HS256 mode must encode, rather than satisfy roundtrip vacuously by error. -/
theorem encode_success_spec (payload : Json) (key : String) :
    (encode payload key .HS256 []).isOk = true := by
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===


end PyJWT
-- === END: FIXED_FINAL ===
