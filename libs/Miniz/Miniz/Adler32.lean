-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Miniz.Types

namespace Miniz

/-! ## Adler32 Checksum -/

def adler32 (data : List UInt8) : UInt32 :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def adler32_postcond (data : List UInt8) (result : UInt32) : Prop :=
  (data = [] → result.toNat = 1) ∧
  (∀ b : UInt8, data = [b] → result.toNat = (1 + b.toNat) * 65537) ∧
  result.toNat % 65536 < 65521 ∧
  result.toNat / 65536 < 65521 ∧
  result.toNat > 0 ∧
  (data = [1, 2] → result.toNat = 393220) ∧
  (data = [1, 2, 3] → result.toNat = 851975) ∧
  (data = [0, 0] → result.toNat = 131073) ∧
  (data = [0xFF] → result.toNat = 16777472) ∧
  (data = [0x61, 0x62, 0x63] → result.toNat = 38600999) ∧
  (data = [1, 2, 3, 4, 5, 6] → result.toNat = 4063254) ∧
  (data = List.replicate 23 (0xFF : UInt8) → result.toNat = 319952618)

theorem adler32_spec (data : List UInt8) :
    adler32_postcond data (adler32 data) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



def adler32Update (prev : UInt32) (data : List UInt8) : UInt32 :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def adler32Update_postcond (prev : UInt32) (data : List UInt8) (result : UInt32) : Prop :=
  (data = [] → result = prev) ∧
  (data ≠ [] → result.toNat % 65536 < 65521) ∧
  (data ≠ [] → result.toNat / 65536 < 65521) ∧
  (data ≠ [] → result.toNat > 0) ∧
  (prev.toNat = 1 ∧ data = [1] → result.toNat = 131074) ∧
  (prev.toNat = 1 ∧ data = [1, 2] → result.toNat = 393220) ∧
  (prev.toNat = 1 ∧ data = [1, 2, 3] → result.toNat = 851975) ∧
  (prev.toNat = 131074 ∧ data = [2] → result.toNat = 393220) ∧
  (prev.toNat = 393220 ∧ data = [3] → result.toNat = 851975) ∧
  (prev.toNat = 1 ∧ data = [1, 2, 3, 4, 5, 6] → result.toNat = 4063254) ∧
  (prev.toNat = 1 ∧ data = List.replicate 23 (0xFF : UInt8) → result.toNat = 319952618)

theorem adler32Update_spec (prev : UInt32) (data : List UInt8) :
    adler32Update_postcond prev data (adler32Update prev data) := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Miniz
-- === END: FIXED_FINAL ===
