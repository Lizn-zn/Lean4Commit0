-- === BEGIN: FIXED_FINAL (provided) ===
import Batteries.Data.String.Matcher
import Std
import Lean

instance : Repr ByteArray where
  reprPrec b _ := s!"ByteArray(size={b.size})"

def ByteArray.u16be (b : ByteArray) (i : Nat) : UInt16 :=
  if h1 : i < b.size then
    if h2 : i + 1 < b.size then
      let hi := (b.get! i).toUInt16
      let lo := (b.get! (i + 1)).toUInt16
      (hi <<< 8) ||| lo
    else 0
  else 0

def ByteArray.pushU16be (b : ByteArray) (n : UInt16) : ByteArray :=
  (b.push (UInt8.ofNat ((n.toNat >>> 8) &&& 0xFF))).push (UInt8.ofNat (n.toNat &&& 0xFF))
-- === END: FIXED_FINAL ===
