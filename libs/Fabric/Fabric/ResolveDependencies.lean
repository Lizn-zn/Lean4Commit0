-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Fabric.Types
import Fabric.Helpers

namespace Fabric

/-! ## Core Function 1: resolveDependencies -/

/-- Resolve task dependencies into a topological execution order. -/
def resolveDependencies (tasks : List TaskDef) (target : TaskId) : Option (List TaskId) := 
                                                                                           
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                                           sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def resolveDependencies_postcond (tasks : List TaskDef) (target : TaskId) (result : Option (List TaskId)) : Prop :=
  ((∃ t ∈ tasks, t.id == target) →
    (∀ t ∈ tasks, ∀ dep ∈ t.dependencies, ∃ d ∈ tasks, d.id == dep) →
    (∃ rank : TaskId → Nat, ∀ t ∈ tasks, ∀ dep ∈ t.dependencies, rank dep < rank t.id) →
    result.isSome = true) ∧
  (∀ order, result = some order → order.Nodup) ∧
  (∀ order, result = some order → ∀ tid ∈ order, ∃ t ∈ tasks, t.id == tid) ∧
  (∀ order, result = some order →
    order.getLast? = some target) ∧
  (∀ order, result = some order → order.length ≥ 1) ∧
  (∀ order, result = some order → target ∈ order) ∧
  -- Topological ordering: for each task in order, its dependencies that are also in order appear earlier
  (∀ order, result = some order →
    ∀ (i : Nat), i < order.length →
      ∀ t ∈ tasks, t.id == order[i]! →
        ∀ dep ∈ t.dependencies, dep ∈ order →
          listIndexOf order dep < i) ∧
  -- Dependency completeness: if a task in order has a dep that exists in tasks, that dep is in order
  (∀ order, result = some order →
    ∀ tid ∈ order, ∀ t ∈ tasks, t.id == tid →
      ∀ dep ∈ t.dependencies, (∃ t2 ∈ tasks, t2.id == dep) → dep ∈ order)

theorem resolveDependencies_spec (tasks : List TaskDef) (target : TaskId) :
    resolveDependencies_postcond tasks target (resolveDependencies tasks target) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Fabric
-- === END: FIXED_FINAL ===
