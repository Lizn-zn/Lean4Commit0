-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Gson.Types
import Gson.Helpers
import Gson.Parse
import Gson.ToCompactString
import Gson.JsonElementAdd

namespace Gson

/-! ## Relational: parse/toCompactString roundtrip -/

@[reducible]
def parse_toCompactString_roundtrip_rel (e : JsonElement) : Prop :=
  parse (toCompactString e) = some e

theorem parse_toCompactString_roundtrip_spec (e : JsonElement) :
    parse_toCompactString_roundtrip_rel e := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: add then has returns true -/

@[reducible]
def add_then_has_rel (obj : JsonElement) (key : String) (value : JsonElement) : Prop :=
  JsonElement.has (JsonElement.add obj key value) key = true

theorem add_then_has_spec (obj : JsonElement) (key : String) (value : JsonElement) :
    add_then_has_rel obj key value := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Gson
-- === END: FIXED_FINAL ===
