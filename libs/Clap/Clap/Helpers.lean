-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Clap.Types

/-- Check if `sub` is a substring of `s`. -/
def _root_.Clap.containsSubstr (s sub : String) : Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



namespace Clap

/-! ## Helper: ArgMatches.getBool (used in parse_flag_rel) -/

/-- Get a boolean flag value. -/
def ArgMatches.getBool (m : ArgMatches) (name : String) : Bool :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def ArgMatches.getBool_postcond (m : ArgMatches) (name : String) (result : Bool) : Prop :=
  (m.values.lookup name = none → result = false) ∧
  ((name, ArgValue.flag true) ∈ m.values → result = true) ∧
  ((name, ArgValue.flag false) ∈ m.values → result = false)

theorem ArgMatches.getBool_spec (m : ArgMatches) (name : String) 
    (hkeys : (m.values.map Prod.fst).Nodup) :
    ArgMatches.getBool_postcond m name (m.getBool name) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Clap
-- === END: FIXED_FINAL ===
