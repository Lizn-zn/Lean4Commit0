-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import NetworkX.Validity
import Std
import Lean

import NetworkX.Types
import NetworkX.Helpers

namespace NetworkX

/-! ## Core Function 3: Connected Components -/

/-- Find all connected components. -/
def connectedComponents (g : Graph) : List (List NodeId) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def connectedComponents_postcond (g : Graph) (result : List (List NodeId)) : Prop :=
  (∀ n, g.hasNode n = true → ∃ comp ∈ result, n ∈ comp) ∧
  (∀ c1 c2, c1 ∈ result → c2 ∈ result → c1 ≠ c2 →
    ∀ n, ¬(n ∈ c1 ∧ n ∈ c2)) ∧
  (∀ comp ∈ result, ∀ u, u ∈ comp → ∀ v, g.hasEdge u v = true → v ∈ comp) ∧
  (g.edges = [] → result.length = g.nodeList.length) ∧
  (∀ comp ∈ result, ∀ u ∈ comp, ∀ v ∈ comp, g.reachable u v = true)

theorem connectedComponents_spec (g : Graph) 
    (hvalid : g.Valid) :
    connectedComponents_postcond g (connectedComponents g) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end NetworkX
-- === END: FIXED_FINAL ===
