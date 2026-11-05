-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import SqlParse.Types
import SqlParse.Tokenize

namespace SqlParse

/-! ## Format -/

def format (sql : String) (options : FormatOptions := {}) : String :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def format_postcond (sql : String) (opts : FormatOptions) (result : String) : Prop :=
  (sql = "" → result = "") ∧
  (sql ≠ "" → result ≠ "") ∧
  (opts = {} ∧ ¬ sql.any (· = ';') ∧ sql = sql.trimAscii.toString → result = sql) ∧
  (opts.keywordCase = some KeywordCase.upper →
    ∀ t ∈ tokenize result,
      (t.ttype = .keyword ∨ t.ttype = .keywordDML ∨ t.ttype = .keywordDDL ∨
       t.ttype = .keywordCTE ∨ t.ttype = .keywordOrder) →
      t.value = t.value.toUpper) ∧
  (opts.keywordCase = some KeywordCase.lower →
    ∀ t ∈ tokenize result,
      (t.ttype = .keyword ∨ t.ttype = .keywordDML ∨ t.ttype = .keywordDDL ∨
       t.ttype = .keywordCTE ∨ t.ttype = .keywordOrder) →
      t.value = t.value.toLower) ∧
  (opts.stripComments = true →
    ∀ t ∈ tokenize result, t.ttype ≠ .commentSingle ∧ t.ttype ≠ .commentMulti) ∧
  (opts.stripWhitespace = true →
    result = result.trimAscii.toString)

theorem format_spec (sql : String) (opts : FormatOptions) :
    format_postcond sql opts (format sql opts) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end SqlParse
-- === END: FIXED_FINAL ===
