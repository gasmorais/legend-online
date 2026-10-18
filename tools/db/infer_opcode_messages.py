#!/usr/bin/env python3
from __future__ import annotations
import json
import re

from common import ROOT

SRC = ROOT / "decompiled"
OUT = ROOT / "data/derived/opcode_messages.json"

FUNC = re.compile(r"function\s+(\w+)\s*\(([^)]*)\)[^{]*\{")
PKG_OUT = re.compile(r"new\s+PackageOut\((\d+)")
NEW_MSG = re.compile(r"new\s+(\w+Msg|\w+Message)\(\)")
PARAM_MSG = re.compile(r":\s*(\w+Msg)\b")
LISTEN = re.compile(r'"SLGSocketEvent"\s*\+\s*(\d+)\s*,\s*(\w+)')
READ_AS = re.compile(r"readBody\([^)]*\)\s+as\s+(\w+)")
GET_CODE = re.compile(r"function\s+getCode\(\)\s*:\s*int\s*\{\s*return\s+(\d+);")


def functions(text: str):
    for m in FUNC.finditer(text):
        i, depth = m.end(), 1
        while i < len(text) and depth:
            c = text[i]
            depth += (c == "{") - (c == "}")
            i += 1
        yield m.group(1), m.group(2), text[m.end():i], text.count("\n", 0, m.start()) + 1


def main():
    protos = set(json.loads((ROOT / "protocol/proto.json").read_text()))
    as3 = ROOT / "data/derived/proto_as3.json"
    if as3.exists():
        protos |= set(json.loads(as3.read_text()))
    out = []
    for f in SRC.rglob("*.as"):
        if "/com/road/yishi/proto/" in f.as_posix():
            continue
        text = f.read_text(encoding="utf-8", errors="replace")
        gc = GET_CODE.search(text)
        if "PackageOut(" not in text and "SLGSocketEvent" not in text and not gc:
            continue
        rel = f.relative_to(ROOT).as_posix()
        listeners = {}
        for m in LISTEN.finditer(text):
            listeners.setdefault(m.group(2), set()).add(int(m.group(1)))
        if gc and "readBody" in text:
            code = int(gc.group(1))
            for name, _params, body, line in functions(text):
                if name in listeners:
                    continue
                for msg in {m for m in READ_AS.findall(body) if m in protos}:
                    out.append({"direction": "accept", "code": code, "message": msg,
                                "handler": f"{f.stem}.{name}", "source_ref": f"{rel}:{line}"})
        for name, params, body, line in functions(text):
            codes = [int(c) for c in PKG_OUT.findall(body)]
            if codes and "sendProtoBuffer" in body or (codes and "sendProtobuffer" in body):
                msgs = {m for m in NEW_MSG.findall(body) if m in protos}
                msgs |= {m for m in PARAM_MSG.findall(params) if m in protos}
                if len(set(codes)) == 1:
                    for msg in msgs:
                        out.append({"direction": "send", "code": codes[0], "message": msg,
                                    "handler": name, "source_ref": f"{rel}:{line}"})
            if name in listeners:
                for msg in {m for m in READ_AS.findall(body) if m in protos}:
                    for code in listeners[name]:
                        out.append({"direction": "accept", "code": code, "message": msg,
                                    "handler": name, "source_ref": f"{rel}:{line}"})
    OUT.parent.mkdir(parents=True, exist_ok=True)
    uniq = {(o["direction"], o["code"], o["message"], o["source_ref"]): o for o in out}
    OUT.write_text(json.dumps(sorted(uniq.values(), key=lambda o: (o["direction"], o["code"])),
                              ensure_ascii=False, indent=1))
    codes = {(o["direction"], o["code"]) for o in uniq.values()}
    print(f"{len(uniq)} pares; {len(codes)} opcodes com mensagem → {OUT.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
