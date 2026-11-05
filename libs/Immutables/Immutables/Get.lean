-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Immutables.Types
import Immutables.Helpers
import Immutables.Sorted
import Immutables.Union

namespace Immutables

/-! ## Core Function 3: ImmutableMap.get -/

def ImmutableMap.get [BEq α] (m : ImmutableMap α β) (k : α) : Option β := 
                                                                          
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                          sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def ImmutableMap.get_postcond [BEq α] (m : ImmutableMap α β) (k : α) (result : Option β) : Prop :=
  (result = none ↔ (m.data.find? (fun pair => pair.1 == k) = none)) ∧
  (∀ v, result = some v → ∃ kv, kv ∈ m.data ∧ (kv.1 == k) = true ∧ kv.2 = v)

theorem ImmutableMap.get_spec [BEq α] [LawfulBEq α] (m : ImmutableMap α β) (k : α) :
    ImmutableMap.get_postcond m k (m.get k) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Immutables
-- === END: FIXED_FINAL ===
