-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Graphene.Types
import Graphene.Helpers

namespace Graphene

/-! ## Core Function 1: validateDocument -/

/-- Validate a document against a schema -/
def validateDocument (schema : Schema) (doc : Document) : List ValidationError :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def validateDocument_postcond (schema : Schema) (doc : Document) (result : List ValidationError) : Prop :=
  (schema.validate = [] →
    (∀ op ∈ doc.operations, ∀ sel ∈ op.selections,
      match sel with
      | Selection.field fname _ _ _ _ => (schema.lookupField schema.queryType fname).isSome = true
      | _ => True) →
    (∀ frag ∈ doc.fragments, (schema.lookupType frag.typeCondition).isSome = true) →
    -- All fragment spreads must reference defined fragments
    (∀ op ∈ doc.operations,
      ∀ spreadName ∈ collectFragmentSpreads op.selections,
        ∃ frag ∈ doc.fragments, frag.name = spreadName) →
    -- No duplicate operation names (among named operations)
    (hasDuplicates (doc.operations.filterMap (·.name)) = false) →
    -- No duplicate fragment names
    (hasDuplicates (doc.fragments.map (·.name)) = false) →
    result = []) ∧
  ((∃ op ∈ doc.operations, ∃ sel ∈ op.selections,
    match sel with
    | Selection.field fname _ _ _ _ => (schema.lookupField schema.queryType fname).isNone = true
    | _ => False) →
    result ≠ []) ∧
  -- Missing fragment type condition must also trigger errors
  ((∃ frag ∈ doc.fragments, (schema.lookupType frag.typeCondition).isNone = true) →
    result ≠ []) ∧
  -- Duplicate operation names must trigger errors
  (hasDuplicates (doc.operations.filterMap (·.name)) = true →
    result ≠ []) ∧
  -- Duplicate fragment names must trigger errors
  (hasDuplicates (doc.fragments.map (·.name)) = true →
    result ≠ [])

theorem validateDocument_spec (schema : Schema) (doc : Document) :
    validateDocument_postcond schema doc (validateDocument schema doc) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Graphene
-- === END: FIXED_FINAL ===
