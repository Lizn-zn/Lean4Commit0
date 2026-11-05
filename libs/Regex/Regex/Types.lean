-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # Regex
   A finite-automata-based regular expression engine.

   Ported from Rust's `regex` crate.
   Original: https://github.com/rust-lang/regex
-/

namespace Regex

structure Match where
  start : Nat
  «end» : Nat
  deriving Repr, BEq

end Regex
-- === END: FIXED_FINAL ===
