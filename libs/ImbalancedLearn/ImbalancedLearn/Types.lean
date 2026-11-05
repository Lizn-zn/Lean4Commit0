-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace ImbalancedLearn

/-! ## Dataset Structure -/

structure Dataset where
  features : Array (Array Float)
  labels : Array Nat
  deriving Repr

def Dataset.nSamples (ds : Dataset) : Nat := 
                                             
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                             sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===


def Dataset.nFeatures (ds : Dataset) : Nat := 
                                              
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
                                              sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/-! ## Sampling Strategy -/

abbrev SamplingStrategy := Array (Nat × Nat)

/-! ## Pure PRNG -/

structure PRNG where
  state : Nat
  deriving Repr

/-! ## Tomek Links -/

structure TomekLink where
  idx1 : Nat
  idx2 : Nat
  class1 : Nat
  class2 : Nat
  deriving Repr, Inhabited


end ImbalancedLearn
-- === END: FIXED_FINAL ===
