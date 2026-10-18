#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
import re
from itertools import product

ROOT = pathlib.Path(__file__).resolve().parent.parent
PATH_MANAGER = ROOT / "decompiled/core_module/scripts/yishi/manager/PathManager.as"
CONFIG = ROOT / "raw" / "config.xml"
MANIFEST = ROOT / "index" / "manifest_res.json"

BASES = {
    "resourcePath": "{RES}", "_info.ResourcePath": "{RES}", "PathManager.resourcePath": "{RES}",
    "_info.TEMPLATE_PATH": "{TPL}", "_info.REQUEST_PATH": "{REQ}",
    "_info.UPLOAD_PATH": "{UPLOAD}", "_info.CastleServicePath": "{AMF}",
    "_info.SocktPath": "{SOCKET}", "_info.CharPort": "{PORT}",
}
FUNC = re.compile(r'public static function (get )?(\w+)\(([^)]*)\)\s*:\s*(\w+)\s*\{(.*?)\n      \}', re.S)
LOCAL = re.compile(r'(?:var )?(_loc\d+_)(?::\w+)?\s*=\s*([^;=][^;]*);')
RETURN = re.compile(r'return ([^;]+);')
SKIP = {"{_info}", "{true}", "{false}", "{null}"}
STRING = re.compile(r'^"((?:[^"\\]|\\.)*)"$')


def split_concat(expr: str) -> list[str]:
    parts, depth, quote, cur = [], 0, None, ""
    for ch in expr:
        if quote:
            cur += ch
            if ch == quote and not cur.endswith("\\" + quote):
                quote = None
            continue
        if ch in "\"'":
            quote = ch
        elif ch in "([":
            depth += 1
        elif ch in ")]":
            depth -= 1
        elif ch == "+" and depth == 0:
            parts.append(cur.strip())
            cur = ""
            continue
        cur += ch
    parts.append(cur.strip())
    return parts


def to_templates(expr: str, locals_: dict[str, list[str]], params: set[str]) -> list[str]:
    options = []
    for tok in split_concat(expr):
        if locals_.get(tok):
            options.append([t for e in locals_[tok] for t in to_templates(e, {}, params)])
        else:
            options.append([to_template(tok, params)])
    return ["".join(combo) for combo in product(*options)][:20]


def to_template(expr: str, params: set[str]) -> str:
    out = []
    for tok in split_concat(expr):
        if m := STRING.match(tok):
            out.append(m.group(1))
        elif tok in BASES:
            out.append(BASES[tok])
        elif tok in params:
            out.append("{" + tok + "}")
        elif tok == "PathInfo.LANGUAGE":
            out.append("{LANGUAGE}")
        else:
            out.append("{" + tok + "}")
    return "".join(out)


def parse_args(args: str) -> dict[str, str]:
    out = {}
    for a in filter(None, (x.strip() for x in args.split(","))):
        name, _, rest = a.partition(":")
        typ, _, default = rest.partition("=")
        out[name.strip()] = typ.strip() + (" (optional)" if default else "")
    return out


def kind(tpl: str) -> str:
    for base in ("{RES}", "{TPL}", "{REQ}", "{UPLOAD}", "{AMF}", "{SOCKET}", "{PORT}"):
        if tpl.startswith(base):
            return base.strip("{}")
    return "class" if tpl.startswith("slg.") else "other"


def config_bases() -> dict[str, str]:
    text = CONFIG.read_text(errors="replace")

    def get(tag: str) -> str:
        m = re.search(r"<%s\s+[^>]*?value=[\"']([^\"']*)" % tag, text)
        return m.group(1) if m else ""

    return {
        "RES": get("ResourcePath"), "TPL": get("TEMPLATE_PATH"), "REQ": get("REQUEST_PATH"),
        "UPLOAD": get("UPLOAD_PATH"), "AMF": get("CastleServicePath"),
        "SOCKET": get("SocktPath"), "LANGUAGE": get("LANGUAGE"),
    }


def template_regex(tpl: str, args: dict[str, str]) -> re.Pattern | None:
    body = tpl.removeprefix("{RES}")
    if body == tpl or not body:
        return None
    pattern = ""
    for piece in re.split(r"(\{[^}]+\})", body):
        if not piece.startswith("{"):
            pattern += re.escape(piece)
        elif args.get(piece[1:-1], "").startswith(("int", "uint", "Number")):
            pattern += r"-?\d+"
        else:
            pattern += r".*?"
    return re.compile(pattern + "$", re.I)


def extract() -> list[dict]:
    text = PATH_MANAGER.read_text(errors="replace")
    res_paths = [r["path"] for r in json.loads(MANIFEST.read_text())] if MANIFEST.exists() else []
    routes = []
    for m in FUNC.finditer(text):
        getter, name, args_s, rtype, body = m.groups()
        args = parse_args(args_s)
        locals_: dict[str, list[str]] = {}
        for var, expr in LOCAL.findall(body):
            if expr.strip() != "null":
                locals_.setdefault(var, []).append(expr.strip())
        templates = []
        for expr in RETURN.findall(body):
            for tpl in to_templates(expr.strip(), locals_, set(args)):
                if tpl and tpl not in templates and tpl not in SKIP:
                    templates.append(tpl)
        if not templates:
            continue
        variants = []
        for tpl in templates:
            v = {"template": tpl, "base": kind(tpl)}
            if rx := template_regex(tpl, args):
                hits = [p for p in res_paths if rx.match(p)]
                v["manifest_hits"] = len(hits)
                v["examples"] = hits[:3]
            variants.append(v)
        routes.append({"fn": name, "getter": bool(getter), "args": args,
                       "returns": rtype, "variants": variants})
    return routes


def main() -> None:
    routes = extract()
    out = {"bases": config_bases(), "path_manager": routes}
    print(json.dumps(out, indent=1, ensure_ascii=False)[:3000])


if __name__ == "__main__":
    main()
