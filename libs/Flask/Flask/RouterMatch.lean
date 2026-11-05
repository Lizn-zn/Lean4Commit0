-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Flask.Types
import Flask.Helpers
import Flask.MatchURL

namespace Flask

/-! ## Core Function 2: Router.match -/

def Router.match (router : Router) (method : HttpMethod) (path : String)
    : Option (String × List (String × String)) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Router.match_prefix_postcond (router : Router) (method : HttpMethod) (path : String)
    (result : Option (String × List (String × String))) : Prop :=
  (∀ endpoint params, result = some (endpoint, params) →
    ∃ r ∈ router.routes, r.endpoint = endpoint ∧ method ∈ r.methods ∧
      matchURL r.pattern path = some params) ∧
  (∀ r ∈ router.routes, method ∈ r.methods →
    (matchURL r.pattern path).isSome = true → result.isSome = true)

theorem Router.match_prefix_spec (router : Router) (method : HttpMethod) (path : String) :
    Router.match_prefix_postcond router method path (router.match method path) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Flask
-- === END: FIXED_FINAL ===
