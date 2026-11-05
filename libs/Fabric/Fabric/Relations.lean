-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Fabric.Types
import Fabric.Helpers
import Fabric.ResolveDependencies
import Fabric.ConfigGet
import Fabric.ShellFragmentRender

namespace Fabric

/-! ## Relational: resolveDependencies — all deps come from the input task graph -/

@[reducible]
def resolveDependencies_closed_rel (tasks : List TaskDef) (target : TaskId)
    (result : Option (List TaskId)) : Prop :=
  (∀ order, result = some order →
    ∀ tid ∈ order, tid = target ∨ ∃ t ∈ tasks, tid = t.id) ∧
  -- No duplicates in the order
  (∀ order, result = some order → order.Nodup)

theorem resolveDependencies_closed_spec (tasks : List TaskDef) (target : TaskId) :
    resolveDependencies_closed_rel tasks target (resolveDependencies tasks target) := by
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-! ## Relational: Config set then get roundtrip -/

@[reducible]
def Config.set_get_roundtrip_rel (cfg : Config) (k : String) (v : ConfigValue)
    (level : ConfigLevel) (result : Option ConfigValue) : Prop :=
  result = some v

theorem Config.set_get_roundtrip_spec (cfg : Config) (k : String) (v : ConfigValue)
    (level : ConfigLevel) :
    Config.set_get_roundtrip_rel cfg k v level ((cfg.set k v level).get k) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-! ## Relational: config set at higher level overrides lower level -/

@[reducible]
def Config.higher_level_overrides_rel (cfg : Config) (k : String) (v1 v2 : ConfigValue)
    (lo hi : ConfigLevel) : Prop :=
  lo.precedence < hi.precedence →
    ((cfg.set k v1 lo).set k v2 hi).get k = some v2

theorem Config.higher_level_overrides_spec (cfg : Config) (k : String) (v1 v2 : ConfigValue)
    (lo hi : ConfigLevel) (hlt : lo.precedence < hi.precedence) :
    Config.higher_level_overrides_rel cfg k v1 v2 lo hi := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



/-! ## Relational: ShellFragment literal renders to the literal string -/

@[reducible]
def ShellFragment.literal_render_rel (s : String) : Prop :=
  ShellFragment.render (.literal s) = s

theorem ShellFragment.literal_render_spec (s : String) :
    ShellFragment.literal_render_rel s := by
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Fabric
-- === END: FIXED_FINAL ===
