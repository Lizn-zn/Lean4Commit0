-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import DashMap.Types

namespace DashMap

/-! ## Core Function 1: insert -/

def DashMap.insert [BEq α] (m : DashMap α β) (k : α) (v : β) : DashMap α β :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def DashMap.insert_postcond [BEq α] (m : DashMap α β) (k : α) (v : β) (result : DashMap α β) : Prop :=
  result.data.length ≤ m.data.length + 1 ∧
  (∃ pair ∈ result.data, pair.1 == k ∧ pair.2 = v) ∧
  (∀ pair ∈ result.data, pair.1 == k → pair.2 = v) ∧
  (∀ pair ∈ m.data, ¬ (pair.1 == k) → pair ∈ result.data)

theorem DashMap.insert_spec [BEq α] [LawfulBEq α] (m : DashMap α β) (k : α) (v : β) :
    DashMap.insert_postcond m k v (m.insert k v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end DashMap
-- === END: FIXED_FINAL ===
