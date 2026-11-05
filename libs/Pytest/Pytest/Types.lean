-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Pytest


/-! ## Types -/

/-- Marker categories used in pytest. -/
inductive MarkerKind where
  | skip           : MarkerKind
  | skipIf         : MarkerKind
  | xfail          : MarkerKind
  | parametrize    : MarkerKind
  | usefixtures    : MarkerKind
  | filterwarnings : MarkerKind
  | custom         : MarkerKind
  deriving Repr, BEq, DecidableEq


/-- A marker attached to a test. -/
structure Marker where
  name   : String
  kind   : MarkerKind
  args   : List String
  kwargs : List (String × String)
  deriving Repr, BEq


/-- Outcome of a single test execution. -/
inductive TestOutcome where
  | passed  : TestOutcome
  | failed  : String → TestOutcome
  | skipped : String → TestOutcome
  | xfailed : String → TestOutcome
  | xpassed : TestOutcome
  | error   : String → TestOutcome
  deriving Repr, BEq


/-- A single test item representing one test to be run. -/
structure TestItem where
  nodeId     : String
  name       : String
  filePath   : String
  lineNo     : Nat
  markers    : List Marker
  parameters : List (String × String)
  parentIds  : List String
  deriving Repr, BEq


/-- A single parameter set for parametrize. -/
structure ParamSet where
  argnames : List String
  values   : List String
  paramId  : Option String
  marks    : List Marker
  deriving Repr, BEq


/-- Fixture scope levels. -/
inductive FixtureScope where
  | function_ : FixtureScope
  | class_    : FixtureScope
  | module_   : FixtureScope
  | package_  : FixtureScope
  | session_  : FixtureScope
  deriving Repr, BEq, DecidableEq


/-- A fixture definition. -/
structure FixtureDef where
  name       : String
  scope      : FixtureScope
  params     : List String
  autouse    : Bool
  depNames   : List String
  modulePath : String
  deriving Repr, BEq


/-- When a report is generated during test execution. -/
inductive ReportWhen where
  | setup    : ReportWhen
  | call     : ReportWhen
  | teardown : ReportWhen
  deriving Repr, BEq, DecidableEq


/-- A section in a test report. -/
structure ReportSection where
  header  : String
  content : String
  deriving Repr, BEq


/-- A test report for a single phase of test execution. -/
structure TestReport where
  nodeId   : String
  when_    : ReportWhen
  outcome  : TestOutcome
  longrepr : Option String
  sections : List ReportSection
  duration : Float
  deriving Repr, BEq


/-- A summary of all test reports. -/
structure TestSummary where
  total    : Nat
  passed   : Nat
  failed   : Nat
  skipped  : Nat
  xfailed  : Nat
  xpassed  : Nat
  errors   : Nat
  duration : Float
  deriving Repr, BEq

end Pytest
-- === END: FIXED_FINAL ===
