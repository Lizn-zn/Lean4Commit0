-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Tabulate.Types
import Tabulate.Helpers
import Tabulate.Tabulate
import Tabulate.ComputeColumnWidths

namespace Tabulate

def formatHtml (data : List (List String)) (headers : List String) : String :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def formatHtml_postcond (data : List (List String)) (headers : List String) (result : String) : Prop :=
  (data ≠ [] → Tabulate.containsSubstr result "<table>" ∧ Tabulate.containsSubstr result "</table>") ∧
  (data ≠ [] → Tabulate.containsSubstr result "<tr>" ∧ Tabulate.containsSubstr result "</tr>") ∧
  (data ≠ [] → Tabulate.containsSubstr result "<td" ∨ Tabulate.containsSubstr result "<th>") ∧
  (headers ≠ [] ∧ data ≠ [] → Tabulate.containsSubstr result "<th>") ∧
  (∀ row ∈ data, ∀ cell ∈ row, cell.length > 0 → cell.toList.all (fun c => c != '<' && c != '>' && c != '&') = true → Tabulate.containsSubstr result cell = true) ∧
  (∀ h ∈ headers, h.length > 0 → h.toList.all (fun c => c != '<' && c != '>' && c != '&') = true → Tabulate.containsSubstr result h = true) ∧
  (data ≠ [] → Tabulate.containsSubstr result "<tbody>") ∧
  (data ≠ [] → (result.splitOn "<tr>").length ≥ data.length + 1)


theorem formatHtml_spec (data : List (List String)) (headers : List String) :
    formatHtml_postcond data headers (formatHtml data headers) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def tabulate_grid_postcond (data : List (List String)) (headers : List String) (result : String) : Prop :=
  data ≠ [] →
    Tabulate.containsSubstr result "+" ∧ Tabulate.containsSubstr result "-" ∧
    Tabulate.containsSubstr result "|" ∧
    (result.splitOn "\n").length ≥ data.length + 2 ∧
    (∀ row ∈ data, ∀ cell ∈ row, cell.length > 0 → Tabulate.containsSubstr result cell = true) ∧
    (∀ h ∈ headers, h.length > 0 → Tabulate.containsSubstr result h = true) ∧
    result.startsWith "+" = true ∧
    result.endsWith "+" = true


theorem tabulate_grid_spec (data : List (List String)) (headers : List String)
    (hne : data ≠ []) :
    tabulate_grid_postcond data headers (tabulate data headers .grid) := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def computeColumnWidths_length_postcond (data : List (List String)) (headers : List String)
    (result : List Nat) : Prop :=
  result.length = max headers.length (data.foldl (fun acc row => max acc row.length) 0) ∧
  (∀ i, i < headers.length → i < result.length → result[i]! ≥ headers[i]!.length) ∧
  (∀ row ∈ data, ∀ i, i < row.length → i < result.length → result[i]! ≥ row[i]!.length)


theorem computeColumnWidths_length_spec (data : List (List String)) (headers : List String) :
    computeColumnWidths_length_postcond data headers (computeColumnWidths data headers) := by

  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Tabulate
-- === END: FIXED_FINAL ===
