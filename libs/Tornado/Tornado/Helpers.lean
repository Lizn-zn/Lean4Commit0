-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Tornado.Types

def _root_.Tornado.containsSubstr (s sub : String) : Prop :=
  (s.splitOn sub).length ≥ 2


instance (s sub : String) : Decidable (Tornado.containsSubstr s sub) :=
  inferInstanceAs (Decidable ((s.splitOn sub).length ≥ 2))

namespace Tornado

/-! ## URL Routing Types -/

/-- A URL specification mapping a regex-like pattern to a handler name. -/

def matchPattern (pattern : String) (path : String) : Option (List String) :=

  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/-- A routing table. -/

def TemplateContext.get (ctx : TemplateContext) (name : String) : Option TemplateValue :=
  ctx.bindings.lookup name

end Tornado
-- === END: FIXED_FINAL ===
