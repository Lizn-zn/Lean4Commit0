-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import LlHttp.Types

/-- Check if `sub` is a substring of `s`. -/
def _root_.LlHttp.containsSubstr (s sub : String) : Bool :=
  if sub.isEmpty then true else (s.splitOn sub).length > 1

namespace LlHttp

def HttpMethod.toString : HttpMethod → String
  | .GET => "GET"
  | .POST => "POST"
  | .PUT => "PUT"
  | .DELETE => "DELETE"
  | .PATCH => "PATCH"
  | .HEAD => "HEAD"
  | .OPTIONS => "OPTIONS"
  | .CONNECT => "CONNECT"
  | .TRACE => "TRACE"

end LlHttp
-- === END: FIXED_FINAL ===
