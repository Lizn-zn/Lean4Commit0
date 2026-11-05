-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Tornado.Types
import Tornado.Helpers

namespace Tornado

def URLRouter.findHandler (router : URLRouter) (path : String)
    : Option (String × List String) :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def URLRouter.findHandler_postcond (router : URLRouter) (path : String)
    (result : Option (String × List String)) : Prop :=
  (router.specs = [] → result = none) ∧
  (∀ spec ∈ router.specs,
    matchPattern spec.pattern path ≠ none →
    result ≠ none) ∧
  (∀ handlerName groups, result = some (handlerName, groups) →
    ∃ spec ∈ router.specs, spec.handlerName = handlerName ∧
      matchPattern spec.pattern path = some groups)


theorem URLRouter.findHandler_spec (router : URLRouter) (path : String) :
    URLRouter.findHandler_postcond router path (router.findHandler path) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Signed Cookie Types -/

/-- Create a signed cookie value (HMAC-based). -/

def createSignedValue (secret : String) (name : String) (value : String)
    (timestamp : Nat) : String :=

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



/-- Verify and decode a signed cookie value. -/

def decodeSignedValue (secret : String) (name : String) (signedValue : String)
    (maxAge : Nat) (currentTime : Nat) : Option String :=

  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



/-! ## Core Function 2: signedCookie -/

@[reducible]
def signedCookie_postcond (secret : String) (name : String) (value : String)
    (timestamp maxAge currentTime : Nat) : Prop :=
  (currentTime ≥ timestamp → currentTime - timestamp < maxAge →
    decodeSignedValue secret name (createSignedValue secret name value timestamp)
      maxAge currentTime = some value) ∧
  (currentTime ≥ timestamp → currentTime - timestamp ≥ maxAge →
    decodeSignedValue secret name (createSignedValue secret name value timestamp)
      maxAge currentTime = none) ∧
  (currentTime ≥ timestamp → currentTime - timestamp < maxAge →
    ∀ name2 : String, name2 ≠ name →
      decodeSignedValue secret name2 (createSignedValue secret name value timestamp)
        maxAge currentTime ≠ some value)


theorem signedCookie_spec (secret : String) (name : String) (value : String)
    (timestamp maxAge currentTime : Nat) :
    signedCookie_postcond secret name value timestamp maxAge currentTime := by

  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===



/-! ## Relational: Signed cookie with wrong secret -/

@[reducible]
def signed_cookie_wrong_secret_rel (secret1 secret2 : String) (name value : String)
    (timestamp maxAge currentTime : Nat) : Prop :=
  secret1 ≠ secret2 →
  currentTime ≥ timestamp → currentTime - timestamp < maxAge →
  decodeSignedValue secret2 name (createSignedValue secret1 name value timestamp)
    maxAge currentTime = none


theorem signed_cookie_wrong_secret_spec (secret1 secret2 : String) (name value : String)
    (timestamp maxAge currentTime : Nat)
    (hdiff : secret1 ≠ secret2)
    (htime : currentTime ≥ timestamp) (hage : currentTime - timestamp < maxAge) :
    signed_cookie_wrong_secret_rel secret1 secret2 name value timestamp maxAge currentTime := by

  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/- Template rendering types. -/

end Tornado
-- === END: FIXED_FINAL ===
