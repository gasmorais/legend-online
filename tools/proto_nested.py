#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
import re

ROOT = pathlib.Path(__file__).resolve().parent.parent
PROTO = ROOT / "protocol/proto.json"
SRC = [ROOT / "decompiled" / m / "scripts/com/road/yishi/proto" for m in ("core_module",)]


def main() -> None:
    schema = json.loads(PROTO.read_text())
    found = 0
    for base in SRC:
        for f in base.rglob("*.as"):
            name = f.stem
            if name not in schema:
                continue
            text = f.read_text(errors="replace")
            getters = dict(re.findall(r"public function get (\w+)\(\)\s*:\s*(\w+)", text))
            pushes = {}
            for m in re.finditer(r"(_loc\d+_)\s*=\s*new (\w+)\(\);.*?(\w+)\.push\(\1\)", text, re.S):
                pushes.setdefault(m.group(3), m.group(2))
            for fld in schema[name]["fields"]:
                if fld["type"] != "MESSAGE":
                    continue
                t = pushes.get(fld["name"]) if fld.get("repeated") else getters.get(fld["name"])
                t = t or getters.get(fld["name"]) or pushes.get(fld["name"])
                if t and t not in ("Array", "Object", "Message"):
                    fld["msg"] = t
                    found += 1
    PROTO.write_text(json.dumps(schema, ensure_ascii=False))
    total = sum(1 for m in schema.values() for f in m["fields"] if f["type"] == "MESSAGE")
    print(f"tipos aninhados: {found}/{total}")


if __name__ == "__main__":
    main()
