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
import Portalocker.RLockAcquire

namespace Portalocker


/-! ## Relational Specs -/

@[reducible]
def acquire_release_rel (name : String) (h : LockHolderId) : Prop :=
  let l := Lock.new name
  (Lock.acquire l h .exclusive >>= fun l' => Lock.release l' h)
  = some (Lock.new name)


theorem acquire_release_spec (name : String) (h : LockHolderId) :
    acquire_release_rel name h := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def double_acquire_exclusive_rel (name : String) (h1 h2 : LockHolderId) : Prop :=
  let l := Lock.new name
  (Lock.acquire l h1 .exclusive >>= fun l' => Lock.acquire l' h2 .exclusive) = none


theorem double_acquire_exclusive_spec (name : String) (h1 h2 : LockHolderId) :
    double_acquire_exclusive_rel name h1 h2 := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===




@[reducible]
def shared_allows_multiple_rel (name : String) (h1 h2 : LockHolderId) : Prop :=
  let l := Lock.new name
  (Lock.acquire l h1 .shared >>= fun l' => Lock.acquire l' h2 .shared) =
    some ⟨name, .sharedBy [h1, h2]⟩


theorem shared_allows_multiple_spec (name : String) (h1 h2 : LockHolderId) :
    shared_allows_multiple_rel name h1 h2 := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Portalocker
-- === END: FIXED_FINAL ===
