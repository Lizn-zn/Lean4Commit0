-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace PyJWT


/-! ## Types -/

inductive Json where
  | null   : Json
  | bool   : Bool → Json
  | int    : Int → Json
  | float  : Float → Json
  | str    : String → Json
  | arr    : List Json → Json
  | obj    : List (String × Json) → Json
  deriving Repr, BEq, Inhabited


inductive Algorithm where
  | HS256 : Algorithm
  | HS384 : Algorithm
  | HS512 : Algorithm
  | none_ : Algorithm
  deriving Repr, BEq, DecidableEq


inductive JWTError where
  | invalidToken (msg : String)
  | decodeError (msg : String)
  | invalidSignature
  | expiredSignature
  | immatureSignature
  | invalidAudience
  | invalidIssuer
  | missingRequiredClaim (claim : String)
  | invalidAlgorithm
  deriving Repr, BEq


structure DecodeOptions where
  verifySig : Bool := true
  verifyExp : Bool := true
  verifyNbf : Bool := true
  verifyIss : Option String := none
  verifyAud : Option String := none
  requiredClaims : List String := []
  algorithms : List Algorithm := [.HS256]
  leeway : Nat := 0
  deriving Repr

end PyJWT
-- === END: FIXED_FINAL ===
