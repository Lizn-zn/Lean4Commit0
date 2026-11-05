-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Sphinx.Types

namespace Sphinx

/-! ## Parse Inline Markup -/

def parseInline (line : String) : List InlineNode :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def parseInline_postcond (line : String) (result : List InlineNode) : Prop :=
  (line = "" → result = []) ∧
  (¬ line.isEmpty →
    (∀ c ∈ line.toList, c ≠ '*' ∧ c ≠ '`' ∧ c ≠ '|' ∧ c ≠ '_') →
    result = [InlineNode.text line]) ∧
  (¬ line.isEmpty → result ≠ []) ∧
  (∀ s, line = "*" ++ s ++ "*" → ¬ s.isEmpty → ¬ s.any (· == '*') →
    result.any (fun n => match n with | .emphasis t => t = s | _ => false) = true) ∧
  (∀ s, line = "**" ++ s ++ "**" → ¬ s.isEmpty → ¬ s.any (· == '*') →
    result.any (fun n => match n with | .strong t => t = s | _ => false) = true) ∧
  (∀ s, line = "``" ++ s ++ "``" → ¬ s.isEmpty → ¬ s.any (· == '`') →
    result.any (fun n => match n with | .literal t => t = s | _ => false) = true)

theorem parseInline_spec (line : String) :
    parseInline_postcond line (parseInline line) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Sphinx
-- === END: FIXED_FINAL ===
