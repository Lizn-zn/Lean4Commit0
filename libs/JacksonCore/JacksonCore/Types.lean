-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace JacksonCore

inductive JsonToken where
  | startObject | endObject
  | startArray | endArray
  | fieldName : String → JsonToken
  | valueString : String → JsonToken
  | valueInt : Int → JsonToken
  | valueFloat : Float → JsonToken
  | valueTrue | valueFalse | valueNull
  | notAvailable
  deriving Repr, BEq

inductive ContextType where
  | root | object_ | array_
  deriving Repr, BEq

structure ParserContext where
  type : ContextType
  index : Nat
  parent : Option ParserContext
  deriving Repr, BEq

structure JsonParser where
  input : String
  position : Nat
  currentToken : Option JsonToken
  currentValue : Option String
  context : ParserContext
  depth : Nat
  closed : Bool
  deriving Repr, BEq

structure JsonGenerator where
  output : List String
  context : ParserContext
  depth : Nat
  closed : Bool
  deriving Repr, BEq

structure JsonPointer where
  segments : List String
  deriving Repr, BEq

inductive TreeNode where
  | null : TreeNode
  | bool : Bool → TreeNode
  | int : Int → TreeNode
  | float : Float → TreeNode
  | string : String → TreeNode
  | array : List TreeNode → TreeNode
  | object : List (String × TreeNode) → TreeNode
  deriving Repr, BEq

end JacksonCore
-- === END: FIXED_FINAL ===
