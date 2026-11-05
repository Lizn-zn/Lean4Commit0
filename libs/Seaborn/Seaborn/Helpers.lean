-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Seaborn.Types

namespace Seaborn

/-! ## Helpers -/

/-- Arithmetic mean of an array of Floats. -/
def mean (xs : Array Float) : Float :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/-- Sum of products of corresponding elements. -/
def dotProduct (xs ys : Array Float) : Float :=
  (List.range (Nat.min xs.size ys.size)).foldl (fun acc i => acc + xs[i]! * ys[i]!) 0.0

/-- Sum of squared elements. -/
def sumOfSquares (xs : Array Float) : Float :=
  xs.foldl (fun acc x => acc + x * x) 0.0

end Seaborn
-- === END: FIXED_FINAL ===
