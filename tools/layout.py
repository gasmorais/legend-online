#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
import re

import asview

ROOT = pathlib.Path(__file__).resolve().parent.parent
DECOMPILED = ROOT / "decompiled"
OUT = ROOT / "web/public/layout"

IDENT = r"(?:this\.)?(\w+)"
LHS = rf"(?:var\s+)?{IDENT}(?::[\w.<>*]+)?\s*=\s*"
CAST = r"(?:\s+as\s+[\w.]+)?"
RE_FACTORY = re.compile(LHS + r"(?:\()?ComponentFactory\.Instance\.(creat\w*)\(\"([^\"]+)\"(?:\s*,\s*(.*?))?\)\)?(?:\.clone\(\))?" + CAST + r";$")
RE_NEW = re.compile(LHS + r"new\s+([\w.]+)\((.*)\)" + CAST + r";$")
RE_ADD = re.compile(r"(?:(?:this\.)?(\w+)\.)?(addChild|addToContent|addChildAt)\((?:this\.)?(\w+)(?:\s*,\s*(\d+))?\);$")
RE_SET = re.compile(r"(?:(?:this\.)?(\w+)\.)?(\w+)\s*=\s*(.+);$")
RE_CALL = re.compile(r"(?:this\.)?(\w+)\.(setFrame|gotoAndStop|gotoAndPlay|stop|play|arrange|refreshChildPos|setView|"
                     r"invalidateViewport|setChildVisible|showImg|setTextFormat|move|setSize|addButton|selectIndex|"
                     r"setChildPos|setChildSize|beginChanges|commitChanges)\((.*)\);$")
RE_SELF_CALL = re.compile(r"^(?:this\.)?(\w+)\(\);$")
RE_SUPER = re.compile(r"^super\((.*)\);$")
SET_PROPS = {"x", "y", "width", "height", "alpha", "visible", "text", "htmlText", "titleText", "selected", "enable",
             "buttonMode", "mouseEnabled", "mouseChildren", "scaleX", "scaleY", "rotation", "rotationDeg", "tipData",
             "wordWrap", "multiline", "autoSize", "spacing", "escEnable", "enterEnable", "moveEnable", "showCancel",
             "showSubmit", "disabled", "filterString", "textFormatStyle", "maxChars", "displayAsPassword", "restrict",
             "frameIndex", "defaultTextFormat", "type", "selectable", "gap", "hSpace", "vSpace", "autoSizeEnable",
             "isAutoFitLength", "info", "data", "label", "smoothing", "currentFrame", "mask"}
RE_HELPER_CALL = re.compile(LHS + r"(\w+)\(\"([^\"]*)\"\)" + CAST + r";$")
RE_HELPER_BODY = re.compile(r'ComponentFactory\.Instance\.(creat\w*)\(\"([^\"]*)\"\s*\+\s*param1\s*(?:\+\s*\"([^\"]*)\")?\)')


def split_args(s: str) -> list[str]:
    out, depth, quote, cur = [], 0, None, ""
    for ch in s:
        if quote:
            cur += ch
            if ch == quote:
                quote = None
            continue
        if ch in "\"'":
            quote = ch
        elif ch in "([{":
            depth += 1
        elif ch in ")]}":
            depth -= 1
        elif ch == "," and depth == 0:
            out.append(cur.strip())
            cur = ""
            continue
        cur += ch
    if cur.strip():
        out.append(cur.strip())
    return out


def expr(s: str):
    s = s.strip()
    if s.startswith("(") and s.endswith(")") and s.count("(") == 1:
        s = s[1:-1].strip()
    if re.fullmatch(r"-?\d+(\.\d+)?", s):
        return ["num", float(s) if "." in s else int(s)]
    if re.fullmatch(r"0x[0-9a-fA-F]+", s):
        return ["num", int(s, 16)]
    if s in ("true", "false"):
        return ["bool", s == "true"]
    if s == "null":
        return ["null"]
    m = re.fullmatch(r'"((?:[^"\\]|\\.)*)"', s)
    if m:
        return ["str", m.group(1).encode().decode("unicode_escape", "ignore") if "\\" in m.group(1) else m.group(1)]
    m = re.fullmatch(r'LanguageMgr\.GetTranslation\("([^"]+)"\s*(?:,(.*))?\)', s)
    if m:
        return ["tr", m.group(1), [expr(a) for a in split_args(m.group(2) or "")]]
    m = re.fullmatch(r"(?:this\.)?(\w+)\.(x|y|width|height|text)", s)
    if m:
        return ["ref", m.group(1), m.group(2)]
    m = re.fullmatch(r"(?:this\.)?(_\w+|\w+_)", s)
    if m:
        return ["ref", m.group(1), None]
    for op, name in (("+", "add"), ("-", "sub")):
        parts = s.rsplit(f" {op} ", 1)
        if len(parts) == 2:
            a, b = expr(parts[0]), expr(parts[1])
            if a[0] != "raw" and b[0] != "raw":
                return [name, a, b]
    return ["raw", s]


def statements(body: str):
    lines = body.splitlines()
    start = next((i for i, l in enumerate(lines) if " function " in l or l.strip().startswith("function ")), -1)
    lines = lines[start + 1:]
    base = None
    for line in lines:
        s = line.strip()
        if not s or s in ("{", "}") or s.startswith("//") or (s.startswith("var ") and "=" not in s):
            continue
        ind = len(line) - len(line.lstrip())
        if base is None:
            base = ind
        yield (ind - base), s


class Extractor:
    def __init__(self, classes: dict):
        self.classes = classes

    def ops_for(self, fqn: str, text: str) -> tuple[list[dict], list[str]]:
        simple = fqn.rsplit(".", 1)[-1]
        methods = asview.methods(text)
        imports = {i.rsplit(".", 1)[-1]: i for i in re.findall(r"^\s*import\s+([\w.]+);", text, re.M)}
        pkg = fqn.rsplit(".", 1)[0] if "." in fqn else ""
        ctor = methods.get(simple)
        ops: list[dict] = []
        super_args: list = []
        if not ctor:
            return ops, super_args
        visited = {simple}

        def resolve(name: str) -> str:
            if "." in name:
                return name
            if name in imports:
                return imports[name]
            local = f"{pkg}.{name}" if pkg else name
            return local if local in self.classes else name

        helpers: dict[str, tuple[str, str, str]] = {}
        for mname, mbody in methods.items():
            hm = RE_HELPER_BODY.search(mbody)
            if hm and "return" in mbody:
                helpers[mname.split("#")[0]] = (hm.group(1), hm.group(2), hm.group(3) or "")

        def walk(body: str, cond_base: bool, depth: int) -> None:
            for rel, s in statements(body):
                cond = 1 if (cond_base or rel > 0) else 0
                if s.startswith(("if", "else", "while", "for", "switch", "case", "default", "return", "break", "try", "catch")):
                    continue
                m = RE_SUPER.match(s)
                if m and not ops and depth == 0:
                    super_args[:] = [expr(a) for a in split_args(m.group(1))]
                    continue
                m = RE_SELF_CALL.match(s)
                if m and m.group(1) in methods and m.group(1) not in visited and depth < 4:
                    visited.add(m.group(1))
                    walk(methods[m.group(1)], bool(cond), depth + 1)
                    continue
                m = RE_FACTORY.match(s)
                if m:
                    var, fn, name, rest = m.groups()
                    how = {"creatComponentByStylename": "style", "creatBitmap": "bitmap", "creatCustomObject": "custom",
                           "creatBitmapData": "bitmapData", "creat": "creat"}.get(fn, fn)
                    op = {"op": "create", "v": var, "how": how, "name": name}
                    if rest:
                        op["args"] = [expr(a) for a in split_args(rest.strip().lstrip("[").rstrip("]"))]
                    ops.append({**op, **({"c": 1} if cond else {})})
                    continue
                m = RE_HELPER_CALL.match(s)
                if m and m.group(2) in helpers:
                    var, helper, arg = m.groups()
                    fn, prefix, suffix = helpers[helper]
                    how = {"creatComponentByStylename": "style", "creatBitmap": "bitmap", "creatCustomObject": "custom",
                           "creat": "creat"}.get(fn, fn)
                    ops.append({"op": "create", "v": var, "how": how, "name": prefix + arg + suffix, **({"c": 1} if cond else {})})
                    continue
                m = RE_NEW.match(s)
                if m:
                    var, cls, args = m.groups()
                    full = resolve(cls)
                    if full in self.classes or full.startswith(("com.pickgliss.", "flash.display.", "flash.text.")):
                        ops.append({"op": "create", "v": var, "how": "new", "name": full,
                                    "args": [expr(a) for a in split_args(args)], **({"c": 1} if cond else {})})
                    continue
                m = RE_ADD.match(s)
                if m:
                    parent, how, var, idx = m.groups()
                    op = {"op": "add", "p": parent or "this", "v": var, "how": how}
                    if idx:
                        op["i"] = int(idx)
                    ops.append({**op, **({"c": 1} if cond else {})})
                    continue
                m = RE_CALL.match(s)
                if m:
                    var, meth, args = m.groups()
                    ops.append({"op": "call", "v": var, "m": meth, "a": [expr(a) for a in split_args(args)],
                                **({"c": 1} if cond else {})})
                    continue
                m = RE_SET.match(s)
                if m and m.group(2) in SET_PROPS:
                    var, prop, value = m.groups()
                    e = expr(value)
                    if e[0] != "raw":
                        ops.append({"op": "set", "v": var or "this", "k": prop, "e": e, **({"c": 1} if cond else {})})

        walk(ctor, False, 0)
        return ops, super_args


def main() -> None:
    classes = json.loads((ROOT / "index/classes.json").read_text())
    screens = json.loads((ROOT / "index/screens.json").read_text())
    views = screens["views"]
    ex = Extractor(classes)
    by_module: dict[str, dict] = {}
    index: dict[str, str] = {}
    n_ops = 0
    for fqn, v in views.items():
        path = DECOMPILED / v["module"] / "scripts" / v["path"]
        text = path.read_text(errors="replace")
        ops, super_args = ex.ops_for(fqn, text)
        rec = {"extends": classes[fqn]["extends"], "ops": ops}
        if super_args:
            rec["super"] = super_args
        by_module.setdefault(v["module"], {})[fqn] = rec
        index[fqn] = v["module"]
        n_ops += len(ops)
    OUT.mkdir(parents=True, exist_ok=True)
    for mod, data in by_module.items():
        (OUT / f"{mod}.json").write_text(json.dumps(data, ensure_ascii=False, separators=(",", ":")))
    (OUT / "index.json").write_text(json.dumps(index, ensure_ascii=False, separators=(",", ":")))
    bases = {}
    for fqn in views:
        cur = fqn
        seen = set()
        while cur in classes and cur not in seen and not cur.startswith(("com.pickgliss.", "flash.")):
            seen.add(cur)
            cur = classes[cur]["extends"]
        bases[fqn] = cur
    (OUT / "bases.json").write_text(json.dumps(bases, ensure_ascii=False, separators=(",", ":")))
    styles = json.loads((ROOT / "index/styles.json").read_text())
    style_index = {name: st["file"] for name, st in styles.items()}
    (ROOT / "web/public/lib/style-index.json").write_text(json.dumps(style_index, ensure_ascii=False, separators=(",", ":")))
    class_styles: dict[str, list[str]] = {}
    for name, st in styles.items():
        cn = st["attrs"].get("classname")
        if cn and not cn.startswith(("com.pickgliss.", "flash.")):
            class_styles.setdefault(cn, []).append(name)
    compact = [{"cls": sc["class"], "title": sc.get("title"), "kind": sc["kind"], "module": sc["module"],
                "size": sc["stats"]["size"], "n": sc["stats"]["elements"]} for sc in screens["screens"]]
    (OUT / "screens.json").write_text(json.dumps(compact, ensure_ascii=False, separators=(",", ":")))
    (OUT / "class-styles.json").write_text(json.dumps(class_styles, ensure_ascii=False, separators=(",", ":")))
    print("views:", len(index), "ops:", n_ops, "módulos:", len(by_module))


if __name__ == "__main__":
    main()
