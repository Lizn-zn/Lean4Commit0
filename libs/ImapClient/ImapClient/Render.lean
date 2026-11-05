-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import ImapClient.Types
import ImapClient.Helpers

namespace ImapClient

/-! ## Core Function 1: ImapCommand.render -/

def ImapCommand.render (cmd : ImapCommand) (tag : String) : String := 
                                                                      
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                                      sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def ImapCommand.render_postcond (cmd : ImapCommand) (tag : String) (result : String) : Prop :=
  result.startsWith tag = true ∧
  (cmd = .capability → result = tag ++ " CAPABILITY") ∧
  (cmd = .noop → result = tag ++ " NOOP") ∧
  (cmd = .logout → result = tag ++ " LOGOUT") ∧
  (cmd = .expunge → result = tag ++ " EXPUNGE") ∧
  (cmd = .idle → result = tag ++ " IDLE") ∧
  (∀ u p, cmd = .login u p →
    result = tag ++ " LOGIN \"" ++ u ++ "\" \"" ++ p ++ "\"") ∧
  (∀ m, cmd = .select m →
    result = tag ++ " SELECT \"" ++ m ++ "\"") ∧
  (∀ m, cmd = .examine m →
    result = tag ++ " EXAMINE \"" ++ m ++ "\"") ∧
  (∀ m, cmd = .create m →
    result = tag ++ " CREATE \"" ++ m ++ "\"") ∧
  (∀ m, cmd = .delete m →
    result = tag ++ " DELETE \"" ++ m ++ "\"") ∧
  (∀ o n, cmd = .rename o n →
    result = tag ++ " RENAME \"" ++ o ++ "\" \"" ++ n ++ "\"") ∧
  (∀ r p, cmd = .list r p →
    result = tag ++ " LIST \"" ++ r ++ "\" \"" ++ p ++ "\"") ∧
  (∀ r p, cmd = .lsub r p →
    result = tag ++ " LSUB \"" ++ r ++ "\" \"" ++ p ++ "\"") ∧
  (∀ m, cmd = .subscribe m →
    result = tag ++ " SUBSCRIBE \"" ++ m ++ "\"") ∧
  (∀ m, cmd = .unsubscribe m →
    result = tag ++ " UNSUBSCRIBE \"" ++ m ++ "\"") ∧
  (∀ m i, cmd = .statusCmd m i →
    result.startsWith (tag ++ " STATUS \"" ++ m ++ "\"") = true) ∧
  (∀ ms i, cmd = .fetch ms i →
    result.startsWith (tag ++ " FETCH " ++ MessageSet.toImapString ms) = true) ∧
  (∀ ms a f, cmd = .store ms a f →
    result.startsWith (tag ++ " STORE " ++ MessageSet.toImapString ms ++ " " ++ a) = true) ∧
  (∀ ms m, cmd = .copy ms m →
    result = tag ++ " COPY " ++ MessageSet.toImapString ms ++ " \"" ++ m ++ "\"") ∧
  (∀ c, cmd = .search c →
    result = tag ++ " SEARCH " ++ SearchCriterion.toImapString c) ∧
  (∀ ms i, cmd = .uidFetch ms i →
    result.startsWith (tag ++ " UID FETCH " ++ MessageSet.toImapString ms) = true) ∧
  (∀ ms a f, cmd = .uidStore ms a f →
    result.startsWith (tag ++ " UID STORE " ++ MessageSet.toImapString ms ++ " " ++ a) = true) ∧
  (∀ ms m, cmd = .uidCopy ms m →
    result = tag ++ " UID COPY " ++ MessageSet.toImapString ms ++ " \"" ++ m ++ "\"") ∧
  (∀ c, cmd = .uidSearch c →
    result = tag ++ " UID SEARCH " ++ SearchCriterion.toImapString c) ∧
  (∀ m fs dt lit, cmd = .append m fs dt lit →
    result.startsWith (tag ++ " APPEND \"" ++ m ++ "\"") = true)

theorem ImapCommand.render_spec (cmd : ImapCommand) (tag : String) :
    ImapCommand.render_postcond cmd tag (ImapCommand.render cmd tag) := by
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end ImapClient
-- === END: FIXED_FINAL ===
