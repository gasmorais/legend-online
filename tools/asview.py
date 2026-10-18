#!/usr/bin/env python3
from __future__ import annotations

import re
import sys

TRIVIAL_GET = re.compile(r"public function get (\w+)\(\)\s*:\s*[\w.*<>]+\s*\{\s*return _?\w+;\s*\}", re.S)
TRIVIAL_SET = re.compile(r"public function set (\w+)\([^)]*\)\s*:\s*void\s*\{\s*_?\w+ = param1;\s*\}", re.S)


def methods(text: str) -> dict[str, str]:
    out = {}
    for m in re.finditer(r"\n(\s*)((?:override )?(?:public|protected|private|internal)(?: static)? function (?:get |set )?(\w+)\([^)]*\)[^{]*)\{", text):
        indent, start = m.group(1).split("\n")[-1], m.start()
        end = text.find("\n" + indent + "}", m.end())
        name = m.group(3)
        key = name if name not in out else name + "#" + str(len(out))
        out[key] = text[start:end + len(indent) + 2]
    return out


def compact(text: str) -> str:
    text = TRIVIAL_GET.sub(lambda m: f"get {m.group(1)}", text)
    text = TRIVIAL_SET.sub(lambda m: f"set {m.group(1)}", text)
    lines = []
    for line in text.splitlines():
        s = line.strip()
        if not s or s.startswith("import ") or s in ("{", "}", "super();"):
            continue
        lines.append(line.rstrip()[3:] if line.startswith("   ") else line.rstrip())
    return "\n".join(lines)


def main() -> None:
    text = open(sys.argv[1], encoding="utf-8", errors="replace").read()
    names = sys.argv[2:]
    if not names:
        print(compact(text))
        return
    found = methods(text)
    for n in names:
        for key, body in found.items():
            if key.split("#")[0] == n:
                print(compact(body))


if __name__ == "__main__":
    main()
