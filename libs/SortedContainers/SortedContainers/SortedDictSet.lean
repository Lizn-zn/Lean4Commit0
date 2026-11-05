-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import SortedContainers.Types

namespace SortedContainers

/-! ## SortedDict.set -/

def SortedDict.set [Ord α] [BEq α] (d : SortedDict α β) (k : α) (v : β) : SortedDict α β :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def SortedDict.set_postcond [Ord α] [BEq α] [DecidableEq α] (d : SortedDict α β) (k : α) (v : β)
    (result : SortedDict α β) : Prop :=
  List.Pairwise (fun a b => Ord.compare a.1 b.1 ≠ .gt) result.data ∧
  (k, v) ∈ result.data ∧
  (∀ k' v', (k', v') ∈ d.data → ¬ (k' == k) → (k', v') ∈ result.data) ∧
  (result.data.map Prod.fst).Nodup ∧
  (d.data.any (fun p => p.1 == k) → result.data.length = d.data.length) ∧
  (¬ d.data.any (fun p => p.1 == k) → result.data.length = d.data.length + 1)

theorem SortedDict.set_spec [Ord α] [Std.TransOrd α] [Std.LawfulEqOrd α] [BEq α] [LawfulBEq α] [DecidableEq α] (d : SortedDict α β) (k : α) (v : β) 
    (hvalid : (d.data.map Prod.fst).Nodup) :
    SortedDict.set_postcond d k v (d.set k v) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SortedContainers
-- === END: FIXED_FINAL ===
