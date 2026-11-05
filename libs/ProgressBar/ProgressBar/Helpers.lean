-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import ProgressBar.Types


/-- Check if `sub` is a substring of `s`. -/
def _root_.ProgressBar.containsSubstr (s sub : String) : Bool := 
                                                                 
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                 sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===




namespace ProgressBar


/-- Sum of literal segment lengths -/
def FormatSpec.literalWidth (fmt : FormatSpec) : Nat :=
  fmt.segments.foldl (fun acc s =>
    match s with
    | FormatSegment.literal str => acc + str.length
    | _ => acc) 0

end ProgressBar
-- === END: FIXED_FINAL ===
