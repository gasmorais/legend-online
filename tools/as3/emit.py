from __future__ import annotations

import json
import os
import re

from parse import ClassDef, Member, Tok, match_brace, read_type, sig

JS_GLOBALS = {"Math", "Array", "Object", "String", "Number", "Boolean", "Date", "RegExp", "Error", "JSON", "Function",
              "isNaN", "isFinite", "parseInt", "parseFloat", "NaN", "Infinity", "undefined", "null", "true", "false",
              "encodeURIComponent", "decodeURIComponent", "encodeURI", "decodeURI", "escape", "unescape", "arguments",
              "this", "super", "TypeError", "RangeError", "ReferenceError", "SyntaxError", "EvalError", "URIError"}
RT_GLOBALS = {"int": "$.int", "uint": "$.uint", "trace": "$.trace", "XML": "$.XML", "XMLList": "$.XMLList",
              "getTimer": "$.getTimer", "setTimeout": "$.setTimeout", "clearTimeout": "$.clearTimeout",
              "setInterval": "$.setInterval", "clearInterval": "$.clearInterval", "getDefinitionByName": "$.getDefinitionByName",
              "getQualifiedClassName": "$.getQualifiedClassName", "getQualifiedSuperclassName": "$.getQualifiedSuperclassName",
              "describeType": "$.describeType", "navigateToURL": "$.navigateToURL", "Class": "$.Class",
              "Vector": "$.Vector", "Namespace": "$.Namespace", "QName": "$.QName", "fscommand": "$.fscommand",
              "sendToURL": "$.sendToURL", "unescapeMultiByte": "$.unescapeMultiByte", "escapeMultiByte": "$.escapeMultiByte"}
KEYWORDS = {"if", "else", "for", "while", "do", "switch", "case", "default", "break", "continue", "return", "throw", "try",
            "catch", "finally", "new", "delete", "typeof", "instanceof", "in", "void", "var", "const", "function", "with",
            "each", "get", "set", "is", "as", "import", "package", "class", "extends", "implements", "use", "namespace",
            "static", "public", "private", "protected", "internal", "override", "final", "dynamic", "native", "include"}
NUMERIC_TYPES = {"int": "0", "uint": "0", "Number": "NaN", "Boolean": "false"}
_PIXI_NAMES = set(json.load(open(os.path.join(os.path.dirname(__file__), "pixi_names.json"))))
FLASH_API = {"addChild", "addChildAt", "alpha", "blendMode", "cacheAsBitmap", "constructor", "filters", "getBounds", "getChildAt",
             "getChildByName", "getChildIndex", "height", "mask", "name", "parent", "removeChild", "removeChildAt",
             "removeChildren", "rotation", "setChildIndex", "swapChildren", "transform", "visible", "width", "x", "y", "text",
             "clear", "lineTo", "moveTo", "beginFill", "endFill", "lineStyle", "drawCircle", "drawEllipse", "drawRect",
             "drawRoundedRect", "clone", "unload", "getSize", "containsPoint",
             "_width", "_height", "_text"}
SHARED_ESC = {n for n in _PIXI_NAMES - FLASH_API if not n.startswith("_")}
GLOBAL_ESC = {n for n in _PIXI_NAMES - FLASH_API if n.startswith("_")} | {"updateTransform", "_localBounds", "_parent",
             "_children", "_visible", "_alpha", "_angle", "_tint", "_effects", "_label", "_destroyed", "_renderGroup",
             "_mask", "_filters", "_x", "_y"}
EXPR_END = {"id", "str", "num", "regex", "xml"}
EXPR_END_OPS = {")", "]"}


def split_statements(code: str) -> list[str]:
    out, cur, depth, i, n = [], [], 0, 0, len(code)
    while i < n:
        c = code[i]
        if c in "\"'`":
            j = i + 1
            while j < n and code[j] != c:
                j += 2 if code[j] == "\\" else 1
            cur.append(code[i:j + 1]); i = j + 1; continue
        cur.append(c)
        if c in "([{":
            depth += 1
        elif c in ")]}":
            depth -= 1
            if c == "}" and depth == 0:
                rest = code[i + 1:].lstrip()
                if not re.match(r"(else|catch|finally|while)\b", rest):
                    out.append("".join(cur)); cur = []
        elif c == ";" and depth == 0:
            out.append("".join(cur)); cur = []
        i += 1
    if "".join(cur).strip():
        out.append("".join(cur))
    return out


def hoist_pre_super(body: str) -> str:
    m = re.search(r"(?<![\w$.])super\(", body)
    if not m:
        return body
    pre = body[:m.start()]
    if not re.search(r"(?<![\w$])this(?![\w$])", pre):
        return body
    keep, hook = [], []
    for st in split_statements(pre):
        if re.search(r"(?<![\w$])this(?![\w$])", st):
            hook.append(re.sub(r"(?<![\w$.])this(?![\w$])", "__s", st))
        else:
            keep.append(st)
    j, depth = m.end(), 1
    while j < len(body) and depth:
        depth += {"(": 1, ")": -1}.get(body[j], 0)
        j += 1
    while j < len(body) and body[j] in " ;":
        j += 1
    return ("".join(keep) + "\n         $.pre(new.target, (__s) => {" + "".join(hook) + "\n         });\n         "
            + body[m.start():j] + "\n         $.preFlush(this, new.target);" + body[j:])


def fix_super_this(body: str) -> str:
    i = body.find("super(")
    if i < 0:
        return body
    j, depth = i + 6, 1
    while j < len(body) and depth:
        depth += {"(": 1, ")": -1}.get(body[j], 0)
        j += 1
    args = body[i + 6:j - 1]
    if "this" not in args:
        return body
    args = re.sub(r'\$\.bind\(this, "([\w$]+)"\)', r"((...__a) => this.\1(...__a))", args)
    args = re.sub(r"(?<![\w$.])this\.([\w$]+)\b(?!\s*\()", "undefined", args)
    return body[:i + 6] + args + body[j - 1:]


def js_regex(lit: str) -> str:
    end = lit.rfind("/")
    body, flags = lit[1:end], lit[end + 1:]
    out, i, cls = [], 0, False
    while i < len(body):
        c = body[i]
        if c == "\\":
            out.append(body[i:i + 2]); i += 2; continue
        if c == "[": cls = True
        elif c == "]": cls = False
        if not cls and c == "+" and out and (out[-1] in ("*", "+", "?") or out[-1].endswith("}")) and \
                not (len(out) >= 2 and out[-2] == "\\"):
            i += 1; continue
        if "x" in flags and not cls and c in " \t\n\r":
            i += 1; continue
        if "x" in flags and not cls and c == "#":
            while i < len(body) and body[i] != "\n": i += 1
            continue
        out.append(c); i += 1
    return "/" + "".join(out) + "/" + flags.replace("x", "")


_CHILDREN: dict[int, dict[str, list[str]]] = {}


def descendant_names(index: dict, fqn: str) -> set[str]:
    key = id(index)
    if key not in _CHILDREN:
        kids: dict[str, list[str]] = {}
        for c, info in index.items():
            if info.get("extends"):
                kids.setdefault(info["extends"], []).append(c)
        _CHILDREN[key] = kids
    kids = _CHILDREN[key]
    out: set[str] = set()
    stack = list(kids.get(fqn, []))
    while stack:
        c = stack.pop()
        out.update(index.get(c, {}).get("inst", {}))
        stack.extend(kids.get(c, []))
    return out


def esc(name: str, display: bool = True) -> str:
    if name in GLOBAL_ESC or (display and name in SHARED_ESC):
        return "$$" + name
    return name


class ClassEmitter:
    def __init__(self, index: dict, cls: ClassDef):
        self.index = index["classes"]
        self.packages = index["packages"]
        self.cls = cls
        self.fqn = cls.fqn
        self.info = self.index.get(self.fqn, {})
        self.inst = self.chain_members("inst")
        self.display = self.is_display()
        self.mangle = self.private_mangles()
        self.stat_own = {m.name for m in cls.members if m.static}
        self.stat_anc = self.ancestor_statics()
        self.deps: set[str] = set()
        self.warnings: list[str] = []
        self.locals: set[str] = set()
        self.e4x = 0

    def mname(self, name: str) -> str:
        return self.mangle.get(name) or esc(name, self.display)

    def private_mangles(self) -> dict[str, str]:
        own = set(self.info.get("priv", []))
        if not own:
            return {}
        others: set[str] = set()
        for c in self.chain()[1:]:
            others.update(self.index.get(c, {}).get("inst", {}))
        others.update(descendant_names(self.index, self.fqn))
        simple = self.cls.name.split("$$")[-1]
        return {n: f"{n}${simple}" for n in own if n in others}

    def is_display(self) -> bool:
        for c in self.chain():
            base = self.index.get(c, {}).get("extends") or ""
            if c.startswith(("flash.display.", "flash.text.TextField", "com.pickgliss.ui")) or \
               base.startswith(("flash.display.", "flash.text.TextField", "com.pickgliss.ui")):
                if not (c.startswith("flash.display.BitmapData") or base.startswith("flash.display.BitmapData")):
                    return True
        return False

    def chain(self) -> list[str]:
        out, cur = [], self.fqn
        while cur and cur not in out:
            out.append(cur)
            cur = self.index.get(cur, {}).get("extends")
        return out

    def chain_members(self, key: str) -> dict[str, str]:
        res: dict[str, str] = {}
        for c in reversed(self.chain()):
            res.update(self.index.get(c, {}).get(key, {}))
        res.update({m.name: m.kind for m in self.cls.members if not m.static} if key == "inst" else {})
        for c in self.chain():
            res.pop(c.rsplit(".", 1)[-1].split("$$")[-1], None)
        return res

    def ancestor_statics(self) -> dict[str, str]:
        res: dict[str, str] = {}
        for c in self.chain()[1:]:
            for n in self.index.get(c, {}).get("stat", {}):
                res.setdefault(n, c)
        return res

    def class_fqn(self, name: str) -> str | None:
        if "." in name:
            return name if name in self.index else None
        imp = self.cls.imports.get(name)
        if imp:
            return imp
        pkg = self.cls.package
        cand = f"{pkg}.{name}" if pkg else name
        if cand in self.index:
            return cand
        aux = f"{pkg}.{self.fqn.rsplit('.', 1)[-1]}$${name}" if pkg else None
        if aux and aux in self.index:
            return aux
        if name in self.index:
            return name
        for wpkg in filter(None, self.cls.imports.get("*", "").split(",")):
            if f"{wpkg}.{name}" in self.index:
                return f"{wpkg}.{name}"
        for flash_pkg in ("flash.display", "flash.events", "flash.text", "flash.geom", "flash.utils", "flash.net",
                          "flash.filters", "flash.media", "flash.system", "flash.ui", "flash.errors", "flash.external"):
            if name in FLASH_NAMES.get(flash_pkg, ()):
                return f"{flash_pkg}.{name}"
        return None

    def class_ref(self, fqn: str) -> str:
        if fqn == self.fqn:
            return self.class_alias
        self.deps.add(fqn)
        return f'$.C({json.dumps(fqn)})'

    def type_ref(self, typ: str) -> str:
        t = typ.strip()
        if t.startswith("Vector."):
            return "$.Vector"
        if t in ("int", "uint", "Number", "String", "Boolean", "Array", "Object", "Function", "XML", "XMLList", "Class", "*"):
            return json.dumps(t)
        fqn = self.class_fqn(t)
        return self.class_ref(fqn) if fqn else json.dumps(t)

    def collect_locals(self, toks: list[Tok], params: list[Tok]) -> set[str]:
        names = set()
        for i, (k, t) in enumerate(toks):
            if k == "id" and t in ("var", "const", "function"):
                j = sig(toks, i + 1)
                if j < len(toks) and toks[j][0] == "id" and toks[j][1] not in ("get", "set"):
                    names.add(toks[j][1])
            if k == "id" and t == "catch":
                j = sig(toks, i + 1)
                j = sig(toks, j + 1)
                if j < len(toks) and toks[j][0] == "id":
                    names.add(toks[j][1])
            if k == "id" and t == "function":
                j = sig(toks, i + 1)
                if toks[j][0] == "id":
                    j = sig(toks, j + 1)
                if j < len(toks) and toks[j][1] == "(":
                    end = match_brace(toks, j, "(", ")")
                    names |= self.param_names(toks[j + 1:end])
        return names | self.param_names(params)

    @staticmethod
    def param_names(params: list[Tok]) -> set[str]:
        names, expect = set(), True
        depth = 0
        for k, t in params:
            if k == "op" and t in "([{":
                depth += 1
            elif k == "op" and t in ")]}":
                depth -= 1
            elif k == "op" and t == "," and depth == 0:
                expect = True
            elif k == "id" and expect and depth == 0:
                names.add(t)
                expect = False
        return names

    @staticmethod
    def param_types(params: list[Tok]) -> list[tuple[str, str]]:
        out, depth, expect, name = [], 0, True, None
        toks = [t for t in params if t[0] not in ("ws", "nl", "comment")]
        i = 0
        while i < len(toks):
            k, t = toks[i]
            if k == "op" and t in "([{":
                depth += 1
            elif k == "op" and t in ")]}":
                depth -= 1
            elif k == "op" and t == "," and depth == 0:
                expect = True
            elif k == "id" and expect and depth == 0 and t != "...":
                name = t
                typ = toks[i + 2][1] if i + 2 < len(toks) and toks[i + 1][1] == ":" else ""
                out.append((name, typ))
                expect = False
            i += 1
        return out

    PARAM_COERCE = {
        "String": "if ({p} != null && typeof {p} !== \"string\") {p} = String({p});",
        "int": "if (typeof {p} !== \"number\" || ({p} | 0) !== {p}) {p} = $.int({p});",
        "uint": "if (typeof {p} !== \"number\" || {p} < 0 || ({p} >>> 0) !== {p}) {p} = $.uint({p});",
        "Number": "if (typeof {p} !== \"number\") {p} = Number({p});",
    }

    def param_coercions(self, params: list[Tok]) -> str:
        lines = [self.PARAM_COERCE[t].format(p=n) for n, t in self.param_types(params) if t in self.PARAM_COERCE]
        return "".join("\n         " + l for l in lines)

    def strip_params(self, params: list[Tok]) -> str:
        out, i = [], 0
        while i < len(params):
            k, t = params[i]
            if k == "op" and t == ":":
                _, i = read_type(params, i + 1)
                continue
            if k == "op" and t == "=":
                j = i + 1
                start = j
                depth = 0
                while j < len(params):
                    kk, tt = params[j]
                    if kk == "op" and tt in "([{":
                        depth += 1
                    elif kk == "op" and tt in ")]}":
                        depth -= 1
                    elif kk == "op" and tt == "," and depth == 0:
                        break
                    j += 1
                out.append("=" + self.body(params[start:j]))
                i = j
                continue
            out.append(t)
            i += 1
        return "".join(out)

    COERCE = {"String": "$.str(", "Number": "Number(", "int": "$.int(", "uint": "$.uint("}

    def xml_coercions(self, toks: list[Tok]) -> tuple[dict[int, str], dict[int, str]]:
        n = len(toks)
        types: dict[str, str] = {m.name: m.type for m in self.cls.members if m.kind in ("var", "const")}
        for i, (k, t) in enumerate(toks):
            if k == "id" and t in ("var", "const"):
                j = sig(toks, i + 1)
                j2 = sig(toks, j + 1)
                if j2 < n and toks[j2][1] == ":":
                    j3 = sig(toks, j2 + 1)
                    if j3 < n:
                        types[toks[j][1]] = toks[j3][1]
        openers: dict[int, str] = {}
        closers: dict[int, str] = {}
        for i, (k, t) in enumerate(toks):
            if k != "id" or types.get(t) not in self.COERCE:
                continue
            pj = i - 1
            while pj >= 0 and toks[pj][0] in ("ws", "nl", "comment"):
                pj -= 1
            if pj >= 0 and toks[pj][1] == "." and not (pj >= 1 and toks[pj - 1][1] == "this"):
                continue
            eq = sig(toks, i + 1)
            if eq < n and toks[eq][1] == ":":
                eq = sig(toks, sig(toks, eq + 1) + 1)
            if eq >= n or toks[eq] != ("op", "="):
                continue
            j, depth, e4x = eq + 1, 0, False
            while j < n:
                kk, tt = toks[j]
                if kk == "op":
                    if tt in ("(", "[", "{"):
                        depth += 1
                    elif tt in (")", "]", "}"):
                        if depth == 0:
                            break
                        depth -= 1
                    elif tt in (";", ",") and depth == 0:
                        break
                    elif tt in (".@", "..", "@"):
                        e4x = True
                if kk == "nl" and depth == 0:
                    break
                j += 1
            if e4x and eq not in openers:
                openers[eq] = self.COERCE[types[t]]
                closers[j] = ")" + closers.get(j, "")
        return openers, closers

    def body(self, toks: list[Tok]) -> str:
        out: list[tuple[str, str]] = []
        obj_stack: list[bool] = []
        i = 0
        n = len(toks)

        def prev_sig(back: int = 1) -> tuple[str, str]:
            c = 0
            for kk, tt in reversed(out):
                if kk in ("ws", "nl", "comment"):
                    continue
                c += 1
                if c == back:
                    return kk, tt
            return ("", "")

        def next_sig(j: int) -> tuple[int, tuple[str, str]]:
            j = sig(toks, j)
            return j, (toks[j] if j < n else ("", ""))

        def wrap_left(fn: str, right: str) -> None:
            j = len(out) - 1
            while j >= 0 and out[j][0] in ("ws", "nl", "comment"):
                j -= 1
            end = j
            depth = 0
            while j >= 0:
                kk, tt = out[j]
                if kk == "op" and tt in (")", "]"):
                    depth += 1
                elif kk == "op" and tt in ("(", "["):
                    if depth == 0:
                        break
                    depth -= 1
                elif depth == 0:
                    if kk in ("ws", "nl", "comment"):
                        k2 = j - 1
                        while k2 >= 0 and out[k2][0] in ("ws", "nl", "comment"):
                            k2 -= 1
                        if k2 >= 0 and out[k2][1] in ("new",):
                            j = k2
                            continue
                        break
                    if kk == "op" and tt not in (".", "$"):
                        break
                    if kk == "id" and tt in KEYWORDS and tt not in ("this", "super", "new"):
                        break
                j -= 1
            start = j + 1
            left = "".join(t for _, t in out[start:end + 1])
            del out[start:]
            out.append(("id", f"{fn}({left}, {right})"))

        openers, closers = self.xml_coercions(toks)
        while i < n:
            k, t = toks[i]
            if i in closers:
                out.append(("op", closers.pop(i)))
            if i in openers:
                out.append((k, t))
                out.append(("id", " " + openers.pop(i)))
                i += 1
                continue
            if k == "comment":
                i += 1
                continue
            if k in ("ws", "nl"):
                out.append((k, t))
                i += 1
                continue
            p = prev_sig()
            after_dot = p == ("op", ".")
            if k == "xml":
                out.append(("id", f"$.XML({json.dumps(t)})"))
                i += 1
                continue
            if k == "op":
                if t == "{":
                    is_obj = p[1] in ("=", "(", ",", ":", "[", "return", "?", "||", "&&") or p == ("", "")
                    obj_stack.append(is_obj)
                elif t == "}":
                    if obj_stack:
                        obj_stack.pop()
                elif t == ".@":
                    j, (kk, tt) = next_sig(i + 1)
                    if tt == "[":
                        out.append(("op", "["))
                        out.append(("str", '"@"+'))
                        i = j + 1
                        continue
                    out.append(("op", f'["@{tt}"]'))
                    i = j + 1
                    continue
                elif t == "..":
                    j, (kk, tt) = next_sig(i + 1)
                    out.append(("op", f'.$descendants({json.dumps(tt)})'))
                    i = j + 1
                    continue
                elif t == "::":
                    out.append(("op", "."))
                    i += 1
                    continue
                elif t == "." and i + 1 < n and toks[sig(toks, i + 1)][1] == "(" and (
                        p[0] in EXPR_END or p[1] in EXPR_END_OPS or p[1].endswith((")", "]"))):
                    j = sig(toks, i + 1)
                    end = match_brace(toks, j, "(", ")")
                    self.e4x += 1
                    inner = self.body(toks[j + 1:end])
                    self.e4x -= 1
                    out.append(("op", f".$filter((__x) => ({inner}))"))
                    i = end + 1
                    continue
                elif t == "@" and self.e4x:
                    j, (kk, tt) = next_sig(i + 1)
                    out.append(("id", f'__x["@{tt}"]'))
                    i = j + 1
                    continue
                elif t == "<" and p == ("id", "new"):
                    depth = 0
                    j = i
                    while j < n:
                        if toks[j][1] == "<":
                            depth += 1
                        elif toks[j][1] == ">":
                            depth -= 1
                            if depth == 0:
                                break
                        elif toks[j][1] == ">>":
                            depth -= 2
                            if depth <= 0:
                                break
                        j += 1
                    while out and out[-1][0] in ("ws",):
                        out.pop()
                    if out and out[-1] == ("id", "new"):
                        out.pop()
                    i = j + 1
                    continue
                out.append((k, t))
                i += 1
                continue
            if k == "regex":
                t = js_regex(t)
            if k != "id":
                out.append((k, t))
                i += 1
                continue
            if after_dot:
                if prev_sig(2)[1] == "this" and self.inst.get(t) == "function" and prev_sig(3)[1] != ".":
                    _, (_, nxt) = next_sig(i + 1)
                    if nxt not in ("(", "=") and not (nxt.endswith("=") and nxt not in ("==", "===", "!=", "!==", "<=", ">=")):
                        while out and out[-1][0] in ("ws", "nl", "comment"):
                            out.pop()
                        out.pop()
                        while out and out[-1][0] in ("ws", "nl", "comment"):
                            out.pop()
                        out.pop()
                        out.append(("id", f"$.bind(this, {json.dumps(self.mname(t))})"))
                        i += 1
                        continue
                out.append(("id", self.mname(t) if prev_sig(2)[1] == "this" or t in self.mangle else esc(t, False)))
                i += 1
                continue
            if t in ("var", "const"):
                out.append(("id", "var"))
                j, (kk, name) = next_sig(i + 1)
                out.append(("ws", " "))
                out.append(("id", name))
                j2, (_, colon) = next_sig(j + 1)
                i = j + 1
                if colon == ":":
                    _, i = read_type(toks, j2 + 1)
                continue
            if t == "function":
                j, (kk, name) = next_sig(i + 1)
                head = "function"
                anon = kk != "id"
                if kk == "id":
                    head += " " + name
                    j, _ = next_sig(j + 1)
                pend = match_brace(toks, j, "(", ")")
                head = ("(" + self.strip_params(toks[j + 1:pend]) + ") =>") if anon else \
                    head + "(" + self.strip_params(toks[j + 1:pend]) + ")"
                j2, (_, colon) = next_sig(pend + 1)
                i = pend + 1
                if colon == ":":
                    _, i = read_type(toks, j2 + 1)
                out.append(("id", head))
                continue
            if t == "catch":
                j, (_, par) = next_sig(i + 1)
                if par == "(":
                    end = match_brace(toks, j, "(", ")")
                    jj = sig(toks, j + 1)
                    out.append(("id", f"catch({toks[jj][1]})"))
                    i = end + 1
                    continue
            if t in ("break", "continue"):
                out.append(("id", t))
                j, (kk, lbl) = next_sig(i + 1)
                if kk == "id" and lbl not in KEYWORDS:
                    out.append(("ws", " "))
                    out.append(("id", lbl))
                    i = j + 1
                    continue
                i += 1
                continue
            if t == "for":
                j, (_, nxt) = next_sig(i + 1)
                if nxt == "each":
                    j, _ = next_sig(j + 1)
                    pend = match_brace(toks, j, "(", ")")
                    inner = toks[j + 1:pend]
                    m = 0
                    decl = ""
                    m = sig(inner, m)
                    if inner[m][1] == "var":
                        decl = "var "
                        m = sig(inner, m + 1)
                    name = inner[m][1]
                    m = sig(inner, m + 1)
                    if inner[m][1] == ":":
                        _, m = read_type(inner, m + 1)
                        m = sig(inner, m)
                    expr = self.body(inner[m + 1:])
                    target = name if decl or name in self.locals else self.resolve_lvalue(name)
                    out.append(("id", f"for ({decl}{target} of $.values({expr.strip()}))"))
                    i = pend + 1
                    continue
                out.append(("id", "for"))
                i += 1
                continue
            if t in ("is", "as") and (p[0] in EXPR_END or p[1] in EXPR_END_OPS):
                typ, j = read_type(toks, i + 1)
                wrap_left("$.is" if t == "is" else "$.as", self.type_ref(typ))
                i = j
                continue
            if t == "new":
                j, (kk, name) = next_sig(i + 1)
                if kk == "id" and name == "Vector":
                    typ, j2 = read_type(toks, j)
                    out.append(("id", "new $.Vector"))
                    i = j2
                    continue
                if kk == "id" and name not in self.locals and name not in self.inst:
                    typ, j2 = read_type(toks, j)
                    fqn = self.class_fqn(typ)
                    if fqn:
                        out.append(("id", f"new ({self.class_ref(fqn)})"))
                        i = j2
                        continue
                out.append(("id", "new"))
                i += 1
                continue
            if t == "Vector":
                j, (_, nxt) = next_sig(i + 1)
                if nxt == "." and j + 1 < n and toks[j + 1][1] == "<":
                    _, j2 = read_type(toks, i)
                    out.append(("id", "$.Vector"))
                    i = j2
                    continue
            if t in KEYWORDS and t not in ("get", "set", "each", "is", "as", "namespace", "include", "dynamic", "native",
                                           "final", "override", "internal"):
                out.append(("id", t))
                i += 1
                continue
            j, (_, nxt) = next_sig(i + 1)
            if nxt == ":" and obj_stack and obj_stack[-1] and p[1] in ("{", ","):
                out.append(("id", t))
                i += 1
                continue
            if nxt == ":" and p[1] in (";", "{", "}", "") and not (obj_stack and obj_stack[-1]):
                out.append(("id", t))
                i += 1
                continue
            if self.e4x and t not in self.locals and t not in self.inst and not self.class_fqn(t) and t not in JS_GLOBALS:
                out.append(("id", f"__x.{t}"))
                i += 1
                continue
            r = self.resolve(t, call=(nxt == "("))
            if r.startswith("$.g(") and nxt == "=":
                r = "this." + t
            out.append(("id", r))
            i += 1
        return "".join(tt for _, tt in out)

    def resolve_lvalue(self, name: str) -> str:
        return self.resolve(name, call=False, bind=False)

    def resolve(self, name: str, call: bool, bind: bool = True) -> str:
        if name in self.locals or name in JS_GLOBALS:
            return name
        if name in self.inst:
            kind = self.inst[name]
            if kind == "function" and not call and bind:
                return f"$.bind(this, {json.dumps(self.mname(name))})"
            return "this." + self.mname(name)
        if name in self.stat_own:
            return f"{self.class_alias}.{esc(name, False)}"
        if name in self.stat_anc:
            return f"{self.class_ref(self.stat_anc[name])}.{esc(name, False)}"
        fqn = self.class_fqn(name)
        if fqn:
            return self.class_ref(fqn)
        if name in RT_GLOBALS:
            return RT_GLOBALS[name]
        self.warnings.append(name)
        return f"$.g({json.dumps(name)}, this)"

    @property
    def class_alias(self) -> str:
        return "__" + re.sub(r"\W", "_", self.cls.name)

    def default_for(self, m: Member) -> str:
        if m.init:
            return self.body(m.init).strip()
        return NUMERIC_TYPES.get(m.type, "undefined" if m.type == "*" else "null")

    def emit(self) -> str:
        c = self.cls
        alias = self.class_alias
        base_fqn = self.info.get("extends")
        lines = ["// @ts-nocheck", "export default function define($) {"]
        if c.kind == "interface":
            lines.append(f"  return $.interface({json.dumps(self.fqn)}, {json.dumps(sorted(set(c.implements)))});")
            lines.append("}")
            return "\n".join(lines) + "\n"
        base_expr = self.class_ref(base_fqn) if base_fqn else "$.Object"
        lines.append(f"  const __Base = {base_expr};")
        lines.append(f"  class {alias} extends __Base {{")
        inits = []
        for m in c.members:
            if m.kind in ("var", "const") and not m.static:
                self.locals = set()
                inits.append(f"    self.{self.mname(m.name)} = {re.sub(r'(?<![\w$.])this(?![\w$])', 'self', self.default_for(m))};")
        lines.append("    static $fields(self) {")
        lines += inits
        lines.append("    }")
        simple = c.name.split("$$")[-1]
        ctor = next((m for m in c.members if m.kind == "function" and m.name == simple and not m.static), None)
        for m in c.members:
            if m.kind in ("var", "const"):
                continue
            self.locals = self.collect_locals(m.body, m.params)
            params = self.strip_params(m.params)
            body = self.body(m.body)
            static = "static " if m.static else ""
            coerce = self.param_coercions(m.params) if m.kind in ("function", "set") else ""
            if coerce and m is not ctor:
                body = coerce + body
            if m is ctor:
                body = hoist_pre_super(fix_super_this(body))
                if "super(" not in body.split("\n", 6)[0:6].__str__() and "super(" not in body:
                    body = "\n      super();" + body
                lines.append(f"    constructor({params}) {{{body}}}")
            elif m.kind in ("get", "set"):
                lines.append(f"    {static}{m.kind} {esc(m.name, False) if m.static else self.mname(m.name)}({params}) {{{body}}}")
            else:
                name = (esc(m.name, False) if m.static else self.mname(m.name)) if m.name not in ("constructor",) else "$constructor"
                lines.append(f"    {static}{name}({params}) {{{body}}}")
        acc: dict[tuple[str, bool], set[str]] = {}
        for m in c.members:
            if m.kind in ("get", "set"):
                acc.setdefault((m.name, m.static), set()).add(m.kind)
        for (name, static), kinds in acc.items():
            if c.kind == "function":
                continue
            js = esc(name, False) if static else self.mname(name)
            st = "static " if static else ""
            if kinds == {"get"}:
                lines.append(f"    {st}set {js}(v) {{ super.{js} = v; }}")
            elif kinds == {"set"}:
                lines.append(f"    {st}get {js}() {{ return super.{js}; }}")
        if ctor is None:
            lines.append("    constructor(...a) { super(...a); }")
        lines.append("  }")
        if c.kind == "function":
            lines.append(f"  const __fn = {alias}.__fn;")
            lines.append(f"  Object.defineProperty(__fn, '__fqn', {{ value: {json.dumps(self.fqn)} }});")
            lines.append("  return __fn;")
            lines.append("}")
            lines.append(f"export const deps = {json.dumps(sorted(self.deps - {self.fqn}))};")
            return "\n".join(lines) + "\n"
        lines.append(f"  $.meta({alias}, {json.dumps(self.fqn)}, {json.dumps(sorted(set(c.implements)))});")
        stat_inits = []
        for m in c.members:
            if m.kind in ("var", "const") and m.static:
                self.locals = set()
                stat_inits.append(f"    {alias}.{esc(m.name, False)} = {self.default_for(m)};")
        if stat_inits:
            lines.append(f"  $.statics({alias}, () => {{")
            lines += stat_inits
            lines.append("  });")
        lines.append(f"  return {alias};")
        lines.append("}")
        lines.append(f"export const deps = {json.dumps(sorted(self.deps - {self.fqn}))};")
        return "\n".join(lines) + "\n"


FLASH_NAMES: dict[str, set[str]] = {
    "flash.display": {"Sprite", "MovieClip", "Shape", "Bitmap", "BitmapData", "DisplayObject", "DisplayObjectContainer",
                      "InteractiveObject", "SimpleButton", "Stage", "Loader", "LoaderInfo", "Graphics", "FrameLabel",
                      "BlendMode", "StageAlign", "StageScaleMode", "PixelSnapping", "GradientType", "SpreadMethod",
                      "LineScaleMode", "CapsStyle", "JointStyle", "Scene", "IBitmapDrawable", "StageQuality",
                      "InterpolationMethod", "StageDisplayState", "BitmapDataChannel"},
    "flash.events": {"Event", "MouseEvent", "KeyboardEvent", "TimerEvent", "IOErrorEvent", "SecurityErrorEvent",
                     "ProgressEvent", "TextEvent", "FocusEvent", "ErrorEvent", "EventDispatcher", "IEventDispatcher",
                     "HTTPStatusEvent", "NetStatusEvent", "AsyncErrorEvent", "ContextMenuEvent", "StatusEvent", "DataEvent",
                     "EventPhase", "FullScreenEvent", "UncaughtErrorEvent", "ActivityEvent"},
    "flash.text": {"TextField", "TextFormat", "TextFieldAutoSize", "TextFieldType", "TextFormatAlign", "Font",
                   "StyleSheet", "AntiAliasType", "GridFitType", "TextLineMetrics", "TextColorType", "FontStyle", "FontType"},
    "flash.geom": {"Point", "Rectangle", "Matrix", "ColorTransform", "Transform", "Matrix3D", "Vector3D", "PerspectiveProjection"},
    "flash.utils": {"ByteArray", "Dictionary", "Timer", "Endian", "Proxy", "IDataInput", "IDataOutput",
                    "IExternalizable", "CompressionAlgorithm"},
    "flash.net": {"URLRequest", "URLLoader", "URLVariables", "URLRequestMethod", "URLLoaderDataFormat", "Socket",
                  "SharedObject", "NetConnection", "Responder", "URLRequestHeader", "XMLSocket", "FileReference",
                  "FileFilter", "ObjectEncoding", "LocalConnection", "registerClassAlias"},
    "flash.filters": {"GlowFilter", "DropShadowFilter", "BlurFilter", "ColorMatrixFilter", "BevelFilter",
                      "GradientGlowFilter", "GradientBevelFilter", "ConvolutionFilter", "BitmapFilter", "BitmapFilterQuality",
                      "BitmapFilterType", "DisplacementMapFilter", "ShaderFilter"},
    "flash.media": {"Sound", "SoundChannel", "SoundTransform", "SoundMixer", "SoundLoaderContext", "Video", "Camera",
                    "Microphone"},
    "flash.system": {"ApplicationDomain", "LoaderContext", "Security", "System", "Capabilities", "SecurityDomain",
                     "IME", "fscommand"},
    "flash.ui": {"Keyboard", "Mouse", "MouseCursor", "ContextMenu", "ContextMenuItem", "Multitouch"},
    "flash.errors": {"IllegalOperationError", "IOError", "EOFError", "MemoryError", "StackOverflowError", "ScriptTimeoutError"},
    "flash.external": {"ExternalInterface"},
}
