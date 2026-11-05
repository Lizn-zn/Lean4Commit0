-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import TinyDB.Types
import TinyDB.Eval

namespace TinyDB

def Table.insert (t : Table) (data : Value) : Table × Nat :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Table.insert_postcond (t : Table) (data : Value) (result : Table × Nat) : Prop :=
  result.1.documents.length = t.documents.length + 1 ∧
  result.2 = t.nextId ∧
  result.1.nextId = t.nextId + 1 ∧
  result.1.name = t.name ∧
  { docId := result.2, data := data } ∈ result.1.documents


theorem Table.insert_spec (t : Table) (data : Value) :
    Table.insert_postcond t data (t.insert data) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end TinyDB
-- === END: FIXED_FINAL ===
