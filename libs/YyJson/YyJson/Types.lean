-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace YyJson

inductive ValType where
  | null | bool | int | real | str | arr | obj
  deriving Repr, BEq


inductive Val where
  | null   : Val
  | bool   : Bool → Val
  | int    : Int → Val
  | real   : Float → Val
  | str    : String → Val
  | arr    : List Val → Val
  | obj    : List (String × Val) → Val
  deriving Repr, BEq, Inhabited


structure Doc where
  root : Val
  deriving Repr, BEq


end YyJson
-- === END: FIXED_FINAL ===
