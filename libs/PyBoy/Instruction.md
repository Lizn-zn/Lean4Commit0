# PyBoy

## Background

PyBoy is a Game Boy emulator written in Python. This spec models the core emulation components — CPU instruction decoding, instruction execution, and memory operations — as pure state-transition functions. The Game Boy's Sharp LR35902 CPU is an 8-bit processor with a 16-bit address space (64 KB), and instructions are decoded from 1-3 byte sequences.

## Task

Complete implementation holes in explicitly editable regions in the `PyBoy/*.lean` module files and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `decode`

- **Signature**: `def decode (opcode : Byte) (arg1 arg2 : Byte) : Instruction`
- **Description**: Decodes a Game Boy opcode byte (with up to 2 argument bytes) into a structured `Instruction` value.
- **Postcondition**: 40+ concrete opcode mappings must be correct. Examples: `0x00` → NOP, `0x76` → HALT, `0xC3` → JP imm16 (little-endian from arg1/arg2), `0xCD` → CALL imm16, `0x01/11/21/31` → LD r16 imm16, `0x06/0E/.../3E` → LD r8 imm8, `0xA8-0xAF` → XOR r8, `0xC7-0xFF` (by 8) → RST vectors.
- **Key constraints**: 16-bit immediate values are constructed little-endian: `(arg2.toUInt16 <<< 8) ||| arg1.toUInt16`. The CB prefix (`0xCB`) must decode to some instruction (existential). All opcode-to-instruction mappings must match exactly.

### 2. `CPUState.execute`

- **Signature**: `def CPUState.execute (state : CPUState) (instr : Instruction) : CPUState`
- **Description**: Executes a single decoded instruction, producing a new CPU state. This is a pure state-transition function.
- **Postcondition**: (1) NOP preserves registers and memory. (2) DI clears IME, EI sets IME; both preserve memory. (3) HALT sets `halted=true`, STOP sets `stopped=true`; both preserve memory. (4) Memory data array size is always preserved. (5) `LD r8, imm8` sets the target register to the value and preserves memory. (6) `LD r8, r8` preserves memory.
- **Key constraints**: The postcondition uses `CPUState.getReg8` to verify register writes. Memory size (`data.size`) must be invariant across all instructions.

### 3. `Memory.writeByte`

- **Signature**: `def Memory.writeByte (mem : Memory) (addr : Word) (val : Byte) : Memory`
- **Description**: Writes a single byte to the specified address in the 64 KB memory space.
- **Postcondition**: (1) Reading back the written address returns the written value. (2) All other addresses are unchanged.
- **Key constraints**: Uses `Memory.readByte` in the postcondition — both functions must be consistent. The idempotent relational property requires that writing twice to the same address is equivalent to just the second write.

## Relational Properties

- **`Memory_writeByte_idempotent_rel`**: Writing value `v1` then `v2` to the same address is identical to just writing `v2`: `(mem.writeByte addr v1).writeByte addr v2 = mem.writeByte addr v2`.

## Types

- **`Byte`/`Word`**: Aliases for `UInt8` and `UInt16`.
- **`Flags`**: CPU flag register with `z` (zero), `n` (subtract), `h` (half-carry), `c` (carry) boolean fields.
- **`Registers`**: The full CPU register file: 8-bit registers `a`-`l`, flags `f`, and 16-bit `sp`/`pc`.
- **`Memory`**: A flat 64 KB address space stored as `Array Byte`.
- **`Reg8`/`Reg16`**: Enums identifying 8-bit registers (`a`-`l`) and 16-bit pairs (`af`, `bc`, `de`, `hl`, `sp`).
- **`Condition`**: CPU condition codes for conditional instructions (`nz`, `z`, `nc`, `cond_c`).
- **`Instruction`**: A large inductive type representing all Game Boy instructions (loads, ALU, jumps, calls, CB-prefix bit ops, etc.).
- **`CPUState`**: Complete CPU state combining registers, memory, IME flag, halted/stopped flags, and cycle counter.

## Hints

- For `Memory.readByte`/`writeByte`, the memory is a flat `Array Byte` of size 65536. Use `addr.toNat` as the array index. `writeByte` should use `Array.set!` and `readByte` should use `Array.get!` (or bounds-checked variants).
- For `decode`, implement a large match on the opcode byte. The CB prefix (0xCB) uses `arg1` as a second opcode byte for bit operations. 16-bit immediates are little-endian.
- For `CPUState.getReg8`, match on the `Reg8` enum and return the corresponding register from `state.registers`.
- For `CPUState.execute`, match on the `Instruction` and update the state accordingly. NOP is trivial. DI/EI just flip IME. LD instructions copy values between registers/memory.
- The `Memory_writeByte_idempotent_rel` proof likely requires showing that two consecutive `Array.set!` calls to the same index collapse to just the second one.
- The `CPUState_execute_postcond` is a conjunction — you can prove each branch independently based on the instruction match.

## Edit Boundaries

`PyBoy/*.lean` is divided into labeled sections:

```text
-- === BEGIN: SECTION_NAME (provided|editable) ===
...
-- === END: SECTION_NAME ===
```

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash and should remain unchanged.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Task contract

Every template placeholder is an explicit editable obligation. Declaration types, headers, predicates, and provided code are protected. Follow the validity assumptions in the theorem statements. The optional PROOF_IMPORTS regions accept imports from Mathlib, Batteries, Std, or Lean. Define any local helpers inside editable implementation or proof bodies.

The checker builds the library in a fresh workspace, verifies required declarations and their types, and audits transitive axioms. A template with unfinished obligations does not pass solution verification.

Task modules (relative to this library directory):

- `PyBoy/Decode.lean`
- `PyBoy/Execute.lean`
- `PyBoy/Helpers.lean`
- `PyBoy/MemoryWriteByte.lean`
- `PyBoy/Relations.lean`
- `PyBoy/Types.lean`
