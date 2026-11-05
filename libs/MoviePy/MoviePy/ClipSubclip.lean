-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import MoviePy.Types

namespace MoviePy

/-! ## Clip.subclip -/

/-- Extract a subclip from startTime to endTime. -/
def Clip.subclip (c : Clip) (newStart newEnd : Time) : Option Clip :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Clip_subclip_postcond (c : Clip) (newStart newEnd : Time) (result : Option Clip) : Prop :=
  (newStart = c.startTime ∧ newEnd = c.endTime ∧ c.endTime > c.startTime ∧ c.fps > 0.0 → result = some c) ∧
  (∀ c', result = some c' →
    c'.startTime = newStart ∧
    c'.endTime = newEnd ∧
    (c'.endTime - c'.startTime) = (newEnd - newStart) ∧
    c'.resolution = c.resolution ∧
    c'.fps = c.fps) ∧
  (newEnd > newStart ∧ c.fps > 0.0 → result.isSome = true) ∧
  (newEnd ≤ newStart → result = none)

theorem Clip_subclip_spec (c : Clip) (newStart newEnd : Time) :
    Clip_subclip_postcond c newStart newEnd (Clip.subclip c newStart newEnd) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end MoviePy
-- === END: FIXED_FINAL ===
