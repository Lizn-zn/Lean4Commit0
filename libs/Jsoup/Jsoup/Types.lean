-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Jsoup
/-! ## Types -/
structure Attribute where
  name : String
  value : String
  deriving Repr, BEq
/-- An HTML node in the DOM tree. -/
inductive Node where
  | element : String → List Attribute → List Node → Node
  | textNode : String → Node
  | comment : String → Node
  | dataNode : String → Node
  | documentType : String → String → String → Node
  deriving Repr, BEq
end Jsoup
-- === END: FIXED_FINAL ===
