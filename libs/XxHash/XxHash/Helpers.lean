-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace XxHash

def xxh32Prime1 : UInt32 := 0x9E3779B1

def xxh32Prime2 : UInt32 := 0x85EBCA77

def xxh32Prime3 : UInt32 := 0xC2B2AE3D

def xxh32Prime4 : UInt32 := 0x27D4EB2F

def xxh32Prime5 : UInt32 := 0x165667B1

def xxh64Prime1 : UInt64 := 0x9E3779B185EBCA87

def xxh64Prime2 : UInt64 := 0xC2B2AE3D27D4EB4F

def xxh64Prime3 : UInt64 := 0x165667B19E3779F9

def xxh64Prime4 : UInt64 := 0x85EBCA77C2B2AE63

def xxh64Prime5 : UInt64 := 0x27D4EB2F165667C5

def rotl32 (v : UInt32) (n : UInt32) : UInt32 :=
  (v <<< n) ||| (v >>> (32 - n))

def rotl64 (v : UInt64) (n : UInt64) : UInt64 :=
  (v <<< n) ||| (v >>> (64 - n))

def readLE32 (data : List UInt8) (offset : Nat) : UInt32 :=
  let b0 := (data.getD offset 0).toUInt32
  let b1 := (data.getD (offset + 1) 0).toUInt32
  let b2 := (data.getD (offset + 2) 0).toUInt32
  let b3 := (data.getD (offset + 3) 0).toUInt32
  b0 ||| (b1 <<< 8) ||| (b2 <<< 16) ||| (b3 <<< 24)

def readLE64 (data : List UInt8) (offset : Nat) : UInt64 :=
  let b0 := (data.getD offset 0).toUInt64
  let b1 := (data.getD (offset + 1) 0).toUInt64
  let b2 := (data.getD (offset + 2) 0).toUInt64
  let b3 := (data.getD (offset + 3) 0).toUInt64
  let b4 := (data.getD (offset + 4) 0).toUInt64
  let b5 := (data.getD (offset + 5) 0).toUInt64
  let b6 := (data.getD (offset + 6) 0).toUInt64
  let b7 := (data.getD (offset + 7) 0).toUInt64
  b0 ||| (b1 <<< 8) ||| (b2 <<< 16) ||| (b3 <<< 24) |||
    (b4 <<< 32) ||| (b5 <<< 40) ||| (b6 <<< 48) ||| (b7 <<< 56)

end XxHash
-- === END: FIXED_FINAL ===
