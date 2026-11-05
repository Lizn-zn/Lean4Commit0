-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace FilesystemSpec

/-! ## Types -/

/-- An in-memory file. -/
structure MemFile where
  content  : ByteArray
  modified : Nat
  created  : Nat
  deriving BEq

/-- An in-memory directory entry (file or directory). -/
inductive MemNode where
  | file : MemFile → MemNode
  | dir  : List (String × MemNode) → Nat → MemNode
  deriving BEq

/-- In-memory filesystem state. -/
structure MemFS where
  root        : List (String × MemNode)
  currentTime : Nat
  deriving BEq

/-- Filesystem operation error. -/
inductive FSError where
  | fileNotFound     : String → FSError
  | isADirectory     : String → FSError
  | notADirectory    : String → FSError
  | alreadyExists    : String → FSError
  | permissionDenied : String → FSError
  | invalidPath      : String → FSError
  deriving Repr, BEq

/-- Result type for filesystem operations. -/
abbrev FSResult (α : Type) := Except FSError α


end FilesystemSpec
-- === END: FIXED_FINAL ===
