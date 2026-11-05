-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Watchdog

inductive FileType where
  | file      : FileType
  | directory : FileType
  deriving Repr, BEq, DecidableEq

/-- A file system event kind. -/

inductive FileEvent where
  | created   : FileEvent
  | deleted   : FileEvent
  | modified  : FileEvent
  | moved     : (srcPath : String) → (destPath : String) → FileEvent
  deriving Repr, BEq

/-- A watch event combining the event kind, path, and whether it is a directory. -/

structure WatchEvent where
  event       : FileEvent
  filePath    : String
  isDirectory : Bool
  deriving Repr, BEq

/-- A file system entry: its type and a content hash for change detection. -/

structure FileEntry where
  fileType    : FileType
  contentHash : UInt64
  deriving Repr, BEq

/-- A snapshot of the file system as a mapping from paths to entries. -/

structure FileSystemState where
  entries : List (String × FileEntry)
  deriving Repr, BEq

/-- An event filter controlling which events are reported. -/

structure EventFilter where
  includePatterns    : List String
  excludePatterns    : List String
  ignoreDirectories  : Bool := false
  caseSensitive      : Bool := true
  deriving Repr, BEq

/-! ## Infrastructure: applyFilter -/

/- Apply a filter to a single event. -/

end Watchdog
-- === END: FIXED_FINAL ===
