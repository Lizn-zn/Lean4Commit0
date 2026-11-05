-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Click.Types
import Click.ConvertValue

namespace Click

/-! ## Parameter Resolution -/

def resolveParam (name : String) (cliValue : Option String) (envValue : Option String)
    (defaultVal : Option ParamValue) (paramType : ParamType) : Except String ResolvedParam :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def resolveParam_postcond (name : String) (cliValue : Option String) (envValue : Option String)
    (defaultVal : Option ParamValue) (paramType : ParamType) (result : Except String ResolvedParam) : Prop :=
  (cliValue = Option.none → envValue = Option.none → ∀ defVal, defaultVal = some defVal →
    result = Except.ok { name := name, value := defVal, source := ParameterSource.defaultValue }) ∧
  (∀ rp, result = .ok rp → rp.name = name) ∧
  (cliValue.isSome → ∀ rp, result = .ok rp → rp.source = .commandLine) ∧
  (cliValue = Option.none → envValue.isSome → ∀ rp, result = .ok rp → rp.source = .environment) ∧
  (cliValue = Option.none → envValue = Option.none → defaultVal = Option.none → ∃ e, result = .error e) ∧
  (∀ cv, cliValue = some cv → paramType = .STRING → ∀ rp, result = .ok rp → rp.value = .str cv) ∧
  (cliValue = Option.none → ∀ ev, envValue = some ev → paramType = .STRING → ∀ rp, result = .ok rp → rp.value = .str ev)

theorem resolveParam_spec (name : String) (cliValue : Option String) (envValue : Option String)
    (defaultVal : Option ParamValue) (paramType : ParamType) :
    resolveParam_postcond name cliValue envValue defaultVal paramType (resolveParam name cliValue envValue defaultVal paramType) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Click
-- === END: FIXED_FINAL ===
