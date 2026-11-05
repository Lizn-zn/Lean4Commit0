-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Dulwich

/-! ## Types -/

/-- A SHA-1 hash represented as a 40-character hex string. -/
abbrev Sha1 := String

/-- Git object types. -/
inductive ObjectType where
  | blob   : ObjectType
  | tree   : ObjectType
  | commit : ObjectType
  | tag    : ObjectType
  deriving Repr, BEq, DecidableEq

/-- Author/committer identity. -/
structure Identity where
  name      : String
  email     : String
  timestamp : Int
  tzOffset  : Int
  deriving Repr, BEq

/-- A commit object. -/
structure Commit where
  treeSha   : Sha1
  parents   : List Sha1
  author    : Identity
  committer : Identity
  message   : String
  sha       : Sha1
  encoding  : Option String
  gpgSig    : Option String
  deriving Repr, BEq

/-- A git reference (branch, tag, or symbolic). -/
inductive GitRef where
  | direct   : String → Sha1 → GitRef
  | symbolic : String → String → GitRef
  deriving Repr, BEq


end Dulwich
-- === END: FIXED_FINAL ===
