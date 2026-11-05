-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Pest.Types
import Pest.Helpers
import Pest.MatchExpr

namespace Pest

/-! ## Core Function 2: Full Input Parsing -/

def parse (g : Grammar) (input : String) : Option ParseNode :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def parse_postcond (g : Grammar) (input : String) (result : Option ParseNode) : Prop :=
  (∀ node, result = some node → node.getSpan = { start := 0, «end» := input.length }) ∧
  (∀ node, result = some node → node.getRuleName = g.start) ∧
  (g.rules = [] → result = none) ∧
  (∀ node, result = some node → (g.findRulePure g.start).isSome = true) ∧
  (∀ r, g.findRulePure g.start = some r → r.expr = Expr.literal input →
    ∃ node, result = some node) ∧
  (∀ r s, g.findRulePure g.start = some r → r.expr = Expr.literal s →
    s ≠ input → result = none)

theorem parse_spec (g : Grammar) (input : String) :
    parse_postcond g input (parse g input) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Core Function 3: Parse Tree Tokenization -/

def ParseNode.tokens : ParseNode → List Token :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



@[reducible]
def ParseNode_tokens_postcond (node : ParseNode) (result : List Token) : Prop :=
  (result.filter fun t => match t with | Token.start .. => true | _ => false).length =
  (result.filter fun t => match t with | Token.end .. => true | _ => false).length ∧
  result.length ≥ 2 ∧
  result.length = 2 * node.countNodes ∧
  (∀ r p, result.head? = some (Token.start r p) → r = node.getRuleName ∧ p = node.getSpan.start) ∧
  (∀ r p, result.getLast? = some (Token.end r p) → r = node.getRuleName ∧ p = node.getSpan.«end»)

theorem ParseNode_tokens_spec (node : ParseNode) :
    ParseNode_tokens_postcond node (ParseNode.tokens node) := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Pest
-- === END: FIXED_FINAL ===
