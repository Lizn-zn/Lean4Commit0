-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import AhoCorasick.Search

namespace AhoCorasick

/-! ## Replacement -/

/-- Replace all non-overlapping matches. Each pattern index maps to a replacement. -/
def replaceAll (a : Automaton) (haystack : String) (replacements : List String) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-- Build the replaced string from haystack, matches and replacements.
    Walks the matches left-to-right, copying non-matched gaps and inserting
    the replacement for each matched span. -/
def buildReplacedString (haystack : String) (matchList : List Match)
    (patterns : List String) (replacements : List String) : String :=
  let rec go (ms : List Match) (pos : Nat) (acc : String) : String :=
    match ms with
    | [] => acc ++ (haystack.drop pos)
    | m :: rest =>
      let gap := (haystack.drop pos).take (m.start - pos)
      let repl := if m.patternIndex < replacements.length
                  then replacements[m.patternIndex]!
                  else if m.patternIndex < patterns.length
                  then patterns[m.patternIndex]!
                  else ""
      go rest m.«end» (acc ++ gap ++ repl)
  go matchList 0 ""

@[reducible]
def replaceAll_postcond (a : Automaton) (haystack : String) (replacements : List String) (result : String) : Prop :=
  (a.patterns = [] → result = haystack) ∧
  (haystack = "" → result = "") ∧
  (isMatch a haystack = false → result = haystack) ∧
  (replacements.length = a.patterns.length →
    let matchList := findAll a haystack
    matchList = [] → result = haystack) ∧
  (∀ i, i < a.patterns.length → i < replacements.length →
    a.patterns[i]! = replacements[i]! →
    isMatch a haystack = true →
    (∀ j, j < a.patterns.length → j < replacements.length →
      a.patterns[j]! = replacements[j]!) →
    result = haystack) ∧
  result = buildReplacedString haystack (findAll a haystack) a.patterns replacements

theorem replaceAll_spec (a : Automaton) (haystack : String) (replacements : List String) :
    replaceAll_postcond a haystack replacements (replaceAll a haystack replacements) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end AhoCorasick
-- === END: FIXED_FINAL ===
