-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Kryo.Types

namespace Kryo

def losslessAt : Nat → KryoValue → Prop
  | 0, _ => False
  | fuel + 1, .int n => -(2^31) ≤ n ∧ n < 2^31
  | fuel + 1, .long n => -(2^63) ≤ n ∧ n < 2^63
  | fuel + 1, .char c => c.toNat < 256
  | fuel + 1, .float f => f.isFinite = true ∧ f.toFloat32.toFloat.toBits = f.toBits
  | fuel + 1, .double f => f.isFinite = true
  | fuel + 1, .array vs => ∀ v ∈ vs, losslessAt fuel v
  | fuel + 1, .object fields => ∀ p ∈ fields, losslessAt fuel p.2
  | _, _ => True

def KryoValue.Lossless (v : KryoValue) : Prop := losslessAt (sizeOf v + 1) v

end Kryo
-- === END: FIXED_FINAL ===
