-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Picocli.Types
import Picocli.Helpers

namespace Picocli

/-! ## Core Function 3: Usage String Generation -/

def generateUsage (spec : CommandSpec) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def generateUsage_postcond (spec : CommandSpec) (result : String) : Prop :=
  result.startsWith "Usage:" = true ∧
  (spec.name.length > 0 → Picocli.containsSubstr result spec.name = true) ∧
  (∀ opt ∈ spec.options, opt.required = true → opt.longName.isSome →
    Picocli.containsSubstr result (opt.longName.get!) = true) ∧
  (∀ pos ∈ spec.positionals, pos.label.length > 0 →
    Picocli.containsSubstr result pos.label = true)

theorem generateUsage_spec (spec : CommandSpec) :
    generateUsage_postcond spec (generateUsage spec) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Picocli
-- === END: FIXED_FINAL ===
