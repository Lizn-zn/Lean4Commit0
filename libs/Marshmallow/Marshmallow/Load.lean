-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Marshmallow.Types
import Marshmallow.Helpers
import Marshmallow.Dump

namespace Marshmallow

/-! ## Core Function 2: Schema.load -/
def Schema.load (s : Schema) (data : Value) (registry : SchemaRegistry := .empty)
    : Except ValidationError Value :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Schema.load_precond (s : Schema) (data : Value) : Prop :=
  ∃ entries, data = Value.dict entries

@[reducible]
def Schema.load_postcond (s : Schema) (data : Value) (registry : SchemaRegistry) (result : Except ValidationError Value) : Prop :=
  (∀ f ∈ s.fields, (Field.getMeta f).load = false →
    ∀ dictResult, result = .ok (.dict dictResult) →
      ∀ p ∈ dictResult, p.1 ≠ (Field.getMeta f).name) ∧
  (∀ f ∈ s.fields, (Field.getMeta f).required = true →
    (Field.getMeta f).missing = .raise →
    ∀ entries, data = .dict entries →
      (∀ p ∈ entries, p.1 ≠ (Field.getMeta f).name) →
      ∃ err, result = .error err) ∧
  (∀ v, result = .ok v → ∃ pairs, v = .dict pairs) ∧
  (∀ f ∈ s.fields, (Field.getMeta f).load = true →
    ∀ entries, data = .dict entries →
      (∃ p ∈ entries, p.1 = ((Field.getMeta f).dataKey.getD (Field.getMeta f).name)) →
      ∀ dictResult, result = .ok (.dict dictResult) →
        ∃ p ∈ dictResult, p.1 = (Field.getMeta f).name) ∧
  (s.fields = [] →
    data = .dict [] →
    s.options.unknown = .raise →
    ∃ v, result = .ok v) ∧
  (∀ f ∈ s.fields, (Field.getMeta f).load = true →
    (Field.getMeta f).allowNone = false →
    ∀ entries, data = .dict entries →
      (∃ p ∈ entries, p.1 = ((Field.getMeta f).dataKey.getD (Field.getMeta f).name) ∧ p.2 = Value.null) →
      ∃ err, result = .error err) ∧
  (s.options.unknown = .raise →
    ∀ entries, data = .dict entries →
      (∃ p ∈ entries, ∀ f ∈ s.fields, p.1 ≠ (Field.getMeta f).dataKey.getD (Field.getMeta f).name) →
      ∃ err, result = .error err)

theorem Schema.load_spec (s : Schema) (data : Value) (registry : SchemaRegistry)
    (h : Schema.load_precond s data) :
    Schema.load_postcond s data registry (s.load data registry) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Marshmallow
-- === END: FIXED_FINAL ===
