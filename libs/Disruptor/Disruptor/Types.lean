-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Disruptor

/-! ## Types -/

/-- A sequence number used for tracking positions in the ring buffer. -/
structure Sequence where
  value : Nat
  deriving Repr, BEq, Ord

structure RingBuffer (α : Type) where
  entries : List (Option α)
  bufferSize : Nat
  mask : Nat
  cursor : Sequence
  deriving Repr

end Disruptor
-- === END: FIXED_FINAL ===
