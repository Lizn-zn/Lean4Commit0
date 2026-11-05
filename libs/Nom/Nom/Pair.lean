-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Nom.Types

namespace Nom

/-! ## pair -/

/-- Parse two things in sequence, returning both. -/
def pair (p1 : Parser α) (p2 : Parser β) : Parser (α × β) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def pair_postcond (p1 : Parser α) (p2 : Parser β)
    (input r1 r2 : String) (v1 : α) (v2 : β) (result : ParseResult (α × β)) : Prop :=
  (p1 input = ParseResult.ok r1 v1 → p2 r1 = ParseResult.ok r2 v2 →
    result = ParseResult.ok r2 (v1, v2)) ∧
  (∀ msg, p1 input = ParseResult.err msg → ∃ msg', result = ParseResult.err msg') ∧
  (p1 input = ParseResult.ok r1 v1 →
    ∀ msg2, p2 r1 = ParseResult.err msg2 → ∃ msg', result = ParseResult.err msg')

theorem pair_spec (p1 : Parser α) (p2 : Parser β)
    (input r1 r2 : String) (v1 : α) (v2 : β)
    (h1 : p1 input = ParseResult.ok r1 v1)
    (h2 : p2 r1 = ParseResult.ok r2 v2) :
    pair p1 p2 input = ParseResult.ok r2 (v1, v2) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Nom
-- === END: FIXED_FINAL ===
