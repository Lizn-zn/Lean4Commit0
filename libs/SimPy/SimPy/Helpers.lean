-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import SimPy.Types

namespace SimPy

/-! ## Helpers -/

def eventQueueSorted (q : List ScheduledEvent) : Prop :=
  List.Pairwise
    (fun a b =>
      a.time < b.time ∨
      (a.time = b.time ∧ compare a.priority b.priority = .lt) ∨
      (a.time = b.time ∧ a.priority == b.priority ∧ a.insertionOrder < b.insertionOrder))
    q

/-- Infrastructure: Resource.count (used by request_spec precondition) -/
def Resource.count (r : Resource) : Nat :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Resource.count_postcond (r : Resource) (result : Nat) : Prop :=
  result = r.users.length

theorem Resource.count_spec (r : Resource) :
    Resource.count_postcond r r.count := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SimPy
-- === END: FIXED_FINAL ===
