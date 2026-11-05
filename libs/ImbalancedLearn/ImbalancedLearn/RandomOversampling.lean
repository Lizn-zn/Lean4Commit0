-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import ImbalancedLearn.Validity
import Std
import Lean

import ImbalancedLearn.Types
import ImbalancedLearn.ClassDistribution

namespace ImbalancedLearn

/-! ## Core Function 2: randomOversampling -/

def randomOversampling (ds : Dataset) (strategy : SamplingStrategy) (seed : Nat) : Dataset := 
                                                                                              
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                                              sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def randomOversampling_postcond (ds : Dataset) (strategy : SamplingStrategy) (seed : Nat) (result : Dataset) : Prop :=
  ds.nSamples ≤ result.nSamples ∧
  result.features.size = result.labels.size ∧
  -- Original samples are preserved as prefix
  (∀ i, i < ds.features.size → result.features[i]? = ds.features[i]?) ∧
  (∀ i, i < ds.labels.size → result.labels[i]? = ds.labels[i]?) ∧
  -- Empty dataset stays empty when strategy is empty
  (ds.features = #[] → strategy = #[] → result.features = #[]) ∧
  -- Upper bound: result can't exceed original + sum of all strategy targets
  result.features.size ≤ ds.features.size + strategy.foldl (fun acc p => acc + p.2) 0 ∧
  -- Each strategy target is actually met
  (∀ p ∈ strategy.toList, p.2 ≤ result.labels.toList.count p.1)

theorem randomOversampling_spec (ds : Dataset) (strategy : SamplingStrategy) (seed : Nat) 
    (hvalid : Dataset.Valid ds) :
    randomOversampling_postcond ds strategy seed (randomOversampling ds strategy seed) := by 
                                                                                             
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
                                                                                             sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end ImbalancedLearn
-- === END: FIXED_FINAL ===
