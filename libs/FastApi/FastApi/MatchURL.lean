-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import FastApi.Types
import FastApi.Helpers

namespace FastApi

/-! ## Core Function 1: matchURL -/

def matchURL (pattern : URLPattern) (path : String)
    : Option (List (String × JsonValue)) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def matchURL_postcond (pattern : URLPattern) (path : String)
    (result : Option (List (String × JsonValue))) : Prop :=
  -- Clause 1: trivial empty-pattern case
  (pattern.segments = [] → path = "/" → result = some []) ∧
  -- Clause 2 (forward): if path matches the pattern → result must be Some
  (urlSegmentsMatch pattern.segments (pathToParts path) = true → result.isSome) ∧
  -- Clause 3: when Some, every parameter segment has a .str entry with the right name
  (∀ r, result = some r →
    ∀ seg ∈ pattern.segments,
      match seg with
      | .parameter name => ∃ s : String, (name, JsonValue.str s) ∈ r
      | .literal _ => True) ∧
  -- Clause 4 (backward): when Some → path must have matched (no false positives)
  (∀ r, result = some r →
    urlSegmentsMatch pattern.segments (pathToParts path) = true) ∧
  -- Clause 5 (exact values): when Some, result = exactly the extracted parameters
  (∀ r, result = some r →
    r = extractParams pattern.segments (pathToParts path)) ∧
  -- Clause 6: result length = number of parameter segments
  (∀ r, result = some r →
    r.length = (pattern.segments.filter fun seg =>
      match seg with | .parameter _ => true | .literal _ => false).length)

theorem matchURL_spec (pattern : URLPattern) (path : String) :
    matchURL_postcond pattern path (matchURL pattern path) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end FastApi
-- === END: FIXED_FINAL ===
