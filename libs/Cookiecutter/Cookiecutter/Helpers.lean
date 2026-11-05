-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Cookiecutter.Types

namespace Cookiecutter

/-! ## Helpers -/

def VarValue.asString : VarValue → String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def VarValue.asString_postcond (v : VarValue) (result : String) : Prop :=
  (∀ s, v = .str s → result = s) ∧
  (∀ n, v = .int n → result = toString n) ∧
  (v = .bool true → result = "true") ∧
  (v = .bool false → result = "false") ∧
  (v = .null → result = "")

theorem VarValue.asString_spec (v : VarValue) :
    VarValue.asString_postcond v (VarValue.asString v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



def hasTemplateSyntax (s : String) : Bool :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def hasTemplateSyntax_postcond (s : String) (result : Bool) : Prop :=
  (Cookiecutter.containsSubstr s "{{" ∨ Cookiecutter.containsSubstr s "{%" → result = true) ∧
  (s = "" → result = false) ∧
  (¬(Cookiecutter.containsSubstr s "{{") → ¬(Cookiecutter.containsSubstr s "{%") → result = false)

theorem hasTemplateSyntax_spec (s : String) :
    hasTemplateSyntax_postcond s (hasTemplateSyntax s) := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



def renderTokens (tokens : List TemplateToken) : String :=
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===



@[reducible]
def renderTokens_postcond (tokens : List TemplateToken) (result : String) : Prop :=
  (tokens = [] → result = "") ∧
  (∀ s, tokens = [.literal s] → result = s) ∧
  (∀ v, tokens = [.variable v] → result = "{{" ++ v ++ "}}")

theorem renderTokens_spec (tokens : List TemplateToken) :
    renderTokens_postcond tokens (renderTokens tokens) := by
  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Cookiecutter
-- === END: FIXED_FINAL ===
