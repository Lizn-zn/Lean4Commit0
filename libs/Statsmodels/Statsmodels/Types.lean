-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # Statsmodels
   Statistical modeling library providing regression, hypothesis testing,
   and distribution functions.
   Summarized to 3 core functions: olsFit, tTestOneSample, normalCdf.

   Ported from Python's `statsmodels` library.
   Original: https://github.com/statsmodels/statsmodels
-/

namespace Statsmodels

structure Matrix where
  rows : Nat
  cols : Nat
  data : Array (Array Float)
  deriving Repr

structure OLSResult where
  coefficients : Array Float
  stdErrors : Array Float
  tStatistics : Array Float
  pValues : Array Float
  rSquared : Float
  adjRSquared : Float
  fStatistic : Float
  fPValue : Float
  residuals : Array Float
  fittedValues : Array Float
  nObs : Nat
  nParams : Nat
  aic : Float
  bic : Float
  logLikelihood : Float
  deriving Repr

structure TestResult where
  statistic : Float
  pValue : Float
  degreesOfFreedom : Float
  deriving Repr

end Statsmodels
-- === END: FIXED_FINAL ===
