-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Immutables.Types
import Immutables.Helpers
import Immutables.Sorted

namespace Immutables

/-! ## Core Function 2: ImmutableSet.union -/

def ImmutableSet.union [BEq α] (a b : ImmutableSet α) : ImmutableSet α := 
                                                                          
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                          sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def ImmutableSet.union_postcond [BEq α] (a b : ImmutableSet α) (result : ImmutableSet α) : Prop :=
  (∀ v, result.data.any (· == v) = true →
    a.data.any (· == v) = true ∨ b.data.any (· == v) = true) ∧
  (∀ v, a.data.any (· == v) = true → result.data.any (· == v) = true) ∧
  (∀ v, b.data.any (· == v) = true → result.data.any (· == v) = true) ∧
  (∀ v, result.data.count v ≤ Nat.max (a.data.count v) (b.data.count v))

theorem ImmutableSet.union_spec [BEq α] [LawfulBEq α] (a b : ImmutableSet α) :
    ImmutableSet.union_postcond a b (a.union b) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Immutables
-- === END: FIXED_FINAL ===
