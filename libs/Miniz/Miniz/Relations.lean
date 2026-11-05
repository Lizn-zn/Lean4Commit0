-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Miniz.Deflate
import Miniz.Adler32

namespace Miniz

/-! ## Relational: inflate/deflate roundtrip -/

@[reducible]
def inflate_deflate_rel (input : List UInt8) (compressed : List Bit)
    (decompressed : Option (List UInt8)) : Prop :=
  decompressed = some input

theorem inflate_deflate_spec (input : List UInt8) :
    inflate_deflate_rel input (deflate input) (inflate (deflate input)) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: Adler32 compositionality -/

@[reducible]
def adler32_append_rel (a b : List UInt8) (full updated : UInt32) : Prop :=
  full = updated

theorem adler32_append_spec (a b : List UInt8) :
    adler32_append_rel a b (adler32 (a ++ b)) (adler32Update (adler32 a) b) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Miniz
-- === END: FIXED_FINAL ===
