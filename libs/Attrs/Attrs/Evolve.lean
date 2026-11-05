-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Attrs.Get

namespace Attrs

/-! ## Evolution (Functional Update) -/

/-- Create a new instance with some fields changed. -/
def Instance.evolve (inst : Instance) (changes : List (String × Value))
    : Except String Instance :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Instance.evolve_postcond (inst : Instance) (changes : List (String × Value))
    (result : Except String Instance) : Prop :=
  (∀ inst', result = .ok inst' →
    ∀ field, (∀ v, (field, v) ∉ changes) → inst'.get field = inst.get field) ∧
  (∀ inst', result = .ok inst' →
    ∀ field, (∃ v, (field, v) ∈ changes) → ∃ v, (field, v) ∈ changes ∧ inst'.get field = some v) ∧
  (∀ inst', result = .ok inst' → inst'.classDef = inst.classDef) ∧
  (inst.classDef.frozen = true → ∃ e, result = .error e) ∧
  (∀ a ∈ inst.classDef.attributes, ∀ v, (a.name, v) ∈ changes →
    ∀ validator ∈ a.validators, ∀ msg, validator.check v = some msg →
    ∃ e, result = .error e) ∧
  (inst.classDef.frozen = false →
    (∀ a ∈ inst.classDef.attributes, ∀ v, (a.name, v) ∈ changes →
      ∀ validator ∈ a.validators, validator.check v = Option.none) →
    ∃ inst', result = .ok inst') ∧
  (∀ inst', result = .ok inst' →
    ∀ name val, (name, val) ∈ inst'.values →
      (∃ v, (name, v) ∈ inst.values) ∨ (∃ v, (name, v) ∈ changes))

theorem Instance.evolve_spec (inst : Instance) (changes : List (String × Value)) :
    Instance.evolve_postcond inst changes (inst.evolve changes) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===


/-! ## Relational: evolve with empty changes preserves instance -/
@[reducible]
def Instance.evolve_empty_rel (inst : Instance) (result : Except String Instance) : Prop :=
  ∀ inst', result = .ok inst' → inst'.values = inst.values

theorem Instance.evolve_empty_spec (inst : Instance) :
    Instance.evolve_empty_rel inst (inst.evolve []) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Attrs
-- === END: FIXED_FINAL ===
