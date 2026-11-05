-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import PythonRsa.Types
import PythonRsa.Helpers
import PythonRsa.NewKeys
import PythonRsa.Encrypt
import PythonRsa.Decrypt
import PythonRsa.Sign
import PythonRsa.Verify

namespace PythonRsa


/-! ## Relational: encrypt / decrypt roundtrip -/

@[reducible]
def encrypt_decrypt_rel (message : ByteArray) (pk : PublicKey) (sk : PrivateKey)
    (ct : ByteArray) (enc_result : Option ByteArray) (dec_result : Option ByteArray) : Prop :=
  pk.n = sk.n ∧ pk.e = sk.e →
  sk.n = sk.p * sk.q →
  isPrime sk.p = true → isPrime sk.q = true →
  (sk.e * sk.d) % Nat.lcm (sk.p - 1) (sk.q - 1) = 1 →
  enc_result = some ct →
  dec_result = some message


theorem encrypt_decrypt_spec (message : ByteArray) (pk : PublicKey) (sk : PrivateKey)
    (randByteFn : Unit → UInt8)
    (hkeys : pk.n = sk.n ∧ pk.e = sk.e)
    (hn : sk.n = sk.p * sk.q)
    (hprime_p : isPrime sk.p = true) (hprime_q : isPrime sk.q = true)
    (hed : (sk.e * sk.d) % Nat.lcm (sk.p - 1) (sk.q - 1) = 1)
    (ct : ByteArray)
    (henc : encrypt message pk randByteFn = some ct) :
    encrypt_decrypt_rel message pk sk ct
      (encrypt message pk randByteFn) (decrypt ct sk) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




/-! ## Relational: sign / verify roundtrip -/

@[reducible]
def sign_verify_rel (message : ByteArray) (pk : PublicKey) (sk : PrivateKey)
    (method : HashMethod) (sig : ByteArray)
    (sign_result : Option ByteArray) (verify_result : Option HashMethod) : Prop :=
  pk.n = sk.n ∧ pk.e = sk.e →
  sk.n = sk.p * sk.q →
  isPrime sk.p = true → isPrime sk.q = true →
  (sk.e * sk.d) % Nat.lcm (sk.p - 1) (sk.q - 1) = 1 →
  sign_result = some sig →
  verify_result = some method


theorem sign_verify_spec (message : ByteArray) (pk : PublicKey) (sk : PrivateKey)
    (method : HashMethod)
    (hkeys : pk.n = sk.n ∧ pk.e = sk.e)
    (hn : sk.n = sk.p * sk.q)
    (hprime_p : isPrime sk.p = true) (hprime_q : isPrime sk.q = true)
    (hed : (sk.e * sk.d) % Nat.lcm (sk.p - 1) (sk.q - 1) = 1)
    (sig : ByteArray)
    (hsign : sign message sk method = some sig) :
    sign_verify_rel message pk sk method sig
      (sign message sk method) (verify message sig pk) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end PythonRsa
-- === END: FIXED_FINAL ===
