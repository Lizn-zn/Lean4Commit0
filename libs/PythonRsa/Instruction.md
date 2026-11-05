# PythonRsa

## Background

python-rsa is a pure Python RSA implementation providing key generation, encryption/decryption, and signing/verification following the PKCS#1 v1.5 standard. This spec covers the three core operations: generating an RSA key pair, encrypting a message, and signing a message, along with roundtrip properties proving that decrypt recovers plaintext and verify confirms signatures.

## Task

Complete implementation holes in explicitly editable regions in the `PythonRsa/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `newkeys`

- **Signature**: `def newkeys (keysize : Nat) (randFn : Nat → Nat) (exponent : Nat := 65537) : PublicKey × PrivateKey`
- **Description**: Generate an RSA key pair of the given bit size using the provided random function and public exponent.
- **Precondition**: `keysize ≥ 16`
- **Postcondition**: `newkeys_postcond` requires:
  - `sk.n = sk.p * sk.q` (modulus is product of two primes)
  - `pk.n = sk.n` and `pk.e = sk.e = exponent` (public key matches)
  - `(sk.e * sk.d) % Nat.lcm (sk.p - 1) (sk.q - 1) = 1` (RSA key equation)
  - `isPrime sk.p = true` and `isPrime sk.q = true` (factors are prime)
  - `sk.toPublicKey = pk` (consistency)
- **Key constraints**: The key equation uses `Nat.lcm` (not Euler's totient). The `randFn` provides randomness for prime generation.

### 2. `encrypt`

- **Signature**: `def encrypt (message : ByteArray) (pk : PublicKey) (randByteFn : Unit → UInt8) : Option ByteArray`
- **Description**: Encrypt a message using PKCS#1 v1.5 padding and RSA public key encryption.
- **Postcondition**: `encrypt_postcond` requires:
  - Message too large (`message.size > pk.bitSize / 8 - 11`) → `none`
  - Ciphertext size equals `(pk.n.log2 + 8) / 8` (key byte length)
  - Ciphertext size > 0
  - Ciphertext value (as big-endian integer) < `pk.n`
- **Key constraints**: PKCS#1 v1.5 requires at least 11 bytes of overhead (padding). The `randByteFn` provides random non-zero padding bytes.

### 3. `sign`

- **Signature**: `def sign (message : ByteArray) (sk : PrivateKey) (method : HashMethod) : Option ByteArray`
- **Description**: Sign a message by hashing it, PKCS#1 v1.5 padding the hash with a DER prefix, and applying the RSA private key operation.
- **Postcondition**: `sign_postcond` requires:
  - Key too small (`sk.n < 2 ^ 88`) → `none`
  - Signature size equals `(sk.n.log2 + 8) / 8`
  - Signature value (as big-endian integer) < `sk.n`
  - Signature size > 0
- **Key constraints**: The minimum key size of 2^88 ensures enough room for the hash + DER prefix + PKCS#1 padding.

## Relational Properties

- **`encrypt_decrypt_rel`**: Given a valid key pair (matching n/e, n = p*q, p and q prime, e*d ≡ 1 mod lcm(p-1,q-1)), if encryption succeeds producing ciphertext `ct`, then `decrypt ct sk = some message`. This is the fundamental RSA correctness property.
- **`sign_verify_rel`**: Given a valid key pair with the same conditions, if signing succeeds producing signature `sig`, then `verify message sig pk = some method`. This proves signature verification works.

## Types

- **`PublicKey`** — RSA public key: modulus `n` and public exponent `e`
- **`PrivateKey`** — RSA private key: modulus `n`, public exponent `e`, private exponent `d`, prime factors `p` and `q`
- **`HashMethod`** — Hash algorithm for signing: sha1, sha256, sha384, sha512

## Hints

- **`PrivateKey.toPublicKey`** is already implemented: `{ n := sk.n, e := sk.e }`.
- **`isPrime`** must be implemented — it's used in `newkeys_postcond` and both relational specs. For small numbers, trial division works. For larger numbers, Miller-Rabin with deterministic witnesses for numbers up to certain bounds.
- **`PublicKey.bitSize`** must be implemented — it computes the number of bits in `pk.n` (i.e., `⌊log₂(n)⌋ + 1`). Referenced by `encrypt_postcond`.
- **`decrypt`** and **`verify`** must be implemented for the relational proofs — they are the inverses of `encrypt` and `sign`. `decrypt` applies the private key operation and removes PKCS#1 padding. `verify` applies the public key operation, strips PKCS#1 padding, and compares the hash.
- **`computeHash`** must be implemented — `sign` internally hashes the message before padding and signing. SHA-256 is the most common choice.
- For `newkeys`, generate two primes p and q using `randFn`, compute n = p*q, compute d as the modular inverse of e modulo lcm(p-1, q-1).
- The RSA operation is modular exponentiation: `ciphertext = message^e mod n` for encryption, `plaintext = ciphertext^d mod n` for decryption.
- PKCS#1 v1.5 type 2 padding format: `[0x00, 0x02, <random non-zero bytes>, 0x00, <message>]`.
- PKCS#1 v1.5 type 1 padding for signing: `[0x00, 0x01, <0xFF bytes>, 0x00, <DER prefix>, <hash>]`.

## Edit Boundaries

`PythonRsa/*.lean` is divided into labeled sections:

```text
-- === BEGIN: SECTION_NAME (provided|editable) ===
...
-- === END: SECTION_NAME ===
```

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash and should remain unchanged.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `PythonRsa/Decrypt.lean`
- `PythonRsa/Encrypt.lean`
- `PythonRsa/Helpers.lean`
- `PythonRsa/NewKeys.lean`
- `PythonRsa/Relations.lean`
- `PythonRsa/Sign.lean`
- `PythonRsa/Types.lean`
- `PythonRsa/Verify.lean`
