-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Bytes.Helpers

namespace Bytes

/-- Read a single byte and advance the cursor. -/
def BufReader.getU8 (r : BufReader) : Option (UInt8 × BufReader) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def BufReader.getU8_postcond (r : BufReader) (result : Option (UInt8 × BufReader)) : Prop :=
  (r.remaining = 0 → result = none) ∧
  (r.pos < r.data.length → result.isSome) ∧
  (∀ v r', result = some (v, r') → r'.remaining = r.remaining - 1) ∧
  (∀ v r', result = some (v, r') → r.data[r.pos]? = some v) ∧
  (∀ v r', result = some (v, r') → r'.data = r.data ∧ r'.pos = r.pos + 1)

theorem BufReader.getU8_spec (r : BufReader) :
    BufReader.getU8_postcond r (r.getU8) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Bytes
-- === END: FIXED_FINAL ===
