-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Disruptor.Validity
import Std
import Lean

import Disruptor.Create
import Disruptor.Publish
import Disruptor.Get

namespace Disruptor

/-! ## Relational: publish then get retrieves the event -/

@[reducible]
def publish_get_rel (rb : RingBuffer α) (event : α) (result : Option α) : Prop :=
  rb.entries.length > 0 → result = some event

theorem publish_get_spec (rb : RingBuffer α) (event : α) 
    (hvalid : RingBuffer.Valid rb) :
    publish_get_rel rb event (RingBuffer.get (RingBuffer.publish rb event) rb.cursor) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: no overwrite before consumed -/

@[reducible]
def no_overwrite_before_consumed_rel (rb : RingBuffer α) (event : α) (gating : Sequence)
    (oldResult newResult : Option α) : Prop :=
  rb.cursor.value - gating.value < rb.bufferSize →
    rb.cursor.value % rb.bufferSize ≠ gating.value % rb.bufferSize →
    newResult = oldResult

theorem no_overwrite_before_consumed_spec (rb : RingBuffer α) (event : α) (gating : Sequence)
    (hcap : rb.cursor.value - gating.value < rb.bufferSize) 
    (hvalid : RingBuffer.Valid rb) :
    no_overwrite_before_consumed_rel rb event gating
      (RingBuffer.get rb gating)
      (RingBuffer.get (RingBuffer.publish rb event) gating) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Relational: after create, all gets return none -/

@[reducible]
def create_all_none_rel (capacity : Nat) (s : Sequence) (result : Option α) : Prop :=
  RingBuffer.create_precond capacity → result = none

theorem create_all_none_spec (capacity : Nat) (s : Sequence) (h : RingBuffer.create_precond capacity) :
    create_all_none_rel capacity s (RingBuffer.get (RingBuffer.create capacity : RingBuffer α) s) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Disruptor
-- === END: FIXED_FINAL ===
