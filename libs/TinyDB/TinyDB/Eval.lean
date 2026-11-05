-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import TinyDB.Types
import TinyDB.Helpers

namespace TinyDB

def Query.eval (q : Query) (doc : Value) : Bool :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Query.eval_postcond (q : Query) (doc : Value) (result : Bool) : Prop :=
  (q = Query.all → result = true) ∧
  (q = Query.none → result = false) ∧
  (∀ q1 q2, q = Query.and q1 q2 → result = (Query.eval q1 doc && Query.eval q2 doc)) ∧
  (∀ q1 q2, q = Query.or q1 q2 → result = (Query.eval q1 doc || Query.eval q2 doc)) ∧
  (∀ q', q = Query.not q' → result = !Query.eval q' doc) ∧
  (∀ f, q = Query.exists f →
    result = (Value.getField doc f).isSome) ∧
  (∀ f v, q = Query.eq f v →
    result = (Value.getField doc f == Option.some v)) ∧
  (∀ f v, q = Query.ne f v →
    result = match Value.getField doc f with
      | Option.some fv => !(fv == v)
      | Option.none => false) ∧
  (∀ f sub, q = Query.search f sub →
    result = match Value.getField doc f with
      | Option.some (Value.str s) => (s.splitOn sub).length > 1
      | _ => false) ∧
  (∀ f vals, q = Query.oneOf f vals →
    result = match Value.getField doc f with
      | Option.some fv => vals.any (fun v => fv == v)
      | Option.none => false)


theorem Query.eval_spec (q : Query) (doc : Value) :
    Query.eval_postcond q doc (Query.eval q doc) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



theorem Query.eval_not_not (q : Query) (doc : Value) :
    Query.eval (Query.not (Query.not q)) doc = Query.eval q doc := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



theorem Query.eval_and_all (q : Query) (doc : Value) :
    Query.eval (Query.and q Query.all) doc = Query.eval q doc := by

  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



theorem Query.eval_or_none (q : Query) (doc : Value) :
    Query.eval (Query.or q Query.none) doc = Query.eval q doc := by

  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end TinyDB
-- === END: FIXED_FINAL ===
