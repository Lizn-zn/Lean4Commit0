-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Parsel

/-! ## Types -/

/-- An attribute on an HTML/XML element. -/
structure Attribute where
  name  : String
  value : String
  deriving Repr, BEq

/-- A node in an HTML/XML document tree. -/
inductive Node where
  | element  : String → List Attribute → List Node → Node
  | text     : String → Node
  | comment  : String → Node
  | cdata    : String → Node
  | processingInstruction : String → String → Node
  deriving Repr, BEq

/-- Attribute selector operators. -/
inductive AttrOp where
  | exists_     : AttrOp
  | equals      : AttrOp
  | contains    : AttrOp
  | startsWith  : AttrOp
  | endsWith    : AttrOp
  | dashMatch   : AttrOp
  | includes    : AttrOp
  deriving Repr, BEq

/-- Pseudo-class selectors. -/
inductive PseudoClass where
  | firstChild       : PseudoClass
  | lastChild        : PseudoClass
  | nthChild         : Int → Int → PseudoClass
  | nthLastChild     : Int → Int → PseudoClass
  | firstOfType      : PseudoClass
  | lastOfType       : PseudoClass
  | nthOfType        : Int → Int → PseudoClass
  | nthLastOfType    : Int → Int → PseudoClass
  | onlyChild        : PseudoClass
  | onlyOfType       : PseudoClass
  | empty            : PseudoClass
  | root             : PseudoClass
  | notTag           : String → PseudoClass
  | notClass         : String → PseudoClass
  | notId            : String → PseudoClass
  deriving Repr, BEq

/-- A simple selector (single component). -/
inductive SimpleSelector where
  | universal   : SimpleSelector
  | tag         : String → SimpleSelector
  | className   : String → SimpleSelector
  | idSelector  : String → SimpleSelector
  | attribute   : String → AttrOp → Option String → SimpleSelector
  | pseudo      : PseudoClass → SimpleSelector
  deriving Repr, BEq

/-- Combinator types between selectors. -/
inductive Combinator where
  | descendant       : Combinator
  | child            : Combinator
  | adjacentSibling  : Combinator
  | generalSibling   : Combinator
  deriving Repr, BEq

/-- A compound selector (sequence of simple selectors). -/
abbrev CompoundSelector := List SimpleSelector

/-- A complex selector (compound selectors joined by combinators). -/
structure ComplexSelector where
  head       : CompoundSelector
  tail       : List (Combinator × CompoundSelector) := []
  deriving Repr, BEq

/-- A selector list (comma-separated complex selectors). -/
abbrev SelectorList := List ComplexSelector

end Parsel
-- === END: FIXED_FINAL ===
