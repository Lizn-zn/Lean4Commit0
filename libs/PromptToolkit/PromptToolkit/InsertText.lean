-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import PromptToolkit.Types

namespace PromptToolkit


/-! ## Document.insertText -/

/-- Insert text at the cursor position. -/
def Document.insertText (doc : Document) (text : String) : Document :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def Document.insertText_postcond (doc : Document) (text : String) (result : Document) : Prop :=
  result.text.length = doc.text.length + text.length ∧
  (text = "" → result.text = doc.text) ∧
  (doc.cursorPosition ≤ doc.text.length →
    result.cursorPosition = doc.cursorPosition + text.length) ∧
  (doc.cursorPosition ≤ doc.text.length →
    result.text = (doc.text.take doc.cursorPosition).toString ++ text ++ (doc.text.drop doc.cursorPosition).toString)


theorem Document.insertText_spec (doc : Document) (text : String) :
    Document.insertText_postcond doc text (doc.insertText text) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end PromptToolkit
-- === END: FIXED_FINAL ===
