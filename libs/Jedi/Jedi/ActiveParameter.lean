-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Jedi.Types
import Jedi.Helpers
import Jedi.BuildScopes

namespace Jedi

/-! ## Core Function 2: activeParameter -/
def activeParameter (sig : SignatureInfo) (argIdx : Nat) : Option ParamInfo :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def activeParameter_postcond (sig : SignatureInfo) (argIdx : Nat) (result : Option ParamInfo) : Prop :=
  (sig.params = [] → result = none) ∧
  (∀ p rest, sig.params = p :: rest → argIdx = 0 → result = some p) ∧
  (argIdx ≥ sig.params.length →
    (∀ p ∈ sig.params, p.kind ≠ ParamKind.varPositional) → result = none) ∧
  (∀ p, result = some p → p ∈ sig.params) ∧
  (argIdx < sig.params.length → result ≠ none) ∧
  (argIdx < sig.params.length → result = sig.params[argIdx]?) ∧
  (argIdx ≥ sig.params.length →
    (∃ p ∈ sig.params, p.kind = ParamKind.varPositional) →
    ∃ p ∈ sig.params, p.kind = ParamKind.varPositional ∧ result = some p)

theorem activeParameter_spec (sig : SignatureInfo) (argIdx : Nat) :
    activeParameter_postcond sig argIdx (activeParameter sig argIdx) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Jedi
-- === END: FIXED_FINAL ===
