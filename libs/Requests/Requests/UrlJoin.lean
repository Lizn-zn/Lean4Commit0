-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Batteries.Data.String.Matcher
import Std
import Lean

import Requests.ParseContentType

namespace Requests

def urlJoin (base : String) (relative : String) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def urlJoin_postcond (base relative : String) (result : String) : Prop :=
  (isAbsoluteUrl relative = true → result = relative) ∧
  (relative = "" → result = base) ∧
  (relative ≠ "" → isAbsoluteUrl relative = false → isAbsoluteUrl base = true →
    result.containsSubstr "://" = true) ∧
  (relative ≠ "" → isAbsoluteUrl relative = false → base.containsSubstr "://" = true →
    let scheme := (base.splitOn "://").head!
    result.startsWith (scheme ++ "://") = true) ∧
  (relative.startsWith "/" = true → relative.startsWith "//" = false → base.containsSubstr "://" = true →
    let schemeParts := base.splitOn "://"
    let scheme := schemeParts.head!
    let host := ((schemeParts.drop 1).head!.splitOn "/").head!
    result = scheme ++ "://" ++ host ++ relative)

theorem urlJoin_spec (base relative : String) :
    urlJoin_postcond base relative (urlJoin base relative) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Requests
-- === END: FIXED_FINAL ===
