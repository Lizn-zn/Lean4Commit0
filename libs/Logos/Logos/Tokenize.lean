-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Logos.Types
import Logos.Helpers
import Logos.MatchPattern
import Logos.NextToken

namespace Logos

/-! ## Core Function 3: tokenize -/
def tokenize (def_ : LexerDef) (input : String) : Option (List Token) :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def tokenize_postcond (def_ : LexerDef) (input : String) (result : Option (List Token)) : Prop :=
  (∀ tokens, result = some tokens →
    List.Pairwise (fun a b => a.span.«end» ≤ b.span.start) tokens) ∧
  (∀ tokens, result = some tokens →
    ∀ t ∈ tokens, t.span.«end» ≤ input.length) ∧
  (∀ tokens, result = some tokens →
    ∀ t ∈ tokens, t.span.start ≤ t.span.«end») ∧
  (∀ tokens, result = some tokens →
    ∀ t ∈ tokens, t.kind ∈ def_.rules.map TokenRule.kind) ∧
  (∀ tokens, result = some tokens →
    ∀ t ∈ tokens, t.slice = (input.drop t.span.start).take (t.span.«end» - t.span.start)) ∧
  (input = "" → ∀ tokens, result = some tokens → tokens = []) ∧
  (∀ tokens, result = some tokens →
    ∀ t ∈ tokens, ∃ r ∈ def_.rules, r.kind = t.kind ∧
      matchPattern r.pattern input t.span.start = some t.span.«end») ∧
  (∀ tokens, result = some tokens → tokens ≠ [] →
    (tokens.getLast?).map (fun t => t.span.«end») = some input.length ∨
    def_.skip.isSome)

theorem tokenize_spec (def_ : LexerDef) (input : String) :
    tokenize_postcond def_ input (tokenize def_ input) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Logos
-- === END: FIXED_FINAL ===
