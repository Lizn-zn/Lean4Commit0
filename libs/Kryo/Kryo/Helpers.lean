-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Kryo.Types

namespace Kryo

def Output.empty : Output :=
  { buffer := [], position := 0 }

/-- Create an input buffer from a byte list. -/
def Input.fromBytes (bytes : List UInt8) : Input :=
  { buffer := bytes, position := 0 }

/-! ## Helpers for byte encoding -/

@[reducible]
def intToBytes4 (n : Int) : List UInt8 :=
  let u : Int := (n % 4294967296 + 4294967296) % 4294967296
  [(u / 16777216 % 256).toNat.toUInt8,
   (u / 65536 % 256).toNat.toUInt8,
   (u / 256 % 256).toNat.toUInt8,
   (u % 256).toNat.toUInt8]

@[reducible]
def intToBytes8 (n : Int) : List UInt8 :=
  let m : Int := 18446744073709551616  -- 2^64
  let u : Int := (n % m + m) % m
  [(u / 72057594037927936 % 256).toNat.toUInt8,
   (u / 281474976710656 % 256).toNat.toUInt8,
   (u / 1099511627776 % 256).toNat.toUInt8,
   (u / 4294967296 % 256).toNat.toUInt8,
   (u / 16777216 % 256).toNat.toUInt8,
   (u / 65536 % 256).toNat.toUInt8,
   (u / 256 % 256).toNat.toUInt8,
   (u % 256).toNat.toUInt8]

/-! ## Float/Double byte encoding helpers -/

@[reducible]
def float32BytesBE (f : Float) : List UInt8 :=
  let bits := f.toFloat32.toBits
  [(bits >>> 24 &&& 255).toUInt8,
   (bits >>> 16 &&& 255).toUInt8,
   (bits >>> 8 &&& 255).toUInt8,
   (bits &&& 255).toUInt8]

@[reducible]
def float64BytesBE (f : Float) : List UInt8 :=
  let bits := f.toBits
  [(bits >>> 56 &&& 255).toUInt8,
   (bits >>> 48 &&& 255).toUInt8,
   (bits >>> 40 &&& 255).toUInt8,
   (bits >>> 32 &&& 255).toUInt8,
   (bits >>> 24 &&& 255).toUInt8,
   (bits >>> 16 &&& 255).toUInt8,
   (bits >>> 8 &&& 255).toUInt8,
   (bits &&& 255).toUInt8]

@[reducible]
def kryoTypeTag : KryoValue → UInt8
  | .null   => typeTagNull
  | .bool _ => typeTagBool
  | .int _  => typeTagInt
  | .long _ => typeTagLong
  | .float _ => typeTagFloat
  | .double _ => typeTagDouble
  | .char _   => typeTagChar
  | .string _ => typeTagString
  | .array _  => typeTagArray
  | .object _ => typeTagObject

end Kryo
-- === END: FIXED_FINAL ===
