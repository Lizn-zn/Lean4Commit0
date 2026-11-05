-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace MoviePy

/-! ## Core Types -/

/-- Time in seconds. -/
abbrev Time := Float

/-- Video resolution (width * height in pixels). -/
structure Resolution where
  width : Nat
  height : Nat
  deriving Repr, BEq

/-- A video clip defined by its time interval and properties. -/
structure Clip where
  startTime : Time
  endTime : Time
  resolution : Resolution
  fps : Float
  deriving Repr

/-- A positioned clip in a composite (with offset in the timeline). -/
structure PositionedClip where
  clip : Clip
  timelineOffset : Time
  posX : Nat
  posY : Nat
  deriving Repr

/-- Result of concatenation or composition. -/
structure CompositeResult where
  duration : Time
  resolution : Resolution
  fps : Float
  clips : Array PositionedClip
  deriving Repr

end MoviePy
-- === END: FIXED_FINAL ===
