-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Tabulate.Types

namespace Tabulate

def computeColumnWidths (data : List (List String)) (headers : List String) : List Nat :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def computeColumnWidths_postcond (data : List (List String)) (headers : List String)
    (result : List Nat) : Prop :=
  (∀ i, i < headers.length → i < result.length →
    result[i]! ≥ headers[i]!.length) ∧
  (∀ row ∈ data, ∀ i, i < row.length → i < result.length →
    result[i]! ≥ row[i]!.length) ∧
  (∀ i, i < result.length →
    (i < headers.length ∧ result[i]! = headers[i]!.length) ∨
    (data.any (fun row => i < row.length && result[i]! == row[i]!.length) = true))


theorem computeColumnWidths_spec (data : List (List String)) (headers : List String) :
    computeColumnWidths_postcond data headers (computeColumnWidths data headers) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Tabulate
-- === END: FIXED_FINAL ===
