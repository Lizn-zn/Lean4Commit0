-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Bytes.Helpers

namespace Bytes

/-- Split at position, returning (prefix, suffix). -/
def Bytes.splitAt (b : Bytes) (pos : Nat) : Bytes × Bytes :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Bytes.splitAt_postcond (b : Bytes) (pos : Nat) (result : Bytes × Bytes) : Prop :=
  (pos ≤ b.len → result.1.len + result.2.len = b.len) ∧
  (pos ≤ b.len → result.1.data ++ result.2.data = b.data) ∧
  (pos ≤ b.len → result.1.len = pos) ∧
  result.1.data = b.data.take pos ∧
  result.2.data = b.data.drop pos

theorem Bytes.splitAt_spec (b : Bytes) (pos : Nat) :
    Bytes.splitAt_postcond b pos (b.splitAt pos) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Bytes
-- === END: FIXED_FINAL ===
