-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

import Orjson.Types

namespace Orjson

/-! ## Helpers -/

/-- Simple substring check (ASCII-safe). -/
def hasSubStr (haystack needle : String) : Bool :=
  let h := haystack.toList
  let n := needle.toList
  if n.isEmpty then true
  else if h.length < n.length then false
  else (List.range (h.length - n.length + 1)).any fun i =>
    (h.drop i).take n.length == n

/-- Returns true if a JsonValue is a scalar (not array or object). -/
def isScalarJV : JsonValue → Bool
  | JsonValue.null     => true
  | JsonValue.bool _   => true
  | JsonValue.int _    => true
  | JsonValue.float _  => true
  | JsonValue.str _    => true
  | JsonValue.array _  => false
  | JsonValue.object _ => false

end Orjson
-- === END: FIXED_FINAL ===
