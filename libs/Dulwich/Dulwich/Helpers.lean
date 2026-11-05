-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Dulwich.Types

namespace Dulwich

/-! ## Helper predicates (pure, decidable — no sorry) -/

/-- Check if a byte is an ASCII hex character (0-9, a-f). -/
def isHexByte (b : UInt8) : Bool :=
  (b ≥ 48 && b ≤ 57) || (b ≥ 97 && b ≤ 102)

/-- Check whether `needle` occurs as a contiguous subarray of `haystack`. -/
def containsSubarray (haystack needle : ByteArray) : Bool :=
  if needle.size = 0 then true
  else
    let n := haystack.size
    let m := needle.size
    if m > n then false
    else (List.range (n - m + 1)).any (fun i =>
      (List.range m).all (fun j => haystack.get! (i + j) = needle.get! j))

/-- True when `raw` begins with `tree <40-hex-chars>\n`, indicating a
    well-formed git commit object body. -/
def hasValidTreeHeader (raw : ByteArray) : Bool :=
  raw.size ≥ 46 &&
  raw.get! 0 = 116 && raw.get! 1 = 114 && raw.get! 2 = 101 &&
  raw.get! 3 = 101 && raw.get! 4 = 32 &&
  (List.range 40).all (fun i => isHexByte (raw.get! (5 + i))) &&
  raw.get! 45 = 10


end Dulwich
-- === END: FIXED_FINAL ===
