-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Chardet.Types

namespace Chardet

@[reducible]
def hasBomPattern (data : ByteArray) : Bool :=
  (data.size ≥ 3 && data.get! 0 == 0xEF && data.get! 1 == 0xBB && data.get! 2 == 0xBF) ||
  (data.size ≥ 2 && data.get! 0 == 0xFE && data.get! 1 == 0xFF) ||
  (data.size ≥ 4 && data.get! 0 == 0x00 && data.get! 1 == 0x00 &&
    data.get! 2 == 0xFE && data.get! 3 == 0xFF) ||
  (data.size ≥ 2 && data.get! 0 == 0xFF && data.get! 1 == 0xFE)

@[reducible]
def allPrintableAscii (data : ByteArray) : Bool :=
  data.size > 0 &&
  (List.range data.size).all (fun i => data.get! i > 0 && data.get! i < 127)

@[reducible]
def hasUtf8Bom (data : ByteArray) : Bool :=
  data.size ≥ 3 && data.get! 0 == 0xEF && data.get! 1 == 0xBB && data.get! 2 == 0xBF

@[reducible]
def hasHighByte (data : ByteArray) : Bool :=
  (List.range data.size).any (fun i => data.get! i >= 128)

@[reducible]
def hasNullByte (data : ByteArray) : Bool :=
  (List.range data.size).any (fun i => data.get! i == 0)

@[reducible]
def DetectionResult.headD (result : List DetectionResult) : DetectionResult :=
  result.headD default

@[reducible]
def isSortedByConfidence : List DetectionResult → Bool
  | [] => true
  | [_] => true
  | r₁ :: r₂ :: rest => r₁.confidence ≥ r₂.confidence && isSortedByConfidence (r₂ :: rest)

end Chardet
-- === END: FIXED_FINAL ===
