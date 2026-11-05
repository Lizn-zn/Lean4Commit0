-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # SqlParse
   A non-validating SQL parser.

   Ported from Python's `sqlparse` library.
   Original: https://github.com/andialbrecht/sqlparse

   This is a summarized version containing only the 3 most essential
   function specs: tokenize, parse, format.
-/

namespace SqlParse

inductive TokenType where
  | numberInteger : TokenType
  | numberFloat : TokenType
  | stringSingle : TokenType
  | stringSymbol : TokenType
  | keyword : TokenType
  | keywordDML : TokenType
  | keywordDDL : TokenType
  | keywordCTE : TokenType
  | keywordOrder : TokenType
  | comparison : TokenType
  | assignment : TokenType
  | operator : TokenType
  | punctuation : TokenType
  | comma : TokenType
  | semicolon : TokenType
  | dot : TokenType
  | name : TokenType
  | namePlaceholder : TokenType
  | whitespace : TokenType
  | newline : TokenType
  | commentSingle : TokenType
  | commentMulti : TokenType
  | wildcard : TokenType
  | other : TokenType
  deriving Repr, BEq, DecidableEq

structure Token where
  ttype : TokenType
  value : String
  deriving Repr, BEq

inductive GroupType where
  | statement : GroupType
  | identifier : GroupType
  | identifierList : GroupType
  | parenthesis : GroupType
  | where_ : GroupType
  | having : GroupType
  | comparison : GroupType
  | operation : GroupType
  | function : GroupType
  | values : GroupType
  | assignment : GroupType
  | orderBy : GroupType
  | typedLiteral : GroupType
  | comment : GroupType
  | case_ : GroupType
  deriving Repr, BEq

inductive TokenTree where
  | leaf (token : Token) : TokenTree
  | group (groupType : GroupType) (children : List TokenTree) : TokenTree
  deriving Repr

inductive KeywordCase where
  | upper : KeywordCase
  | lower : KeywordCase
  | capitalize : KeywordCase
  deriving Repr, BEq, DecidableEq

inductive IdentifierCase where
  | upper : IdentifierCase
  | lower : IdentifierCase
  deriving Repr, BEq, DecidableEq

inductive OutputFormat where
  | sql : OutputFormat
  | python : OutputFormat
  | php : OutputFormat
  deriving Repr, BEq, DecidableEq

structure FormatOptions where
  keywordCase : Option KeywordCase := none
  identifierCase : Option IdentifierCase := none
  indent : Bool := false
  indentWidth : Nat := 2
  indentAfterFirst : Bool := false
  stripComments : Bool := false
  stripWhitespace : Bool := false
  reindent : Bool := false
  reindentAligned : Bool := false
  comma_first : Bool := false
  truncateStrings : Option Nat := none
  outputFormat : Option OutputFormat := none
  deriving Repr, BEq, DecidableEq

end SqlParse
-- === END: FIXED_FINAL ===
