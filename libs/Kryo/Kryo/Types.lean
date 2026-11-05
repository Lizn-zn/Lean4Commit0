-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Kryo

inductive KryoValue where
  | null : KryoValue
  | bool : Bool → KryoValue
  | int : Int → KryoValue
  | long : Int → KryoValue
  | float : Float → KryoValue
  | double : Float → KryoValue
  | char : Char → KryoValue
  | string : String → KryoValue
  | array : List KryoValue → KryoValue
  | object : List (String × KryoValue) → KryoValue
  deriving Repr, BEq, Inhabited
/-- An output buffer for writing serialized data. -/
structure Output where
  buffer : List UInt8
  position : Nat
  deriving Repr, BEq
/-- An input buffer for reading serialized data. -/
structure Input where
  buffer : List UInt8
  position : Nat
  deriving Repr, BEq

def typeTagNull : UInt8 := 0
def typeTagBool : UInt8 := 1
def typeTagInt : UInt8 := 2
def typeTagLong : UInt8 := 3
def typeTagFloat : UInt8 := 4
def typeTagDouble : UInt8 := 5
def typeTagChar : UInt8 := 6
def typeTagString : UInt8 := 7
def typeTagArray : UInt8 := 8
def typeTagObject : UInt8 := 9

end Kryo
-- === END: FIXED_FINAL ===
