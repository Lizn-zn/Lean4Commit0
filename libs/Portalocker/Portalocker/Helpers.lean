-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Portalocker.Types

namespace Portalocker


/-! ## Infrastructure: Lock.isLocked, Lock.isHeldBy, Lock.new, RLock.new -/

/-- Check if the lock is currently held. -/
def Lock.isLocked (lock : Lock) : Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def Lock.isLocked_postcond (lock : Lock) (result : Bool) : Prop :=
  (result = false ↔ lock.state = .unlocked)


theorem Lock.isLocked_spec (lock : Lock) :
    Lock.isLocked_postcond lock (lock.isLocked) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===




/-- Check if a specific holder holds the lock. -/
def Lock.isHeldBy (lock : Lock) (holder : LockHolderId) : Bool :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===




@[reducible]
def Lock.isHeldBy_postcond (lock : Lock) (holder : LockHolderId) (result : Bool) : Prop :=
  (result = true ↔
    (∃ hs, lock.state = .sharedBy hs ∧ holder ∈ hs) ∨
    lock.state = .exclusiveBy holder)


theorem Lock.isHeldBy_spec (lock : Lock) (holder : LockHolderId) :
    Lock.isHeldBy_postcond lock holder (lock.isHeldBy holder) := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===




/-- Create a new (unlocked) lock. -/
def Lock.new (name : String) : Lock :=
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===




@[reducible]
def Lock.new_postcond (name : String) (result : Lock) : Prop :=
  result.name = name ∧
  result.state = .unlocked ∧
  result.isLocked = false


theorem Lock.new_spec (name : String) :
    Lock.new_postcond name (Lock.new name) := by
  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_7 (provided) ===




/-- Create a new reentrant lock. -/
def RLock.new (name : String) : RLock :=
  
  
-- === END: FIXED_7 ===
-- === BEGIN: OBLIGATION_7 (editable) ===
  sorry
-- === END: OBLIGATION_7 ===
-- === BEGIN: FIXED_8 (provided) ===




@[reducible]
def RLock.new_postcond (name : String) (result : RLock) : Prop :=
  result.count = 0 ∧ result.holder = none ∧ result.name = name


theorem RLock.new_spec (name : String) :
    RLock.new_postcond name (RLock.new name) := by
  
  
-- === END: FIXED_8 ===
-- === BEGIN: OBLIGATION_8 (editable) ===
  sorry
-- === END: OBLIGATION_8 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Portalocker
-- === END: FIXED_FINAL ===
