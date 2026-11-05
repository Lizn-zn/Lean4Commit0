-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Jedi
/-! ## Types -/
inductive BinOp where
  | add | sub | mul | div | floorDiv | modulo | pow
  | bitAnd | bitOr | bitXor | lShift | rShift
  deriving Repr, BEq, DecidableEq
/-- Comparison operators. -/
inductive CmpOp where
  | eq | notEq | lt | ltE | gt | gtE
  | isOp | isNotOp | inOp | notInOp
  deriving Repr, BEq, DecidableEq
/-- Unary operators. -/
inductive UnaryOp where
  | not_ | uSub | uAdd | invert
  deriving Repr, BEq, DecidableEq
/-- A position in source code. -/
structure Position where
  line   : Nat
  column : Nat
  deriving Repr, BEq, Ord
/-- A simplified Python expression AST for analysis. -/
inductive Expr where
  | name       : String → Position → Expr
  | intLit     : Int → Position → Expr
  | floatLit   : Float → Position → Expr
  | strLit     : String → Position → Expr
  | boolLit    : Bool → Position → Expr
  | noneLit    : Position → Expr
  | attribute  : Expr → String → Position → Expr
  | call       : Expr → List Expr → List (String × Expr) → Position → Expr
  | binOp      : Expr → BinOp → Expr → Position → Expr
  | unaryOp    : UnaryOp → Expr → Position → Expr
  | compare    : Expr → List (CmpOp × Expr) → Position → Expr
  | subscript  : Expr → Expr → Position → Expr
  | list_      : List Expr → Position → Expr
  | tuple      : List Expr → Position → Expr
  | dict       : List (Expr × Expr) → Position → Expr
  | set_       : List Expr → Position → Expr
  | ifExpr     : Expr → Expr → Expr → Position → Expr
  | lambda     : List String → Expr → Position → Expr
  | starred    : Expr → Position → Expr
  deriving Repr, BEq
/-- Function argument definition. -/
structure FuncArg where
  name       : String
  annotation : Option Expr
  defaultVal : Option Expr
  deriving Repr, BEq
/-- Function arguments specification. -/
structure FuncArgs where
  args       : List FuncArg
  vararg     : Option FuncArg
  kwonlyargs : List FuncArg
  kwarg      : Option FuncArg
  deriving Repr, BEq
/-- Import alias. -/
structure ImportAlias where
  name   : String
  asname : Option String
  deriving Repr, BEq
/-- A simplified Python statement AST for analysis. -/
inductive Stmt where
  | functionDef  : String → FuncArgs → List Stmt → Option Expr → Bool → Position → Stmt
  | classDef     : String → List Expr → List Stmt → Position → Stmt
  | assign       : List Expr → Expr → Position → Stmt
  | annAssign    : Expr → Expr → Option Expr → Position → Stmt
  | return_      : Option Expr → Position → Stmt
  | ifStmt       : Expr → List Stmt → List Stmt → Position → Stmt
  | forStmt      : Expr → Expr → List Stmt → Position → Stmt
  | whileStmt    : Expr → List Stmt → Position → Stmt
  | withStmt     : List (Expr × Option Expr) → List Stmt → Position → Stmt
  | tryStmt      : List Stmt → List (Option Expr × Option String × List Stmt) → List Stmt → List Stmt → Position → Stmt
  | import_      : List ImportAlias → Position → Stmt
  | importFrom   : Option String → List ImportAlias → Position → Stmt
  | exprStmt     : Expr → Position → Stmt
  | pass_        : Position → Stmt
  | global_      : List String → Position → Stmt
  | nonlocal_    : List String → Position → Stmt
  deriving Repr, BEq
/-- A Python module. -/
structure Module where
  name     : String
  filePath : String
  body     : List Stmt
  deriving Repr, BEq
-- ============================================================================
-- Scope analysis
-- ============================================================================
/-- Scope types in Python. -/
inductive ScopeKind where
  | builtin  : ScopeKind
  | module_  : ScopeKind
  | class_   : ScopeKind
  | function_: ScopeKind
  | lambda_  : ScopeKind
  | comprehension : ScopeKind
  deriving Repr, BEq, DecidableEq
/-- A scope in the scope chain. -/
structure Scope where
  kind      : ScopeKind
  name      : String
  startPos  : Position
  endPos    : Position
  parentIdx : Option Nat
  deriving Repr, BEq
/-- Position less-than-or-equal comparison. -/
inductive NameDefKind where
  | variable   : NameDefKind
  | function_  : NameDefKind
  | class_     : NameDefKind
  | parameter  : NameDefKind
  | importDef  : NameDefKind
  | importFrom : NameDefKind
  | withVar    : NameDefKind
  | forVar     : NameDefKind
  | exceptVar  : NameDefKind
  deriving Repr, BEq, DecidableEq
/-- A name definition in the source. -/
structure NameDef where
  name       : String
  kind       : NameDefKind
  pos        : Position
  scopeIdx   : Nat
  modulePath : String
  annotation : Option String
  docstring  : Option String
  deriving Repr, BEq
-- ============================================================================
-- Signature information
-- ============================================================================
/-- Parameter kind. -/
inductive ParamKind where
  | positionalOnly    : ParamKind
  | positionalOrKw    : ParamKind
  | varPositional     : ParamKind
  | keywordOnly       : ParamKind
  | varKeyword        : ParamKind
  deriving Repr, BEq, DecidableEq
/-- A function parameter in a signature. -/
structure ParamInfo where
  name        : String
  kind        : ParamKind
  annotation  : Option String
  defaultVal  : Option String
  description : Option String
  deriving Repr, BEq
/-- Function signature information. -/
structure SignatureInfo where
  name       : String
  params     : List ParamInfo
  returnType : Option String
  docstring  : Option String
  modulePath : String
  deriving Repr, BEq
end Jedi
-- === END: FIXED_FINAL ===
