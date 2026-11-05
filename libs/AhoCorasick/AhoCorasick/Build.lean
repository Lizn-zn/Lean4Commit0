-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import AhoCorasick.Types

namespace AhoCorasick

/-! ## Construction -/

/-- Build an Aho-Corasick automaton from a list of patterns. -/
def build (patterns : List String) : Automaton :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-- Follow a path through the trie from a given nodeId.
    Returns the final nodeId after consuming all characters, or none if path not found. -/
def traceTriePath (nodes : List TrieNode) (nodeId : Nat) (path : List Char) : Option Nat :=
  match path with
  | [] => some nodeId
  | c :: rest =>
    if h : nodeId < nodes.length then
      let node := nodes[nodeId]
      match node.children.find? (fun p => p.1 == c) with
      | some (_, childId) => traceTriePath nodes childId rest
      | none => none
    else none

@[reducible]
def build_postcond (patterns : List String) (result : Automaton) : Prop :=
  (result.patterns = patterns) ∧
  ((result.nodes.length ≥ 1) ∧
   ((result.nodes.head!).failure = 0 ∧
    (result.nodes.head!).depth = 0)) ∧
  (∀ n ∈ result.nodes, n.failure < result.nodes.length) ∧
  (∀ n ∈ result.nodes, ∀ pidx ∈ n.output, pidx < patterns.length) ∧
  ((result.nodes.head!).output = [] ∨ patterns.any (· == "") = true) ∧
  (∀ n ∈ result.nodes, ∀ p ∈ n.children, p.2 < result.nodes.length) ∧
  (∀ n ∈ result.nodes, n.depth ≤ (patterns.map String.length).foldl Nat.max 0) ∧
  (∀ (pidx : Nat), pidx < patterns.length → patterns[pidx]! ≠ "" →
    ∃ finalId, traceTriePath result.nodes 0 patterns[pidx]!.toList = some finalId ∧
      finalId < result.nodes.length ∧
      pidx ∈ result.nodes[finalId]!.output)

theorem build_spec (patterns : List String) :
    build_postcond patterns (build patterns) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end AhoCorasick
-- === END: FIXED_FINAL ===
