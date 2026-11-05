-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import TinyDB.Types
import TinyDB.Eval
import TinyDB.Insert

namespace TinyDB

def Table.search (t : Table) (q : Query) : List Document :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Table.search_postcond (t : Table) (q : Query) (result : List Document) : Prop :=
  (q = Query.all → result = t.documents) ∧
  (q = Query.none → result = []) ∧
  (∀ d, d ∈ result → d ∈ t.documents ∧ Query.eval q d.data = true) ∧
  (∀ d, d ∈ t.documents → Query.eval q d.data = true → d ∈ result)


theorem Table.search_spec (t : Table) (q : Query) :
    Table.search_postcond t q (t.search q) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



def Table.get (t : Table) (docId : Nat) : Option Document :=

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def Table.get_after_insert_rel (t : Table) (data : Value)
    (get_result : Option Document) : Prop :=
  let result := t.insert data
  let id := result.2
  get_result = some { docId := id, data := data }


theorem Table.get_after_insert_spec (t : Table) (data : Value) :
    let result := t.insert data
    let t' := result.1
    let id := result.2
    t'.get id = some { docId := id, data := data } := by

  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



@[reducible]
def Table.insert_search_rel (t : Table) (data : Value) (q : Query)
    (search_result : List Document) : Prop :=
  let inserted_id := t.nextId
  Query.eval q data = true →
  ∃ d ∈ search_result, d.data = data ∧ d.docId = inserted_id


theorem Table.insert_search_spec' (t : Table) (data : Value) (q : Query)
    (hq : Query.eval q data = true) :
    let result := t.insert data
    let t' := result.1
    let id := result.2
    { docId := id, data := data } ∈ t'.search q := by

  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end TinyDB
-- === END: FIXED_FINAL ===
