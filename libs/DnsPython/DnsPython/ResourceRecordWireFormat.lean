-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_1 (provided) ===
import Std
import Lean

import DnsPython.Types
import DnsPython.Helpers

namespace DnsPython

/-! ## Core Function 1: ResourceRecord wire format -/

/-- Encode a domain name to wire format. -/
def DomainName.toWireFormat (name : DomainName) : ByteArray := 
                                                               
-- === END: FIXED_1 ===
-- === BEGIN: OBLIGATION_1 (editable) ===
                                                               sorry
-- === END: OBLIGATION_1 ===
-- === BEGIN: FIXED_2 (provided) ===



/-- Decode a domain name from wire format at a given offset. -/
def DomainName.fromWireFormat (data : ByteArray) (offset : Nat) : Option (DomainName × Nat) := 
                                                                                               
-- === END: FIXED_2 ===
-- === BEGIN: OBLIGATION_2 (editable) ===
                                                                                               sorry
-- === END: OBLIGATION_2 ===
-- === BEGIN: FIXED_3 (provided) ===



/-- Encode a resource record to wire format. -/
def ResourceRecord.toWireFormat (rr : ResourceRecord) : ByteArray := 
                                                                     
-- === END: FIXED_3 ===
-- === BEGIN: OBLIGATION_3 (editable) ===
                                                                     sorry
-- === END: OBLIGATION_3 ===
-- === BEGIN: FIXED_4 (provided) ===



/-- Decode a resource record from wire format at a given offset. -/
def ResourceRecord.fromWireFormat (data : ByteArray) (offset : Nat) : Option (ResourceRecord × Nat) := 
                                                                                                       
-- === END: FIXED_4 ===
-- === BEGIN: OBLIGATION_4 (editable) ===
                                                                                                       sorry
-- === END: OBLIGATION_4 ===
-- === BEGIN: FIXED_5 (provided) ===



@[reducible]
def ResourceRecord.wireFormat_roundtrip_rel (rr : ResourceRecord) (wire : ByteArray) (decoded : Option (ResourceRecord × Nat)) : Prop :=
  decoded = some (rr, wire.size) ∧
  -- Wire must contain at least: domain name wire + 2 (type) + 2 (class) + 4 (TTL) + 2 (rdlength) = +10 bytes
  wire.size ≥ rr.name.wireSize + 10 ∧
  -- The 2 bytes after the encoded domain name must be the RRType numeric value
  getUInt16BE wire rr.name.wireSize = rr.rrtype.numericValue ∧
  -- The 2 bytes after the RRType must be the DnsClass numeric value
  getUInt16BE wire (rr.name.wireSize + 2) = rr.rrclass.numericValue ∧
  -- The 4 bytes after the DnsClass must be the TTL in big-endian
  getUInt32BE wire (rr.name.wireSize + 4) = rr.ttl

theorem ResourceRecord.wireFormat_roundtrip_spec (rr : ResourceRecord) :
    ResourceRecord.wireFormat_roundtrip_rel rr rr.toWireFormat (ResourceRecord.fromWireFormat rr.toWireFormat 0) := by
  
  
-- === END: FIXED_5 ===
-- === BEGIN: OBLIGATION_5 (editable) ===
  sorry
-- === END: OBLIGATION_5 ===
-- === BEGIN: FIXED_FINAL (provided) ===




end DnsPython
-- === END: FIXED_FINAL ===
