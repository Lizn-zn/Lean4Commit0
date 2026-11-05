-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Statsmodels.Types

namespace Statsmodels

/-! ## OLS Regression -/

@[reducible]
def floatClose (a b tol : Float) : Prop :=
  Float.abs (a - b) ≤ tol

@[reducible]
def validOlsInput (x : Matrix) (y : Array Float) (addConst : Bool) : Prop :=
  let k := x.cols + (if addConst then 1 else 0)
  y.size = x.rows ∧
  x.data.size = x.rows ∧
  x.data.all (fun row => row.size == x.cols) = true ∧
  y.all Float.isFinite = true ∧
  x.data.all (fun row => row.all Float.isFinite) = true ∧
  0 < y.size ∧
  0 < k ∧
  k ≤ y.size

@[reducible]
def olsFittedAt (x : Matrix) (r : OLSResult) (addConst : Bool) (i : Nat) : Float :=
  let offset := if addConst then 1 else 0
  let intercept := if addConst then r.coefficients[0]! else 0.0
  intercept + (List.range x.cols).foldl
    (fun acc j =>
      let row := x.data[i]!
      acc + row[j]! * r.coefficients[j + offset]!) 0.0

@[reducible]
def olsResidualMoment (x : Matrix) (r : OLSResult) (j : Nat) : Float :=
  (List.range r.nObs).foldl
    (fun acc i =>
      let row := x.data[i]!
      acc + row[j]! * r.residuals[i]!) 0.0

@[reducible]
def olsResidualSum (r : OLSResult) : Float :=
  (List.range r.nObs).foldl (fun acc i => acc + r.residuals[i]!) 0.0

@[reducible]
def olsResidualSS (r : OLSResult) : Float :=
  (List.range r.nObs).foldl
    (fun acc i => acc + r.residuals[i]! * r.residuals[i]!) 0.0

@[reducible]
def arrayMean (xs : Array Float) : Float :=
  xs.foldl (· + ·) 0.0 / Float.ofNat xs.size

@[reducible]
def olsTotalSS (y : Array Float) : Float :=
  let m := arrayMean y
  (List.range y.size).foldl
    (fun acc i => acc + (y[i]! - m) * (y[i]! - m)) 0.0

def olsFit (x : Matrix) (y : Array Float) (addConstant : Bool := true) : Option OLSResult :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def olsFit_postcond (x : Matrix) (y : Array Float) (addConst : Bool) (result : Option OLSResult) : Prop :=
  (validOlsInput x y addConst → result.isSome = true) ∧
  ∀ r, result = some r →
    r.coefficients.size = r.nParams ∧
    r.residuals.size = r.nObs ∧
    r.fittedValues.size = r.nObs ∧
    r.stdErrors.size = r.coefficients.size ∧
    r.tStatistics.size = r.coefficients.size ∧
    r.pValues.size = r.coefficients.size ∧
    r.nObs = y.size ∧
    r.nParams = x.cols + (if addConst then 1 else 0) ∧
    (decide (r.rSquared < 0.0) = false) ∧
    (decide (1.0 < r.rSquared) = false) ∧
    (decide (r.adjRSquared ≤ r.rSquared) = true) ∧
    (decide (r.fStatistic < 0.0) = false) ∧
    (∀ i, i < r.nObs → floatClose (r.fittedValues[i]! + r.residuals[i]!) y[i]! 1e-8) ∧
    (validOlsInput x y addConst →
      (∀ i, i < r.nObs → floatClose r.fittedValues[i]! (olsFittedAt x r addConst i) 1e-8) ∧
      (addConst = true → floatClose (olsResidualSum r) 0.0 1e-6) ∧
      (∀ j, j < x.cols → floatClose (olsResidualMoment x r j) 0.0 1e-6) ∧
      (decide (olsTotalSS y > 1e-12) = true →
        floatClose r.rSquared (1.0 - olsResidualSS r / olsTotalSS y) 1e-6)) ∧
    (∀ i, i < r.coefficients.size →
      (decide (r.stdErrors[i]! < 0.0) = false) ∧
      (decide (r.pValues[i]! < 0.0) = false) ∧
      (decide (1.0 < r.pValues[i]!) = false) ∧
      floatClose (r.tStatistics[i]! * r.stdErrors[i]!) r.coefficients[i]! 1e-6)

theorem olsFit_spec (x : Matrix) (y : Array Float) 
    (hstable : (olsTotalSS y).isFinite = true ∧
      (y.foldl (fun s v => s + v*v) 0.0).isFinite = true ∧
      (x.data.foldl (fun (s : Float) (row : Array Float) => row.foldl (fun (t v : Float) => t + v*v) s) 0.0).isFinite = true) :
    olsFit_postcond x y false (olsFit x y false) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Statsmodels
-- === END: FIXED_FINAL ===
