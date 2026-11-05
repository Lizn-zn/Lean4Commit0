-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Orjson.Types
import Orjson.Helpers

namespace Orjson

/-! ## sortKeys -/

def sortKeys (v : JsonValue) : JsonValue :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def sortKeys_postcond (v : JsonValue) (result : JsonValue) : Prop :=
  (∀ kvs, v = JsonValue.object kvs →
    ∃ kvs', result = JsonValue.object kvs' ∧
      List.Pairwise (fun a b => a.1 ≤ b.1) kvs' ∧
      kvs'.length = kvs.length ∧
      (∀ k, k ∈ kvs.map (·.1) ↔ k ∈ kvs'.map (·.1)) ∧
      (∀ kv, kv ∈ kvs → isScalarJV kv.2 = true → kv ∈ kvs'))

theorem sortKeys_spec (v : JsonValue) :
    sortKeys_postcond v (sortKeys v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Relational: sortKeys produces sorted output -/

@[reducible]
def sortKeys_output_sorted_rel (kvs : List (String × JsonValue)) : Prop :=
  ∀ kvs', sortKeys (JsonValue.object kvs) = JsonValue.object kvs' →
    List.Pairwise (fun a b => a.1 ≤ b.1) kvs' ∧
    kvs'.length = kvs.length ∧
    (∀ k, k ∈ kvs.map (·.1) ↔ k ∈ kvs'.map (·.1)) ∧
    (∀ kv, kv ∈ kvs → isScalarJV kv.2 = true → kv ∈ kvs')

theorem sortKeys_output_sorted_spec (kvs : List (String × JsonValue)) :
    sortKeys_output_sorted_rel kvs := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Orjson
-- === END: FIXED_FINAL ===
