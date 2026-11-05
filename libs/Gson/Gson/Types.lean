-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Gson

/-! ## Core Types -/

/-- A JSON element, the fundamental type of the Gson model. -/
inductive JsonElement where
  | jsonNull : JsonElement
  | jsonBool : Bool → JsonElement
  | jsonInt : Int → JsonElement
  | jsonFloat : Float → JsonElement
  | jsonString : String → JsonElement
  | jsonArray : List JsonElement → JsonElement
  | jsonObject : List (String × JsonElement) → JsonElement
  deriving Repr, BEq, Inhabited


end Gson
-- === END: FIXED_FINAL ===
