-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Batteries.Data.String.Matcher
import Std
import Lean

/- # Requests
   HTTP client library for Python, modeled as pure data structures and algorithms.

   Ported from Python's `requests` library.
   Original: https://github.com/psf/requests
-/

namespace Requests

structure ContentType where
  mediaType : String
  charset : Option String
  boundary : Option String
  params : List (String × String)
  deriving Repr, BEq

end Requests
-- === END: FIXED_FINAL ===
