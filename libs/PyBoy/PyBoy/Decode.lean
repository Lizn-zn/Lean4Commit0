-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import PyBoy.Types
import PyBoy.Helpers
import PyBoy.MemoryWriteByte

namespace PyBoy


/-! ## decode -/

/-- Decode an opcode byte to an instruction. -/
def decode (opcode : Byte) (arg1 arg2 : Byte) : Instruction :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===




@[reducible]
def decode_postcond (opcode arg1 arg2 : Byte) (result : Instruction) : Prop :=
  (opcode = 0x00 → result = Instruction.nop) ∧
  (opcode = 0x76 → result = Instruction.halt) ∧
  (opcode = 0xF3 → result = Instruction.di) ∧
  (opcode = 0xFB → result = Instruction.ei) ∧
  (opcode = 0x10 → result = Instruction.stop) ∧
  (opcode = 0xC9 → result = Instruction.ret) ∧
  -- CB prefix: specific common sub-instructions pinned to arg1
  (opcode = 0xCB ∧ arg1 = 0x11 → result = Instruction.cbRlReg8 Reg8.c) ∧
  (opcode = 0xCB ∧ arg1 = 0x7C → result = Instruction.cbBitReg8 7 Reg8.h) ∧
  (opcode = 0xCB ∧ arg1 = 0x87 → result = Instruction.cbResReg8 0 Reg8.a) ∧
  (opcode = 0xCB ∧ arg1 = 0xC7 → result = Instruction.cbSetReg8 0 Reg8.a) ∧
  (opcode = 0xCB ∧ arg1 = 0x00 → result = Instruction.cbRlcReg8 Reg8.b) ∧
  (opcode = 0xCB ∧ arg1 = 0x08 → result = Instruction.cbRrcReg8 Reg8.b) ∧
  (opcode = 0xC3 → result = Instruction.jpImm16 ((arg2.toUInt16 <<< 8) ||| arg1.toUInt16)) ∧
  (opcode = 0xCD → result = Instruction.callImm16 ((arg2.toUInt16 <<< 8) ||| arg1.toUInt16)) ∧
  (opcode = 0x01 → result = Instruction.ldReg16Imm16 Reg16.bc ((arg2.toUInt16 <<< 8) ||| arg1.toUInt16)) ∧
  (opcode = 0x11 → result = Instruction.ldReg16Imm16 Reg16.de ((arg2.toUInt16 <<< 8) ||| arg1.toUInt16)) ∧
  (opcode = 0x21 → result = Instruction.ldReg16Imm16 Reg16.hl ((arg2.toUInt16 <<< 8) ||| arg1.toUInt16)) ∧
  (opcode = 0x31 → result = Instruction.ldSPImm16 ((arg2.toUInt16 <<< 8) ||| arg1.toUInt16)) ∧
  (opcode = 0xAF → result = Instruction.xorAReg8 Reg8.a) ∧
  (opcode = 0xE0 → result = Instruction.ldhMemImm8A arg1) ∧
  (opcode = 0xF0 → result = Instruction.ldhAMemImm8 arg1) ∧
  (opcode = 0x06 → result = Instruction.ldReg8Imm8 Reg8.b arg1) ∧
  (opcode = 0x0E → result = Instruction.ldReg8Imm8 Reg8.c arg1) ∧
  (opcode = 0x16 → result = Instruction.ldReg8Imm8 Reg8.d arg1) ∧
  (opcode = 0x1E → result = Instruction.ldReg8Imm8 Reg8.e arg1) ∧
  (opcode = 0x26 → result = Instruction.ldReg8Imm8 Reg8.h arg1) ∧
  (opcode = 0x2E → result = Instruction.ldReg8Imm8 Reg8.l arg1) ∧
  (opcode = 0x3E → result = Instruction.ldReg8Imm8 Reg8.a arg1) ∧
  (opcode = 0xA8 → result = Instruction.xorAReg8 Reg8.b) ∧
  (opcode = 0xA9 → result = Instruction.xorAReg8 Reg8.c) ∧
  (opcode = 0xAA → result = Instruction.xorAReg8 Reg8.d) ∧
  (opcode = 0xAB → result = Instruction.xorAReg8 Reg8.e) ∧
  (opcode = 0xAC → result = Instruction.xorAReg8 Reg8.h) ∧
  (opcode = 0xAD → result = Instruction.xorAReg8 Reg8.l) ∧
  (opcode = 0xC7 → result = Instruction.rst 0x00) ∧
  (opcode = 0xCF → result = Instruction.rst 0x08) ∧
  (opcode = 0xD7 → result = Instruction.rst 0x10) ∧
  (opcode = 0xDF → result = Instruction.rst 0x18) ∧
  (opcode = 0xE7 → result = Instruction.rst 0x20) ∧
  (opcode = 0xEF → result = Instruction.rst 0x28) ∧
  (opcode = 0xF7 → result = Instruction.rst 0x30) ∧
  (opcode = 0xFF → result = Instruction.rst 0x38) ∧
  (opcode = 0xE9 → result = Instruction.jpHL) ∧
  (opcode = 0xF9 → result = Instruction.ldSPHL) ∧
  (opcode = 0xD9 → result = Instruction.reti)


theorem decode_spec (opcode arg1 arg2 : Byte) :
    decode_postcond opcode arg1 arg2 (decode opcode arg1 arg2) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end PyBoy
-- === END: FIXED_FINAL ===
