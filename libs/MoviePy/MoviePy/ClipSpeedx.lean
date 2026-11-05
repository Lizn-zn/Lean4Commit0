-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import MoviePy.Types

namespace MoviePy

/-! ## Clip.speedx -/

/-- Change playback speed. Factor > 1 is faster, < 1 is slower. -/
def Clip.speedx (c : Clip) (factor : Float) : Option Clip :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Clip_speedx_postcond (c : Clip) (factor : Float) (result : Option Clip) : Prop :=
  (factor = 1.0 → result = some c) ∧
  (factor > 0.0 → ∀ c', result = some c' →
    (factor ≠ 1.0 → c'.endTime = c.startTime + (c.endTime - c.startTime) / factor) ∧
    c'.resolution = c.resolution ∧
    c'.fps = c.fps ∧
    c'.startTime = c.startTime) ∧
  (factor > 0.0 → result.isSome = true) ∧
  (factor ≤ 0.0 → result = none)

theorem Clip_speedx_spec (c : Clip) (factor : Float) :
    Clip_speedx_postcond c factor (Clip.speedx c factor) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MoviePy
-- === END: FIXED_FINAL ===
