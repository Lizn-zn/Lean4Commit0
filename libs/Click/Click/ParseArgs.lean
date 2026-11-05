-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Click.Types

namespace Click

/-! ## Argument Parsing -/

def parseArgs (cmd : Command) (args : List String) : Except String (List ResolvedParam) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def parseArgs_postcond (cmd : Command) (args : List String) (result : Except String (List ResolvedParam)) : Prop :=
  (∀ opt, opt ∈ cmd.options → opt.required = true → opt.default = Option.none →
    (∀ a ∈ args, ¬ (a.startsWith ("--" ++ opt.name))) →
    ∃ e, result = Except.error e) ∧
  (cmd.options = [] → cmd.arguments = [] → ∃ ps, result = Except.ok ps) ∧
  ((∀ opt ∈ cmd.options, opt.required = false) → ∃ ps, result = .ok ps)

theorem parseArgs_spec (cmd : Command) (args : List String) :
    parseArgs_postcond cmd args (parseArgs cmd args) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Click
-- === END: FIXED_FINAL ===
