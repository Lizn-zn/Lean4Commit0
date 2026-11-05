-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Marshmallow.Types
import Marshmallow.Helpers
import Marshmallow.Dump
import Marshmallow.Load
import Marshmallow.Validate

namespace Marshmallow

/-! ## Relational: dump then load roundtrip -/

@[reducible]
def dump_load_roundtrip_rel (s : Schema) (data dumped loaded : Value) (reg : SchemaRegistry) : Prop :=
  ((∀ f ∈ s.fields, (Field.getMeta f).dump = true ∧ (Field.getMeta f).load = true) →
    s.dump data reg = .ok dumped →
    s.load dumped reg = .ok loaded →
    loaded = data) ∧
  (s.fields = [] → s.options.unknown = .raise →
    ∃ v, s.dump (.dict []) reg = .ok v)

theorem dump_load_roundtrip_spec (s : Schema) (data : Value) (reg : SchemaRegistry)
    (hFields : ∀ f ∈ s.fields, (Field.getMeta f).dump = true ∧ (Field.getMeta f).load = true)
    (dumped loaded : Value)
    (hDump : s.dump data reg = .ok dumped)
    (hLoad : s.load dumped reg = .ok loaded) :
    dump_load_roundtrip_rel s data dumped loaded reg := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: load then dump roundtrip -/

@[reducible]
def load_dump_roundtrip_rel (s : Schema) (data loaded dumped : Value) (reg : SchemaRegistry) : Prop :=
  ((∀ f ∈ s.fields, (Field.getMeta f).dump = true ∧ (Field.getMeta f).load = true) →
    s.load data reg = .ok loaded →
    s.dump loaded reg = .ok dumped →
    dumped = data) ∧
  (s.fields = [] → s.options.unknown = .raise →
    ∃ v, s.load (.dict []) reg = .ok v)

theorem load_dump_roundtrip_spec (s : Schema) (data : Value) (reg : SchemaRegistry)
    (hFields : ∀ f ∈ s.fields, (Field.getMeta f).dump = true ∧ (Field.getMeta f).load = true)
    (loaded dumped : Value)
    (hLoad : s.load data reg = .ok loaded)
    (hDump : s.dump loaded reg = .ok dumped) :
    load_dump_roundtrip_rel s data loaded dumped reg := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Relational: missing optional fields get defaults -/

@[reducible]
def missing_optional_default_rel (s : Schema) (entries : List (String × Value))
    (reg : SchemaRegistry) (f : Field) (dflt : Value) (result : List (String × Value)) : Prop :=
  (f ∈ s.fields →
    (Field.getMeta f).missing = .useDefault dflt →
    (∀ p ∈ entries, p.1 ≠ (Field.getMeta f).name) →
    s.load (.dict entries) reg = .ok (.dict result) →
    ((Field.getMeta f).name, dflt) ∈ result) ∧
  (s.fields = [] → s.options.unknown = .raise →
    ∃ v, s.load (.dict []) reg = .ok v)

theorem missing_optional_default_spec (s : Schema) (entries : List (String × Value))
    (reg : SchemaRegistry) (f : Field) (dflt : Value) (result : List (String × Value))
    (hf : f ∈ s.fields)
    (hDefault : (Field.getMeta f).missing = .useDefault dflt)
    (hAbsent : ∀ p ∈ entries, p.1 ≠ (Field.getMeta f).name)
    (hLoad : s.load (.dict entries) reg = .ok (.dict result)) :
    missing_optional_default_rel s entries reg f dflt result := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Marshmallow
-- === END: FIXED_FINAL ===
