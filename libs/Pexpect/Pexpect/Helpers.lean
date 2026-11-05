-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Pexpect.Types

namespace Pexpect

/-! ## Pure helpers for postcondition use -/

/-- Check whether `needle` occurs as a substring of `haystack`. -/
def containsSubstr (haystack : String) (needle : String) : Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-- Pure helper: check if `needle` appears at position `i` in `haystack`. -/
def substringAt (haystack needle : String) (i : Nat) : Bool :=
  if i + needle.length > haystack.length then false
  else (haystack.drop i).take needle.length == needle

/-- Pure helper: check if `needle` occurs as a substring of `haystack` at any position. -/
def hasSubstring (haystack needle : String) : Bool :=
  if needle == "" then true
  else
    let n := haystack.length
    (List.range n).any (substringAt haystack needle)

/-- Pure helper: check if any exact pattern in a list matches (is a substring of) the buffer. -/
def anyExactMatch (patterns : List Pattern) (buffer : String) : Bool :=
  patterns.any (fun p => match p with
    | Pattern.exact s => if s.isEmpty then true else hasSubstring buffer s
    | _ => false)

@[reducible]
def containsSubstr_postcond (haystack needle : String) (result : Bool) : Prop :=
  (needle = "" → result = true) ∧
  (haystack = "" → needle ≠ "" → result = false) ∧
  (result = true → needle.length ≤ haystack.length) ∧
  (result = true ↔ hasSubstring haystack needle = true)

theorem containsSubstr_spec (haystack needle : String) :
    containsSubstr_postcond haystack needle (containsSubstr haystack needle) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Pexpect
-- === END: FIXED_FINAL ===
