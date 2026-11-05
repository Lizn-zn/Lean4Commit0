-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import FilesystemSpec.Types
import FilesystemSpec.Helpers
import FilesystemSpec.PathJoin
import FilesystemSpec.PathNormalize

namespace FilesystemSpec

/-! ## Core Function 3: MemFS.put -/

def MemFS.exists_ (fs : MemFS) (path : String) : Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



def MemFS.cat (fs : MemFS) (path : String) : FSResult ByteArray :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



def MemFS.put (fs : MemFS) (path : String) (content : ByteArray)
    : FSResult MemFS :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def MemFS.put_postcond (fs : MemFS) (path : String) (content : ByteArray) (result : FSResult MemFS) : Prop :=
  -- Strengthening: put on a non-empty path must succeed (blocks always-error cheat)
  (path ≠ "" → ∃ fs', result = Except.ok fs') ∧
  (∀ fs', result = Except.ok fs' → fs'.exists_ path = true) ∧
  (∀ fs', result = Except.ok fs' → fs'.cat path = Except.ok content)

theorem MemFS.put_spec (fs : MemFS) (path : String) (content : ByteArray) :
    MemFS.put_postcond fs path content (fs.put path content) := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end FilesystemSpec
-- === END: FIXED_FINAL ===
