-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Cookiecutter.Types

namespace Cookiecutter

/-! ## Core Function 3: buildContext -/

def buildContext (varDefs : List VarDef) (overrides : List (String × VarValue))
    : TemplateContext :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def buildContext_postcond (varDefs : List VarDef) (overrides : List (String × VarValue)) (result : TemplateContext) : Prop :=
  (∀ vd ∈ varDefs, ∃ v, (vd.name, v) ∈ result) ∧
  (∀ k v, (k, v) ∈ overrides → ∃ v', (k, v') ∈ result) ∧
  (∀ vd ∈ varDefs, (∀ v, ¬((vd.name, v) ∈ overrides)) →
    (vd.name, vd.defaultValue) ∈ result) ∧
  (∀ vd ∈ varDefs, ∀ v, (vd.name, v) ∈ overrides →
    (∀ v', (vd.name, v') ∈ overrides → v' = v) →
    (vd.name, v) ∈ result)

theorem buildContext_spec (varDefs : List VarDef) (overrides : List (String × VarValue)) :
    buildContext_postcond varDefs overrides (buildContext varDefs overrides) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Cookiecutter
-- === END: FIXED_FINAL ===
