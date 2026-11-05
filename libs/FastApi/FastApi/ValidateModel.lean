-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import FastApi.Types
import FastApi.Helpers
import FastApi.MatchURL

namespace FastApi

/-! ## Core Function 2: validateModel -/

def validateModel (modelDef : ModelDef) (data : List (String × JsonValue))
    : List String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def validateModel_postcond (modelDef : ModelDef) (data : List (String × JsonValue))
    (result : List String) : Prop :=
  (∀ field ∈ modelDef.fields,
    field.required = true →
    (∃ v, (field.name, v) ∈ data) →
    (∀ v, (field.name, v) ∈ data →
      (match field.fieldType with
       | .string  => ∀ s, v ≠ .str s
       | .integer => ∀ i, v ≠ .int i
       | .float   => ∀ f, v ≠ .float f
       | .boolean => ∀ b, v ≠ .bool b)) →
    result.length > 0) ∧
  (∀ field ∈ modelDef.fields,
    field.required = true →
    ¬(∃ v, (field.name, v) ∈ data) →
    result.length > 0) ∧
  ((∀ field ∈ modelDef.fields,
    field.required = true →
    (∃ v, (field.name, v) ∈ data ∧
      (match field.fieldType with
       | .string  => ∃ s, v = .str s
       | .integer => ∃ i, v = .int i
       | .float   => ∃ f, v = .float f
       | .boolean => ∃ b, v = .bool b))) →
    result = [])

theorem validateModel_spec (modelDef : ModelDef) (data : List (String × JsonValue)) :
    validateModel_postcond modelDef data (validateModel modelDef data) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end FastApi
-- === END: FIXED_FINAL ===
