-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Dulwich.Types

namespace Dulwich

def Commit.Valid (c : Commit) : Prop :=
  c.treeSha.length = 40 ∧ (∀ p ∈ c.parents, p.length = 40) ∧
  c.author.name ≠ "" ∧ c.committer.name ≠ "" ∧
  c.treeSha.toList.all (fun c => c.isDigit || ('a' ≤ c && c ≤ 'f')) = true

end Dulwich
-- === END: FIXED_FINAL ===
