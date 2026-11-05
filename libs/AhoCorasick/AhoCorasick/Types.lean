-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace AhoCorasick

/-! ## Types -/

/-- A match result: pattern index and position span [start, end) in the haystack. -/
structure Match where
  patternIndex : Nat
  start        : Nat
  «end»        : Nat
  deriving Repr, BEq

/-- A node in the Aho-Corasick trie. -/
structure TrieNode where
  children    : List (Char × Nat)   -- (character, child node ID)
  failure     : Nat                  -- failure link (node ID)
  output      : List Nat             -- pattern indices that end here
  depth       : Nat
  deriving Repr, BEq

/-- The Aho-Corasick automaton. -/
structure Automaton where
  nodes    : List TrieNode
  patterns : List String
  deriving Repr, BEq

/-- Match semantics: how overlapping matches are handled. -/
inductive MatchKind where
  | standard        : MatchKind  -- leftmost-first, non-overlapping
  | leftmostFirst   : MatchKind  -- leftmost start, prefer first pattern
  | leftmostLongest : MatchKind  -- leftmost start, prefer longest match
  deriving Repr, BEq

deriving instance Inhabited for TrieNode

end AhoCorasick
-- === END: FIXED_FINAL ===
