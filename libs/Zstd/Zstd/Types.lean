-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Zstd

structure Sequence where
  literals      : List UInt8
  literalLength : Nat
  matchLength   : Nat
  offset        : Nat
  deriving Repr, BEq


end Zstd
-- === END: FIXED_FINAL ===
