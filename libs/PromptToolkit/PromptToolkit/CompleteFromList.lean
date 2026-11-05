-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import PromptToolkit.Types
import PromptToolkit.InsertText
import PromptToolkit.Backspace

namespace PromptToolkit


/-! ## completeFromList -/

/-- Complete from a list of candidates given a prefix. -/
def completeFromList (candidates : List String) (pfx : String) : List Completion :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def completeFromList_postcond (candidates : List String) (pfx : String) (result : List Completion) : Prop :=
  (∀ c ∈ result, c.text.startsWith pfx = true) ∧
  (pfx = "" → result.length = candidates.length) ∧
  result.length = (candidates.filter (fun s => s.startsWith pfx)).length ∧
  (∀ c ∈ result, c.text ∈ candidates) ∧
  (∀ s ∈ candidates, s.startsWith pfx = true → ∃ c ∈ result, c.text = s)


theorem completeFromList_spec (candidates : List String) (pfx : String) :
    completeFromList_postcond candidates pfx (completeFromList candidates pfx) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end PromptToolkit
-- === END: FIXED_FINAL ===
