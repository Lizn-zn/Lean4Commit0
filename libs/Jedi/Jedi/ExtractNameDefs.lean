-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Jedi.Types
import Jedi.Helpers
import Jedi.BuildScopes
import Jedi.ActiveParameter

namespace Jedi

/-! ## Core Function 3: extractNameDefs -/
def extractNameDefs (mod : Module) : List NameDef :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def extractNameDefs_postcond (mod : Module) (result : List NameDef) : Prop :=
  (mod.body = [] → result = []) ∧
  (∀ nd ∈ result, nd.modulePath = mod.filePath) ∧
  (∀ nd ∈ result, nd.name.length ≥ 1) ∧
  (∀ nd ∈ result, nd.pos.line ≥ 1) ∧
  (∀ nd ∈ result, nd.scopeIdx < (result.length + mod.body.length + 1)) ∧
  (result.filter (fun nd => nd.kind = NameDefKind.function_)).length ≥ countFuncDefs mod.body ∧
  (result.filter (fun nd => nd.kind = NameDefKind.class_)).length ≥ countClassDefs mod.body ∧
  (∀ name args body ret isAsync pos,
    Stmt.functionDef name args body ret isAsync pos ∈ mod.body →
    ∃ nd ∈ result, nd.name = name ∧ nd.kind = NameDefKind.function_) ∧
  (∀ name bases body pos,
    Stmt.classDef name bases body pos ∈ mod.body →
    ∃ nd ∈ result, nd.name = name ∧ nd.kind = NameDefKind.class_)

theorem extractNameDefs_spec (mod : Module) :
    extractNameDefs_postcond mod (extractNameDefs mod) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Jedi
-- === END: FIXED_FINAL ===
