-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace ImapClient

/-! ## Types -/

/-- Standard IMAP message flags -/
inductive MessageFlag where
  | seen     : MessageFlag
  | answered : MessageFlag
  | flagged  : MessageFlag
  | deleted  : MessageFlag
  | draft    : MessageFlag
  | recent   : MessageFlag
  | custom   : String → MessageFlag
  deriving Repr, BEq

/-- A set of message identifiers (ranges and individual values). -/
inductive MessageSet where
  | single  : Nat → MessageSet
  | range   : Nat → Nat → MessageSet
  | star    : MessageSet
  | rangeTo : Nat → MessageSet
  | list    : List MessageSet → MessageSet
  deriving Repr, BEq

/-- IMAP search criteria as an algebraic data type -/
inductive SearchCriterion where
  | all        : SearchCriterion
  | and_       : SearchCriterion → SearchCriterion → SearchCriterion
  | or_        : SearchCriterion → SearchCriterion → SearchCriterion
  | not_       : SearchCriterion → SearchCriterion
  | from       : String → SearchCriterion
  | to         : String → SearchCriterion
  | subject    : String → SearchCriterion
  | body       : String → SearchCriterion
  | text       : String → SearchCriterion
  | since      : String → SearchCriterion
  | before     : String → SearchCriterion
  | on         : String → SearchCriterion
  | sentSince  : String → SearchCriterion
  | sentBefore : String → SearchCriterion
  | sentOn     : String → SearchCriterion
  | hasFlag    : MessageFlag → SearchCriterion
  | notFlag    : MessageFlag → SearchCriterion
  | header     : String → String → SearchCriterion
  | larger     : Nat → SearchCriterion
  | smaller    : Nat → SearchCriterion
  | uid        : MessageSet → SearchCriterion
  | seqSet     : MessageSet → SearchCriterion
  | new_       : SearchCriterion
  | old        : SearchCriterion
  | recent_    : SearchCriterion
  deriving Repr, BEq

/-- IMAP command types -/
inductive ImapCommand where
  | capability  : ImapCommand
  | login       : (username password : String) → ImapCommand
  | logout      : ImapCommand
  | select      : String → ImapCommand
  | examine     : String → ImapCommand
  | create      : String → ImapCommand
  | delete      : String → ImapCommand
  | rename      : (oldName newName : String) → ImapCommand
  | list        : (reference pattern : String) → ImapCommand
  | lsub        : (reference pattern : String) → ImapCommand
  | subscribe   : String → ImapCommand
  | unsubscribe : String → ImapCommand
  | statusCmd   : (mailbox : String) → (items : List String) → ImapCommand
  | append      : (mailbox : String) → (flags : List MessageFlag) →
                   (dateTime : Option String) → (literal : String) → ImapCommand
  | fetch       : MessageSet → (items : List String) → ImapCommand
  | store       : MessageSet → (action : String) → (flags : List MessageFlag) → ImapCommand
  | copy        : MessageSet → String → ImapCommand
  | search      : SearchCriterion → ImapCommand
  | expunge     : ImapCommand
  | noop        : ImapCommand
  | idle        : ImapCommand
  | uidFetch    : MessageSet → (items : List String) → ImapCommand
  | uidStore    : MessageSet → (action : String) → (flags : List MessageFlag) → ImapCommand
  | uidCopy     : MessageSet → String → ImapCommand
  | uidSearch   : SearchCriterion → ImapCommand
  deriving Repr, BEq


end ImapClient
-- === END: FIXED_FINAL ===
