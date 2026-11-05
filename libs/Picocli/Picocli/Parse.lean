-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Picocli.Types

namespace Picocli

/-! ## Core Function 1: Parsing -/

def parse (args : List String) (spec : CommandSpec) : ParseResult ⊕ ParseError :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def parse_postcond (args : List String) (spec : CommandSpec) (result : ParseResult ⊕ ParseError) : Prop :=
  (∀ r, result = Sum.inl r →
    (∀ opt ∈ spec.options, opt.required = true →
      (r.matchedOptions.find? (fun p => p.1 == opt.longName.getD "")).isSome = true) ∧
    (∀ me ∈ spec.mutualExclusions,
      (me.optionNames.filter (fun n => (r.matchedOptions.find? (fun p => p.1 == n)).isSome)).length ≤ 1)) ∧
  (∀ name, result = Sum.inr (ParseError.unknownOption name) →
    ∀ opt ∈ spec.options, opt.longName ≠ some name) ∧
  (args = [] ∧ (∀ opt ∈ spec.options, opt.required = false) ∧
   (∀ pos ∈ spec.positionals, pos.required = false) ∧ spec.subcommands = [] →
   ∃ r, result = Sum.inl r) ∧
  (∀ r, result = Sum.inl r →
    ∀ p ∈ r.matchedOptions, ∃ opt ∈ spec.options,
      opt.longName = some p.1 ∨ (opt.shortName.isSome ∧ p.1 = opt.longName.getD "")) ∧
  (∀ r, result = Sum.inl r →
    (r.matchedOptions.map (·.1)).Nodup) ∧
  (∀ r, result = Sum.inl r →
    ∀ p ∈ r.matchedPositionals, p.1 < spec.positionals.length ∨ p.1 < args.length)

theorem parse_spec (args : List String) (spec : CommandSpec) :
    parse_postcond args spec (parse args spec) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Picocli
-- === END: FIXED_FINAL ===
