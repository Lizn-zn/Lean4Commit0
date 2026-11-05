-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Seaborn.Helpers

namespace Seaborn

/-! ## kde -/

/-- Kernel density estimation at a set of evaluation points. -/
def kde (xs : Array Float) (evalPoints : Array Float) (bandwidth : Float) : Array Float :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def kde_postcond (xs evalPoints : Array Float) (bw : Float) (result : Array Float) : Prop :=
  result.size = evalPoints.size ∧
  (bw > 0.0 → ∀ i, i < result.size → result[i]! ≥ 0.0) ∧
  (bw > 0.0 → xs.size > 0 → evalPoints.size > 0 →
    ∃ i, i < result.size ∧ result[i]! > 0.0) ∧
  (bw > 0.0 → ∀ i, i < result.size →
    result[i]! ≤ 1.0 / (bw * Float.sqrt (2.0 * 3.14159265358979)) +
      1e-8 * (1.0 + (1.0 / (bw * Float.sqrt (2.0 * 3.14159265358979))).abs)) ∧
  (bw > 0.0 → xs.size > 0 →
    ∀ i, i < evalPoints.size →
      ∀ j, j < xs.size → evalPoints[i]! = xs[j]! →
        result[i]! ≥ (1.0 / Float.sqrt (2.0 * 3.14159265358979)) / (Float.ofNat xs.size * bw) - 1e-10) ∧
  (bw > 0.0 → xs.size > 0 →
    ∀ i, i < result.size →
      (result[i]! -
        (xs.foldl (fun acc x =>
          acc + (1.0 / Float.sqrt (2.0 * 3.14159265358979)) *
                Float.exp ((-0.5) * ((evalPoints[i]! - x) / bw) * ((evalPoints[i]! - x) / bw)))
          0.0) / (Float.ofNat xs.size * bw)).abs ≤ 1e-10)

theorem kde_spec (xs evalPoints : Array Float) (bw : Float) 
    (hfinite : xs.all Float.isFinite = true ∧ evalPoints.all Float.isFinite = true ∧ bw.isFinite = true) 
    (hstable : xs.size ≤ 10000 ∧ 1e-6 ≤ bw ∧ bw ≤ 1e6 ∧
      xs.all (fun x => x.abs ≤ 1e6) = true ∧ evalPoints.all (fun x => x.abs ≤ 1e6) = true) :
    kde_postcond xs evalPoints bw (kde xs evalPoints bw) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Seaborn
-- === END: FIXED_FINAL ===
