-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace Toolz

def groupBy (xs : List α) (key : α → β) [BEq β] : List (β × List α) :=
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def groupBy_postcond [BEq β] (xs : List α) (key : α → β) (result : List (β × List α)) : Prop :=
  (result.map (·.2)).flatten.length = xs.length ∧
  (∀ pair ∈ result, ∀ elem ∈ pair.2, (key elem == pair.1) = true)


theorem groupBy_spec [BEq β] [LawfulBEq β] (xs : List α) (key : α → β) :
    groupBy_postcond xs key (groupBy xs key) := by
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/-! ## merge (dicttoolz) -/


end Toolz
-- === END: FIXED_FINAL ===
