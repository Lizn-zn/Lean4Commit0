-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Scrapy

/-! ## Types -/

/-- An attribute on an HTML/XML element. -/
structure Attribute where
  name  : String
  value : String
  deriving Repr, BEq

/-- An HTML/XML node in a document tree. -/
inductive Node where
  | text    : String → Node
  | comment : String → Node
  | element : String → List Attribute → List Node → Node
  deriving Repr, BEq

/-- Get the tag name of an element node. -/
def Node.tagName : Node → Option String
  | .element name _ _ => some name
  | _ => none

/-- Get the attributes of an element node. -/
def Node.attributes : Node → List Attribute
  | .element _ attrs _ => attrs
  | _ => []

/-- Get the children of an element node. -/
def Node.children : Node → List Node
  | .element _ _ children => children
  | _ => []

/-- A simple CSS selector component. -/
inductive SelectorPart where
  | tag       : String → SelectorPart
  | className : String → SelectorPart
  | idSel     : String → SelectorPart
  | attr      : String → SelectorPart
  | attrEq    : String → String → SelectorPart
  | attrContains : String → String → SelectorPart
  | attrStartsWith : String → String → SelectorPart
  | attrEndsWith : String → String → SelectorPart
  | pseudoClass : String → SelectorPart
  | universal : SelectorPart
  deriving Repr, BEq

/-- CSS combinator between selector parts. -/
inductive Combinator where
  | descendant : Combinator
  | child      : Combinator
  | adjacent   : Combinator
  | sibling    : Combinator
  deriving Repr, BEq, DecidableEq

/-- A compound selector (multiple parts that all apply to the same element). -/
structure CompoundSelector where
  parts : List SelectorPart
  deriving Repr, BEq

/-- A complex selector: a chain of compound selectors with combinators. -/
structure CSSSelector where
  chain : List (CompoundSelector × Option Combinator)
  deriving Repr, BEq

/-- An XPath axis. -/
inductive XPathAxis where
  | child_      | descendant_ | parent_ | ancestor_
  | selfAxis    | attribute_  | following_ | preceding_
  deriving Repr, BEq, DecidableEq

/-- An XPath node test. -/
inductive XPathNodeTest where
  | nameTest : String → XPathNodeTest
  | wildcard : XPathNodeTest
  | textTest : XPathNodeTest
  | nodeTest : XPathNodeTest
  deriving Repr, BEq

/-- An XPath predicate expression (simplified). -/
inductive XPathPredicate where
  | position : Nat → XPathPredicate
  | attrExists : String → XPathPredicate
  | attrEq : String → String → XPathPredicate
  | textEq : String → XPathPredicate
  | contains : String → String → XPathPredicate
  deriving Repr, BEq

/-- A single step in an XPath expression. -/
structure XPathStep where
  axis       : XPathAxis
  nodeTest   : XPathNodeTest
  predicates : List XPathPredicate
  deriving Repr, BEq

/-- An extracted link. -/
structure Link where
  url  : String
  text : String
  noFollow : Bool
  deriving Repr, BEq

end Scrapy
-- === END: FIXED_FINAL ===
