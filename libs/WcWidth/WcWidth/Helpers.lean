-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import WcWidth.Types

namespace WcWidth

def CharWidth.toInt : CharWidth → Int
  | .control => -1
  | .zero    => 0
  | .narrow  => 1
  | .wide    => 2

/-! ## Infrastructure: pure predicates -/

/- Pure predicate: is this a control character (width = -1)? -/

@[reducible]
def isControlChar (c : Char) : Bool :=
  (c.val ≥ 0x01 ∧ c.val ≤ 0x1F) ∨ (c.val ≥ 0x7F ∧ c.val ≤ 0x9F)

/- Pure predicate: is this an ASCII printable character (width = 1)? -/

@[reducible]
def isAsciiPrintable (c : Char) : Bool :=
  c.val ≥ 0x20 ∧ c.val ≤ 0x7E

/-! ## Core Function 1: classify -/

/- Classify a character into its width category. -/

end WcWidth
-- === END: FIXED_FINAL ===
