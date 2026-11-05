-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import DashMap.Types

namespace DashMap

/-! ## Helper: new -/

def DashMap.new [BEq α] : DashMap α β :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def DashMap.new_postcond [BEq α] (result : DashMap α β) : Prop :=
  result.data = []

theorem DashMap.new_spec [BEq α] [LawfulBEq α] :
    DashMap.new_postcond (DashMap.new : DashMap α β) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end DashMap
-- === END: FIXED_FINAL ===
