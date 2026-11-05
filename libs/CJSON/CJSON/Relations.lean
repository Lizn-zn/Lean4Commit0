-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import CJSON.AddItemToObject

namespace CJSON

@[reducible]
def parse_print_rel (j : JSON) (printed : String) (parsed : Option JSON) : Prop :=
  parsed = some j

theorem parse_print_spec (j : JSON) :
    parse_print_rel j (print j) (parse (print j)) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def addItemToObject_preserves_rel (j : JSON) (key1 key2 : String) (item : JSON) : Prop :=
  key1 ≠ key2 →
  hasItem j key2 = true →
  getItem (addItemToObject j key1 item) key2 = getItem j key2

theorem addItemToObject_preserves_spec (j : JSON) (key1 key2 : String) (item : JSON) 
    (hkeys : ∀ fields, j = JSON.object fields → (fields.map Prod.fst).Nodup) :
    addItemToObject_preserves_rel j key1 key2 item := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end CJSON
-- === END: FIXED_FINAL ===
