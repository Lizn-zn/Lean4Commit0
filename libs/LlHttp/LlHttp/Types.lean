-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace LlHttp
/-! ## Types -/
inductive HttpMethod where
  | GET | POST | PUT | DELETE | PATCH | HEAD | OPTIONS | CONNECT | TRACE
  deriving Repr, BEq
/-- Convert an HttpMethod to its canonical string representation. -/
structure HttpVersion where
  major : Nat
  minor : Nat
  deriving Repr, BEq
structure Header where
  name  : String
  value : String
  deriving Repr, BEq
structure HttpRequest where
  method  : HttpMethod
  url     : String
  version : HttpVersion
  headers : List Header
  body    : List UInt8
  deriving Repr, BEq
end LlHttp
-- === END: FIXED_FINAL ===
