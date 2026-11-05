-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Nom.Types

namespace Nom

/-! ## many0 -/

/-- Apply parser zero or more times, collecting results. -/
def many0 (p : Parser α) : Parser (List α) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def many0_postcond (p : Parser α) (input : String) (result : ParseResult (List α)) : Prop :=
  ((∃ msg, p input = ParseResult.err msg) → result = ParseResult.ok input []) ∧
  (∃ rem vs, result = ParseResult.ok rem vs ∧ rem.length ≤ input.length) ∧
  (∀ rem' v', p input = ParseResult.ok rem' v' → rem'.length < input.length →
    ∃ rem vs, result = ParseResult.ok rem vs ∧ vs.length ≥ 1) ∧
  (∀ rem vs, result = ParseResult.ok rem vs →
    ∀ rem' v', p rem = ParseResult.ok rem' v' → rem' = rem)

theorem many0_spec (p : Parser α) (input : String) 
    (hprogress : ∀ s rem value, p s = ParseResult.ok rem value → rem.length < s.length) :
    many0_postcond p input (many0 p input) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Nom
-- === END: FIXED_FINAL ===
