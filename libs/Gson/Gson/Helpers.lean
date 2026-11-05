-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import Gson.Types

namespace Gson

/-! ## Spec helpers (pure, fully defined) -/

/-- Compute the length of a minimally-escaped JSON string (excluding quotes).
    Escaping rules: `"` and `\` → 2 chars, `\n`/`\r`/`\t` → 2 chars,
    other control chars (< 0x20) → 6 chars (\uXXXX), everything else → 1 char. -/
def pureStringEscapedLength (s : String) : Nat :=
  s.toList.foldl (fun acc c =>
    acc + if c == '"' || c == '\\' then 2
    else if c == '\n' || c == '\r' || c == '\t' then 2
    else if c.toNat < 0x20 then 6
    else 1) 0

/-! ### Compactness predicate -/

/-- Check that no JSON whitespace (space, tab, CR, LF) appears outside string literals. -/
def isCompactJson : List Char → Bool → Bool
  | [], _ => true
  | '\\' :: c :: rest, true => isCompactJson rest true  -- skip escaped char inside string
  | '"' :: rest, inStr => isCompactJson rest (!inStr)    -- toggle string mode
  | c :: rest, false =>
    if c == ' ' || c == '\n' || c == '\r' || c == '\t' then false
    else isCompactJson rest false
  | _ :: rest, true => isCompactJson rest true           -- inside string, anything goes

def isCompactJsonString (s : String) : Bool := isCompactJson s.toList false

/-- Strip leading and trailing JSON whitespace (space, tab, CR, LF). -/
private def jsonTrimList : List Char → List Char
  | [] => []
  | c :: cs =>
    if c == ' ' || c == '\n' || c == '\r' || c == '\t' then jsonTrimList cs
    else c :: cs

def jsonTrim (s : String) : String :=
  String.ofList ((jsonTrimList (jsonTrimList s.toList.reverse).reverse))

/-! ## Helper: JsonElement.has -/

def JsonElement.has (obj : JsonElement) (key : String) : Bool :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end Gson
-- === END: FIXED_FINAL ===
