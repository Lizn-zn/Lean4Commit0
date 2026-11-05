-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Sphinx.Types

namespace Sphinx

/-! ## Resolve Cross-Reference -/

def resolveRef (targets : List RefTarget) (pending : PendingRef) : RefResult :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def resolveRef_postcond (targets : List RefTarget) (pending : PendingRef) (result : RefResult) : Prop :=
  (targets = [] → ∃ msg, result = RefResult.unresolved msg) ∧
  (∀ t, targets = [t] → t.kind = pending.kind → t.name = pending.target →
    result = RefResult.resolved t) ∧
  ((targets.any (fun t => t.kind == pending.kind && t.name == pending.target)) = true →
    (∃ t, result = RefResult.resolved t) ∨ (∃ ts, result = RefResult.ambiguous ts))

theorem resolveRef_spec (targets : List RefTarget) (pending : PendingRef) :
    resolveRef_postcond targets pending (resolveRef targets pending) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Sphinx
-- === END: FIXED_FINAL ===
