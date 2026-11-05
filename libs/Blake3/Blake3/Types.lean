-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # Blake3
   The BLAKE3 cryptographic hash function.

   Ported from Rust's `blake3` crate.
   Original: https://github.com/BLAKE3-team/BLAKE3

   This is a summarized version containing only the 3 most essential
   function specs: hash, compress, and g.
-/

namespace Blake3

/-! ## Constants -/

/-- BLAKE3 output length in bytes. -/
def hashLen : Nat := 32

/-- BLAKE3 block length in bytes. -/
def blockLen : Nat := 64

/-- BLAKE3 chunk length in bytes. -/
def chunkLen : Nat := 1024

/-- The BLAKE3 initialization vector (first 8 words of fractional parts of square roots of primes). -/
def iv : List UInt32 :=
  [0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A,
   0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19]

/-- BLAKE3 message permutation schedule. -/
def msgSchedule : List (List Nat) :=
  [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],
   [2,6,3,10,7,0,4,13,1,11,12,5,9,14,15,8],
   [3,4,10,12,13,2,7,14,6,5,9,0,11,15,8,1],
   [10,7,12,9,14,3,13,15,4,0,11,2,5,8,1,6],
   [12,13,9,11,15,10,14,8,7,2,5,3,0,1,6,4],
   [9,14,11,5,8,12,15,1,13,3,0,10,2,6,4,7],
   [11,15,5,0,1,9,8,6,14,10,2,12,3,4,7,13]]

/-! ## Types -/

/-- A 32-byte hash output. -/
structure Hash where
  bytes : List UInt8
  deriving Repr, BEq

end Blake3
-- === END: FIXED_FINAL ===
