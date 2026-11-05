-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Attrs.Types

namespace Attrs

/-! ## Instance Construction -/

/-- Create an instance of an attrs class. -/
def ClassDef.create (cls : ClassDef) (values : List (String × Value))
    : Except String Instance :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def ClassDef.create_postcond (cls : ClassDef) (values : List (String × Value))
    (result : Except String Instance) : Prop :=
  (∀ inst, result = .ok inst →
    ∀ a ∈ cls.attributes, ∃ v, (a.name, v) ∈ inst.values) ∧
  (∀ a ∈ cls.attributes, ∀ v validator msg,
    (a.name, v) ∈ values → validator ∈ a.validators → validator.check v = some msg →
    ∃ e, result = .error e) ∧
  ((∀ a ∈ cls.attributes, (∃ v, (a.name, v) ∈ values) ∨ a.default ≠ .none) →
   (∀ a ∈ cls.attributes, ∀ v validator,
     (a.name, v) ∈ values → validator ∈ a.validators → validator.check v = Option.none) →
   ∃ inst, result = .ok inst) ∧
  (∀ inst, result = .ok inst → inst.classDef = cls) ∧
  (∀ inst, result = .ok inst →
    ∀ name val, (name, val) ∈ values →
      (∃ a ∈ cls.attributes, a.name = name ∧ a.converter = none) →
      (name, val) ∈ inst.values) ∧
  (∀ inst, result = .ok inst →
    ∀ a ∈ cls.attributes, (∀ v, (a.name, v) ∉ values) →
      ∀ d, a.default = .value d → (a.name, d) ∈ inst.values) ∧
  (∀ inst, result = .ok inst →
    ∀ name val, (name, val) ∈ inst.values →
      (∃ a ∈ cls.attributes, a.name = name) ∨ (∃ v, (name, v) ∈ values))

theorem ClassDef.create_spec (cls : ClassDef) (values : List (String × Value)) :
    ClassDef.create_postcond cls values (cls.create values) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Attrs
-- === END: FIXED_FINAL ===
