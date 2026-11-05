-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Attrs.Create

namespace Attrs

/-! ## Instance Operations -/

/-- Get a field value from an instance. -/
def Instance.get (inst : Instance) (field : String) : Option Value :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Instance.get_postcond (inst : Instance) (field : String) (result : Option Value) : Prop :=
  (∃ v, (field, v) ∈ inst.values ∧ result = some v) ∨
  (result = none ∧ ∀ v, (field, v) ∉ inst.values)

theorem Instance.get_spec (inst : Instance) (field : String) :
    Instance.get_postcond inst field (inst.get field) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Relational: get after create -/
@[reducible]
def get_after_create_rel (cls : ClassDef) (vals : List (String × Value))
    (inst : Instance) (field : String) (val : Value) : Prop :=
  cls.create vals = .ok inst →
  (field, val) ∈ vals →
  (∃ a ∈ cls.attributes, a.name = field ∧ a.converter = none) →
  inst.get field = some val

theorem get_after_create_spec (cls : ClassDef) (vals : List (String × Value))
    (inst : Instance) (field : String) (val : Value)
    (h_create : cls.create vals = .ok inst)
    (h_in : (field, val) ∈ vals)
    (h_attr : ∃ a ∈ cls.attributes, a.name = field ∧ a.converter = none) 
    (hkeys : (vals.map Prod.fst).Nodup) :
    get_after_create_rel cls vals inst field val := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Attrs
-- === END: FIXED_FINAL ===
