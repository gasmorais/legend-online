from __future__ import annotations

import re

OPS = sorted(""">>>= ... === !== >>> <<= >>= == != <= >= && || ++ -- += -= *= /= %= &= |= ^= << >> :: .. .@ ( ) [ ] { } ; , . : ? ! ~ + - * / % & | ^ = < > @""".split(),
             key=len, reverse=True)
ID_START = re.compile(r"[A-Za-z_$§\u0080-￿]")
ID_CHAR = re.compile(r"[A-Za-z0-9_$§\u0080-￿]")
NUM = re.compile(r"0[xX][0-9a-fA-F]+|(?:\d+\.?\d*|\.\d+)(?:[eE][+-]?\d+)?")
REGEX_PREV = {"(", ",", "=", ":", "[", "!", "&", "|", "?", "{", "}", ";", "return", "&&", "||", "==", "!=", "+"}


def tokenize(src: str) -> list[tuple[str, str]]:
    src = re.sub(r"\b(?:public|[A-Za-z]+_internal)::", "", src)
    out: list[tuple[str, str]] = []
    i, n = 0, len(src)
    last_sig = ""

    def push(kind: str, text: str) -> None:
        nonlocal last_sig
        out.append((kind, text))
        if kind not in ("ws", "nl", "comment"):
            last_sig = text if kind in ("op", "id") else kind

    while i < n:
        c = src[i]
        if c == "\n":
            push("nl", c)
            i += 1
        elif c in " \t\r":
            j = i
            while j < n and src[j] in " \t\r":
                j += 1
            push("ws", src[i:j])
            i = j
        elif src.startswith("//", i):
            j = src.find("\n", i)
            j = n if j < 0 else j
            push("comment", src[i:j])
            i = j
        elif src.startswith("/*", i):
            j = src.find("*/", i + 2)
            j = n if j < 0 else j + 2
            push("comment", src[i:j])
            i = j
        elif c in "\"'":
            j = i + 1
            while j < n and src[j] != c:
                j += 2 if src[j] == "\\" else 1
            push("str", src[i:j + 1])
            i = j + 1
        elif c.isdigit() or (c == "." and i + 1 < n and src[i + 1].isdigit()):
            m = NUM.match(src, i)
            push("num", m.group(0))
            i = m.end()
        elif ID_START.match(c):
            j = i + 1
            while j < n and ID_CHAR.match(src[j]):
                j += 1
            push("id", src[i:j])
            i = j
        elif c == "/" and last_sig in REGEX_PREV:
            j = i + 1
            in_class = False
            while j < n and (src[j] != "/" or in_class):
                if src[j] == "\\":
                    j += 1
                elif src[j] == "[":
                    in_class = True
                elif src[j] == "]":
                    in_class = False
                elif src[j] == "\n":
                    break
                j += 1
            k = j + 1
            while k < n and src[k].isalpha():
                k += 1
            push("regex", src[i:k])
            i = k
        elif c == "<" and last_sig in ("=", "(", "return", ",", ":", "[") and i + 1 < n and (src[i + 1].isalpha() or src[i + 1] in "!{"):
            j = _xml_end(src, i)
            push("xml", src[i:j])
            i = j
        else:
            for op in OPS:
                if src.startswith(op, i):
                    push("op", op)
                    i += len(op)
                    break
            else:
                push("op", c)
                i += 1
    return out


def _xml_end(src: str, i: int) -> int:
    m = re.match(r"<([\w:.-]+)", src[i:])
    if not m:
        return i + 1
    name = m.group(1)
    depth = 0
    j = i
    pat = re.compile(r"<(/?)([\w:.-]+)[^>]*?(/?)>|<!--.*?-->|<!\[CDATA\[.*?\]\]>", re.S)
    while True:
        m = pat.search(src, j)
        if not m:
            return len(src)
        j = m.end()
        if m.group(0).startswith(("<!--", "<![")):
            continue
        closing, tag, selfclose = m.group(1), m.group(2), m.group(3)
        if tag != name and depth == 0:
            continue
        if closing:
            depth -= 1
        elif not selfclose:
            depth += 1
        if depth <= 0:
            return j
