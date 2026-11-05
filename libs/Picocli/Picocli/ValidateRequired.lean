-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Picocli.Types

namespace Picocli

/-! ## Core Function 2: Required Option Validation -/

def validateRequired (result : ParseResult) (spec : CommandSpec)
    : Option ParseError :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def validateRequired_postcond (result : ParseResult) (spec : CommandSpec)
    (ret : Option ParseError) : Prop :=
  (ret = none ↔ ∀ opt ∈ spec.options, opt.required = true →
    (result.matchedOptions.find? (fun p => p.1 == opt.longName.getD "")).isSome = true)

theorem validateRequired_spec (result : ParseResult) (spec : CommandSpec) :
    validateRequired_postcond result spec (validateRequired result spec) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Picocli
-- === END: FIXED_FINAL ===
