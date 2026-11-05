-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Memchr.Helpers
import Memchr.FindByte
import Memchr.FindSubstring
import Memchr.FindLastByte

namespace Memchr

/-! ## Relational: memchr found implies memrchr found -/

@[reducible]
def memchr_memrchr_rel (needle : UInt8) (haystack : List UInt8)
    (fwd_result rev_result : Option Nat) : Prop :=
  fwd_result.isSome = true ↔ rev_result.isSome = true

theorem memchr_memrchr_spec (needle : UInt8) (haystack : List UInt8) :
    memchr_memrchr_rel needle haystack (memchr needle haystack) (memrchr needle haystack) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Memchr
-- === END: FIXED_FINAL ===
