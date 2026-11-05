-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Sphinx.Types

namespace Sphinx

/-! ## Parse RST -/

def parseRst (source : String) : RstNode :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def parseRst_postcond (source : String) (result : RstNode) : Prop :=
  (∃ children, result = RstNode.document children) ∧
  (source = "" → result = RstNode.document []) ∧
  (¬ source.isEmpty → source.any (fun c => c ≠ '\n' ∧ c ≠ ' ') →
    ∃ children, result = RstNode.document children ∧ children ≠ []) ∧
  (∀ children, result = RstNode.document children →
    ∀ c ∈ children, match c with | .document _ => False | _ => True) ∧
  (¬ source.contains '\n' →
    match source.toList with
    | c :: _ => c.isAlpha →
      ∃ children, result = RstNode.document children ∧
        children.any (fun ch => match ch with | .paragraph _ => True | _ => False)
    | [] => True) ∧
  (¬ source.contains '\n' →
    match source.toList with
    | c :: _ => c.isAlpha →
      ¬ source.any (fun c => c = '*' ∨ c = '`' ∨ c = '|') →
      result = RstNode.document [RstNode.paragraph [InlineNode.text source]]
    | [] => True)

theorem parseRst_spec (source : String) :
    parseRst_postcond source (parseRst source) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Sphinx
-- === END: FIXED_FINAL ===
