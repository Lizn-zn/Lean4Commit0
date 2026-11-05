-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import SmallVec.Push

namespace SmallVec

def SmallVec.insert (v : SmallVec α) (i : Nat) (x : α) : SmallVec α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def SmallVec.insert_postcond (v : SmallVec α) (i : Nat) (x : α) (result : SmallVec α) : Prop :=
  (i ≤ v.data.length →
    result.data = v.data.take i ++ [x] ++ v.data.drop i) ∧
  result.inlineCap = v.inlineCap

theorem SmallVec.insert_spec (v : SmallVec α) (i : Nat) (x : α) :
    SmallVec.insert_postcond v i x (v.insert i x) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SmallVec
-- === END: FIXED_FINAL ===
