-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import YyJson.Read
import YyJson.Write

namespace YyJson

def Val.objGet (v : Val) (key : String) : Option Val :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def Val.objGet_postcond (v : Val) (key : String) (result : Option Val) : Prop :=
  (¬ (∃ kvs, v = Val.obj kvs) → result = none) ∧
  (∀ kvs, v = Val.obj kvs →
    (∀ val, (key, val) ∈ kvs → result ≠ none)) ∧
  (v = Val.obj [] → result = none) ∧
  (∀ kvs, v = Val.obj kvs →
    (∀ val, result = some val → (key, val) ∈ kvs)) ∧
  (∀ kvs, v = Val.obj kvs →
    (¬ ∃ val, (key, val) ∈ kvs) → result = none) ∧
  (∀ kvs, v = Val.obj kvs →
    result = (kvs.find? (fun p => p.1 = key)).map Prod.snd)


theorem Val.objGet_spec (v : Val) (key : String) :
    Val.objGet_postcond v key (Val.objGet v key) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===




@[reducible]
def read_write_rel (v : Val) (written : String) (parsed : Option Doc) : Prop :=
  written ≠ "" ∧
  parsed ≠ none ∧
  (∀ d, parsed = some d → d.root = v)


theorem read_write_spec (v : Val) :
    read_write_rel v (write { root := v }) (read (write { root := v })) := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end YyJson
-- === END: FIXED_FINAL ===
