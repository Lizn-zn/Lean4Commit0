-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Flask.Types
import Flask.Helpers
import Flask.MatchURL
import Flask.RouterMatch
import Flask.SessionSet

namespace Flask

/-! ## Relational: Session set then get roundtrip -/

@[reducible]
def Session.set_get_roundtrip_rel (session : Session) (k : String) (v : String) : Prop :=
  (session.set k v).get k = some v

theorem Session.set_get_roundtrip_spec (session : Session) (k : String) (v : String) :
    Session.set_get_roundtrip_rel session k v := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: Session set different key preserves -/

@[reducible]
def Session.set_preserves_other_rel (session : Session) (k1 k2 : String) (v : String) : Prop :=
  k1 ≠ k2 → (session.set k1 v).get k2 = session.get k2

theorem Session.set_preserves_other_spec (session : Session) (k1 k2 : String) (v : String)
    (hne : k1 ≠ k2) :
    Session.set_preserves_other_rel session k1 k2 v := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Flask
-- === END: FIXED_FINAL ===
