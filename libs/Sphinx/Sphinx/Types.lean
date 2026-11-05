-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # Sphinx
   A documentation generator for Python projects.

   Ported from Python's `sphinx` library.
   Original: https://github.com/sphinx-doc/sphinx

   This is a summarized version containing only the 3 most essential
   function specs: parseRst, resolveRef, parseInline.
-/

namespace Sphinx

inductive HeadingLevel where
  | part | chapter | section | subsection | subsubsection | paragraph
  deriving Repr, BEq, DecidableEq

inductive InlineNode where
  | text : String → InlineNode
  | emphasis : String → InlineNode
  | strong : String → InlineNode
  | literal : String → InlineNode
  | reference : String → String → InlineNode
  | role : String → String → InlineNode
  | footnoteRef : String → InlineNode
  | substitutionRef : String → InlineNode
  deriving Repr, BEq

structure FieldEntry where
  name : String
  body : List String
  deriving Repr, BEq

structure DirectiveOptions where
  entries : List (String × String)
  deriving Repr, BEq

inductive RstNode where
  | document : List RstNode → RstNode
  | section_ : HeadingLevel → String → List RstNode → RstNode
  | paragraph : List InlineNode → RstNode
  | literalBlock : String → Option String → RstNode
  | blockQuote : List RstNode → RstNode
  | bulletList : List (List RstNode) → RstNode
  | enumList : List (List RstNode) → RstNode
  | defList : List (String × List RstNode) → RstNode
  | fieldList : List FieldEntry → RstNode
  | lineBlock : List String → RstNode
  | transition : RstNode
  | comment : String → RstNode
  | directive : String → List String → DirectiveOptions → List RstNode → RstNode
  | substitutionDef : String → List RstNode → RstNode
  | footnote : String → List RstNode → RstNode
  | target : String → String → RstNode
  | table : List (List String) → RstNode
  | raw : String → String → RstNode
  deriving Repr, BEq

inductive RefKind where
  | label | doc | any | term | numref | keyword | option | envvar
  deriving Repr, BEq, DecidableEq

structure RefTarget where
  kind : RefKind
  name : String
  docname : String
  anchorId : String
  title : Option String
  deriving Repr, BEq

structure PendingRef where
  kind : RefKind
  target : String
  docname : String
  lineNo : Nat
  deriving Repr, BEq

inductive RefResult where
  | resolved : RefTarget → RefResult
  | unresolved : String → RefResult
  | ambiguous : List RefTarget → RefResult
  deriving Repr, BEq

end Sphinx
-- === END: FIXED_FINAL ===
