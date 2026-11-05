-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Re2


/-! ## AST -/

inductive AnchorKind where
  | none | start | end_ | both
  deriving Repr, BEq


inductive RegexOp where
  | empty       : RegexOp
  | literal     : Char → RegexOp
  | litString   : String → RegexOp
  | charClass   : (negated : Bool) → List (Char × Char) → RegexOp
  | anyChar     : RegexOp
  | anyByte     : RegexOp
  | concat      : List RegexOp → RegexOp
  | alternate   : List RegexOp → RegexOp
  | repeat_     : RegexOp → (min : Nat) → (max : Option Nat) → (greedy : Bool) → RegexOp
  | capture     : (index : Nat) → (name : Option String) → RegexOp → RegexOp
  | anchor      : AnchorKind → RegexOp
  deriving Repr, BEq


/-! ## Compiled Program -/

inductive Inst where
  | match_    : Inst
  | char      : Char → Nat → Inst
  | charClass : (negated : Bool) → List (Char × Char) → Nat → Inst
  | anyChar   : Nat → Inst
  | jump      : Nat → Inst
  | split     : Nat → Nat → Inst
  | save      : Nat → Nat → Inst
  | fail      : Inst
  deriving Repr, BEq


structure Prog where
  insts : List Inst
  start : Nat
  numCaptures : Nat
  deriving Repr, BEq

end Re2
-- === END: FIXED_FINAL ===
