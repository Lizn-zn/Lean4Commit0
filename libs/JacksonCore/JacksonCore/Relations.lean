-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import JacksonCore.Helpers
import JacksonCore.NextToken
import JacksonCore.Navigate
import JacksonCore.WriteStartObject

namespace JacksonCore

/-! ## Relational: generate then parse roundtrip -/

@[reducible]
def generate_parse_roundtrip_rel (t : TreeNode) (result : Option TreeNode) : Prop :=
  result = some t

theorem generate_parse_roundtrip_spec (t : TreeNode) :
    let g := TreeNode.toGenerator t JsonGenerator.create
    let p := JsonParser.create (g.flush)
    generate_parse_roundtrip_rel t ((TreeNode.fromParser p).map Prod.fst) := by 
                                                                                
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                                sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end JacksonCore
-- === END: FIXED_FINAL ===
