-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

/- # SimPy
   A process-based discrete-event simulation framework.

   Summarized from the full spec to 3 core functions:
   Environment.step, Environment.schedule, Resource.request.
   Original: https://simpy.readthedocs.io/
-/

namespace SimPy

/-! ## Types -/

abbrev SimTime := Float

inductive EventPriority where
  | urgent  : EventPriority
  | normal  : EventPriority
  | low     : EventPriority
  deriving Repr, BEq, Ord

abbrev EventId := Nat

inductive EventResult where
  | ok (value : String)
  | err (message : String)
  deriving Repr, BEq

inductive EventState where
  | pending    : EventState
  | triggered  : EventResult → EventState
  | processed  : EventResult → EventState
  deriving Repr

structure Event where
  id : EventId
  state : EventState
  callbacks : List EventId
  deriving Repr

structure ScheduledEvent where
  time : SimTime
  priority : EventPriority
  eventId : EventId
  insertionOrder : Nat
  deriving Repr

inductive ProcessStep where
  | yieldEvent (eventId : EventId) (continuation : EventResult → ProcessStep)
  | done (value : String)
  | fail (message : String)

structure Process where
  id : EventId
  name : String
  step : ProcessStep
  isAlive : Bool

/-! ## Environment -/

structure Environment where
  now : SimTime
  eventQueue : List ScheduledEvent
  events : List Event
  processes : List Process
  nextId : Nat
  insertionCounter : Nat

/-! ## Resource -/

structure Resource where
  capacity : Nat
  users : List EventId
  queue : List EventId
  deriving Repr

end SimPy
-- === END: FIXED_FINAL ===
