-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Portalocker


/-! ## Types -/

/-- Type of lock to acquire. -/
inductive LockType where
  | shared     : LockType  -- read lock (multiple readers allowed)
  | exclusive  : LockType  -- write lock (exclusive access)
  deriving Repr, BEq, DecidableEq


/-- Identifier for a lock holder. -/
abbrev LockHolderId := Nat


/-- The state of a lock. -/
inductive LockState where
  | unlocked : LockState
  | sharedBy (holders : List LockHolderId) : LockState
  | exclusiveBy (holder : LockHolderId) : LockState
  deriving Repr, BEq


/-- A lock instance. -/
structure Lock where
  name : String
  state : LockState
  deriving Repr


/-- A reentrant (recursive) lock. -/
structure RLock where
  name : String
  holder : Option LockHolderId
  count : Nat
  deriving Repr

end Portalocker
-- === END: FIXED_FINAL ===
