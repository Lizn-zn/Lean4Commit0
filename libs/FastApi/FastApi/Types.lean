-- === BEGIN: PROOF_IMPORTS (editable) ===
-- Optional additional imports: Mathlib.*, Batteries.*, Std.*, Lean.* only.
-- === END: PROOF_IMPORTS ===
-- === BEGIN: FIXED_FINAL (provided) ===
import Std
import Lean

namespace FastApi

/-! ## Types -/

/-- HTTP request methods. -/
inductive HttpMethod where
  | GET | POST | PUT | DELETE | PATCH | HEAD | OPTIONS
  deriving Repr, BEq, DecidableEq

/-- A dynamically-typed JSON-like value. -/
inductive JsonValue where
  | null   : JsonValue
  | bool   : Bool → JsonValue
  | int    : Int → JsonValue
  | float  : Float → JsonValue
  | str    : String → JsonValue
  | array  : List JsonValue → JsonValue
  | object : List (String × JsonValue) → JsonValue
  deriving Repr, BEq

/-- Parameter type constraints for path and query parameters. -/
inductive ParamType where
  | string  : ParamType
  | integer : ParamType
  | float   : ParamType
  | boolean : ParamType
  deriving Repr, BEq, DecidableEq

/-- A segment in a URL pattern. -/
inductive PatternSegment where
  | literal   : String → PatternSegment
  | parameter : String → PatternSegment
  deriving Repr, BEq

/-- A parsed URL pattern with typed parameters. -/
structure URLPattern where
  segments : List PatternSegment
  deriving Repr, BEq

/-- A path parameter definition with type constraint. -/
structure PathParam where
  name     : String
  paramType : ParamType
  deriving Repr, BEq

/-- A query parameter definition with type, default, and required flag. -/
structure QueryParam where
  name         : String
  paramType    : ParamType
  defaultValue : Option String
  required     : Bool
  deriving Repr, BEq

/-- A route definition in a FastAPI app. -/
structure Route where
  pattern     : URLPattern
  methods     : List HttpMethod
  endpoint    : String
  pathParams  : List PathParam
  queryParams : List QueryParam
  summary     : String
  description : String
  tags        : List String
  deprecated  : Bool
  deriving Repr, BEq

/-- A router containing routes. -/
structure Router where
  routes    : List Route
  urlPrefix : String
  tags      : List String
  deriving Repr, BEq

/-- A field definition for request body validation. -/
structure FieldDef where
  name         : String
  fieldType    : ParamType
  required     : Bool
  defaultValue : Option String
  deriving Repr, BEq

/-- A model definition (like a Pydantic model). -/
structure ModelDef where
  name   : String
  fields : List FieldDef
  deriving Repr, BEq

/-- A JSON Schema definition (simplified). -/
inductive SchemaType where
  | stringType  : SchemaType
  | integerType : SchemaType
  | numberType  : SchemaType
  | booleanType : SchemaType
  | arrayType   : SchemaType → SchemaType
  | objectType  : List (String × SchemaType × Bool) → SchemaType
  | nullType    : SchemaType

/-- An OpenAPI parameter definition. -/
structure OpenAPIParam where
  name     : String
  location : String
  required : Bool
  schema   : SchemaType

/-- An OpenAPI operation (endpoint). -/
structure OpenAPIOperation where
  operationId : String
  summary     : String
  description : String
  tags        : List String
  parameters  : List OpenAPIParam
  deprecated  : Bool

/-- An OpenAPI path item. -/
structure OpenAPIPathItem where
  path       : String
  operations : List (String × OpenAPIOperation)

/-- An OpenAPI specification. -/
structure OpenAPISpec where
  title       : String
  version     : String
  description : String
  paths       : List OpenAPIPathItem


end FastApi
-- === END: FIXED_FINAL ===
