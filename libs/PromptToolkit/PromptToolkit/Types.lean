-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace PromptToolkit


/-! ## Types -/

/-- A text document representing a buffer of lines with a cursor. -/
structure Document where
  text           : String
  cursorPosition : Nat
  deriving Repr, BEq


/-- A completion candidate. -/
structure Completion where
  text        : String
  startOffset : Int := 0
  displayText : String := ""
  description : String := ""
  deriving Repr, BEq

end PromptToolkit
-- === END: FIXED_FINAL ===
