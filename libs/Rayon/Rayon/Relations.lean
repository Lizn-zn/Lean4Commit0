-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Rayon.Types
import Rayon.FromList
import Rayon.Collect
import Rayon.Map
import Rayon.Reduce
import Rayon.Join

namespace Rayon


/-! ## Relational: collect after fromList -/

@[reducible]
def collect_fromList_rel (xs : List α) (result : List α) : Prop :=
  result = xs


theorem collect_fromList_spec (xs : List α) :
    collect_fromList_rel xs (ParIter.fromList xs).collect := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




/-! ## Relational: reduce sum -/

@[reducible]
def reduce_sum_rel (xs : List Nat) (result : Nat) (sequential : Nat) : Prop :=
  result = sequential


theorem reduce_sum_spec (xs : List Nat) :
    reduce_sum_rel xs ((ParIter.fromList xs).reduce 0 (· + ·)) (xs.foldl (· + ·) 0) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Rayon
-- === END: FIXED_FINAL ===
