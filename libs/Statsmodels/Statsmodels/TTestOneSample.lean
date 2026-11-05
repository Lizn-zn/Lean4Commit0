-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Statsmodels.Types

namespace Statsmodels

/-! ## Hypothesis Testing -/

@[reducible]
def tTestFloatClose (a b tol : Float) : Prop :=
  Float.abs (a - b) ≤ tol

@[reducible]
def tTestMean (xs : Array Float) : Float :=
  xs.foldl (· + ·) 0.0 / Float.ofNat xs.size

@[reducible]
def tTestSampleVariance (xs : Array Float) : Float :=
  let m := tTestMean xs
  (List.range xs.size).foldl
    (fun acc i => acc + (xs[i]! - m) * (xs[i]! - m)) 0.0 /
      (Float.ofNat xs.size - 1.0)

@[reducible]
def tTestExpectedStatistic (xs : Array Float) (mu0 : Float) : Float :=
  (tTestMean xs - mu0) / (Float.sqrt (tTestSampleVariance xs) / Float.sqrt (Float.ofNat xs.size))

def tTestOneSample (xs : Array Float) (mu0 : Float := 0.0) : TestResult :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def tTestOneSample_postcond (xs : Array Float) (mu0 : Float) (result : TestResult) : Prop :=
  (xs.size ≥ 2 → Float.beq result.degreesOfFreedom (Float.ofNat xs.size - 1.0) = true) ∧
  (xs.size ≥ 2 → (decide (result.pValue < 0.0) = false)) ∧
  (xs.size ≥ 2 → (decide (1.0 < result.pValue) = false)) ∧
  (xs.size ≥ 2 → xs.all (fun x => decide (x > mu0)) = true →
    decide (result.statistic > 0.0) = true) ∧
  (xs.size ≥ 2 → xs.all (fun x => decide (x < mu0)) = true →
    decide (result.statistic < 0.0) = true) ∧
  (xs.size ≥ 2 → (result.statistic == result.statistic) = true →
    decide (xs.foldl (· + ·) 0.0 > Float.ofNat xs.size * mu0) = true →
    decide (result.statistic > 0.0) = true) ∧
  (xs.size ≥ 2 → (result.statistic == result.statistic) = true →
    decide (xs.foldl (· + ·) 0.0 < Float.ofNat xs.size * mu0) = true →
    decide (result.statistic < 0.0) = true) ∧
  (xs.size ≥ 2 → decide (tTestSampleVariance xs > 1e-12) = true →
    tTestFloatClose result.statistic (tTestExpectedStatistic xs mu0) 1e-6) ∧
  (xs.size ≥ 5 → decide (result.statistic.abs > 4.0) = true →
    decide (result.pValue < 0.05) = true) ∧
  (xs.size ≥ 3 → decide (result.statistic.abs > 2.5) = true →
    decide (result.pValue < 0.2) = true)

theorem tTestOneSample_spec (xs : Array Float) (mu0 : Float) 
    (hstable : (tTestMean xs).isFinite = true ∧ (tTestSampleVariance xs).isFinite = true ∧
      (tTestSampleVariance xs > 1e-12 → (tTestExpectedStatistic xs mu0).isFinite = true)) :
    tTestOneSample_postcond xs mu0 (tTestOneSample xs mu0) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Statsmodels
-- === END: FIXED_FINAL ===
