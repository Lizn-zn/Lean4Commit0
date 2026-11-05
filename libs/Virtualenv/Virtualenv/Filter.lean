-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Virtualenv.Types
import Virtualenv.Helpers

namespace Virtualenv

def VersionSpecSet.filter (specs : VersionSpecSet) (versions : List Version) : List Version :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def VersionSpecSet.filter_postcond (specs : VersionSpecSet) (versions : List Version) (result : List Version) : Prop :=
  (versions = [] → result = []) ∧
  (∀ v, v ∈ result → v ∈ versions) ∧
  result.length ≤ versions.length ∧
  (specs.specs = [] → result = versions) ∧
  (∀ v, v ∈ versions → VersionSpecSet.matches specs v = true → v ∈ result) ∧
  (∀ v, v ∈ result → VersionSpecSet.matches specs v = true)


theorem VersionSpecSet.filter_spec (specs : VersionSpecSet) (versions : List Version) :
    VersionSpecSet.filter_postcond specs versions (VersionSpecSet.filter specs versions) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/- Environment markers. -/

end Virtualenv
-- === END: FIXED_FINAL ===
