-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Tornado.Types
import Tornado.Helpers

namespace Tornado

def renderTemplate (templateStr : String) (ctx : TemplateContext) : String :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def renderTemplate_postcond (templateStr : String) (ctx : TemplateContext) (result : String) : Prop :=
  (templateStr.splitOn "{{" = [templateStr] → result = templateStr) ∧
  (∀ name value, ctx.get name = some (.str value) →
    templateStr = "{{" ++ name ++ "}}" → result = value) ∧
  (∀ name value, ctx.get name = some (.str value) →
    Tornado.containsSubstr templateStr ("{{" ++ name ++ "}}") →
    ¬ Tornado.containsSubstr value "{{" →
    Tornado.containsSubstr result value) ∧
  (∀ (pfx name value : String), ctx.get name = some (.str value) →
    templateStr = pfx ++ "{{" ++ name ++ "}}" →
    ¬ Tornado.containsSubstr pfx "{{" →
    ¬ Tornado.containsSubstr value "{{" →
    result = pfx ++ value) ∧
  (∀ (name suffix value : String), ctx.get name = some (.str value) →
    templateStr = "{{" ++ name ++ "}}" ++ suffix →
    ¬ Tornado.containsSubstr value "{{" →
    ¬ Tornado.containsSubstr suffix "{{" →
    result = value ++ suffix) ∧
  (∀ (pfx mid name1 name2 value1 value2 : String),
    ctx.get name1 = some (.str value1) → ctx.get name2 = some (.str value2) →
    templateStr = pfx ++ "{{" ++ name1 ++ "}}" ++ mid ++ "{{" ++ name2 ++ "}}" →
    ¬ Tornado.containsSubstr pfx "{{" → ¬ Tornado.containsSubstr mid "{{" →
    ¬ Tornado.containsSubstr value1 "{{" → ¬ Tornado.containsSubstr value2 "{{" →
    result = pfx ++ value1 ++ mid ++ value2)


theorem renderTemplate_spec (templateStr : String) (ctx : TemplateContext) 
    (hnames : ∀ pair ∈ ctx.bindings, pair.1 ≠ "" ∧ pair.1.toList.all (fun c => c.isAlphanum || c == '_') = true) :
    renderTemplate_postcond templateStr ctx (renderTemplate templateStr ctx) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Tornado
-- === END: FIXED_FINAL ===
