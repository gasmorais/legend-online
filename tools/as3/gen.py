from __future__ import annotations

import collections
import json
import pathlib
import pickle
import re
import sys
import time

sys.path.insert(0, str(pathlib.Path(__file__).parent))
import emit

ROOT = pathlib.Path(__file__).resolve().parents[2]
OUT = ROOT / "build/as3/gen"
BUILD = ROOT / "build/as3"
SKIP_GOTO = ("§", "loop1:", "addr")


SEARCH_LOOP_RE = re.compile(r'do\s*\{\s*for \(var (\w+) of \$\.values\((\w+)\)\)\s*\{\s*\}\s*continue (loop\d+);\s*\}\s*while\((.*?)\);\n', re.S)
HASNEXT_RE = re.compile(r'while\(\$\.g\("\\u00a7\\u00a7hasnext", this\)\((\w+),(\w+)\)\)\n(\s*)\{\n\s*var (\w+) = \$\.g\("\\u00a7\\u00a7next(value|name)", this\)\(\2,\1\);')
CAST_RE = re.compile(r'(?<![\w$.])\$\.C\("([\w.$]+\.[A-Z][\w$]*|[A-Z][\w$]*)"\)\(')

PATCHES: dict[str, list[tuple[str, str]]] = {
    "mvc.module.room.RoomInfo": [(
        """do
            {
               if($.g("\\u00a7\\u00a7hasnext", this)(_loc6_,_loc7_))
               {
                  continue;
               }
            }
            while(_loc3_ = $.g("\\u00a7\\u00a7nextvalue", this)(_loc7_,_loc6_), _loc3_.id != param1);
            return _loc3_;""",
        """_loc3_ = null;
            for (var __v of $.values(_loc6_))
            {
               if(__v.id == param1)
               {
                  _loc3_ = __v;
                  break;
               }
            }
            return _loc3_;""")],
    "com.speedEngine.speedBones.display.DisplayObject": [
        ("globalToLocal(2(param1) {", "globalToLocal$public(param1) {"),
        ("globalToLocal(11(param1, param2 = null) {", "globalToLocal(param1, param2 = null) {")],
    "com.speedEngine.speedBones.manager.RenderManager": [
        ("createImageData(12(param1) {", "createImageData(param1) {"),
        ("createImageData(1() {", "createImageData$1() {"),
        ('$.bind(this, "createImageData")#1()', "this.createImageData$1()")],
    "friends.view.FriendsFrame": [(
        """with(this._mood)
         {
            if($.g("textWidth", this) > this.width)
            {
               this.text = $.g("text", this).substring(0,$.g("getCharIndexAtPoint", this)(this.width - 22,5)) + "...";
            }
         }""",
        """{ const __m = this._mood;
            if(__m.textWidth > __m.width)
            {
               __m.text = __m.text.substring(0,__m.getCharIndexAtPoint(__m.width - 22,5)) + "...";
            }
         }""")],
}


def out_path(fqn: str) -> pathlib.Path:
    return OUT / (fqn.replace("$$", "__").replace(".", "/") + ".ts")


def main() -> None:
    t0 = time.time()
    index = json.loads((BUILD / "index.json").read_text())
    with open(BUILD / "parsed.pkl", "rb") as fh:
        parsed = pickle.load(fh)
    prefixes = sys.argv[1:]
    native_deps = collections.Counter()
    unresolved = collections.Counter()
    failed = []
    n = 0
    for fqn, cls in parsed.items():
        if prefixes and not any(fqn.startswith(p) for p in prefixes):
            continue
        try:
            e = emit.ClassEmitter(index, cls)
            code = e.emit()
            code = CAST_RE.sub(r'$.cast($.C("\1"), ', code)
            alias = "__" + fqn.split(".")[-1].split("$$")[-1]
            code = re.sub(r"(?<![\w$.])(?<!new )" + re.escape(alias) + r"\(", "$.cast(" + alias + ", ", code)
            code = SEARCH_LOOP_RE.sub(lambda m: (
                f"var __found_{m.group(3)} = false;\n"
                f"for (var {m.group(1)} of $.values({m.group(2)})) {{ if (!({m.group(4)})) {{ __found_{m.group(3)} = true; break; }} }}\n"
                f"if (!__found_{m.group(3)}) continue {m.group(3)};"), code)
            code = HASNEXT_RE.sub(lambda m: f"for (var {m.group(4)} {'of $.values(' + m.group(1) + ')' if m.group(5) == 'value' else 'in ' + m.group(1)})\n{m.group(3)}{{", code)
            code = code.replace('$.g("\\u00a7\\u00a7findproperty", this)(this.percent)', "this")
            for old, new in PATCHES.get(fqn, []):
                code = code.replace(old, new)
        except Exception as ex:
            failed.append((fqn, repr(ex)[:160]))
            continue
        p = out_path(fqn)
        p.parent.mkdir(parents=True, exist_ok=True)
        if not p.exists() or p.read_text() != code:
            p.write_text(code)
        n += 1
        for d in e.deps:
            if d not in parsed:
                native_deps[d] += 1
        for w in e.warnings:
            unresolved[w] += 1
    write_bundles(index, parsed)
    report = {"generated": n, "failed": failed, "native_deps": native_deps.most_common(),
              "unresolved": unresolved.most_common(300)}
    (BUILD / "report.json").write_text(json.dumps(report, ensure_ascii=False, indent=1))
    print(f"gerados {n} em {time.time() - t0:.0f}s; falhas {len(failed)}; nativos {len(native_deps)}; "
          f"não resolvidos {len(unresolved)}")
    print("falhas:", failed[:5])
    print("nativos mais usados:", native_deps.most_common(25))
    print("não resolvidos:", unresolved.most_common(30))


def write_bundles(index: dict, parsed: dict) -> None:
    bundles: dict[str, list[str]] = collections.defaultdict(list)
    classmap: dict[str, str] = {}
    for fqn in parsed:
        mod = index["classes"].get(fqn, {}).get("module")
        p = out_path(fqn)
        if not mod or not p.exists():
            continue
        code = p.read_text()
        code = code.replace("// @ts-nocheck\n", "", 1)
        code = code.replace("export default function define($) {", f"defs[{json.dumps(fqn)}] = function define($) {{", 1)
        code = code.replace("export const deps = ", f"deps[{json.dumps(fqn)}] = ", 1)
        bundles[mod].append(code)
        classmap[fqn] = mod
    bdir = ROOT / "web/src/gen-bundles"
    bdir.mkdir(parents=True, exist_ok=True)
    for mod, parts in bundles.items():
        text = "// @ts-nocheck\nexport const defs = {};\nexport const deps = {};\n" + "\n".join(parts)
        (bdir / f"{mod}.ts").write_text(text)
    pub = ROOT / "web/public/as3"
    pub.mkdir(parents=True, exist_ok=True)
    (pub / "classmap.json").write_text(json.dumps(classmap, separators=(",", ":")))
    print("bundles:", {m: len(v) for m, v in bundles.items()})


if __name__ == "__main__":
    main()
    import subprocess
    subprocess.run(["node", str(pathlib.Path(__file__).with_name("build_bundles.mjs"))], check=True)
