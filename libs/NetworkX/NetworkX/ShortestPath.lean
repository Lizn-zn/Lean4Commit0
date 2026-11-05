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

/-! ## Core Function 2: Shortest Path -/

/-- Shortest path between two nodes (unweighted). -/
def shortestPath (g : Graph) (source target : NodeId) : Option (List NodeId) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def shortestPath_postcond (g : Graph) (source target : NodeId) (result : Option (List NodeId)) : Prop :=
  (result.isSome = true →
    result.get!.head? = some source ∧
    result.get!.getLast? = some target ∧
    result.get!.length ≥ 1 ∧
    (∀ n, n ∈ result.get! → g.hasNode n = true) ∧
    result.get!.Nodup ∧
    (∀ p, p ∈ result.get!.zip (result.get!.tail) → g.hasEdge p.1 p.2 = true) ∧
    (g.hasEdge source target = true → result.get!.length ≤ 2)) ∧
  (g.hasEdge source target = true → result.isSome = true) ∧
  (source = target → g.hasNode source = true → result.isSome = true)

theorem shortestPath_spec (g : Graph) (source target : NodeId) 
    (hvalid : g.Valid) :
    shortestPath_postcond g source target (shortestPath g source target) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end NetworkX
-- === END: FIXED_FINAL ===
