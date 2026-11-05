-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Utf8Proc.Types

namespace Utf8Proc

def charCategory (c : Char) : Category :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def charCategory_postcond (c : Char) (result : Category) : Prop :=
  (c.val ≥ 0x41 ∧ c.val ≤ 0x5A → result = .Lu) ∧
  (c.val ≥ 0x61 ∧ c.val ≤ 0x7A → result = .Ll) ∧
  (c.val ≥ 0x30 ∧ c.val ≤ 0x39 → result = .Nd) ∧
  (c.val = 0x20 → result = .Zs) ∧
  (c.val ≤ 0x1F → result = .Cc) ∧
  (c.val = 0x7F → result = .Cc) ∧
  (c.val ≥ 0xC0 ∧ c.val ≤ 0xD6 → result = .Lu) ∧
  (c.val ≥ 0xD8 ∧ c.val ≤ 0xDE → result = .Lu) ∧
  (c.val = 0xD7 → result = .Sm) ∧
  (c.val = 0xF7 → result = .Sm) ∧
  (c.val ≥ 0xE0 ∧ c.val ≤ 0xF6 → result = .Ll) ∧
  (c.val ≥ 0xF8 ∧ c.val ≤ 0xFE → result = .Ll) ∧
  (c.val ≥ 0x0391 ∧ c.val ≤ 0x03A1 → result = .Lu) ∧
  (c.val ≥ 0x03A3 ∧ c.val ≤ 0x03A9 → result = .Lu) ∧
  (c.val ≥ 0x03B1 ∧ c.val ≤ 0x03C9 → result = .Ll) ∧
  (c.val ≥ 0x0410 ∧ c.val ≤ 0x042F → result = .Lu) ∧
  (c.val ≥ 0x0430 ∧ c.val ≤ 0x044F → result = .Ll) ∧
  (c.val ≥ 0x0300 ∧ c.val ≤ 0x036F → result = .Mn) ∧
  (c.val = 0x20AC → result = .Sc) ∧
  (c.val ≥ 0x4E00 ∧ c.val ≤ 0x9FFF → result = .Lo) ∧
  (c.val ≥ 0x05D0 ∧ c.val ≤ 0x05EA → result = .Lo) ∧
  (c.val = 0x21 ∨ c.val = 0x2C ∨ c.val = 0x2E ∨ c.val = 0x3A ∨
   c.val = 0x3B ∨ c.val = 0x3F → result = .Po) ∧
  (c.val = 0x28 ∨ c.val = 0x5B ∨ c.val = 0x7B → result = .Ps) ∧
  (c.val = 0x29 ∨ c.val = 0x5D ∨ c.val = 0x7D → result = .Pe) ∧
  (c.val = 0x5F → result = .Pc) ∧
  (c.val = 0x2B ∨ c.val = 0x3C ∨ c.val = 0x3D ∨ c.val = 0x3E ∨
   c.val = 0x7C ∨ c.val = 0x7E → result = .Sm) ∧
  (c.val = 0x24 → result = .Sc) ∧
  (c.val = 0xA0 → result = .Zs) ∧
  (c.val = 0xAD → result = .Cf) ∧
  (c.val = 0xFF → result = .Ll) ∧
  (c.val ≥ 0x0621 ∧ c.val ≤ 0x063A → result = .Lo) ∧
  (c.val ≥ 0x0641 ∧ c.val ≤ 0x064A → result = .Lo) ∧
  (c.val ≥ 0xAC00 ∧ c.val ≤ 0xD7A3 → result = .Lo) ∧
  (c.val ≥ 0x0904 ∧ c.val ≤ 0x0939 → result = .Lo) ∧
  (c.val ≥ 0x0E01 ∧ c.val ≤ 0x0E2E → result = .Lo)


theorem charCategory_spec (c : Char) :
    charCategory_postcond c (charCategory c) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/-! ## normalize -/


end Utf8Proc
-- === END: FIXED_FINAL ===
