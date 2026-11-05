-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import NetworkX.Types

namespace NetworkX

/-! ## Query Operations (infrastructure for postconditions) -/

/-- Check if a node exists. -/
def Graph.hasNode (g : Graph) (n : NodeId) : Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Graph.hasNode_postcond (g : Graph) (n : NodeId) (result : Bool) : Prop :=
  (result = true ↔ ∃ attrs, (n, attrs) ∈ g.nodes)

theorem Graph.hasNode_spec (g : Graph) (n : NodeId) :
    Graph.hasNode_postcond g n (g.hasNode n) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-- Check if an edge exists. -/
def Graph.hasEdge (g : Graph) (u v : NodeId) : Bool :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def Graph.hasEdge_postcond (g : Graph) (u v : NodeId) (result : Bool) : Prop :=
  (result = true ↔ ∃ attrs, (u, v, attrs) ∈ g.edges ∨ (v, u, attrs) ∈ g.edges)

theorem Graph.hasEdge_spec (g : Graph) (u v : NodeId) :
    Graph.hasEdge_postcond g u v (g.hasEdge u v) := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



/-- Get all nodes. -/
def Graph.nodeList (g : Graph) : List NodeId :=
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===



@[reducible]
def Graph.nodeList_postcond (g : Graph) (result : List NodeId) : Prop :=
  result = g.nodes.map Prod.fst ∧
  ∀ n, n ∈ result ↔ g.hasNode n = true

theorem Graph.nodeList_spec (g : Graph) :
    Graph.nodeList_postcond g (g.nodeList) := by
  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/-- BFS reachability on a graph: can we reach `target` from `source`? -/
def Graph.reachable (g : Graph) (source target : NodeId) : Bool :=
  let rec bfs (queue : List NodeId) (visited : List NodeId) (fuel : Nat) : Bool :=
    match fuel with
    | 0 => target ∈ visited
    | fuel' + 1 =>
      match queue with
      | [] => target ∈ visited
      | n :: rest =>
        if n == target then true
        else if n ∈ visited then bfs rest visited fuel'
        else
          let nbrs := g.edges.filterMap (fun (a, b, _) =>
            if a == n then some b else if b == n then some a else none)
          bfs (rest ++ nbrs) (n :: visited) fuel'
  bfs [source] [] (2 * g.edges.length + g.nodes.length + 1)

end NetworkX
-- === END: FIXED_FINAL ===
