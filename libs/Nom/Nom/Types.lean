-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Nom

/-! ## Parse Result -/

/-- The result of a parser: success with remaining input and value, or failure. -/
inductive ParseResult (α : Type) where
  | ok  : (remaining : String) → (value : α) → ParseResult α
  | err : (message : String) → ParseResult α
  deriving Repr

/-- A parser is a function from input string to parse result. -/
def Parser (α : Type) := String → ParseResult α

end Nom
-- === END: FIXED_FINAL ===
