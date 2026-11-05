-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace PyBoy


/-! ## Basic Types -/

/-- An 8-bit unsigned value. -/
abbrev Byte := UInt8


/-- A 16-bit unsigned value. -/
abbrev Word := UInt16


/-! ## CPU Flags -/

/-- CPU flag register bits. -/
structure Flags where
  z : Bool   -- Zero flag
  n : Bool   -- Subtract flag
  h : Bool   -- Half-carry flag
  c : Bool   -- Carry flag
  deriving Repr, BEq


/-! ## CPU Registers -/

/-- The Game Boy CPU register file. -/
structure Registers where
  a : Byte
  b : Byte
  c : Byte
  d : Byte
  e : Byte
  f : Flags
  h : Byte
  l : Byte
  sp : Word
  pc : Word
  deriving Repr


/-! ## Memory -/

/-- The Game Boy memory (64 KB flat address space). -/
structure Memory where
  data : Array Byte
  deriving Repr


/-! ## Instruction Set -/

/-- An 8-bit register identifier. -/
inductive Reg8 where
  | a | b | c | d | e | h | l
  deriving Repr, BEq


/-- A 16-bit register pair identifier. -/
inductive Reg16 where
  | af | bc | de | hl | sp
  deriving Repr, BEq


/-- CPU condition codes for conditional jumps/calls. -/
inductive Condition where
  | nz   -- not zero
  | z    -- zero
  | nc   -- not carry
  | cond_c   -- carry
  deriving Repr, BEq


/-- Decoded CPU instruction. -/
inductive Instruction where
  | nop
  | halt
  | stop
  | di
  | ei
  | ldReg8Reg8 (dst src : Reg8)
  | ldReg8Imm8 (dst : Reg8) (val : Byte)
  | ldReg16Imm16 (dst : Reg16) (val : Word)
  | ldHLMemReg8 (src : Reg8)
  | ldReg8HLMem (dst : Reg8)
  | ldAMemBC
  | ldAMemDE
  | ldMemBCA
  | ldMemDEA
  | ldAMemImm16 (addr : Word)
  | ldMemImm16A (addr : Word)
  | ldHLIncA
  | ldHLDecA
  | ldAHLInc
  | ldAHLDec
  | ldSPImm16 (val : Word)
  | ldMemImm16SP (addr : Word)
  | addAReg8 (src : Reg8)
  | addAImm8 (val : Byte)
  | addAHLMem
  | adcAReg8 (src : Reg8)
  | adcAImm8 (val : Byte)
  | adcAHLMem
  | subAReg8 (src : Reg8)
  | subAImm8 (val : Byte)
  | subAHLMem
  | sbcAReg8 (src : Reg8)
  | sbcAImm8 (val : Byte)
  | sbcAHLMem
  | andAReg8 (src : Reg8)
  | andAImm8 (val : Byte)
  | andAHLMem
  | orAReg8 (src : Reg8)
  | orAImm8 (val : Byte)
  | orAHLMem
  | xorAReg8 (src : Reg8)
  | xorAImm8 (val : Byte)
  | xorAHLMem
  | cpAReg8 (src : Reg8)
  | cpAImm8 (val : Byte)
  | cpAHLMem
  | incReg8 (dst : Reg8)
  | decReg8 (dst : Reg8)
  | incHLMem
  | decHLMem
  | incReg16 (dst : Reg16)
  | decReg16 (dst : Reg16)
  | addHLReg16 (src : Reg16)
  | rlca | rrca | rla | rra
  | cpl
  | ccf
  | scf
  | daa
  | jpImm16 (addr : Word)
  | jpCondImm16 (cond : Condition) (addr : Word)
  | jpHL
  | jrImm8 (offset : Int)
  | jrCondImm8 (cond : Condition) (offset : Int)
  | callImm16 (addr : Word)
  | callCondImm16 (cond : Condition) (addr : Word)
  | ret
  | retCond (cond : Condition)
  | reti
  | rst (vec : Byte)
  | pushReg16 (src : Reg16)
  | popReg16 (dst : Reg16)
  | cbRlcReg8 (dst : Reg8)
  | cbRrcReg8 (dst : Reg8)
  | cbRlReg8 (dst : Reg8)
  | cbRrReg8 (dst : Reg8)
  | cbSlaReg8 (dst : Reg8)
  | cbSraReg8 (dst : Reg8)
  | cbSwapReg8 (dst : Reg8)
  | cbSrlReg8 (dst : Reg8)
  | cbBitReg8 (bit : Nat) (src : Reg8)
  | cbResReg8 (bit : Nat) (dst : Reg8)
  | cbSetReg8 (bit : Nat) (dst : Reg8)
  | cbRlcHL
  | cbRrcHL
  | cbRlHL
  | cbRrHL
  | cbSlaHL
  | cbSraHL
  | cbSwapHL
  | cbSrlHL
  | cbBitHL (bit : Nat)
  | cbSetHL (bit : Nat)
  | cbResHL (bit : Nat)
  | ldhMemImm8A (offset : Byte)
  | ldhAMemImm8 (offset : Byte)
  | ldhMemCA
  | ldhAMemC
  | addSPImm8 (offset : Int)
  | ldHLSPImm8 (offset : Int)
  | ldSPHL
  | unknown (opcode : Byte)
  deriving Repr


/-! ## CPU State -/

/-- Interrupt Master Enable flag. -/
abbrev IME := Bool


/-- Complete CPU state. -/
structure CPUState where
  registers : Registers
  memory : Memory
  ime : IME
  halted : Bool
  stopped : Bool
  cycles : Nat
  deriving Repr

end PyBoy
-- === END: FIXED_FINAL ===
