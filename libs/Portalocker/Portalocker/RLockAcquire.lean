-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Portalocker.Types
import Portalocker.Helpers
import Portalocker.Acquire
import Portalocker.Release

namespace Portalocker


/-! ## Core Function 3: RLock.acquire -/

/-- Acquire the reentrant lock. -/
def RLock.acquire (lock : RLock) (holder : LockHolderId) : Option RLock :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def RLock.acquire_postcond (lock : RLock) (holder : LockHolderId) (result : Option RLock) : Prop :=
  (lock.holder = none → result.isSome = true) ∧
  (lock.holder = some holder → result.isSome = true ∧
    ∀ r, result = some r → r.count = lock.count + 1) ∧
  (∀ other, lock.holder = some other → other ≠ holder → result = none) ∧
  (∀ r, result = some r → lock.holder = none →
    r.holder = some holder ∧ r.count = 1 ∧ r.name = lock.name) ∧
  (∀ r, result = some r → lock.holder = some holder →
    r.holder = some holder ∧ r.name = lock.name)


theorem RLock.acquire_spec (lock : RLock) (holder : LockHolderId) :
    RLock.acquire_postcond lock holder (lock.acquire holder) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Portalocker
-- === END: FIXED_FINAL ===
