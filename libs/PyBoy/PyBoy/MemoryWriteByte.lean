-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import PyBoy.Types
import PyBoy.Helpers

namespace PyBoy


/-- Write a byte to memory. -/
def Memory.writeByte (mem : Memory) (addr : Word) (val : Byte) : Memory :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def Memory_writeByte_postcond (mem : Memory) (addr : Word) (val : Byte) (result : Memory) : Prop :=
  result.readByte addr = val ∧
  (∀ a2, a2 ≠ addr → result.readByte a2 = mem.readByte a2)


theorem Memory_writeByte_spec (mem : Memory) (addr : Word) (val : Byte) :
    Memory_writeByte_postcond mem addr val (Memory.writeByte mem addr val) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===




/-! ## Relational: Memory writeByte idempotent -/

@[reducible]
def Memory_writeByte_idempotent_rel (mem : Memory) (addr : Word) (v1 v2 : Byte) : Prop :=
  (mem.writeByte addr v1).writeByte addr v2 = mem.writeByte addr v2


theorem Memory_writeByte_idempotent_spec (mem : Memory) (addr : Word) (v1 v2 : Byte) :
    Memory_writeByte_idempotent_rel mem addr v1 v2 := by
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end PyBoy
-- === END: FIXED_FINAL ===
