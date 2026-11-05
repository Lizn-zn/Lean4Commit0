-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import PromptToolkit.Types
import PromptToolkit.InsertText
import PromptToolkit.Backspace
import PromptToolkit.CompleteFromList

namespace PromptToolkit


/-! ## Relational: insert then backspace restores text -/

@[reducible]
def insert_backspace_rel (doc : Document) (c : Char) (result_text : String) : Prop :=
  result_text = doc.text


theorem insert_backspace_spec (doc : Document) (c : Char) :
    insert_backspace_rel doc c ((doc.insertText (String.singleton c)).backspace).text := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




/-! ## Relational: completion application grows text -/

@[reducible]
def completion_application_rel (doc : Document) (c : Completion) : Prop :=
  (c.startOffset ≤ 0 → (doc.insertText c.text).text.length = doc.text.length + c.text.length) ∧
  (doc.cursorPosition ≤ doc.text.length →
    (doc.insertText c.text).text = (doc.text.take doc.cursorPosition).toString ++ c.text ++ (doc.text.drop doc.cursorPosition).toString)


theorem completion_application_spec (doc : Document) (c : Completion) :
    completion_application_rel doc c := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end PromptToolkit
-- === END: FIXED_FINAL ===
