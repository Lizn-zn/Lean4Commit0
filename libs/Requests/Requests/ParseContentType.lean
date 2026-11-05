-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Batteries.Data.String.Matcher
import Std
import Lean

import Requests.Helpers

namespace Requests

def parseContentType (value : String) : ContentType :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def parseContentType_postcond (value : String) (result : ContentType) : Prop :=
  (value = "application/json" → result.isJson = true) ∧
  (value = "application/json; charset=utf-8" → result.charset = some "utf-8") ∧
  (value = "application/x-www-form-urlencoded" → result.isForm = true) ∧
  (value = "multipart/form-data; boundary=abc" → result.isMultipart = true ∧ result.boundary = some "abc") ∧
  (value ≠ "" → result.mediaType ≠ "") ∧
  (value.containsSubstr "charset=" → result.charset.isSome = true) ∧
  (value.containsSubstr "boundary=" → result.boundary.isSome = true) ∧
  (value = "text/html" → result.mediaType = "text/html") ∧
  (value = "text/plain" → result.mediaType = "text/plain") ∧
  (value = "application/xml" → result.mediaType = "application/xml") ∧
  (value = "image/png" → result.mediaType = "image/png") ∧
  (value = "text/html; charset=utf-8" → result.mediaType = "text/html" ∧ result.charset = some "utf-8") ∧
  (value = "text/html; charset=iso-8859-1" → result.mediaType = "text/html" ∧ result.charset = some "iso-8859-1") ∧
  (value ≠ "" → value.startsWith result.mediaType = true) ∧
  (value.containsSubstr "/" = true → result.mediaType.containsSubstr "/" = true) ∧
  (value = "application/octet-stream" → result.mediaType = "application/octet-stream") ∧
  (value = "application/javascript" → result.mediaType = "application/javascript") ∧
  (value = "text/css" → result.mediaType = "text/css") ∧
  (value = "multipart/mixed; boundary=sep" → result.mediaType = "multipart/mixed" ∧ result.boundary = some "sep") ∧
  (value = "multipart/form-data; boundary=----WebKitFormBoundary" →
    result.isMultipart = true ∧ result.boundary = some "----WebKitFormBoundary")

theorem parseContentType_spec (value : String) :
    parseContentType_postcond value (parseContentType value) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end Requests
-- === END: FIXED_FINAL ===
