-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Disruptor.Types

namespace Disruptor

def RingBuffer.Valid (rb : RingBuffer α) : Prop :=
  0 < rb.bufferSize ∧ rb.entries.length = rb.bufferSize ∧
  rb.mask = rb.bufferSize - 1 ∧ ∃ k, rb.bufferSize = 2 ^ k

end Disruptor
-- === END: FIXED_FINAL ===
