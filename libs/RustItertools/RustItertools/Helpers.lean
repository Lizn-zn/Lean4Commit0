-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace RustItertools

/-! ## Helpers -/

/-- Binomial coefficient. -/
def Nat.choose : Nat → Nat → Nat
  | _,     0     => 1
  | 0,     _+1   => 0
  | n+1,   k+1   => Nat.choose n k + Nat.choose n (k+1)

end RustItertools
-- === END: FIXED_FINAL ===
