-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Batteries.Data.String.Matcher
import Std
import Lean

import Requests.UrlJoin

namespace Requests

def domainMatch (cookieDomain : String) (requestDomain : String) : Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def domainMatch_postcond (cookieDomain requestDomain : String) (result : Bool) : Prop :=
  (cookieDomain = requestDomain → result = true) ∧
  (∀ sub parent, parent ≠ "" → cookieDomain = "." ++ parent → requestDomain = sub ++ "." ++ parent →
    result = true) ∧
  (result = true →
    cookieDomain = requestDomain ∨
      (cookieDomain.startsWith "." = true ∧
       cookieDomain.drop 1 ≠ "" ∧
       requestDomain.endsWith (cookieDomain.drop 1) = true))

theorem domainMatch_spec (cookieDomain requestDomain : String) :
    domainMatch_postcond cookieDomain requestDomain (domainMatch cookieDomain requestDomain) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Requests
-- === END: FIXED_FINAL ===
