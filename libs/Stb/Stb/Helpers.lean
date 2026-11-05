-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Stb.Types

namespace Stb

def listGetOpt (l : List UInt8) (i : Nat) : Option UInt8 := l[i]?


def pngSignature : List UInt8 := [137, 80, 78, 71, 13, 10, 26, 10]


def readBE32 (a b c d : UInt8) : Nat :=
  a.toNat * 256 * 256 * 256 + b.toNat * 256 * 256 + c.toNat * 256 + d.toNat


end Stb
-- === END: FIXED_FINAL ===
