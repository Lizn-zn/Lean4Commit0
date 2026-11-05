# PyJWT

## Background

PyJWT is a Python library for encoding, decoding, and verifying JSON Web Tokens (JWT) following RFC 7519. JWTs are signed tokens used for authentication and data exchange. The signing process involves HMAC-SHA algorithms applied to base64url-encoded header and payload segments. This spec covers the three foundational layers: HMAC cryptography, signing/verification, and base64url encoding, plus the end-to-end JWT roundtrip property.

## Task

Complete implementation holes in explicitly editable regions in the `PyJWT/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `hmacSha256`

- **Signature**: `def hmacSha256 (key : ByteArray) (message : ByteArray) : ByteArray`
- **Description**: Compute the HMAC-SHA256 of a message with a given key, producing a 32-byte authentication code.
- **Postcondition**: `hmacSha256_postcond` requires:
  - Output is exactly 32 bytes (`result.size = 32`)
  - RFC 4231 Test Case 2: key="Jefe", msg="what do ya want for nothing?" produces the known output
  - Test vector 2: key="secret", msg="hello" produces the known output
- **Key constraints**: Must implement the full HMAC-SHA256 algorithm (HMAC as defined in RFC 2104 using SHA-256). The test vectors are provided as byte arrays in the spec.

### 2. `sign` + `verifySignature`

- **Signature**: `def sign (algorithm : Algorithm) (key : ByteArray) (message : ByteArray) : ByteArray`
- **Signature**: `def verifySignature (algorithm : Algorithm) (key : ByteArray) (message : ByteArray) (signature : ByteArray) : Bool`
- **Description**: `sign` produces a cryptographic signature of the message; `verifySignature` checks if a signature is valid.
- **Postcondition**: `sign_verify_postcond` (combined) requires:
  - `verifySignature alg key msg (sign alg key msg) = true` (roundtrip)
  - HS256 signatures are 32 bytes, HS384 are 48 bytes, HS512 are 64 bytes
  - `none_` algorithm produces an empty signature
  - HS256 with test vector inputs produces the correct HMAC output
- **Additional**: `sign_none_postcond` requires `sign .none_ key msg = ByteArray.empty`
- **Key constraints**: `sign` should delegate to the appropriate HMAC function based on the algorithm. `verifySignature` should recompute the signature and compare.

### 3. `base64UrlEncode` + `base64UrlDecode`

- **Signature**: `def base64UrlEncode (data : ByteArray) : String`
- **Signature**: `def base64UrlDecode (s : String) : Option ByteArray`
- **Description**: URL-safe base64 encoding/decoding without padding, as used in JWT (RFC 4648 §5).
- **Postcondition**: `base64url_roundtrip_postcond` requires:
  - `base64UrlDecode (base64UrlEncode data) = some data` (perfect roundtrip)
- **Postcondition**: `base64url_format_postcond` requires:
  - Output contains only URL-safe characters: no `+`, `/`, or `=`
  - "Hello" (bytes [72,101,108,108,111]) encodes to `"SGVsbG8"`
  - Bytes [0,255,128,63,62] encode to `"AP-APz4"`
- **Key constraints**: Standard base64 uses `+` and `/`; base64url replaces them with `-` and `_`. No padding (`=`) characters. `base64UrlDecode` returns `none` for invalid input.

## Relational Properties

- **`jwt_roundtrip_rel`**: If `encode payload key alg headers` succeeds, then there exists a token such that `decode token key opts = .ok payload` (with signature verification enabled, time checks disabled). This is the fundamental JWT correctness property — encode then decode recovers the original payload.

## Types

- **`Json`** — A JSON value: null, bool, int, float, str, array, or object (key-value list)
- **`Algorithm`** — JWT signing algorithm: HS256, HS384, HS512, or none_
- **`JWTError`** — Error variants: invalidToken, decodeError, invalidSignature, expiredSignature, etc.
- **`DecodeOptions`** — Decode configuration: signature verification, expiration/nbf checks, required claims, allowed algorithms

## Hints

- For `hmacSha256`, implement the HMAC construction: `HMAC(K, m) = H((K' ⊕ opad) || H((K' ⊕ ipad) || m))` where H is SHA-256, K' is the key padded/hashed to block size (64 bytes), ipad = 0x36 repeated, opad = 0x5C repeated.
- For `sign`, dispatch on the algorithm: HS256 → `hmacSha256`, HS384/HS512 → corresponding HMAC (you'll need to implement SHA-384/512 internally even though their standalone postconds were removed), none_ → empty.
- For `verifySignature`, compute `sign alg key msg` and compare with the provided signature.
- For `base64UrlEncode`, implement standard base64 encoding, then replace `+` with `-`, `/` with `_`, and strip `=` padding.
- For `base64UrlDecode`, reverse the process: add padding, replace `-`/`_` back, then decode standard base64.
- `encode` and `decode` are included for the relational spec but have no standalone postconditions — implement them to create/parse the standard JWT format: `base64url(header).base64url(payload).base64url(signature)`.
- The HMAC test vectors use the same key/msg constants (`hmac256_tv_key`, etc.) — these are defined as concrete `ByteArray` literals in the spec.

## Edit Boundaries

`PyJWT/*.lean` is divided into labeled sections:

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

## Revised release contract (v3)

Every template placeholder is now an explicit editable obligation, including the former provided/unmarked holes. All types, declaration headers, predicates and non-hole support source are protected. Read the validity assumptions in the theorem statements; they are part of this revised task, not the historical experiment. The optional PROOF_IMPORTS regions permit only Mathlib, Batteries, Std or Lean imports. Use local helper definitions inside implementation/proof bodies when needed.

The default root checker reconstructs an authenticated fresh task tree, builds it, checks required declarations and exact trusted types, and audits transitive axioms of all task-module declarations. A compiling template with sorry is not solved. The verdict concerns the published simplified Lean model. All original paper results remain associated with the preserved experiment version.

Current task modules (relative to this library directory):

- `PyJWT/Base64Url.lean`
- `PyJWT/Decode.lean`
- `PyJWT/Encode.lean`
- `PyJWT/Helpers.lean`
- `PyJWT/HmacSha256.lean`
- `PyJWT/Relations.lean`
- `PyJWT/SignVerify.lean`
- `PyJWT/Types.lean`
