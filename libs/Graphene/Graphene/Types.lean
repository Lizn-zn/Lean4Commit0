-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace Graphene

/-! ## Types -/

/-- Scalar types in GraphQL -/
inductive ScalarType where
  | int       : ScalarType
  | float     : ScalarType
  | string    : ScalarType
  | boolean   : ScalarType
  | id        : ScalarType
  | custom    : String → ScalarType
  deriving Repr, BEq

/-- GraphQL type references -/
inductive TypeRef where
  | scalar    : ScalarType → TypeRef
  | object    : String → TypeRef
  | interface : String → TypeRef
  | union     : String → TypeRef
  | enum      : String → TypeRef
  | inputObject : String → TypeRef
  | list      : TypeRef → TypeRef
  | nonNull   : TypeRef → TypeRef
  deriving Repr, BEq

/-- A value in the GraphQL type system -/
inductive Value where
  | null      : Value
  | intVal    : Int → Value
  | floatVal  : Float → Value
  | stringVal : String → Value
  | boolVal   : Bool → Value
  | enumVal   : String → Value
  | listVal   : List Value → Value
  | objectVal : List (String × Value) → Value
  deriving Repr, BEq

/-- An argument definition for a field -/
structure ArgumentDef where
  name         : String
  argType      : TypeRef
  defaultValue : Option Value := none
  description  : String := ""
  deriving Repr, BEq

/-- A field definition within an object type -/
structure FieldDef where
  name         : String
  fieldType    : TypeRef
  arguments    : List ArgumentDef := []
  resolverName : String := ""
  description  : String := ""
  isDeprecated : Bool := false
  deprecationReason : String := ""
  deriving Repr, BEq

/-- An enum value definition -/
structure EnumValueDef where
  name         : String
  value        : Value := Value.null
  description  : String := ""
  isDeprecated : Bool := false
  deprecationReason : String := ""
  deriving Repr, BEq

/-- A type definition in the GraphQL schema -/
inductive TypeDef where
  | scalarDef    : String → String → TypeDef
  | objectDef    : String → List FieldDef → List String → String → TypeDef
  | interfaceDef : String → List FieldDef → String → TypeDef
  | unionDef     : String → List String → String → TypeDef
  | enumDef      : String → List EnumValueDef → String → TypeDef
  | inputObjectDef : String → List FieldDef → String → TypeDef
  deriving Repr, BEq

/-- Get the name of a type definition -/
def TypeDef.name : TypeDef → String
  | .scalarDef n _       => n
  | .objectDef n _ _ _   => n
  | .interfaceDef n _ _  => n
  | .unionDef n _ _      => n
  | .enumDef n _ _       => n
  | .inputObjectDef n _ _ => n

/-- A directive definition -/
structure DirectiveDef where
  name        : String
  description : String := ""
  locations   : List String := []
  arguments   : List ArgumentDef := []
  deriving Repr, BEq

/-- A GraphQL schema -/
structure Schema where
  types         : List TypeDef := []
  queryType     : String := "Query"
  mutationType  : Option String := none
  subscriptionType : Option String := none
  directives    : List DirectiveDef := []
  deriving Repr, BEq

/-- Operation type -/
inductive OperationType where
  | query        : OperationType
  | mutation     : OperationType
  | subscription : OperationType
  deriving Repr, BEq

/-- A directive usage in a query -/
structure Directive where
  name      : String
  arguments : List (String × Value) := []
  deriving Repr, BEq

/-- A variable definition in an operation -/
structure VariableDef where
  name         : String
  varType      : TypeRef
  defaultValue : Option Value := none
  deriving Repr, BEq

/-- Selection within a query -/
inductive Selection where
  | field           : String → Option String → List (String × Value) → List Directive → List Selection → Selection
  | fragmentSpread  : String → List Directive → Selection
  | inlineFragment  : Option String → List Directive → List Selection → Selection
  deriving Repr, BEq

/-- A fragment definition -/
structure FragmentDef where
  name          : String
  typeCondition : String
  directives    : List Directive := []
  selections    : List Selection := []
  deriving Repr, BEq

/-- An operation definition -/
structure OperationDef where
  opType     : OperationType := OperationType.query
  name       : Option String := none
  «variables»  : List VariableDef := []
  directives : List Directive := []
  selections : List Selection := []
  deriving Repr, BEq

/-- A complete GraphQL document -/
structure Document where
  operations : List OperationDef := []
  fragments  : List FragmentDef := []
  deriving Repr, BEq

/-- A validation error with location information -/
structure ValidationError where
  message : String
  line    : Nat := 0
  column  : Nat := 0
  deriving Repr, BEq

/-- A data tree representing resolved values -/
inductive DataTree where
  | null      : DataTree
  | leaf      : Value → DataTree
  | node      : List (String × DataTree) → DataTree
  | listNode  : List DataTree → DataTree
  deriving Repr, BEq

/-- Execution context for resolving queries -/
structure ExecutionContext where
  schema    : Schema
  document  : Document
  «variables» : List (String × Value) := []
  rootData  : DataTree := DataTree.null
  deriving Repr, BEq

/-- Result of executing a query -/
structure ExecutionResult where
  resultData : Option DataTree := none
  errors     : List String := []
  deriving Repr, BEq

/-- The introspection type for __Type -/
inductive IntrospectionTypeKind where
  | scalar      : IntrospectionTypeKind
  | object      : IntrospectionTypeKind
  | interface   : IntrospectionTypeKind
  | union       : IntrospectionTypeKind
  | enum        : IntrospectionTypeKind
  | inputObject : IntrospectionTypeKind
  | list        : IntrospectionTypeKind
  | nonNull     : IntrospectionTypeKind
  deriving Repr, BEq

/-- Introspection result for __type query -/
structure IntrospectionType where
  kind        : IntrospectionTypeKind
  name        : Option String := none
  description : Option String := none
  fields      : List FieldDef := []
  enumValues  : List EnumValueDef := []
  possibleTypes : List String := []
  ofType      : Option TypeRef := none
  deriving Repr, BEq

/-- Introspection result for __schema query -/
structure IntrospectionSchema where
  types            : List IntrospectionType := []
  queryType        : IntrospectionType
  mutationType     : Option IntrospectionType := none
  subscriptionType : Option IntrospectionType := none
  directives       : List DirectiveDef := []
  deriving Repr, BEq


end Graphene
-- === END: FIXED_FINAL ===
