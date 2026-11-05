-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import FastApi.Types

namespace FastApi

/-! ## Helper functions for postconditions -/

/-- Split a URL path into its segment strings: "/" → [], "/a/b" → ["a","b"]. -/
def pathToParts (path : String) : List String :=
  if path = "/" then []
  else match path.splitOn "/" with
    | [] => []
    | _ :: rest => rest  -- drop the leading empty string from the "/" prefix

/-- Render a URLPattern back to a path string, e.g. [literal "items", parameter "id"] → "/items/{id}" -/
def renderURLPattern (pattern : URLPattern) : String :=
  if pattern.segments.isEmpty then "/"
  else "/" ++ String.intercalate "/" (pattern.segments.map fun seg =>
    match seg with
    | .literal s => s
    | .parameter name => "{" ++ name ++ "}")

/-- Check that segment count matches and all literal segments equal the corresponding parts. -/
def urlSegmentsMatch (segments : List PatternSegment) (parts : List String) : Bool :=
  segments.length == parts.length &&
  (List.zipWith (fun seg part =>
    match seg with | .literal s => s == part | .parameter _ => true)
    segments parts).all id

/-- Extract parameter bindings from matched segments, e.g.
    [literal "a", parameter "id"] ∧ ["a","42"] → [("id", .str "42")] -/
def extractParams (segments : List PatternSegment) (parts : List String)
    : List (String × JsonValue) :=
  (List.zipWith (fun seg part =>
    match seg with
    | .parameter name => [(name, JsonValue.str part)]
    | .literal _ => []) segments parts).flatten


end FastApi
-- === END: FIXED_FINAL ===
