-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Jsoup.Types
import Jsoup.Helpers
import Jsoup.MatchesSelector
import Jsoup.Append

namespace Jsoup

/-! ## Core Function 3: clean -/
mutual
def allTagsAllowed (sl : Safelist) : Node → Bool
  | .element t _ cs => sl.allowedTags.contains t && allTagsAllowedList sl cs
  | _ => true

def allTagsAllowedList (sl : Safelist) : List Node → Bool
  | [] => true
  | n :: ns => allTagsAllowed sl n && allTagsAllowedList sl ns
end

def clean (node : Node) (safelist : Safelist) : Node :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def clean_postcond (node : Node) (safelist : Safelist) (result : Node) : Prop :=
  allTagsAllowed safelist result = true ∧
  (∀ s, node = .textNode s → result = .textNode s) ∧
  (∀ tag attrs children, node = .element tag attrs children →
    safelist.allowedTags.contains tag = true →
    ∃ as' cs', result = .element tag as' cs')

theorem clean_spec (node : Node) (safelist : Safelist) :
    clean_postcond node safelist (clean node safelist) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Jsoup
-- === END: FIXED_FINAL ===
