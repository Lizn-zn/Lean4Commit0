-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Virtualenv

inductive PreRelease where
  | alpha : Nat → PreRelease
  | beta  : Nat → PreRelease
  | rc    : Nat → PreRelease
  deriving Repr, BEq

/-- A PEP 440 version. -/

structure Version where
  epoch   : Nat
  release : List Nat
  pre     : Option PreRelease
  post    : Option Nat
  dev     : Option Nat
  local_  : Option String
  deriving Repr, BEq

/-! ## Version Specifiers -/

/-- Version specifier operators. -/

inductive SpecOp where
  | eq       : SpecOp
  | ne       : SpecOp
  | ge       : SpecOp
  | le       : SpecOp
  | gt       : SpecOp
  | lt       : SpecOp
  | compat   : SpecOp
  | arbitrary: SpecOp
  deriving Repr, BEq, DecidableEq

/-- A single version specifier (e.g., ">=3.7"). -/

structure VersionSpec where
  op      : SpecOp
  version : String
  deriving Repr, BEq

/-- A set of version specifiers (e.g., ">=3.7,<4.0"). -/

structure VersionSpecSet where
  specs : List VersionSpec
  deriving Repr, BEq

/-! ## Infrastructure: VersionSpec.matches, VersionSpecSet.matches -/

/-- Check if a version matches a single specifier. -/

inductive MarkerVar where
  | osName
  | sysPlatform
  | platformMachine
  | platformRelease
  | platformSystem
  | platformVersion
  | pythonVersion
  | pythonFullVersion
  | implementation
  | implementationVersion
  | extra
  deriving Repr, BEq, DecidableEq

inductive MarkerOp where
  | eq
  | ne
  | lt
  | le
  | gt
  | ge
  | inOp
  | notIn
  deriving Repr, BEq, DecidableEq

inductive MarkerExpr where
  | comparison : MarkerVar → MarkerOp → String → MarkerExpr
  | andExpr    : MarkerExpr → MarkerExpr → MarkerExpr
  | orExpr     : MarkerExpr → MarkerExpr → MarkerExpr
  deriving Repr, BEq

structure MarkerEnv where
  osName : String
  sysPlatform : String
  platformMachine : String
  platformRelease : String
  platformSystem : String
  platformVersion : String
  pythonVersion : String
  pythonFullVersion : String
  implementation : String
  implementationVersion : String
  extras : List String
  deriving Repr, BEq

structure Dependency where
  name : String
  extras : List String
  versionSpec : Option VersionSpecSet
  marker : Option MarkerExpr
  url : Option String
  deriving Repr, BEq

structure PackageInfo where
  name : String
  version : Version
  dependencies : List Dependency
  deriving Repr, BEq

structure ResolvedPackage where
  name : String
  version : Version
  deriving Repr, BEq

inductive ResolutionResult where
  | success  : List ResolvedPackage → ResolutionResult
  | conflict : String → ResolutionResult
  | missing  : String → ResolutionResult
  deriving Repr, BEq

end Virtualenv
-- === END: FIXED_FINAL ===
