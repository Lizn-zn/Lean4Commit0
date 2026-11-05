-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # Bytes
   Efficient byte buffer abstractions.

   Summarized from the full spec to 3 core functions: Bytes.splitAt, BytesMut.putU32Le, BufReader.getU8.
   Original: https://github.com/tokio-rs/bytes
-/

namespace Bytes

/-- An immutable byte sequence. -/
structure Bytes where
  data : List UInt8
  deriving Repr, BEq

/-- A mutable byte buffer with capacity. -/
structure BytesMut where
  data     : List UInt8
  capacity' : Nat
  deriving Repr, BEq

/-- Read state: a byte list with a position cursor. -/
structure BufReader where
  data : List UInt8
  pos  : Nat
  deriving Repr, BEq

end Bytes
-- === END: FIXED_FINAL ===
