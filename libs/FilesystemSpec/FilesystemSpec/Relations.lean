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
import FilesystemSpec.MemFSPut

namespace FilesystemSpec

/-! ## Relational: pathJoin/pathSplit roundtrip -/

def pathSplit (path : String) : String × String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def pathJoin_pathSplit_roundtrip_rel (dir : String) (base : String) (result : String × String) : Prop :=
  dir ≠ "" → base ≠ "" → ¬ base.contains '/' → result = (dir, base)

theorem pathJoin_pathSplit_roundtrip_spec (dir : String) (base : String)
    (hdir : dir ≠ "") (hbase : base ≠ "")
    (hno_sep : ¬ base.contains '/') 
    (hcanonical_dir : dir = "/" ∨ dir.back ≠ '/') :
    pathJoin_pathSplit_roundtrip_rel dir base (pathSplit (pathJoin dir base)) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end FilesystemSpec
-- === END: FIXED_FINAL ===
