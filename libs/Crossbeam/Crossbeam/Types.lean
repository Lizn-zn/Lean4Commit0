-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Crossbeam

/-! ## MPMC Queue (lock-free multi-producer multi-consumer) -/

/-- An unbounded MPMC queue, modeled as a list (FIFO). -/
structure Queue (α : Type) where
  data : List α
  deriving Repr

/-- A bounded MPMC queue with fixed capacity. -/
structure ArrayQueue (α : Type) where
  data : List α
  capacity' : Nat
  deriving Repr

/-- A work-stealing deque: the owner pushes/pops from one end,
    other threads can steal from the other end. -/
structure Deque (α : Type) where
  data : List α
  deriving Repr

end Crossbeam
-- === END: FIXED_FINAL ===
