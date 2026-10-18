#!/usr/bin/env python3
from __future__ import annotations
import json
import re

from common import ROOT

OUT = ROOT / "data/derived/proto_as3.json"
TAG = re.compile(r"writeTag\(\s*param1\s*,\s*(\d+)\s*,\s*(\d+)\s*\)\s*;\s*\n\s*WriteUtils\.write\$TYPE_(\w+)\(\s*param1\s*,\s*([^;]+?)\)\s*;")
CASE = re.compile(r"case (\d+):(.*?)(?=case \d+:|default:|\Z)", re.S)
READ_MSG = re.compile(r"new\s+(\w+)\(\)")
WIRE = {"INT32": 0, "UINT32": 0, "INT64": 0, "UINT64": 0, "SINT32": 0, "SINT64": 0, "BOOL": 0, "ENUM": 0,
        "FIXED64": 1, "SFIXED64": 1, "DOUBLE": 1, "STRING": 2, "BYTES": 2, "MESSAGE": 2, "FIXED32": 5, "SFIXED32": 5, "FLOAT": 5}


def field_name(expr: str) -> tuple[str, bool]:
    expr = expr.strip()
    m = re.match(r"(\w+)\$field$", expr)
    if m:
        return m.group(1), False
    m = re.match(r"(?:this\.)?(\w+)\[", expr)
    if m:
        return m.group(1), True
    return re.sub(r"\W", "", expr) or "?", False


def parse(path):
    text = path.read_text(encoding="utf-8", errors="replace")
    w = text.find("writeToBuffer")
    r = text.find("readFromSlice")
    if w < 0:
        return None
    body = text[w:r if r > w else len(text)]
    fields = []
    for m in TAG.finditer(body):
        wire, num, ptype, expr = int(m.group(1)), int(m.group(2)), m.group(3), m.group(4)
        name, rep = field_name(expr)
        before = body[:m.start()]
        rep = rep or before.rfind("while(") > before.rfind("if(has")
        fields.append({"num": num, "name": name, "type": ptype, "wire": wire, "repeated": rep, "message_type": None,
                       "line": text.count("\n", 0, w + m.start()) + 1})
    if r > 0:
        sub = {}
        for cm in CASE.finditer(text[r:]):
            mm = READ_MSG.search(cm.group(2)) if "read$TYPE_MESSAGE" in cm.group(2) else None
            if mm:
                sub[int(cm.group(1)) + 1] = mm.group(1)
        for f in fields:
            if f["type"] == "MESSAGE":
                decl = re.search(rf"var {re.escape(f['name'])}\$field:(\w+)", text)
                f["message_type"] = sub.get(f["num"]) or (decl.group(1) if decl else None)
    return fields


def main():
    out = {}
    for f in sorted(ROOT.glob("decompiled/*/scripts/com/road/yishi/proto/**/*.as")):
        rel = f.relative_to(ROOT).as_posix()
        pkg = rel.split("/com/road/yishi/proto/")[1].rsplit("/", 1)[0].replace("/", ".")
        fields = parse(f)
        if fields is None or f.stem in out:
            continue
        out[f.stem] = {"package": pkg, "module": rel.split("/")[1], "source_ref": rel, "fields": fields}
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    known = set(json.loads((ROOT / "protocol/proto.json").read_text()))
    print(f"{len(out)} classes; {len(set(out) - known)} ausentes de protocol/proto.json; "
          f"{sum(1 for v in out.values() for x in v['fields'] if x['message_type'])} campos com tipo de submensagem")


if __name__ == "__main__":
    main()
