-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import SimPy.Types

namespace SimPy

def Environment.Valid (env : Environment) : Prop :=
  env.now.isFinite = true ∧ ∀ se ∈ env.eventQueue,
    se.time.isFinite = true ∧ env.now ≤ se.time

end SimPy
-- === END: FIXED_FINAL ===
