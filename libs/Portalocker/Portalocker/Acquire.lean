-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Portalocker.Types
import Portalocker.Helpers

namespace Portalocker


/-! ## Core Function 1: Lock.acquire -/

/-- Attempt to acquire a lock. -/
def Lock.acquire (lock : Lock) (holder : LockHolderId)
    (lockType : LockType := .exclusive) (blocking : Bool := true)
    : Option Lock :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def Lock.acquire_postcond (lock : Lock) (holder : LockHolderId)
    (lockType : LockType) (blocking : Bool) (result : Option Lock) : Prop :=
  (lock.state = .unlocked → result.isSome = true) ∧
  (∀ h1, lock.state = .exclusiveBy h1 → result = none) ∧
  (∀ hs, lock.state = .sharedBy hs → lockType = .shared → result.isSome = true) ∧
  (∀ hs, lock.state = .sharedBy hs → lockType = .exclusive → result = none) ∧
  (∀ l, result = some l → l.isHeldBy holder = true) ∧
  (∀ l, result = some l → l.name = lock.name) ∧
  (∀ l, result = some l → lock.state = .unlocked → lockType = .shared →
    l.state = .sharedBy [holder]) ∧
  (∀ l, result = some l → lock.state = .unlocked → lockType = .exclusive →
    l.state = .exclusiveBy holder) ∧
  (∀ l hs, result = some l → lock.state = .sharedBy hs → lockType = .shared →
    l.state = .sharedBy (hs ++ [holder]))


theorem Lock.acquire_spec (lock : Lock) (holder : LockHolderId)
    (lockType : LockType) (blocking : Bool) :
    Lock.acquire_postcond lock holder lockType blocking (lock.acquire holder lockType blocking) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Portalocker
-- === END: FIXED_FINAL ===
