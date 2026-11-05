-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Gson.Types
import Gson.Helpers
import Gson.Parse

namespace Gson

/-! ## Core Function 2: toCompactString -/

def toCompactString (e : JsonElement) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-- toCompactString postcond: concrete examples + properties. -/
@[reducible]
def toCompactString_postcond (e : JsonElement) (result : String) : Prop :=
  -- C1: Concrete array/object rendering
  (e = .jsonArray [.jsonInt 1, .jsonInt 2, .jsonInt 3] → result = "[1,2,3]") ∧
  (e = .jsonObject [("a", .jsonInt 1)] → result = "{\"a\":1}") ∧
  (e = .jsonArray [.jsonArray [.jsonInt 1], .jsonInt 2] → result = "[[1],2]") ∧
  (e = .jsonArray [.jsonNull, .jsonBool true, .jsonString "hi", .jsonInt 42] →
    result = "[null,true,\"hi\",42]") ∧
  (e = .jsonObject [("a", .jsonObject [("b", .jsonInt 1)])] →
    result = "{\"a\":{\"b\":1}}") ∧
  (e = .jsonObject [("x", .jsonBool true), ("y", .jsonBool false)] →
    result = "{\"x\":true,\"y\":false}") ∧
  (e = .jsonArray [] → result = "[]") ∧
  (e = .jsonObject [] → result = "{}") ∧
  -- C2: String rendering with escapes
  (e = .jsonString "hello" → result = "\"hello\"") ∧
  (e = .jsonString "a\"b" → result = "\"a\\\"b\"") ∧
  (e = .jsonString "a\nb" → result = "\"a\\nb\"") ∧
  (e = .jsonString "" → result = "\"\"") ∧
  -- C3: Compactness — no JSON whitespace outside string literals
  isCompactJsonString result = true ∧
  -- C3-C6: Exact primitive rendering (fully determined)
  (e = .jsonNull → result = "null") ∧
  (e = .jsonBool true → result = "true") ∧
  (e = .jsonBool false → result = "false") ∧
  (∀ n, e = .jsonInt n → result = toString n) ∧
  -- C7: String escaping — uses minimal escaping (length pinned)
  (∀ s, e = .jsonString s → result.length = 2 + pureStringEscapedLength s) ∧
  -- C8: Structural delimiters
  (∀ elems, e = .jsonArray elems → result.front? = some '[' ∧ result.back? = some ']') ∧
  (∀ entries, e = .jsonObject entries → result.front? = some '{' ∧ result.back? = some '}')

theorem toCompactString_spec (e : JsonElement) :
    toCompactString_postcond e (toCompactString e) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Gson
-- === END: FIXED_FINAL ===
