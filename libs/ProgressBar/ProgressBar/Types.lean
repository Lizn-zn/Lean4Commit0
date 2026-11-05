-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace ProgressBar


/-! ## Types -/

/-- A duration in milliseconds -/
abbrev Duration := Nat


/-- A timestamp in milliseconds since epoch -/
abbrev Timestamp := Nat


/-- The current state of a progress bar -/
structure ProgressState where
  current     : Nat
  total       : Option Nat := none
  startTime   : Timestamp := 0
  currentTime : Timestamp := 0
  deriving Repr, BEq


/-- Bar fill characters -/
structure BarChars where
  filled    : Char := '#'
  empty     : Char := '-'
  leftEnd   : Char := '|'
  rightEnd  : Char := '|'
  partials  : List Char := []
  deriving Repr, BEq


/-- Widget types that can be placed in a progress bar -/
inductive Widget where
  | bar             : BarChars → Nat → Widget
  | counter         : String → Widget
  | percentage      : Nat → Widget
  | timer           : Widget
  | eta             : Widget
  | adaptiveEta     : Widget
  | bouncingBar     : BarChars → Nat → Widget
  | rotatingMarker  : List Char → Widget
  | text            : String → Widget
  | rateWidget      : String → Widget
  | fileTransferSpeed : Widget
  | dataSize        : Widget
  | separator       : String → Widget
  | dynamicMessage  : String → Widget
  deriving Repr, BEq


/-- A segment in a parsed format string -/
inductive FormatSegment where
  | literal : String → FormatSegment
  | widget  : Widget → FormatSegment
  deriving Repr, BEq


/-- A parsed format specification -/
structure FormatSpec where
  segments : List FormatSegment := []
  deriving Repr, BEq


/-- Render context for widgets -/
structure RenderContext where
  state         : ProgressState
  adaptiveEta   : Unit := ()  -- simplified, not needed for core
  smoothedRate  : Float := 0.0
  terminalWidth : Nat := 80
  extraData     : List (String × String) := []
  bouncingPos   : Nat := 0
  markerPos     : Nat := 0
  deriving Repr, BEq

end ProgressBar
-- === END: FIXED_FINAL ===
