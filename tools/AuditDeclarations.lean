import Lean
import Lean.Util.CollectAxioms
open Lean

private partial def withoutMetadata : Expr → Expr
  | .mdata _ e => withoutMetadata e
  | .app f a => .app (withoutMetadata f) (withoutMetadata a)
  | .lam n t b bi => .lam n (withoutMetadata t) (withoutMetadata b) bi
  | .forallE n t b bi => .forallE n (withoutMetadata t) (withoutMetadata b) bi
  | .letE n t v b nd => .letE n (withoutMetadata t) (withoutMetadata v) (withoutMetadata b) nd
  | .proj n i e => .proj n i (withoutMetadata e)
  | e => e

unsafe def main (args : List String) : IO UInt32 := do
  if args.length != 3 then
    IO.eprintln "usage: AuditDeclarations.lean <library-module> <required-names.txt> <report.json>"
    return 2
  initSearchPath (← findSysroot)
  enableInitializersExecution
  let env ← importModules #[{module := args[0]!.toName}] {} (loadExts := true)
  let requested ← IO.FS.lines args[1]!
  let localNames := env.constants.fold (init := #[]) fun acc name _ =>
    match env.getModuleIdxFor? name with
    | none => acc
    | some idx =>
      let moduleName := env.header.moduleNames[idx.toNat]!.toString
      if moduleName = args[0]! || moduleName.startsWith (args[0]! ++ ".") then acc.push name else acc
  let mut names := requested
  for name in localNames do
    let text := name.toString
    if !text.startsWith "_private." && (text.splitOn ".").getLast!.startsWith "inst" && !names.contains text then
      names := names.push text
  let (_, moduleState) := ((localNames.forM fun name => CollectAxioms.collect name).run env).run {}
  let moduleAxioms := moduleState.axioms.map Name.toString
  let mut rows : Array Json := #[]
  for raw in names do
    let name := raw.trimAscii.toString.toName
    if let some info := env.checked.get.find? name then
      let typeText := reprStr (info.levelParams, withoutMetadata info.type)
      rows := rows.push <| Json.mkObj [
        ("name", toJson name.toString), ("type", toJson typeText),
        ("axioms", Json.null), ("present", toJson true)]
    else
      rows := rows.push <| Json.mkObj [("name", toJson name.toString), ("present", toJson false)]
  IO.FS.writeFile args[2]! <| (Json.mkObj [("declarations",Json.arr rows),("module_axioms",toJson moduleAxioms),("module_declaration_count",toJson localNames.size)]).pretty ++ "\n"
  return 0
