#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
import re

ROOT = pathlib.Path(__file__).resolve().parent.parent
BASES = sorted((ROOT / "decompiled").glob("*/scripts/com/road/yishi/proto"))
CASE = re.compile(r"case (\d+):(.*?)(?=\n\s*case \d+:|\n\s*default:|\Z)", re.S)


def parse(text: str) -> list[dict]:
    m = re.search(r"function readFromSlice\(.*?\{(.*)", text, re.S)
    if not m:
        return []
    body = m.group(1)
    setters = {}
    for sm in re.finditer(r"public function set (\w+)\(param1:[\w.*<>]+\)\s*:\s*void\s*\{(.*?)\n\s{6}\}", text, re.S):
        fm = re.search(r"(\w+)\$field\s*=\s*param1", sm.group(2))
        if fm:
            setters[sm.group(1)] = fm.group(1)
    fields = []
    for cm in CASE.finditer(body):
        num, block = int(cm.group(1)), cm.group(2)
        f: dict = {"num": num, "repeated": False}
        pm = re.search(r"readPackedRepeated\(param1,ReadUtils\.read\$TYPE_(\w+),(\w+)\)", block)
        if pm:
            f.update(type=pm.group(1), prop=pm.group(2), repeated=True)
        else:
            mm = re.search(r"(\w+)\s*=\s*new (\w+)\(\);\s*ReadUtils\.read\$TYPE_MESSAGE\(param1,\1\);(?:\s*(\w+)\.push\(\1\))?", block)
            if mm:
                f.update(type="MESSAGE", msg=mm.group(2))
                if mm.group(3):
                    f.update(prop=mm.group(3), repeated=True)
                else:
                    f["prop"] = mm.group(1)
            else:
                rm = re.search(r"(\w+)\.push\(ReadUtils\.read\$TYPE_(\w+)\(param1\)\)", block)
                if rm:
                    f.update(type=rm.group(2), prop=rm.group(1), repeated=True)
                else:
                    sm2 = re.search(r"(\w+)\s*=\s*ReadUtils\.read\$TYPE_(\w+)\(param1\)", block)
                    if not sm2:
                        continue
                    f.update(type=sm2.group(2), prop=sm2.group(1))
        f["name"] = setters.get(f["prop"], f["prop"])
        fields.append(f)
    if re.search(r">>>\s*3\)?\s*-\s*1\)", body) or (fields and min(f["num"] for f in fields) == 0):
        for f in fields:
            f["num"] += 1
    return fields


def main() -> None:
    schema: dict[str, dict] = {}
    for base in BASES:
        for path in sorted(base.rglob("*.as")):
            text = path.read_text(errors="replace")
            if "extends Message" not in text:
                continue
            name = path.stem
            if name in schema:
                continue
            schema[name] = {"package": str(path.parent.relative_to(base)).replace("/", "."), "fields": parse(text)}
    (ROOT / "protocol/proto.json").write_text(json.dumps(schema, ensure_ascii=False))
    nf = sum(len(m["fields"]) for m in schema.values())
    nm = sum(1 for m in schema.values() for f in m["fields"] if f["type"] == "MESSAGE")
    nmt = sum(1 for m in schema.values() for f in m["fields"] if f.get("msg"))
    print(f"mensagens: {len(schema)}  campos: {nf}  aninhados: {nmt}/{nm}")


if __name__ == "__main__":
    main()
