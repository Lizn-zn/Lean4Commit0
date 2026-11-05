-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Pest.Types
import Pest.Helpers

namespace Pest

/-! ## Core Function 1: PEG Matching Engine -/

def matchExpr (g : Grammar) (e : Expr) (input : String) (pos : Nat)
    (stack : List String) : Option (Nat × List String) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def matchExpr_postcond (g : Grammar) (e : Expr) (input : String) (pos : Nat)
    (stack : List String) (result : Option (Nat × List String)) : Prop :=
  (∀ s, e = Expr.literal s → (input.drop pos).startsWith s = true →
    ∃ stack', result = some (pos + s.length, stack')) ∧
  (∀ s, e = Expr.literal s → (input.drop pos).startsWith s = false →
    result = none) ∧
  (∀ s, e = Expr.insensitive s →
    ∀ endPos stack', result = some (endPos, stack') → endPos = pos + s.length) ∧
  (∀ s, e = Expr.insensitive s →
    ((input.drop pos).take s.length).toString.toLower = s.toLower →
    ∃ stack', result = some (pos + s.length, stack')) ∧
  (∀ s, e = Expr.insensitive s →
    ((input.drop pos).take s.length).toString.toLower ≠ s.toLower →
    result = none) ∧
  (∀ lo hi, e = Expr.range lo hi →
    ∀ endPos stack', result = some (endPos, stack') → endPos = pos + 1) ∧
  (∀ lo hi, e = Expr.range lo hi → pos ≥ input.length → result = none) ∧
  (e = Expr.any → ∀ endPos stack', result = some (endPos, stack') → endPos = pos + 1) ∧
  (e = Expr.any → pos ≥ input.length → result = none) ∧
  (e = Expr.sequence [] → ∃ stack', result = some (pos, stack')) ∧
  (∀ s rest, e = Expr.sequence (Expr.literal s :: rest) →
    (input.drop pos).startsWith s = false →
    result = none) ∧
  (∀ e', e = Expr.optional e' → result.isSome = true) ∧
  (∀ e', e = Expr.zeroOrMore e' → result.isSome = true) ∧
  (∀ e', e = Expr.oneOrMore e' →
    ∀ endPos stack', result = some (endPos, stack') → endPos > pos) ∧
  (∀ e', e = Expr.posLookahead e' →
    ∀ endPos stack', result = some (endPos, stack') → endPos = pos) ∧
  (∀ s, e = Expr.posLookahead (Expr.literal s) →
    (input.drop pos).startsWith s = true →
    ∃ stack', result = some (pos, stack')) ∧
  (∀ s, e = Expr.posLookahead (Expr.literal s) →
    (input.drop pos).startsWith s = false →
    result = none) ∧
  (∀ e', e = Expr.negLookahead e' →
    ∀ endPos stack', result = some (endPos, stack') → endPos = pos) ∧
  (∀ s, e = Expr.negLookahead (Expr.literal s) →
    (input.drop pos).startsWith s = false →
    ∃ stack', result = some (pos, stack')) ∧
  (∀ s, e = Expr.negLookahead (Expr.literal s) →
    (input.drop pos).startsWith s = true →
    result = none) ∧
  (∀ s, e = Expr.push (Expr.literal s) →
    (input.drop pos).startsWith s = true →
    result.isSome = true) ∧
  (∀ s, e = Expr.push (Expr.literal s) →
    (input.drop pos).startsWith s = false →
    result = none) ∧
  (∀ endPos stack', result = some (endPos, stack') → endPos ≥ pos)

theorem matchExpr_spec (g : Grammar) (e : Expr) (input : String) (pos : Nat)
    (stack : List String) :
    matchExpr_postcond g e input pos stack (matchExpr g e input pos stack) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Pest
-- === END: FIXED_FINAL ===
