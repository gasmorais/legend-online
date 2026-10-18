#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
import re

import asview

ROOT = pathlib.Path(__file__).resolve().parent.parent
DEC = ROOT / "decompiled"
FCM = DEC / "core_module/scripts/yishi/manager/FrameControllerManager.as"


def find_class(simple: str, imports: dict[str, str]) -> pathlib.Path | None:
    fqn = imports.get(simple)
    rel = (fqn.replace(".", "/") + ".as") if fqn else None
    for mod in sorted(DEC.iterdir()):
        if rel and (mod / "scripts" / rel).exists():
            return mod / "scripts" / rel
    hits = list(DEC.glob(f"*/scripts/**/{simple}.as"))
    return hits[0] if hits else None


def frame_names(path: pathlib.Path) -> tuple[str | None, dict[str, str]]:
    text = path.read_text(errors="replace")
    body = asview.methods(text).get("frameClassName")
    if not body:
        return None, {}
    by_type: dict[str, str] = {}
    default: str | None = None
    keys: list[str] = []
    base_indent = None
    for line in body.splitlines()[1:]:
        st = line.strip()
        if not st or st in ("{", "}"):
            continue
        ind = len(line) - len(line.lstrip())
        if base_indent is None:
            base_indent = ind
        if st.startswith(("if", "else if")):
            keys = [a or b or c for a, b, c in re.findall(r'==\s*(?:"([^"]+)"|[\w]+\.(\w+)|(-?\d+))', st)]
            continue
        if st.startswith("else"):
            keys = []
            continue
        m = re.search(r'(?:return|_loc\d+_\s*(?::String)?\s*=)\s*"([\w.]+)"', st)
        if not m:
            continue
        if ind > base_indent and keys:
            for k in keys:
                by_type.setdefault(k, m.group(1))
        elif default is None:
            default = m.group(1)
    if default is None and by_type:
        default = next(iter(by_type.values()))
    return default, by_type


def main() -> None:
    text = FCM.read_text(errors="replace")
    imports = {i.rsplit(".", 1)[-1]: i for i in re.findall(r"^\s*import\s+([\w.]+);", text, re.M)}
    var_class = dict(re.findall(r"(_\w+)\s*=\s*new\s+(\w+)\(\)", text))
    body = asview.methods(text)["openControllerByInfo"]
    out: dict[str, dict] = {}
    pending: list[str] = []
    for line in body.splitlines():
        s = line.strip()
        m = re.match(r'case\s+"([^"]+)":', s)
        if m:
            pending.append(m.group(1))
            continue
        m = re.match(r"(_\w+)\.start\(", s)
        if m and pending:
            cls = var_class.get(m.group(1))
            path = find_class(cls, imports) if cls else None
            frame, by_type = frame_names(path) if path else (None, {})
            for key in pending:
                out[key] = {"controller": cls, "frame": frame, "byType": by_type}
            pending = []
        elif s.startswith("break") or s.startswith("default"):
            pending = []
    (ROOT / "web/public/layout/controllers.json").write_text(json.dumps(out, ensure_ascii=False, indent=0))
    ok = sum(1 for v in out.values() if v["frame"])
    print("chaves:", len(out), "com frame:", ok)


if __name__ == "__main__":
    main()
