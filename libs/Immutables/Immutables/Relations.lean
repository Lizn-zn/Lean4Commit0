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
import Immutables.Get

namespace Immutables

/-! ## Relational: ImmutableSet.union_contains -/

@[reducible]
def ImmutableSet.union_contains_rel [BEq α] (a b : ImmutableSet α) (v : α)
    (result : Bool) : Prop :=
  result = (a.contains v || b.contains v)

theorem ImmutableSet.union_contains_spec [BEq α] [LawfulBEq α] (a b : ImmutableSet α) (v : α) :
    ImmutableSet.union_contains_rel a b v ((a.union b).contains v) := by 
                                                                         
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                         sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: ImmutableMap.containsKey_get -/

@[reducible]
def ImmutableMap.containsKey_get_rel [BEq α] (m : ImmutableMap α β) (k : α)
    (containsResult : Bool) (getResult : Option β) : Prop :=
  (containsResult = true ↔ getResult.isSome = true)

theorem ImmutableMap.containsKey_get_spec [BEq α] [LawfulBEq α] (m : ImmutableMap α β) (k : α) :
    ImmutableMap.containsKey_get_rel m k (m.containsKey k) (m.get k) := by 
                                                                           
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
                                                                           sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Immutables
-- === END: FIXED_FINAL ===
