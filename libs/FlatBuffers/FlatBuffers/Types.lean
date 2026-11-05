-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

namespace FlatBuffers

/-! ## Schema Types -/

inductive ScalarType where
  | bool | int8 | int16 | int32 | int64
  | uint8 | uint16 | uint32 | uint64
  | float32 | float64
  deriving Repr, BEq

inductive FieldType where
  | scalar   : ScalarType → FieldType
  | string   : FieldType
  | vector   : FieldType → FieldType
  | table    : String → FieldType
  | struct_  : String → FieldType
  | enum_    : String → FieldType
  | union_   : String → FieldType
  deriving Repr, BEq

structure FieldDef where
  name         : String
  type         : FieldType
  defaultValue : Option Int := none
  deprecated   : Bool := false
  deriving Repr, BEq

structure TableDef where
  name   : String
  fields : List FieldDef
  deriving Repr, BEq

structure StructDef where
  name   : String
  fields : List (String × ScalarType)
  deriving Repr, BEq

structure EnumDef where
  name   : String
  values : List (String × Int)
  deriving Repr, BEq

structure Schema where
  tables  : List TableDef
  structs : List StructDef
  enums   : List EnumDef
  rootType : String
  deriving Repr, BEq

/-! ## Values -/

inductive Value where
  | bool   : Bool → Value
  | int    : Int → Value
  | float  : Float → Value
  | string : String → Value
  | vector : List Value → Value
  | table  : String → List (String × Value) → Value
  | struct_ : String → List (String × Value) → Value
  | null   : Value
  deriving Repr, BEq

/-! ## Builder -/

structure Builder where
  buffer    : List UInt8
  vtables   : List (List Nat)
  finished  : Bool
  deriving Repr

/-! ## Core Function 2: Builder.addFieldInt -/

def Builder.addFieldInt (b : Builder) (fieldIdx : Nat) (val : Int) (default : Int) : Builder := 
                                                                                                
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                                                sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def Builder.addFieldInt_postcond (b : Builder) (fieldIdx : Nat) (val : Int) (default : Int) (result : Builder) : Prop :=
  result.buffer.length ≥ b.buffer.length ∧
  result.finished = false ∧
  (val ≠ default → result.buffer.length = b.buffer.length + 4) ∧
  (val = default → result.buffer.length = b.buffer.length)

theorem Builder.addFieldInt_spec (b : Builder) (fieldIdx : Nat) (val : Int) (default : Int) :
    Builder.addFieldInt_postcond b fieldIdx val default (b.addFieldInt fieldIdx val default) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end FlatBuffers
-- === END: FIXED_FINAL ===
