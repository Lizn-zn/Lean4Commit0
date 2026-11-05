-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Jedi.Types
import Jedi.Helpers

namespace Jedi

/-! ## Core Function 1: buildScopes -/
def buildScopes (mod : Module) : List Scope :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def buildScopes_postcond (mod : Module) (result : List Scope) : Prop :=
  result.length ≥ 1 ∧
  (∀ s, result.head? = some s → s.kind = ScopeKind.module_ ∧ s.parentIdx = none) ∧
  (∀ s, result.head? = some s → s.name = mod.name) ∧
  (∀ s ∈ result, s.startPos.line ≥ 1 ∨ s.startPos.line = 0) ∧
  (∀ s ∈ result, s.parentIdx = none ∨ ∃ idx, s.parentIdx = some idx ∧ idx < result.length) ∧
  (∀ s ∈ result, s.name.length ≥ 1 ∨ s.kind = ScopeKind.comprehension) ∧
  (∀ s ∈ result, Position.le s.startPos s.endPos = true) ∧
  (∀ s ∈ result, s.kind ≠ ScopeKind.module_ → s.parentIdx ≠ none) ∧
  (result.filter (fun s => s.kind = ScopeKind.function_)).length ≥ countFuncDefs mod.body ∧
  (result.filter (fun s => s.kind = ScopeKind.class_)).length ≥ countClassDefs mod.body ∧
  (∀ name args body ret isAsync pos,
    Stmt.functionDef name args body ret isAsync pos ∈ mod.body →
    ∃ s ∈ result, s.name = name ∧ s.kind = ScopeKind.function_) ∧
  (∀ name bases body pos,
    Stmt.classDef name bases body pos ∈ mod.body →
    ∃ s ∈ result, s.name = name ∧ s.kind = ScopeKind.class_) ∧
  (∀ s ∈ result, s.name = "<lambda>" → s.kind = ScopeKind.lambda_) ∧
  (∀ s, result.head? = some s → s.startPos.line ≤ 1)

theorem buildScopes_spec (mod : Module) 
    (hnames : mod.name ≠ "" ∧ mod.name ≠ "<lambda>" ∧
      ∀ name args body ret async pos, Stmt.functionDef name args body ret async pos ∈ mod.body → name ≠ "" ∧ name ≠ "<lambda>") 
    (hclasses : ∀ name bases body pos, Stmt.classDef name bases body pos ∈ mod.body → name ≠ "" ∧ name ≠ "<lambda>") :
    buildScopes_postcond mod (buildScopes mod) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Jedi
-- === END: FIXED_FINAL ===
