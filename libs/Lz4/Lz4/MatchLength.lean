-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Lz4.Types
import Lz4.Helpers
import Lz4.CompressBlock
import Lz4.DecompressBlock

namespace Lz4

/-! ## Core Function 3: matchLength -/
def matchLength (a b : List UInt8) : Nat :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def matchLength_postcond (a b : List UInt8) (result : Nat) : Prop :=
  result ≤ min a.length b.length ∧
  a.take result = b.take result ∧
  (result < min a.length b.length → a[result]? ≠ b[result]?)

theorem matchLength_spec (a b : List UInt8) :
    matchLength_postcond a b (matchLength a b) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Lz4
-- === END: FIXED_FINAL ===
