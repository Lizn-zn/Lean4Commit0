-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import JacksonCore.Types

namespace JacksonCore

def JsonParser.create (input : String) : JsonParser :=
  
  
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
  sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



def JsonGenerator.create : JsonGenerator :=
  
  
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
  sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



def JsonGenerator.flush (g : JsonGenerator) : String :=
  
  
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
  sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



def JsonGenerator.close (g : JsonGenerator) : JsonGenerator :=
  
  
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
  sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



def TreeNode.fromParser (p : JsonParser) : Option (TreeNode × JsonParser) :=
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_6 (provided) ===



def TreeNode.toGenerator (t : TreeNode) (g : JsonGenerator) : JsonGenerator :=
  
  
-- === END: FIXED_6 ===
-- === BEGIN: OBLIGATION_6 (editable) ===
  sorry
-- === END: OBLIGATION_6 ===
-- === BEGIN: FIXED_FINAL (provided) ===



/-! ## Helpers used in postconditions -/

def skipWS (s : String) (pos : Nat) : Nat :=
  if pos ≥ s.length then pos
  else
    let c := s.toList.getD pos ' '
    if c == ' ' || c == '\n' || c == '\t' || c == '\r' then skipWS s (pos + 1)
    else pos
termination_by s.length - pos

def isNumberStart (c : Char) : Bool :=
  c == '-' || (c.toNat ≥ '0'.toNat && c.toNat ≤ '9'.toNat)

def tokenMatchesChar (c : Char) (tok : JsonToken) : Prop :=
  (c == '{' → tok = JsonToken.startObject) ∧
  (c == '}' → tok = JsonToken.endObject) ∧
  (c == '[' → tok = JsonToken.startArray) ∧
  (c == ']' → tok = JsonToken.endArray) ∧
  (c == 't' → tok = JsonToken.valueTrue) ∧
  (c == 'f' → tok = JsonToken.valueFalse) ∧
  (c == 'n' → tok = JsonToken.valueNull) ∧
  (c == '"' → (∃ s, tok = JsonToken.valueString s ∨ tok = JsonToken.fieldName s)) ∧
  (isNumberStart c = true → (∃ n, tok = JsonToken.valueInt n) ∨ (∃ f, tok = JsonToken.valueFloat f))

end JacksonCore
-- === END: FIXED_FINAL ===
