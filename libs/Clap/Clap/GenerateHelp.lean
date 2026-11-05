-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Clap.Types
import Clap.Helpers

namespace Clap

/-! ## Core Function 2: generateHelp -/

/-- Generate full help text. -/
def generateHelp (cmd : Command) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def generateHelp_postcond (cmd : Command) (result : String) : Prop :=
  (∀ a ∈ cmd.args, Clap.containsSubstr result a.name = true) ∧
  (cmd.about ≠ "" → Clap.containsSubstr result cmd.about = true) ∧
  (Clap.containsSubstr result cmd.name = true) ∧
  (∀ a ∈ cmd.args, a.help ≠ "" → Clap.containsSubstr result a.help = true) ∧
  (Clap.containsSubstr result ("Usage: " ++ cmd.name) = true)

theorem generateHelp_spec (cmd : Command) :
    generateHelp_postcond cmd (generateHelp cmd) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Clap
-- === END: FIXED_FINAL ===
