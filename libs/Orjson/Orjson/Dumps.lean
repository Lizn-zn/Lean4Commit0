-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Orjson.Types
import Orjson.Helpers

namespace Orjson

/-! ## dumps -/

def dumps (v : JsonValue) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def dumps_postcond (v : JsonValue) (result : String) : Prop :=
  result.length > 0 ∧
  (v = JsonValue.null → result = "null") ∧
  (∀ b, v = JsonValue.bool b → (b = true → result = "true") ∧ (b = false → result = "false")) ∧
  (∀ n : Int, v = JsonValue.int n → result = toString n) ∧
  (v = JsonValue.float 0.0 → result = "0.0") ∧
  (v = JsonValue.float 3.14 → result = "3.14") ∧
  (∀ f : Float, v = JsonValue.float f →
    result.length > 0 ∧
    result.any (fun c => c == '.' || c == 'e' || c == 'E') = true) ∧
  (∀ s, v = JsonValue.str s →
    result.startsWith "\"" = true ∧ result.endsWith "\"" = true ∧ result.length ≥ s.length + 2 ∧
    (s.all (fun c => c != '"' && c != '\\' && Nat.ble 32 c.val.toNat) = true →
     hasSubStr result s = true)) ∧
  (∀ vs, v = JsonValue.array vs →
    result.startsWith "[" = true ∧ result.endsWith "]" = true ∧
    (vs = [] → result = "[]") ∧
    (vs.all (fun jv => match jv with
      | JsonValue.null     => hasSubStr result "null" = true
      | JsonValue.bool b   => hasSubStr result (if b then "true" else "false") = true
      | JsonValue.int n    => hasSubStr result (toString n) = true
      | JsonValue.str s    => hasSubStr result ("\"" ++ s ++ "\"") = true
      | _                  => true) = true)) ∧
  (∀ kvs, v = JsonValue.object kvs →
    result.startsWith "{" = true ∧ result.endsWith "}" = true ∧
    (kvs = [] → result = "{}") ∧
    (kvs.all (fun kv =>
      hasSubStr result ("\"" ++ kv.1 ++ "\"") &&
      (match kv.2 with
       | JsonValue.null     => hasSubStr result "null"
       | JsonValue.bool b   => hasSubStr result (if b then "true" else "false")
       | JsonValue.int n    => hasSubStr result (toString n)
       | _                  => true)) = true))

theorem dumps_spec (v : JsonValue) :
    dumps_postcond v (dumps v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Orjson
-- === END: FIXED_FINAL ===
