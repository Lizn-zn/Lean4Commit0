-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import AhoCorasick.Build

namespace AhoCorasick

/-! ## Searching -/

/-- Find all non-overlapping matches (leftmost-first). -/
def findAll (a : Automaton) (haystack : String) : List Match :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def findAll_postcond (a : Automaton) (haystack : String) (result : List Match) : Prop :=
  (∀ m ∈ result,
    m.patternIndex < a.patterns.length ∧
    m.start ≤ m.«end» ∧
    m.«end» ≤ haystack.length ∧
    (haystack.drop m.start).take (m.«end» - m.start) = a.patterns[m.patternIndex]!) ∧
  List.Pairwise (fun m1 m2 => m1.«end» ≤ m2.start) result ∧
  (∀ (pos pidx : Nat),
    pidx < a.patterns.length →
    a.patterns[pidx]! ≠ "" →
    (haystack.drop pos).take a.patterns[pidx]!.length = a.patterns[pidx]! →
    pos + a.patterns[pidx]!.length ≤ haystack.length →
    ∃ m ∈ result, m.start ≤ pos ∧ pos < m.«end»)

theorem findAll_spec (patterns : List String) (haystack : String) :
    let a := build patterns
    findAll_postcond a haystack (findAll a haystack) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Helper: isMatch -/

/-- Check if any pattern matches. -/

def isMatch (a : Automaton) (haystack : String) : Bool :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end AhoCorasick
-- === END: FIXED_FINAL ===
