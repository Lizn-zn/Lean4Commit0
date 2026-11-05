-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import WcWidth.Helpers

namespace WcWidth

def classify (c : Char) : CharWidth :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def classify_postcond (c : Char) (result : CharWidth) : Prop :=
  (c.val = 0 → result = .zero) ∧
  (c.val ≥ 0x01 ∧ c.val ≤ 0x1F → result = .control) ∧
  (c.val ≥ 0x7F ∧ c.val ≤ 0x9F → result = .control) ∧
  (c.val ≥ 0x20 ∧ c.val ≤ 0x7E → result = .narrow) ∧
  (c.val ≥ 0x4E00 ∧ c.val ≤ 0x9FFF → result = .wide) ∧
  (c.val ≥ 0xFF01 ∧ c.val ≤ 0xFF60 → result = .wide) ∧
  (c.val = 0x0300 → result = .zero) ∧
  (result = .control ∨ result = .zero ∨ result = .narrow ∨ result = .wide) ∧
  (c.val ≥ 0x0300 ∧ c.val ≤ 0x036F → result = .zero) ∧
  (c.val ≥ 0x3000 ∧ c.val ≤ 0x303F → result = .wide) ∧
  (c.val ≥ 0xAC00 ∧ c.val ≤ 0xD7A3 → result = .wide) ∧
  (c.val ≥ 0x3400 ∧ c.val ≤ 0x4DBF → result = .wide) ∧
  (c.val = 0x00AD → result = .zero) ∧
  (c.val = 0x200B → result = .zero) ∧
  (c.val ≥ 0xA0 ∧ c.val ≤ 0xFF ∧ c.val ≠ 0xAD → result = .narrow) ∧
  (c.val ≥ 0x1100 ∧ c.val ≤ 0x115F → result = .wide) ∧
  (c.val ≥ 0x2E80 ∧ c.val ≤ 0x2E99 → result = .wide) ∧
  (c.val ≥ 0x2E9B ∧ c.val ≤ 0x2EF3 → result = .wide) ∧
  (c.val ≥ 0x2F00 ∧ c.val ≤ 0x2FD5 → result = .wide) ∧
  (c.val ≥ 0x3041 ∧ c.val ≤ 0x3096 → result = .wide) ∧
  (c.val ≥ 0x309B ∧ c.val ≤ 0x30FF → result = .wide) ∧
  (c.val ≥ 0xF900 ∧ c.val ≤ 0xFAFF → result = .wide) ∧
  (c.val ≥ 0x0100 ∧ c.val ≤ 0x02FF → result = .narrow) ∧
  (c.val ≥ 0x0370 ∧ c.val ≤ 0x0482 → result = .narrow) ∧
  (c.val ≥ 0x048A ∧ c.val ≤ 0x04FF → result = .narrow)


theorem classify_spec (c : Char) :
    classify_postcond c (classify c) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/- Core Function 2: wcwidth. -/

end WcWidth
-- === END: FIXED_FINAL ===
