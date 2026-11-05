-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Fabric.Types
import Fabric.Helpers
import Fabric.ResolveDependencies

namespace Fabric

/-! ## Core Function 2: Config.get -/

/-- Set a configuration value at a given level. -/
def Config.set (cfg : Config) (key : String) (value : ConfigValue) (level : ConfigLevel) : Config := 
                                                                                                     
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                                                     sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-- Get a configuration value, respecting the level hierarchy. -/
def Config.get (cfg : Config) (key : String) : Option ConfigValue := 
                                                                     
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
                                                                     sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



@[reducible]
def Config.get_postcond (cfg : Config) (key : String) (result : Option ConfigValue) : Prop :=
  (cfg = Config.empty → result = none) ∧
  (cfg.entries = [] → result = none) ∧
  (∀ v, result = some v → ∃ e ∈ cfg.entries, e.key = key ∧ e.value = v) ∧
  -- Highest-precedence selection: returned entry has max precedence among matching entries
  (∀ v, result = some v →
    ∃ e ∈ cfg.entries, e.key = key ∧ e.value = v ∧
      ∀ e2 ∈ cfg.entries, e2.key = key → e2.level.precedence ≤ e.level.precedence) ∧
  -- Completeness: if a matching entry exists, result is not none
  (∀ e ∈ cfg.entries, e.key = key → result ≠ none)

theorem Config.get_spec (cfg : Config) (key : String) :
    Config.get_postcond cfg key (Config.get cfg key) := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Fabric
-- === END: FIXED_FINAL ===
