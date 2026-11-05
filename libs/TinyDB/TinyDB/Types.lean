-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace TinyDB

inductive Value where
  | null   : Value
  | bool   : Bool → Value
  | int    : Int → Value
  | float  : Float → Value
  | str    : String → Value
  | list   : List Value → Value
  | dict   : List (String × Value) → Value
  deriving Repr, BEq, Inhabited


structure Document where
  docId : Nat
  data : Value
  deriving Repr, BEq


inductive Query where
  | exists (field : String) : Query
  | eq (field : String) (value : Value) : Query
  | ne (field : String) (value : Value) : Query
  | lt (field : String) (value : Value) : Query
  | le (field : String) (value : Value) : Query
  | gt (field : String) (value : Value) : Query
  | ge (field : String) (value : Value) : Query
  | matches (field : String) (pattern : String) : Query
  | search (field : String) (substring : String) : Query
  | oneOf (field : String) (values : List Value) : Query
  | test (field : String) (predicate : Value → Bool) : Query
  | and (lhs rhs : Query) : Query
  | or (lhs rhs : Query) : Query
  | not (q : Query) : Query
  | nested (path : List String) (q : Query) : Query
  | all : Query
  | none : Query


structure Table where
  name : String
  documents : List Document
  nextId : Nat
  deriving Repr


end TinyDB
-- === END: FIXED_FINAL ===
