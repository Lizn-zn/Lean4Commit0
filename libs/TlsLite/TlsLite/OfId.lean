-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import TlsLite.Types
import TlsLite.Helpers

namespace TlsLite

def CipherSuite.ofId (id : UInt16) : Option CipherSuite :=
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def CipherSuite.ofId_postcond (id : UInt16) (result : Option CipherSuite) : Prop :=
  (∀ cs, result = some cs → cs.id = id) ∧
  (∀ cs, cs ∈ cipherSuites → cs.id = id → result = some cs) ∧
  (∀ cs, result = some cs → cs ∈ cipherSuites) ∧
  (result = none → ∀ cs, cs ∈ cipherSuites → cs.id ≠ id)


theorem CipherSuite.ofId_spec (id : UInt16) :
    CipherSuite.ofId_postcond id (CipherSuite.ofId id) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/- ## Handshake State Machine -/


end TlsLite
-- === END: FIXED_FINAL ===
