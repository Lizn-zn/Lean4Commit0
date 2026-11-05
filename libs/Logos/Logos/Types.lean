-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Logos
/-! ## Types -/
structure Span where
  start : Nat
  «end» : Nat
  deriving Repr, BEq
/-- A simple pattern for token matching. -/
inductive Pattern where
  | literal     : String → Pattern
  | charRange   : Char → Char → Pattern
  | charSet     : List Char → Pattern
  | sequence    : List Pattern → Pattern
  | oneOrMore   : Pattern → Pattern
  | zeroOrMore  : Pattern → Pattern
  | optional    : Pattern → Pattern
  | alt         : Pattern → Pattern → Pattern
  | any         : Pattern
  deriving Repr, BEq
/-- A token rule mapping a pattern to a token kind (identified by name). -/
structure TokenRule where
  kind    : String
  pattern : Pattern
  priority : Nat := 0
  deriving Repr, BEq
/-- Lexer definition: a list of token rules and optional skip patterns. -/
structure LexerDef where
  rules : List TokenRule
  skip  : Option Pattern := none
  deriving Repr, BEq
/-- A single token produced by the lexer. -/
structure Token where
  kind  : String
  slice : String
  span  : Span
  deriving Repr, BEq
/-- Lexer state during tokenization. -/
structure LexerState where
  source    : String
  position  : Nat
  deriving Repr, BEq
end Logos
-- === END: FIXED_FINAL ===
