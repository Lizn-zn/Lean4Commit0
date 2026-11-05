-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Nom.Types

namespace Nom

/-! ## tag -/

/-- Match an exact string tag. -/
def tag (t : String) : Parser String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def tag_postcond (t input : String) (result : ParseResult String) : Prop :=
  (input.startsWith t = true → result = ParseResult.ok (input.drop t.length).toString t) ∧
  (input.startsWith t = false → ∃ msg, result = ParseResult.err msg)

theorem tag_spec (t input : String) :
    tag_postcond t input (tag t input) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Nom
-- === END: FIXED_FINAL ===
