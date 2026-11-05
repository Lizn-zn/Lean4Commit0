-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Jinja.Types
import Jinja.Helpers
import Jinja.EvalExpr
import Jinja.RenderNode

namespace Jinja

/-! ## Core Function 3: escapeHtml -/
def escapeHtmlChar (c : Char) : String :=
  if c == '&' then "&amp;"
  else if c == '<' then "&lt;"
  else if c == '>' then "&gt;"
  else if c == '"' then "&quot;"
  else if c == '\'' then "&#39;"
  else c.toString

def escapeHtmlRef (s : String) : String :=
  String.join (s.toList.map escapeHtmlChar)

def escapeHtml (s : String) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def escapeHtml_postcond (s : String) (result : String) : Prop :=
  result = escapeHtmlRef s

theorem escapeHtml_spec (s : String) :
    escapeHtml_postcond s (escapeHtml s) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Jinja
-- === END: FIXED_FINAL ===
