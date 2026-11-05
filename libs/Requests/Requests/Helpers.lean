-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Batteries.Data.String.Matcher
import Std
import Lean

import Requests.Types

namespace Requests

def isAbsoluteUrl (url : String) : Bool :=
  let scheme := (url.splitOn "://").head!
  url.containsSubstr "://" &&
    scheme != "" &&
    !scheme.containsSubstr "/" &&
    !scheme.containsSubstr "?" &&
    !scheme.containsSubstr "#"

def ContentType.isJson (ct : ContentType) : Bool :=
  ct.mediaType = "application/json" ||
    ct.mediaType = "text/json" ||
    ct.mediaType.endsWith "+json"

def ContentType.isForm (ct : ContentType) : Bool :=
  ct.mediaType = "application/x-www-form-urlencoded"

def ContentType.isMultipart (ct : ContentType) : Bool :=
  ct.mediaType.startsWith "multipart/"

end Requests
-- === END: FIXED_FINAL ===
