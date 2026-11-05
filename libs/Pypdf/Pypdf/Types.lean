-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Pypdf


/-! ## Types -/

/-- PDF object types. -/
inductive PdfObject where
  | null    : PdfObject
  | boolean : Bool → PdfObject
  | integer : Int → PdfObject
  | real    : Float → PdfObject
  | str     : String → PdfObject
  | name    : String → PdfObject
  | array   : List PdfObject → PdfObject
  | dict    : List (String × PdfObject) → PdfObject
  | stream  : List (String × PdfObject) → ByteArray → PdfObject
  | ref     : Nat → Nat → PdfObject
  deriving BEq


/-- A rectangle defined by four coordinates (lower-left and upper-right). -/
structure Rectangle where
  x1 : Float
  y1 : Float
  x2 : Float
  y2 : Float
  deriving Repr, BEq


/-- PDF content stream operator. -/
inductive ContentOp where
  | Tj  : String → ContentOp
  | TJ  : List PdfObject → ContentOp
  | Tm  : Float → Float → Float → Float → Float → Float → ContentOp
  | Td  : Float → Float → ContentOp
  | TD  : Float → Float → ContentOp
  | Tf  : String → Float → ContentOp
  | Tc  : Float → ContentOp
  | Tw  : Float → ContentOp
  | Ts  : Float → ContentOp
  | TL  : Float → ContentOp
  | Tr  : Nat → ContentOp
  | Tz  : Float → ContentOp
  | BT  : ContentOp
  | ET  : ContentOp
  | cm  : Float → Float → Float → Float → Float → Float → ContentOp
  | q   : ContentOp
  | Q   : ContentOp
  | re  : Float → Float → Float → Float → ContentOp
  | m   : Float → Float → ContentOp
  | l   : Float → Float → ContentOp
  | Do  : String → ContentOp
  deriving BEq


/-- Annotation type. -/
inductive AnnotationType where
  | text | link | freeText | line | square | circle
  | highlight | underline | strikeout | stamp | popup | widget
  | other : String → AnnotationType
  deriving Repr, BEq


/-- An annotation on a page. -/
structure Annotation where
  annotType : AnnotationType
  rect      : Rectangle
  contents  : Option String
  dest      : Option String
  uri       : Option String
  deriving Repr, BEq


/-- Page rotation in degrees (multiples of 90). -/
inductive Rotation where
  | r0 | r90 | r180 | r270
  deriving Repr, BEq, DecidableEq


/-- Page merge mode. -/
inductive MergeMode where
  | overlay  : MergeMode
  | underlay : MergeMode
  deriving Repr, BEq, DecidableEq


/-- A single PDF page. -/
structure Page where
  mediaBox    : Rectangle
  cropBox     : Option Rectangle
  trimBox     : Option Rectangle
  bleedBox    : Option Rectangle
  artBox      : Option Rectangle
  rotation    : Rotation
  contents    : List ContentOp
  annotations : List Annotation
  resources   : List (String × PdfObject)
  deriving BEq

end Pypdf
-- === END: FIXED_FINAL ===
