-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Stb

structure Color where
  r : UInt8
  g : UInt8
  b : UInt8
  a : UInt8 := 255
  deriving Repr, BEq


structure Image where
  width    : Nat
  height   : Nat
  channels : Nat
  data     : List UInt8
  deriving Repr, BEq


end Stb
-- === END: FIXED_FINAL ===
