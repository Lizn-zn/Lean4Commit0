-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Portalocker.Types
import Portalocker.Helpers
import Portalocker.Acquire

namespace Portalocker


/-! ## Core Function 2: Lock.release -/

/-- Release a lock held by the given holder. -/
def Lock.release (lock : Lock) (holder : LockHolderId) : Option Lock :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def Lock.release_postcond (lock : Lock) (holder : LockHolderId) (result : Option Lock) : Prop :=
  (lock.state = .unlocked → result = none) ∧
  (∀ h1, lock.state = .exclusiveBy h1 → h1 = holder → result.isSome = true) ∧
  (∀ l, result = some l → lock.state = .exclusiveBy holder → l.state = .unlocked) ∧
  (∀ h1, lock.state = .exclusiveBy h1 → h1 ≠ holder → result = none) ∧
  (∀ l, result = some l → l.name = lock.name) ∧
  (∀ hs, lock.state = .sharedBy hs → holder ∈ hs → result.isSome = true) ∧
  (∀ hs, lock.state = .sharedBy hs → holder ∉ hs → result = none) ∧
  (∀ l hs, result = some l → lock.state = .sharedBy hs → holder ∈ hs →
    (hs.filter (· != holder) = [] → l.state = .unlocked) ∧
    (hs.filter (· != holder) ≠ [] → l.state = .sharedBy (hs.filter (· != holder))))


theorem Lock.release_spec (lock : Lock) (holder : LockHolderId) :
    Lock.release_postcond lock holder (lock.release holder) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Portalocker
-- === END: FIXED_FINAL ===
