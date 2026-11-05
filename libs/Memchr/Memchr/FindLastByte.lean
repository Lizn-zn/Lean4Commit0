-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Memchr.Helpers
import Memchr.FindByte
import Memchr.FindSubstring

namespace Memchr

/-! ## Core Function 3: memrchr -/
def memrchr (needle : UInt8) (haystack : List UInt8) : Option Nat :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def memrchr_postcond (needle : UInt8) (haystack : List UInt8) (result : Option Nat) : Prop :=
  (∀ i, result = some i →
    i < haystack.length ∧ haystack[i]? = some needle ∧
    ∀ j, j > i → j < haystack.length → haystack[j]? ≠ some needle) ∧
  (result = none → ∀ i, i < haystack.length → haystack[i]? ≠ some needle)

theorem memrchr_spec (needle : UInt8) (haystack : List UInt8) :
    memrchr_postcond needle haystack (memrchr needle haystack) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Memchr
-- === END: FIXED_FINAL ===
