-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Clap.Types

namespace Clap

/-! ## Core Function 3: ArgMatches.getString -/

/-- Get a string value by argument name. -/
def ArgMatches.getString (m : ArgMatches) (name : String) : Option String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def ArgMatches.getString_postcond (m : ArgMatches) (name : String) (result : Option String) : Prop :=
  (∀ s, result = some s → (name, ArgValue.string s) ∈ m.values) ∧
  (m.values.lookup name = none → result = none) ∧
  ((∃ s, (name, ArgValue.string s) ∈ m.values) → result.isSome = true)

theorem ArgMatches.getString_spec (m : ArgMatches) (name : String) :
    ArgMatches.getString_postcond m name (m.getString name) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Clap
-- === END: FIXED_FINAL ===
