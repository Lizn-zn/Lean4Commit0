-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Seaborn.Helpers

namespace Seaborn

/-! ## histBinsEqualWidth -/

/-- Equal-width histogram binning. -/
def histBinsEqualWidth (xs : Array Float) (nBins : Nat) : Array Bin :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def histBinsEqualWidth_postcond (xs : Array Float) (nBins : Nat) (result : Array Bin) : Prop :=
  (nBins > 0 → xs.size > 0 → result.size = nBins) ∧
  (nBins > 0 → xs.size > 0 →
    result.foldl (fun acc b => acc + b.count) 0 = xs.size) ∧
  (nBins > 1 → xs.size > 0 →
    ∀ i, i + 1 < result.size → result[i]!.hi = result[i + 1]!.lo) ∧
  (nBins > 0 → xs.size > 0 →
    ∀ i, i < result.size → result[i]!.lo ≤ result[i]!.hi) ∧
  (nBins > 1 → xs.size > 0 →
    ∀ i j, i < result.size → j < result.size →
      ((result[i]!.hi - result[i]!.lo) - (result[j]!.hi - result[j]!.lo)).abs ≤
      1e-8 * (1.0 + (result[i]!.hi - result[i]!.lo).abs + (result[j]!.hi - result[j]!.lo).abs)) ∧
  (nBins > 0 → xs.size > 0 →
    ∀ j, j < xs.size →
      result[0]!.lo ≤ xs[j]! ∧ xs[j]! ≤ result[nBins - 1]!.hi)

theorem histBinsEqualWidth_spec (xs : Array Float) (nBins : Nat) 
    (hfinite : xs.all Float.isFinite = true) 
    (hstable : nBins ≤ 4096 ∧ xs.all (fun x => x.abs ≤ 1e6) = true) :
    histBinsEqualWidth_postcond xs nBins (histBinsEqualWidth xs nBins) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Seaborn
-- === END: FIXED_FINAL ===
