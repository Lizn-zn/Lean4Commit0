-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Cookiecutter.Types

namespace Cookiecutter

/-! ## Core Function 1: tokenizeTemplate -/

def tokenizeTemplate (template : String) : List TemplateToken :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def tokenizeTemplate_postcond (template : String) (result : List TemplateToken) : Prop :=
  (template = "" → result = []) ∧
  (template.length > 0 → result.length > 0) ∧
  (¬(Cookiecutter.containsSubstr template "{{") → ¬(Cookiecutter.containsSubstr template "{%") →
    ¬(Cookiecutter.containsSubstr template "{#") → template ≠ "" →
    result = [TemplateToken.literal template]) ∧
  (Cookiecutter.containsSubstr template "{{" → Cookiecutter.containsSubstr template "}}" →
    result ≠ [TemplateToken.literal template]) ∧
  (Cookiecutter.containsSubstr template "{%" → Cookiecutter.containsSubstr template "%}" →
    result ≠ [TemplateToken.literal template])

theorem tokenizeTemplate_spec (template : String) :
    tokenizeTemplate_postcond template (tokenizeTemplate template) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Cookiecutter
-- === END: FIXED_FINAL ===
