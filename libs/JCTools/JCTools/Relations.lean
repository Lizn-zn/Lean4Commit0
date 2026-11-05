-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import JCTools.Types
import JCTools.Helpers
import JCTools.Offer
import JCTools.Poll
import JCTools.Drain

namespace JCTools

/-! ## Relational: offer then poll on empty queue returns the value -/

@[reducible]
def SpscQueue.offer_poll_roundtrip_rel (q : SpscQueue α) (v : α) (q' : SpscQueue α)
    (poll_result : Option α) : Prop :=
  q.buffer = [] → poll_result = some v

theorem SpscQueue.offer_poll_roundtrip_spec (q : SpscQueue α) (v : α) (q' : SpscQueue α)
    (hempty : q.buffer = []) (h : q.offer v = some q') :
    SpscQueue.offer_poll_roundtrip_rel q v q' (q'.poll).2 := by 
                                                                
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: bounded queue rejects offer when full -/

@[reducible]
def SpscQueue.bounded_rejects_rel (q : SpscQueue α) (v : α) (result : Option (SpscQueue α)) : Prop :=
  (q.buffer.length ≥ q.capacity → result = none) ∧
  (q.buffer.length < q.capacity → result.isSome = true)

theorem SpscQueue.bounded_rejects_spec (q : SpscQueue α) (v : α)
    (h : q.buffer.length ≥ q.capacity) :
    SpscQueue.bounded_rejects_rel q v (q.offer v) := by 
                                                        
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
                                                        sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Relational: FIFO ordering — two offers then poll returns the first -/

@[reducible]
def SpscQueue.fifo_ordering_rel (a b : α) (poll_result : Option α) : Prop :=
  poll_result = some a

theorem SpscQueue.fifo_ordering_spec (a b : α) (cap : Nat) (hcap : cap ≥ 2) :
    let q := SpscQueue.new (α := α) cap
    ∀ q1, q.offer a = some q1 →
    ∀ q2, q1.offer b = some q2 →
    SpscQueue.fifo_ordering_rel a b q2.poll.2 := by 
                                                    
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
                                                    sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



/-! ## Relational: poll after offer on empty returns the offered value -/

@[reducible]
def SpscQueue.poll_after_offer_rel (v : α) (poll_result : Option α) : Prop :=
  poll_result = some v

theorem SpscQueue.poll_after_offer_spec (v : α) (cap : Nat) (hcap : cap ≥ 1) :
    let q := SpscQueue.new (α := α) cap
    ∀ q', q.offer v = some q' →
    SpscQueue.poll_after_offer_rel v q'.poll.2 := by 
                                                     
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
                                                     sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end JCTools
-- === END: FIXED_FINAL ===
