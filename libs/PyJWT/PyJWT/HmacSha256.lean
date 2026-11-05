-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import PyJWT.Types
import PyJWT.Helpers

namespace PyJWT


/-! ## Core Function 1: HMAC-SHA256 -/

def hmacSha256 (key : ByteArray) (message : ByteArray) : ByteArray :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def hmacSha256_postcond (key msg : ByteArray) (result : ByteArray) : Prop :=
  result.size = 32 ∧
  (key = hmac256_tv_key ∧ msg = hmac256_tv_msg → result = hmac256_tv_out) ∧
  (key = hmac256_tv2_key ∧ msg = hmac256_tv2_msg → result = hmac256_tv2_out)


theorem hmacSha256_spec (key msg : ByteArray) :
    hmacSha256_postcond key msg (hmacSha256 key msg) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end PyJWT
-- === END: FIXED_FINAL ===
