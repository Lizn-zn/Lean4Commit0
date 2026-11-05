-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Memchr.Helpers
import Memchr.FindByte

namespace Memchr

/-! ## Core Function 2: memmem -/
def memmem (needle : List UInt8) (haystack : List UInt8) : Option Nat :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def memmem_postcond (needle : List UInt8) (haystack : List UInt8) (result : Option Nat) : Prop :=
  (∀ i, result = some i →
    i + needle.length ≤ haystack.length ∧
    List.take needle.length (List.drop i haystack) = needle ∧
    ∀ j, j < i → List.take needle.length (List.drop j haystack) ≠ needle) ∧
  (needle = [] → result = some 0) ∧
  (result = none → ∀ i, i + needle.length ≤ haystack.length →
    List.take needle.length (List.drop i haystack) ≠ needle)

theorem memmem_spec (needle : List UInt8) (haystack : List UInt8) :
    memmem_postcond needle haystack (memmem needle haystack) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Memchr
-- === END: FIXED_FINAL ===
