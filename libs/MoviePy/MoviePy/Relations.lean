-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import MoviePy.ClipSpeedx

namespace MoviePy

/-! ## Relational: speedx(1.0) is identity -/

@[reducible]
def Clip_speedx_identity_rel (c : Clip) : Prop :=
  Clip.speedx c 1.0 = some c

theorem Clip_speedx_identity_spec (c : Clip) :
    Clip_speedx_identity_rel c := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MoviePy
-- === END: FIXED_FINAL ===
