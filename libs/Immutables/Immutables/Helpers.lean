-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Immutables.Types

namespace Immutables

/-! ## Helper: ImmutableSet.contains -/

def ImmutableSet.contains [BEq α] (s : ImmutableSet α) (v : α) : Bool := 
                                                                         
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                         sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def ImmutableSet.contains_postcond [BEq α] (s : ImmutableSet α) (v : α) (result : Bool) : Prop :=
  (result = true ↔ s.data.any (· == v) = true)

theorem ImmutableSet.contains_spec [BEq α] [LawfulBEq α] (s : ImmutableSet α) (v : α) :
    ImmutableSet.contains_postcond s v (s.contains v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Helper: ImmutableMap.containsKey -/

def ImmutableMap.containsKey [BEq α] (m : ImmutableMap α β) (k : α) : Bool := 
                                                                              
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
                                                                              sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def ImmutableMap.containsKey_postcond [BEq α] (m : ImmutableMap α β) (k : α) (result : Bool) : Prop :=
  result = m.data.any (fun p => p.1 == k)

theorem ImmutableMap.containsKey_spec [BEq α] [LawfulBEq α] (m : ImmutableMap α β) (k : α) :
    ImmutableMap.containsKey_postcond m k (m.containsKey k) := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Immutables
-- === END: FIXED_FINAL ===
