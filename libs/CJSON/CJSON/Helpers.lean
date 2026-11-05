-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import CJSON.Types

namespace CJSON

/-- Check if s2 is a substring of s1 -/
def containsSub (s1 s2 : String) : Bool :=
  if s2.length == 0 then true
  else if s2.length > s1.length then false
  else
    let rec go (i : Nat) (fuel : Nat) : Bool :=
      match fuel with
      | 0 => false
      | fuel + 1 =>
        if i + s2.length > s1.length then false
        else if (s1.drop i).take s2.length == s2 then true
        else go (i + 1) fuel
    go 0 (s1.length - s2.length + 1)

def getItem (j : JSON) (key : String) : Option JSON :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



def hasItem (j : JSON) (key : String) : Bool :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end CJSON
-- === END: FIXED_FINAL ===
