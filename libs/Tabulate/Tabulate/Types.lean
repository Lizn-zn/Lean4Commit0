-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Tabulate

inductive TableFormat where
  | plain | simple | grid | pipe | orgtbl
  | rst | mediawiki | html | latex | tsv | csv
  deriving Repr, BEq


inductive Alignment where
  | left | center | right | decimal
  deriving Repr, BEq


structure FormatConfig where
  headerSep     : Option String
  rowSep        : Option String
  lineBetween   : Option String
  lineAbove     : Option String
  lineBelow     : Option String
  colSep        : String
  headerColSep  : String
  padding       : Nat := 1
  deriving Repr, BEq


end Tabulate
-- === END: FIXED_FINAL ===
