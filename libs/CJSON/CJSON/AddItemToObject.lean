-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import CJSON.Parse

namespace CJSON

def addItemToObject (j : JSON) (key : String) (item : JSON) : JSON :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def addItemToObject_postcond (j : JSON) (key : String) (item : JSON) (result : JSON) : Prop :=
  getItem result key = some item ∧
  (∃ kvs, result = JSON.object kvs) ∧
  (∀ kvs, j = JSON.object kvs →
    (∀ k v, (k, v) ∈ kvs → k ≠ key → getItem result k = some v)) ∧
  (∀ kvs, j = JSON.object kvs →
    ∃ rkvs, result = JSON.object rkvs ∧ rkvs.length ≥ kvs.length)

theorem addItemToObject_spec (j : JSON) (key : String) (item : JSON) :
    addItemToObject_postcond j key item (addItemToObject j key item) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end CJSON
-- === END: FIXED_FINAL ===
