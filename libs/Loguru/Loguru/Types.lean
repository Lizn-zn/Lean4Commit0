-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Loguru
/-! ## Types -/
inductive Level where
  | TRACE    : Level
  | DEBUG    : Level
  | INFO     : Level
  | SUCCESS  : Level
  | WARNING  : Level
  | ERROR    : Level
  | CRITICAL : Level
  deriving Repr, BEq, DecidableEq
/-- Get the numeric value for a log level. -/
structure Timestamp where
  year        : Nat
  month       : Nat
  day         : Nat
  hour        : Nat
  minute      : Nat
  second      : Nat
  microsecond : Nat
  deriving Repr, BEq
/-- Extra context data bound to a log record. -/
abbrev ExtraData := List (String × String)
/-- A traceback frame. -/
structure TracebackFrame where
  filename : String
  lineno   : Nat
  funcName : String
  code     : String
  deriving Repr, BEq
/-- An exception/traceback representation. -/
structure ExceptionInfo where
  typeName : String
  message  : String
  frames   : List TracebackFrame
  deriving Repr, BEq
/-- A single log record. -/
structure LogRecord where
  elapsed     : Nat
  level       : Level
  message     : String
  moduleName  : String
  funcName    : String
  lineNo      : Nat
  fileName    : String
  time        : Timestamp
  extra       : ExtraData
  exception   : Option ExceptionInfo
  processId   : Nat
  processName : String
  threadId    : Nat
  threadName  : String
  deriving Repr, BEq
/-- A filter specification for log messages. -/
inductive FilterSpec where
  | byLevel          : Level → FilterSpec
  | byModuleName     : String → FilterSpec
  | byLevelAndModule : Level → String → FilterSpec
  deriving Repr, BEq
/-- Configuration for a logging sink. -/
structure SinkConfig where
  formatStr : String
  filter    : Option FilterSpec
  level     : Level
  colorize  : Bool
  serialize : Bool
  backtrace : Bool
  diagnose  : Bool
  sinkId    : Nat
  deriving Repr, BEq
/-- Logger state containing configured sinks. -/
structure LoggerState where
  sinks      : List SinkConfig
  nextSinkId : Nat
  extra      : ExtraData
  startTime  : Timestamp
  deriving Repr, BEq
end Loguru
-- === END: FIXED_FINAL ===
