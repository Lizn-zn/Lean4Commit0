-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Pest

/-! ## Types -/

/-- A span within the input: [start, end) byte positions. -/
structure Span where
  start : Nat
  «end» : Nat
  deriving Repr, BEq

/-- A parsing expression in a PEG grammar. -/
inductive Expr where
  | literal    : String → Expr
  | insensitive : String → Expr
  | range      : Char → Char → Expr
  | any        : Expr
  | sequence   : List Expr → Expr
  | choice     : List Expr → Expr
  | optional   : Expr → Expr
  | zeroOrMore : Expr → Expr
  | oneOrMore  : Expr → Expr
  | posLookahead : Expr → Expr
  | negLookahead : Expr → Expr
  | push       : Expr → Expr
  | peek       : Expr
  deriving Repr, BEq

/-- A named rule in a grammar. -/
structure Rule where
  name : String
  expr : Expr
  deriving Repr, BEq

/-- A grammar is a list of named rules with a designated start rule. -/
structure Grammar where
  rules : List Rule
  start : String
  deriving Repr, BEq

/-- A parse-tree node (called a "Pair" in Pest). -/
inductive ParseNode where
  | leaf : (rule : String) → (span : Span) → ParseNode
  | node : (rule : String) → (span : Span) → (children : List ParseNode) → ParseNode
  deriving Repr, BEq

/-- A token -- the leaves of a parse traversal. -/
inductive Token where
  | start : (rule : String) → (pos : Nat) → Token
  | «end» : (rule : String) → (pos : Nat) → Token
  deriving Repr, BEq

end Pest
-- === END: FIXED_FINAL ===
