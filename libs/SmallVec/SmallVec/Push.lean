-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import SmallVec.Types

namespace SmallVec

def SmallVec.push (v : SmallVec α) (x : α) : SmallVec α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def SmallVec.push_postcond (v : SmallVec α) (x : α) (result : SmallVec α) : Prop :=
  result.data = v.data ++ [x] ∧
  result.data.length = v.data.length + 1 ∧
  result.inlineCap = v.inlineCap

theorem SmallVec.push_spec (v : SmallVec α) (x : α) :
    SmallVec.push_postcond v x (v.push x) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SmallVec
-- === END: FIXED_FINAL ===
