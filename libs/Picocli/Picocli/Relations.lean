-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Picocli.Parse
import Picocli.ValidateRequired

namespace Picocli

/-! ## Relational: parse validates required -/

@[reducible]
def parse_validates_required_rel (args : List String) (spec : CommandSpec)
    (parseResult : ParseResult ⊕ ParseError) (validateResult : Option ParseError) : Prop :=
  (∀ r, parseResult = Sum.inl r → validateResult = none) ∧
  (∀ name, parseResult = Sum.inr (ParseError.missingRequired name) →
    ∃ opt ∈ spec.options, opt.longName = some name ∧ opt.required = true)

theorem parse_validates_required_spec (args : List String) (spec : CommandSpec)
    (result : ParseResult) (hparse : parse args spec = Sum.inl result) :
    parse_validates_required_rel args spec (parse args spec) (validateRequired result spec) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Picocli
-- === END: FIXED_FINAL ===
