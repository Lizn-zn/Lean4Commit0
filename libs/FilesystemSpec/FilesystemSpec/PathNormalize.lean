-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import FilesystemSpec.Types
import FilesystemSpec.Helpers
import FilesystemSpec.PathJoin

namespace FilesystemSpec

/-! ## Core Function 2: pathNormalize -/

def isAbsolute (path : String) : Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



def pathNormalize (path : String) : String :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def pathNormalize_postcond (path : String) (result : String) : Prop :=
  pathNormalize result = result ∧
  (¬ FilesystemSpec.containsSubstr result "//") ∧
  (result.length > 1 → result.back ≠ '/') ∧
  (isAbsolute path = true → isAbsolute result = true) ∧
  (path = "" → result = "." ∨ result = "") ∧
  (¬ FilesystemSpec.containsSubstr result "/./") ∧
  (¬ FilesystemSpec.containsSubstr path "//" → ¬ FilesystemSpec.containsSubstr path "/./" →
    ¬ FilesystemSpec.containsSubstr path "/../" → ¬ path.endsWith "/" →
    ¬ path.endsWith "/." → ¬ path.endsWith "/.." →
    ¬ path.startsWith "./" → path ≠ "." → path ≠ ".." → path ≠ "" →
    result = path) ∧
  -- Strengthening 1: result has no /../ traversals (normalization resolves all ..)
  (¬ FilesystemSpec.containsSubstr result "/../") ∧
  -- Strengthening 2: result does not start with ./
  (¬ result.startsWith "./") ∧
  -- Strengthening 3: for paths without .., every non-empty non-. segment is preserved
  (¬ FilesystemSpec.containsSubstr path ".." →
    ((path.splitOn "/").filter (fun s => s ≠ "" && s ≠ ".")).all
      (fun seg => FilesystemSpec.containsSubstr result seg)) ∧
  -- Strengthening 4: the last non-empty path segment (if not . or ..) must appear in result
  (match ((path.splitOn "/").filter (fun s => s ≠ "")).getLast? with
   | none => True
   | some p => p = ".." ∨ p = "." ∨ FilesystemSpec.containsSubstr result p)

theorem pathNormalize_spec (path : String) :
    pathNormalize_postcond path (pathNormalize path) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end FilesystemSpec
-- === END: FIXED_FINAL ===
