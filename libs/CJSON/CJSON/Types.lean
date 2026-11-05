-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # CJSON
   An ultralightweight JSON parser.

   Ported from C's `cJSON` library.
   Original: https://github.com/DaveGamble/cJSON

   This is a summarized version containing only the 3 most essential
   function specs: parse, print, and addItemToObject,
   plus the parse/print roundtrip and addItemToObject preserves relational specs.
-/

namespace CJSON

inductive JSON where
  | null   : JSON
  | bool   : Bool → JSON
  | number : Float → JSON
  | string : String → JSON
  | array  : List JSON → JSON
  | object : List (String × JSON) → JSON
  deriving Repr, BEq, Inhabited

end CJSON
-- === END: FIXED_FINAL ===
