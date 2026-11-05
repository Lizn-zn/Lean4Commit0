# Flask

## Background

Flask is a lightweight Python web framework (microframework) for building web applications. It provides URL routing with pattern matching and parameter extraction, a routing table for dispatching requests to endpoints, and server-side session management for storing per-user state. This core spec focuses on Flask's three essential mechanisms: matching URLs against patterns, looking up routes in a routing table, and managing session data.

## Task

Complete implementation holes in explicitly editable regions in `Flask/*.lean` and complete the proof obligations assigned to editable regions.

**Completion review**: fill the assigned editable obligations and preserve trusted contracts; mechanical checks alone do not establish a solved library. Provided/unmarked holes require the author policy described below.

## Core Functions

### 1. `matchURL`

- **Signature**: `def matchURL (pattern : URLPattern) (path : String) : Option (List (String × String))`
- **Description**: Matches a request path against a URL pattern, extracting named parameters. For example, pattern `[literal "users", parameter "id"]` matching path `"/users/42"` yields `some [("id", "42")]`.
- **Postcondition**: For pattern `[literal "users", parameter paramName]` and path `"/users/" ++ value`, the result is `some [(paramName, value)]`.
- **Key constraints**: Split the path on `"/"` (ignoring the leading empty segment from the leading slash). Each `literal` segment must match exactly; each `parameter` segment captures its corresponding path segment as a string. Return `none` if segment counts don't match or a literal doesn't match.

### 2. `Router.match`

- **Signature**: `def Router.match (router : Router) (method : HttpMethod) (path : String) : Option (String × List (String × String))`
- **Description**: Looks up a route in the routing table by HTTP method and path. Returns the endpoint name and extracted parameters if a match is found.
- **Postcondition** (`Router.match_prefix_postcond`):
  - If result is `some (endpoint, params)`, then there exists a route in `router.routes` with that endpoint and the given method in its methods list
  - Completeness: if any route in `router.routes` has the method and its pattern matches the path (via `matchURL`), then the result must be `some`
- **Key constraints**: Must iterate through routes and check both method membership and URL pattern matching. The completeness clause means you can't miss a valid match.

### 3. `Session.set`

- **Signature**: `def Session.set (session : Session) (key : String) (value : String) : Session`
- **Description**: Sets a key-value pair in the session, replacing any existing value for that key.
- **Postcondition**: `result.get key = some value` — getting the key from the result returns the set value.
- **Key constraints**: Must handle both inserting new keys and updating existing ones. The result must be consistent with `Session.get`.

### 4. `Session.get` (helper)

- **Signature**: `def Session.get (session : Session) (key : String) : Option String`
- **Description**: Looks up a key in the session data. Returns the associated value or `none` if not found.
- **Key constraints**: No separate postcondition theorem, but it's referenced by `Session.set`'s postcondition and both relational specs. Must search through `session.data` for the first matching key.

## Relational Properties

- **`Session.set_get_roundtrip`**: `(session.set k v).get k = some v` — setting a key then getting it returns the set value. (Same as the `set` postcondition, stated as a relational property.)
- **`Session.set_preserves_other`**: When `k1 ≠ k2`, `(session.set k1 v).get k2 = session.get k2` — setting one key doesn't affect lookups of other keys.

## Types

- **`HttpMethod`**: HTTP verb enum (GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS).
- **`PatternSegment`**: A URL pattern segment — either a `literal` string (must match exactly) or a `parameter` name (captures the path segment).
- **`URLPattern`**: A list of `PatternSegment`s representing a URL pattern like `/users/<id>`.
- **`Route`**: A routing table entry with a URL pattern, list of allowed HTTP methods, and endpoint name.
- **`Router`**: A routing table containing a list of routes.
- **`Session`**: Session state as a list of `(String × String)` key-value pairs.

## Hints

- For `matchURL`, split the path on `"/"` and drop the leading empty string (from the leading `/`). Then zip with `pattern.segments`: for `literal s`, check `s = pathSegment`; for `parameter name`, collect `(name, pathSegment)`. Return `none` if lengths differ or a literal doesn't match.
- For `Router.match`, iterate through `router.routes`. For each route, check if `method ∈ route.methods` and if `matchURL route.pattern path` returns `some params`. Return the first match as `some (route.endpoint, params)`.
- For `Session.get`, use `List.lookup` or iterate through `session.data` to find the first pair with matching key.
- For `Session.set`, filter out any existing entries with the same key, then prepend (or append) `(key, value)`. This ensures `get` returns the new value and other keys are preserved.
- The `set_preserves_other` proof requires showing that filtering/replacing for key `k1` doesn't affect lookups for a different key `k2`. Design `set` and `get` so this is straightforward — e.g., if `get` finds the first match and `set` replaces all occurrences then prepends, the proof follows from `k1 ≠ k2`.

## Edit Boundaries

`Flask/*.lean` is divided into labeled sections:

```text
-- === BEGIN: SECTION_NAME (provided|editable) ===
...
-- === END: SECTION_NAME ===
```

Only `(editable)` sections should be modified. `(provided)` sections are checked by hash and should remain unchanged.

Checking commands:

- `./check.sh --integrity-only`
- `./check.sh --compile`
- `./check.sh`

## Revised release contract (v3)

Every template placeholder is now an explicit editable obligation, including the former provided/unmarked holes. All types, declaration headers, predicates and non-hole support source are protected. Read the validity assumptions in the theorem statements; they are part of this revised task, not the historical experiment. The optional PROOF_IMPORTS regions permit only Mathlib, Batteries, Std or Lean imports. Use local helper definitions inside implementation/proof bodies when needed.

The default root checker reconstructs an authenticated fresh task tree, builds it, checks required declarations and exact trusted types, and audits transitive axioms of all task-module declarations. A compiling template with sorry is not solved. The verdict concerns the published simplified Lean model. All original paper results remain associated with the preserved experiment version.

Current task modules (relative to this library directory):

- `Flask/Helpers.lean`
- `Flask/MatchURL.lean`
- `Flask/Relations.lean`
- `Flask/RouterMatch.lean`
- `Flask/SessionSet.lean`
- `Flask/Types.lean`

## Published model limits (v3)

The parameter-capture contract permits a parameter value containing slashes. This is a path-style capture in this model; segment-only routing is not required.
