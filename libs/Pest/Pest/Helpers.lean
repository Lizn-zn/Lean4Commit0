-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Pest.Types

namespace Pest

/-! ## Pure helpers (no sorry) for postcondition use -/

def Grammar.findRulePure (g : Grammar) (name : String) : Option Rule :=
  g.rules.find? fun r => r.name == name

def ParseNode.getRuleName : ParseNode → String
  | .leaf r _ => r
  | .node r _ _ => r

def ParseNode.getSpan : ParseNode → Span
  | .leaf _ s => s
  | .node _ s _ => s

def ParseNode.countNodes : ParseNode → Nat
  | .leaf _ _ => 1
  | .node _ _ cs => 1 + cs.foldl (fun acc c => acc + c.countNodes) 0

end Pest
-- === END: FIXED_FINAL ===
