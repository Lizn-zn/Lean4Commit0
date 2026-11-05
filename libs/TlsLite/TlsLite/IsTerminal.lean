-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import TlsLite.Types
import TlsLite.Transition

namespace TlsLite

def HandshakeState.isTerminal (state : HandshakeState) : Bool :=
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



@[reducible]
def HandshakeState.isTerminal_postcond (state : HandshakeState) (result : Bool) : Prop :=
  (state = .connected → result = true) ∧
  (state = .error → result = true) ∧
  (state = .initial → result = false) ∧
  (state = .clientHelloSent → result = false) ∧
  (state = .serverHelloReceived → result = false) ∧
  (state = .finishedSent → result = false) ∧
  (result = true ↔ (state = .connected ∨ state = .error))


theorem HandshakeState.isTerminal_spec (state : HandshakeState) :
    HandshakeState.isTerminal_postcond state (HandshakeState.isTerminal state) := by

  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/- Relational: terminal states have no transitions -/

@[reducible]
def HandshakeState.terminal_no_transition_rel (state : HandshakeState) : Prop :=
  HandshakeState.isTerminal state = true →
  ∀ event, HandshakeState.transition state event = none


theorem HandshakeState.terminal_no_transition_spec (state : HandshakeState) :
    HandshakeState.terminal_no_transition_rel state := by

  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_FINAL (provided) ===



end TlsLite
-- === END: FIXED_FINAL ===
