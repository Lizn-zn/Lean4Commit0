-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Pexpect

/-! ## Types -/

/-- A pattern to match against a byte stream. -/
inductive Pattern where
  | exact   : String → Pattern
  | regex   : String → Pattern
  | eof     : Pattern
  | timeout : Pattern
  deriving Repr, BEq

/-- Result of a pattern match attempt. -/
structure MatchResult where
  patternIdx : Nat
  startPos   : Nat
  endPos     : Nat
  matched    : String
  before     : String
  deriving Repr, BEq

/-- An action to take after a pattern match. -/
inductive Action where
  | send       : String → Action
  | sendLine   : String → Action
  | noAction   : Action
  | close      : Action
  deriving Repr, BEq

/-- A single expect rule: match a pattern, then do an action. -/
structure ExpectRule where
  patterns : List Pattern
  action   : Action
  deriving Repr, BEq

/-- State of the expect state machine. -/
structure ExpectState where
  buffer      : String
  matched     : Option MatchResult
  beforeMatch : String
  afterMatch  : String
  timedOut    : Bool
  closed      : Bool
  deriving Repr, BEq

/-- Create an initial expect state. -/
def ExpectState.initial : ExpectState :=
  { buffer := "", matched := none, beforeMatch := "",
    afterMatch := "", timedOut := false, closed := false }

/-- Result of an expect operation. -/
inductive ExpectResult where
  | matched    : MatchResult → ExpectResult
  | timedOut   : String → ExpectResult
  | eofReached : String → ExpectResult
  deriving Repr, BEq

end Pexpect
-- === END: FIXED_FINAL ===
