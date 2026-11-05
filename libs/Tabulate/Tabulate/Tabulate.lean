-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Tabulate.Types
import Tabulate.Helpers

namespace Tabulate

def tabulate (data : List (List String)) (headers : List String := [])
    (fmt : TableFormat := .simple) (colAlign : List Alignment := []) : String :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def tabulate_postcond (data : List (List String)) (headers : List String)
    (fmt : TableFormat) (colAlign : List Alignment) (result : String) : Prop :=
  (∀ row ∈ data, ∀ cell ∈ row, cell.length > 0 → Tabulate.containsSubstr result cell = true) ∧
  (∀ h ∈ headers, h.length > 0 → Tabulate.containsSubstr result h = true) ∧
  (data ≠ [] → (result.splitOn "\n").length ≥ data.length) ∧
  (fmt = .grid ∧ data ≠ [] → Tabulate.containsSubstr result "|" ∧ Tabulate.containsSubstr result "+") ∧
  (fmt = .html ∧ data ≠ [] → Tabulate.containsSubstr result "<table>") ∧
  (fmt = .latex ∧ data ≠ [] → Tabulate.containsSubstr result "\\begin{tabular}") ∧
  (fmt = .pipe ∧ data ≠ [] → Tabulate.containsSubstr result "|") ∧
  (data = [] ∧ headers = [] → result = "")


theorem tabulate_spec (data : List (List String)) (headers : List String := [])
    (fmt : TableFormat := .simple) (colAlign : List Alignment := []) :
    tabulate_postcond data headers fmt colAlign (tabulate data headers fmt colAlign) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Tabulate
-- === END: FIXED_FINAL ===
