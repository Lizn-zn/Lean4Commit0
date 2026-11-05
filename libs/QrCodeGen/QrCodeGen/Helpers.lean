-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import QrCodeGen.Types

namespace QrCodeGen


/-! ## Masking -/

/-- Apply mask formula i to position (r, c). Returns true if the module should be flipped. -/
def maskFormula (i : Nat) (r c : Nat) : Bool :=
  match i with
  | 0 => (r + c) % 2 == 0
  | 1 => r % 2 == 0
  | 2 => c % 3 == 0
  | 3 => (r + c) % 3 == 0
  | 4 => (r / 2 + c / 3) % 2 == 0
  | 5 => (r * c) % 2 + (r * c) % 3 == 0
  | 6 => ((r * c) % 2 + (r * c) % 3) % 2 == 0
  | 7 => ((r + c) % 2 + (r * c) % 3) % 2 == 0
  | _ => false

end QrCodeGen
-- === END: FIXED_FINAL ===
