-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Pylint


/-! ## Types -/

/-- Pylint message categories. -/
inductive MessageCategory where
  | convention : MessageCategory
  | refactor   : MessageCategory
  | warning    : MessageCategory
  | error      : MessageCategory
  | fatal      : MessageCategory
  deriving Repr, BEq, DecidableEq


/-- A pylint message definition. -/
structure MessageDef where
  msgId       : String
  symbol      : String
  category    : MessageCategory
  description : String
  checkerName : String
  deriving Repr, BEq


/-- A concrete message instance emitted during linting. -/
structure Message where
  msgId    : String
  symbol   : String
  category : MessageCategory
  line     : Nat
  column   : Nat
  endLine  : Option Nat
  endCol   : Option Nat
  msg      : String
  filePath : String
  module_  : String
  deriving Repr, BEq


/-! ## Simplified Python AST -/

/-- Binary operators. -/
inductive BinOperator where
  | add | sub | mul | div | floorDiv | modulo | pow
  | bitAnd | bitOr | bitXor | lShift | rShift
  deriving Repr, BEq, DecidableEq


/-- Comparison operators. -/
inductive CmpOperator where
  | eq | notEq | lt | ltE | gt | gtE
  | isOp | isNotOp | inOp | notInOp
  deriving Repr, BEq, DecidableEq


/-- Unary operators. -/
inductive UnaryOperator where
  | not_ | uSub | uAdd | invert
  deriving Repr, BEq, DecidableEq


/-- Boolean operators. -/
inductive BoolOperator where
  | and_ | or_
  deriving Repr, BEq, DecidableEq


/-- A simplified Python expression AST. -/
inductive Expr where
  | name       : String → Nat → Expr
  | intLit     : Int → Nat → Expr
  | floatLit   : Float → Nat → Expr
  | strLit     : String → Nat → Expr
  | boolLit    : Bool → Nat → Expr
  | noneLit    : Nat → Expr
  | attribute  : Expr → String → Nat → Expr
  | call       : Expr → List Expr → List (String × Expr) → Nat → Expr
  | binOp      : Expr → BinOperator → Expr → Nat → Expr
  | unaryOp    : UnaryOperator → Expr → Nat → Expr
  | boolOp     : BoolOperator → List Expr → Nat → Expr
  | compare    : Expr → List (CmpOperator × Expr) → Nat → Expr
  | subscript  : Expr → Expr → Nat → Expr
  | list_      : List Expr → Nat → Expr
  | tuple      : List Expr → Nat → Expr
  | dict       : List (Expr × Expr) → Nat → Expr
  | set_       : List Expr → Nat → Expr
  | ifExpr     : Expr → Expr → Expr → Nat → Expr
  | lambda     : List String → Expr → Nat → Expr
  | starred    : Expr → Nat → Expr
  | fstring    : List Expr → Nat → Expr
  deriving Repr, BEq


/-- Function argument definition. -/
structure Arg where
  name       : String
  annotation : Option Expr
  defaultVal : Option Expr
  deriving Repr, BEq


/-- Function arguments specification. -/
structure Arguments where
  args       : List Arg
  vararg     : Option Arg
  kwonlyargs : List Arg
  kwarg      : Option Arg
  defaults   : List Expr
  kwDefaults : List (Option Expr)
  deriving Repr, BEq


/-- Import alias (name with optional as-name). -/
structure ImportAlias where
  name   : String
  asname : Option String
  deriving Repr, BEq


/-- A decorator. -/
structure Decorator where
  expr : Expr
  line : Nat
  deriving Repr, BEq


/-- A simplified Python statement AST. -/
inductive Stmt where
  | functionDef  : String → Arguments → List Stmt → List Decorator → Option Expr → Bool → Nat → Stmt
  | classDef     : String → List Expr → List (String × Expr) → List Stmt → List Decorator → Nat → Stmt
  | assign       : List Expr → Expr → Nat → Stmt
  | annAssign    : Expr → Expr → Option Expr → Nat → Stmt
  | augAssign    : Expr → BinOperator → Expr → Nat → Stmt
  | return_      : Option Expr → Nat → Stmt
  | delete       : List Expr → Nat → Stmt
  | ifStmt       : Expr → List Stmt → List Stmt → Nat → Stmt
  | forStmt      : Expr → Expr → List Stmt → List Stmt → Nat → Stmt
  | whileStmt    : Expr → List Stmt → List Stmt → Nat → Stmt
  | withStmt     : List (Expr × Option Expr) → List Stmt → Nat → Stmt
  | raise_       : Option Expr → Option Expr → Nat → Stmt
  | tryStmt      : List Stmt → List (Option Expr × Option String × List Stmt) → List Stmt → List Stmt → Nat → Stmt
  | assert_      : Expr → Option Expr → Nat → Stmt
  | import_      : List ImportAlias → Nat → Stmt
  | importFrom   : Option String → List ImportAlias → Nat → Stmt
  | global_      : List String → Nat → Stmt
  | nonlocal_    : List String → Nat → Stmt
  | exprStmt     : Expr → Nat → Stmt
  | pass_        : Nat → Stmt
  | break_       : Nat → Stmt
  | continue_    : Nat → Stmt
  deriving Repr, BEq


/-- A Python module AST. -/
structure Module where
  name      : String
  filePath  : String
  body      : List Stmt
  docstring : Option String
  deriving Repr, BEq


/-! ## Checker Interface -/

/-- A lint rule is a pure function from a statement and its context to messages. -/
structure LintContext where
  moduleName : String
  filePath   : String
  parentStmt : Option Stmt
  deriving Repr, BEq


/-- A checker definition. -/
structure CheckerDef where
  name     : String
  msgDefs  : List MessageDef
  visitFn  : LintContext → Stmt → List Message

end Pylint
-- === END: FIXED_FINAL ===
