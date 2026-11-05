-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Voluptuous.Types
import Voluptuous.Helpers

namespace Voluptuous

def validate (node : SchemaNode) (value : Value) (path : List String := [])
    : Except MultipleInvalid Value :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def validate_postcond (node : SchemaNode) (value : Value) (path : List String)
    (result : Except MultipleInvalid Value) : Prop :=
  (∀ v, result = .ok v → node = .literal value → v = value) ∧
  (∀ e, result = .error e → e.errors.length ≥ 1) ∧
  ((∃ v, result = .ok v) ∨ (∃ e, result = .error e)) ∧
  (∀ (tname : String) (check : Value → Bool) (v : Value),
    node = .typeCheck tname check → result = .ok v → check value = true ∧ v = value) ∧
  (∀ (tname : String) (check : Value → Bool),
    node = .typeCheck tname check → check value = false →
    ∃ e, result = .error e) ∧
  (∀ (lo hi : Option Float),
    node = .range lo hi → value.toFloat? = none →
    ∃ e, result = .error e) ∧
  (∀ (lo hi : Option Nat),
    node = .length lo hi → value.length? = none →
    ∃ e, result = .error e) ∧
  (∀ (elemSchema : SchemaNode),
    node = .listOf elemSchema → ¬ value.isList →
    ∃ e, result = .error e) ∧
  (∀ (keys : List (String × KeyRequirement × SchemaNode)) (extra : ExtraKeys),
    node = .dictOf keys extra → ¬ value.isDict →
    ∃ e, result = .error e) ∧
  (∀ (keys : List (String × KeyRequirement × SchemaNode)) (extra : ExtraKeys)
     (entries : List (String × Value)),
    node = .dictOf keys extra → value = .dict entries →
    (∃ k ∈ keys, k.1 ∉ entries.map Prod.fst ∧ k.2.1 = .required) →
    ∃ e, result = .error e) ∧
  (∀ (keys : List (String × KeyRequirement × SchemaNode))
     (entries : List (String × Value)),
    node = .dictOf keys .prevent → value = .dict entries →
    (∃ k ∈ entries.map Prod.fst, k ∉ keys.map (·.1)) →
    ∃ e, result = .error e) ∧
  (∀ (lit : Value),
    node = .literal lit → ¬ (value == lit) →
    ∃ e, result = .error e) ∧
  (∀ (tname : String) (check : Value → Bool),
    node = .typeCheck tname check → check value = true →
    ∃ v, result = .ok v) ∧
  (∀ (lo hi : Option Float) (v : Value) (f : Float),
    node = .range lo hi → result = .ok v →
    value.toFloat? = some f →
    (match lo with | some l => f ≥ l | none => True) ∧
    (match hi with | some h => f ≤ h | none => True)) ∧
  (∀ (lo hi : Option Float) (v : Value),
    node = .range lo hi → result = .ok v → v = value) ∧
  (∀ (lo hi : Option Nat) (v : Value) (len : Nat),
    node = .length lo hi → result = .ok v →
    value.length? = some len →
    (match lo with | some l => len ≥ l | none => True) ∧
    (match hi with | some h => len ≤ h | none => True)) ∧
  (∀ (lo hi : Option Nat) (v : Value),
    node = .length lo hi → result = .ok v → v = value) ∧
  (∀ (tname : String) (convert : Value → Option Value),
    node = .coerce tname convert → convert value = none →
    ∃ e, result = .error e) ∧
  (∀ (tname : String) (convert : Value → Option Value) (v : Value),
    node = .coerce tname convert → result = .ok v →
    convert value = some v) ∧
  (∀ (name : String) (f : Value → Option Value),
    node = .custom name f → f value = none →
    ∃ e, result = .error e) ∧
  (∀ (name : String) (f : Value → Option Value) (v : Value),
    node = .custom name f → result = .ok v →
    f value = some v) ∧
  (∀ (pat : String),
    node = .matchRegex pat → ¬ value.isStr →
    ∃ e, result = .error e) ∧
  (node = .all [] → result = .ok value) ∧
  (node = .any [] → ∃ e, result = .error e)


theorem validate_spec (node : SchemaNode) (value : Value) (path : List String) :
    validate_postcond node value path (validate node value path) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/- Core Function 2: isBoolean_accepts. -/

@[reducible]
def isBoolean_accepts_postcond (b : Bool) (result : Except MultipleInvalid Value) : Prop :=
  result = .ok (.bool b)


theorem isBoolean_accepts_spec (b : Bool) :
    isBoolean_accepts_postcond b (validate isBoolean (.bool b)) := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



/- Core Function 3: isBoolean_rejects_int. -/

@[reducible]
def isBoolean_rejects_int_postcond (n : Int) (result : Except MultipleInvalid Value) : Prop :=
  ∃ e, result = .error e ∧ e.errors.length ≥ 1


theorem isBoolean_rejects_int_spec (n : Int) :
    isBoolean_rejects_int_postcond n (validate isBoolean (.int n)) := by

  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



/- Additional: isBoolean rejects strings. -/

@[reducible]
def isBoolean_rejects_str_postcond (s : String) (result : Except MultipleInvalid Value) : Prop :=
  ∃ e, result = .error e ∧ e.errors.length ≥ 1


theorem isBoolean_rejects_str_spec (s : String) :
    isBoolean_rejects_str_postcond s (validate isBoolean (.str s)) := by

  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Voluptuous
-- === END: FIXED_FINAL ===
