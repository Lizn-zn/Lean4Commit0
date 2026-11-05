-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Regex.Types

namespace Regex

def findFirst (pattern : String) (input : String) : Option Match :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



def refindAllFrom (pattern : String) (input : String) (pos : Nat) (fuel : Nat) : List Match :=
  match fuel with
  | 0 => []
  | fuel + 1 =>
    match findFirst pattern (String.mk (input.toList.drop pos)) with
    | none => []
    | some m =>
      let absStart := m.start + pos
      let absEnd := m.«end» + pos
      let nextPos := if absEnd > pos then absEnd else pos + 1
      ⟨absStart, absEnd⟩ :: refindAllFrom pattern input nextPos fuel

def refindAll (pattern : String) (input : String) : List Match :=
  refindAllFrom pattern input 0 (input.length + 1)

def applyReplacements (input : String) (ms : List Match) (replacement : String) : String :=
  let chars := input.toList
  let rec go (remaining : List Match) (pos : Nat) : List Char :=
    match remaining with
    | [] => chars.drop pos
    | m :: rest =>
      let pre := (chars.drop pos).take (m.start - pos)
      pre ++ replacement.toList ++ go rest m.«end»
  String.ofList (go ms 0)

end Regex
-- === END: FIXED_FINAL ===
