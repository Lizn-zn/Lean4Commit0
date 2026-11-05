-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import PromptToolkit.Types
import PromptToolkit.InsertText

namespace PromptToolkit


/-! ## Document.backspace -/

/-- Delete the character before the cursor (backspace). -/
def Document.backspace (doc : Document) : Document :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def Document.backspace_postcond (doc : Document) (result : Document) : Prop :=
  (doc.cursorPosition > 0 ∧ doc.cursorPosition ≤ doc.text.length →
    result.text.length = doc.text.length - 1 ∧
    result.text = (doc.text.take (doc.cursorPosition - 1)).toString ++ (doc.text.drop doc.cursorPosition).toString ∧
    result.cursorPosition = doc.cursorPosition - 1) ∧
  (doc.cursorPosition = 0 → result = doc)


theorem Document.backspace_spec (doc : Document) :
    Document.backspace_postcond doc (doc.backspace) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end PromptToolkit
-- === END: FIXED_FINAL ===
