-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import SmallVec.Insert

namespace SmallVec

def SmallVec.drain (v : SmallVec α) (start stop : Nat) : SmallVec α × List α :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def SmallVec.drain_postcond (v : SmallVec α) (start stop : Nat) (result : SmallVec α × List α) : Prop :=
  start ≤ stop → stop ≤ v.data.length →
    result.2 = (v.data.drop start).take (stop - start) ∧
    result.1.data = v.data.take start ++ v.data.drop stop ∧
    result.1.inlineCap = v.inlineCap

theorem SmallVec.drain_spec (v : SmallVec α) (start stop : Nat) :
    SmallVec.drain_postcond v start stop (v.drain start stop) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SmallVec
-- === END: FIXED_FINAL ===
