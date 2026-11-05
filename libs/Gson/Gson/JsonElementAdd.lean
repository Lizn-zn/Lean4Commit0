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

namespace Gson

/-! ## Core Function 3: JsonElement.add -/

def JsonElement.add (obj : JsonElement) (key : String) (value : JsonElement) : JsonElement :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def JsonElement.add_postcond (obj : JsonElement) (key : String) (value : JsonElement) (result : JsonElement) : Prop :=
  -- Concrete examples pinning append-to-end behavior
  (obj = .jsonObject [("a", .jsonInt 1)] ∧ key = "b" ∧ value = .jsonInt 2 →
    result = .jsonObject [("a", .jsonInt 1), ("b", .jsonInt 2)]) ∧
  (obj = .jsonObject [("a", .jsonInt 1), ("b", .jsonInt 2)] ∧ key = "c" ∧ value = .jsonBool true →
    result = .jsonObject [("a", .jsonInt 1), ("b", .jsonInt 2), ("c", .jsonBool true)]) ∧
  -- Structural properties
  (∀ entries, obj = .jsonObject entries →
    ∃ entries', result = .jsonObject entries' ∧
      entries'.find? (fun (k, _) => k == key) = some (key, value) ∧
      (∀ k v, k ≠ key → (k, v) ∈ entries → (k, v) ∈ entries') ∧
      (entries'.filter (fun (k, _) => k == key)).length = 1) ∧
  (match obj with | .jsonObject _ => True | _ => result = .jsonObject [(key, value)])

theorem JsonElement.add_spec (obj : JsonElement) (key : String) (value : JsonElement) :
    JsonElement.add_postcond obj key value (JsonElement.add obj key value) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Gson
-- === END: FIXED_FINAL ===
