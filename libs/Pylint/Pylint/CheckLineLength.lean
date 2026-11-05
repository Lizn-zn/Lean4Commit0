-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Pylint.Types

namespace Pylint


/-! ## Core Function 1: Line Length Check -/

/-- Check for lines exceeding a maximum length. -/
def checkLineLength (maxLen : Nat) (source : String) (filePath : String) : List Message :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def checkLineLength_postcond (maxLen : Nat) (source : String) (filePath : String) (result : List Message) : Prop :=
  (source = "" → result = []) ∧
  ((∀ line ∈ source.splitOn "\n", line.length ≤ maxLen) → result = []) ∧
  ((∃ line ∈ source.splitOn "\n", line.length > maxLen) → result.length > 0) ∧
  result.length = ((source.splitOn "\n").filter (fun l => l.length > maxLen)).length ∧
  (∀ m ∈ result, m.filePath = filePath) ∧
  (∀ m ∈ result, m.msgId = "C0301") ∧
  (∀ m ∈ result, m.line ≥ 1 ∧ m.line ≤ (source.splitOn "\n").length ∧
    ((source.splitOn "\n").getD (m.line - 1) "").length > maxLen)


theorem checkLineLength_spec (maxLen : Nat) (source : String) (filePath : String) :
    checkLineLength_postcond maxLen source filePath (checkLineLength maxLen source filePath) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Pylint
-- === END: FIXED_FINAL ===
