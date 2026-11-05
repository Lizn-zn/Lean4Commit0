-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import PyBoy.Types
import PyBoy.Helpers
import PyBoy.MemoryWriteByte
import PyBoy.Decode

namespace PyBoy


/-! ## CPUState.execute -/

/-- Execute a single instruction. Pure state transition. -/
def CPUState.execute (state : CPUState) (instr : Instruction) : CPUState :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def CPUState_execute_postcond (state : CPUState) (instr : Instruction) (result : CPUState) : Prop :=
  (instr = Instruction.nop → result.registers = state.registers ∧ result.memory = state.memory) ∧
  (instr = Instruction.di → result.ime = false) ∧
  (instr = Instruction.ei → result.ime = true) ∧
  (instr = Instruction.halt → result.halted = true) ∧
  (instr = Instruction.stop → result.stopped = true) ∧
  result.memory.data.size = state.memory.data.size ∧
  (instr = Instruction.di → result.memory = state.memory) ∧
  (instr = Instruction.ei → result.memory = state.memory) ∧
  (instr = Instruction.halt → result.memory = state.memory) ∧
  (instr = Instruction.stop → result.memory = state.memory) ∧
  (∀ dst val, instr = Instruction.ldReg8Imm8 dst val →
    result.getReg8 dst = val ∧ result.memory = state.memory) ∧
  (∀ dst src, instr = Instruction.ldReg8Reg8 dst src →
    result.getReg8 dst = state.getReg8 src ∧ result.memory = state.memory)


theorem CPUState_execute_spec (state : CPUState) (instr : Instruction) :
    CPUState_execute_postcond state instr (CPUState.execute state instr) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end PyBoy
-- === END: FIXED_FINAL ===
