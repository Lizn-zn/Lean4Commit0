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

namespace PyJWT


def decode (token : String) (key : String)
    (options : DecodeOptions := {}) (now : Nat := 0)
    : Except JWTError Json :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end PyJWT
-- === END: FIXED_FINAL ===
