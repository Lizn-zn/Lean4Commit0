-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Lz4
/-! ## Types -/
structure Token where
  literalLength : Nat
  literals      : List UInt8
  matchOffset   : Nat
  matchLength   : Nat
  deriving Repr, BEq
/-- An LZ4 compressed block: a sequence of tokens. -/
structure Block where
  tokens : List Token
  deriving Repr, BEq
end Lz4
-- === END: FIXED_FINAL ===
