-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Regex.ReplaceAll

namespace Regex

@[reducible]
def replaceAll_no_match_rel (pattern input replacement : String) : Prop :=
  findAll pattern input = [] → replaceAll pattern input replacement = input

theorem replaceAll_no_match_spec (pattern input replacement : String) :
    replaceAll_no_match_rel pattern input replacement := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Regex
-- === END: FIXED_FINAL ===
