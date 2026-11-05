-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import PyJWT.Types

namespace PyJWT


def Algorithm.name : Algorithm → String
  | .HS256 => "HS256"
  | .HS384 => "HS384"
  | .HS512 => "HS512"
  | .none_ => "none"


/-! ## HMAC Test Vectors -/

def hmac256_tv_key : ByteArray := ⟨#[74, 101, 102, 101]⟩

def hmac256_tv_msg : ByteArray := ⟨#[119, 104, 97, 116, 32, 100, 111, 32, 121, 97, 32, 119, 97, 110, 116, 32, 102, 111, 114, 32, 110, 111, 116, 104, 105, 110, 103, 63]⟩

def hmac256_tv_out : ByteArray := ⟨#[91, 220, 193, 70, 191, 96, 117, 78, 106, 4, 36, 38, 8, 149, 117, 199, 90, 0, 63, 8, 157, 39, 57, 131, 157, 236, 88, 185, 100, 236, 56, 67]⟩


def hmac256_tv2_key : ByteArray := ⟨#[115, 101, 99, 114, 101, 116]⟩

def hmac256_tv2_msg : ByteArray := ⟨#[104, 101, 108, 108, 111]⟩

def hmac256_tv2_out : ByteArray := ⟨#[136, 170, 179, 237, 232, 211, 173, 249, 77, 38, 171, 144, 211, 186, 253, 74, 32, 131, 7, 12, 59, 204, 233, 192, 20, 238, 4, 164, 67, 132, 124, 11]⟩

end PyJWT
-- === END: FIXED_FINAL ===
