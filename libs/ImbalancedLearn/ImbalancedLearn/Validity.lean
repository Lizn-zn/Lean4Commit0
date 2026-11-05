-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import ImbalancedLearn.Types

namespace ImbalancedLearn

def Dataset.Valid (ds : Dataset) : Prop :=
  ds.features.size = ds.labels.size ∧
  ∀ i j, i < ds.features.size → j < ds.features.size →
    ds.features[i]!.size = ds.features[j]!.size

end ImbalancedLearn
-- === END: FIXED_FINAL ===
