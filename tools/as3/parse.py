from __future__ import annotations

from dataclasses import dataclass, field

from lexer import tokenize

Tok = tuple[str, str]
MODIFIERS = {"public", "private", "protected", "internal", "static", "override", "final", "dynamic", "native"}


@dataclass
class Member:
    kind: str
    name: str
    static: bool = False
    params: list[Tok] = field(default_factory=list)
    body: list[Tok] = field(default_factory=list)
    init: list[Tok] = field(default_factory=list)
    type: str = ""
    private: bool = False


@dataclass
class ClassDef:
    name: str
    package: str
    kind: str = "class"
    extends: str | None = None
    implements: list[str] = field(default_factory=list)
    members: list[Member] = field(default_factory=list)
    imports: dict[str, str] = field(default_factory=dict)
    in_package: bool = True

    @property
    def fqn(self) -> str:
        return f"{self.package}.{self.name}" if self.package else self.name


def sig(tokens: list[Tok], i: int) -> int:
    while i < len(tokens) and tokens[i][0] in ("ws", "nl", "comment"):
        i += 1
    return i


def match_brace(tokens: list[Tok], i: int, open_: str, close: str) -> int:
    depth = 0
    for j in range(i, len(tokens)):
        k, t = tokens[j]
        if k == "op":
            if t == open_:
                depth += 1
            elif t == close:
                depth -= 1
                if depth == 0:
                    return j
    return len(tokens) - 1


def read_type(tokens: list[Tok], i: int) -> tuple[str, int]:
    i = sig(tokens, i)
    parts = []
    while i < len(tokens):
        k, t = tokens[i]
        if k == "id" or (k == "op" and t in (".", "*")):
            parts.append(t)
            i += 1
        elif k == "op" and t == ".<":
            parts.append(t)
            i += 1
        elif k == "op" and t == "<" and parts and parts[-1] == ".":
            depth = 1
            parts.append("<")
            i += 1
            while i < len(tokens) and depth:
                if tokens[i][1] == "<":
                    depth += 1
                elif tokens[i][1] == ">":
                    depth -= 1
                elif tokens[i][1] == ">>":
                    depth -= 2
                parts.append(tokens[i][1])
                i += 1
        else:
            break
    return "".join(parts), i


def parse_file(src: str) -> list[ClassDef]:
    tokens = tokenize(src)
    classes: list[ClassDef] = []
    imports: dict[str, str] = {}
    package = ""
    i = 0
    pkg_depth = None
    depth = 0
    while i < len(tokens):
        k, t = tokens[i]
        if k == "id" and t == "package":
            j = sig(tokens, i + 1)
            name = []
            while j < len(tokens) and (tokens[j][0] == "id" or tokens[j][1] == "."):
                name.append(tokens[j][1])
                j += 1
            package = "".join(name)
            j = sig(tokens, j)
            pkg_depth = depth
            depth += 1
            i = j + 1
            continue
        if k == "id" and t == "import":
            j = sig(tokens, i + 1)
            name = []
            while j < len(tokens) and (tokens[j][0] == "id" or tokens[j][1] in (".", "*")):
                name.append(tokens[j][1])
                j += 1
            fq = "".join(name)
            if fq.endswith(".*"):
                imports.setdefault("*", "")
                imports["*"] = (imports["*"] + "," + fq[:-2]).strip(",")
            else:
                imports[fq.rsplit(".", 1)[-1]] = fq
            i = j
            continue
        if k == "op" and t == "}":
            depth -= 1
            i += 1
            continue
        if k == "id" and t in ("class", "interface"):
            cls, i = parse_class(tokens, i, package if depth > 0 else "", t)
            cls.imports = dict(imports)
            cls.in_package = depth > 0
            classes.append(cls)
            continue
        if k == "op" and t == "[":
            i = match_brace(tokens, i, "[", "]") + 1
            continue
        if k == "id" and t == "function" and depth == 1 and pkg_depth == 0:
            j = sig(tokens, i + 1)
            fname = tokens[j][1]
            p0 = sig(tokens, j + 1)
            p1 = match_brace(tokens, p0, "(", ")")
            b0 = p1 + 1
            while b0 < len(tokens) and tokens[b0][1] != "{":
                b0 += 1
            b1 = match_brace(tokens, b0, "{", "}")
            cls = ClassDef(name=fname, package=package, kind="function")
            cls.members.append(Member(name="__fn", kind="function", static=True, params=tokens[p0 + 1:p1], body=tokens[b0 + 1:b1]))
            cls.imports = dict(imports)
            classes.append(cls)
            i = b1 + 1
            continue
        i += 1
    return classes


def parse_class(tokens: list[Tok], i: int, package: str, kind: str) -> tuple[ClassDef, int]:
    j = sig(tokens, i + 1)
    cls = ClassDef(name=tokens[j][1], package=package, kind=kind)
    j += 1
    while True:
        j = sig(tokens, j)
        k, t = tokens[j]
        if k == "op" and t == "{":
            break
        if k == "id" and t == "extends":
            name, j = read_type(tokens, j + 1)
            if kind == "interface":
                cls.implements.append(name)
                while sig(tokens, j) < len(tokens) and tokens[sig(tokens, j)][1] == ",":
                    name, j = read_type(tokens, sig(tokens, j) + 1)
                    cls.implements.append(name)
            else:
                cls.extends = name
            continue
        if k == "id" and t == "implements":
            name, j = read_type(tokens, j + 1)
            cls.implements.append(name)
            while tokens[sig(tokens, j)][1] == ",":
                name, j = read_type(tokens, sig(tokens, j) + 1)
                cls.implements.append(name)
            continue
        j += 1
    end = match_brace(tokens, j, "{", "}")
    parse_members(cls, tokens, j + 1, end)
    return cls, end + 1


def parse_members(cls: ClassDef, tokens: list[Tok], i: int, end: int) -> None:
    mods: set[str] = set()
    while i < end:
        i = sig(tokens, i)
        if i >= end:
            break
        k, t = tokens[i]
        if k == "op" and t == "[":
            i = match_brace(tokens, i, "[", "]") + 1
            continue
        if k == "id" and t in MODIFIERS:
            mods.add(t)
            i += 1
            continue
        if k == "id" and t in ("var", "const"):
            j = sig(tokens, i + 1)
            name = tokens[j][1]
            j = sig(tokens, j + 1)
            typ = ""
            if tokens[j][1] == ":":
                typ, j = read_type(tokens, j + 1)
                j = sig(tokens, j)
            init: list[Tok] = []
            if tokens[j][1] == "=":
                j += 1
                start = j
                d = 0
                while j < end:
                    kk, tt = tokens[j]
                    if kk == "op" and tt in "([{":
                        d += 1
                    elif kk == "op" and tt in ")]}":
                        d -= 1
                    elif kk == "op" and tt == ";" and d == 0:
                        break
                    j += 1
                init = tokens[start:j]
            cls.members.append(Member(kind=t, name=name, static="static" in mods, init=init, type=typ, private="private" in mods))
            mods = set()
            i = j + 1
            continue
        if k == "id" and t == "function":
            j = sig(tokens, i + 1)
            fkind = "function"
            if tokens[j][1] in ("get", "set") and tokens[sig(tokens, j + 1)][0] == "id":
                fkind = tokens[j][1]
                j = sig(tokens, j + 1)
            name = tokens[j][1]
            j = sig(tokens, j + 1)
            pend = match_brace(tokens, j, "(", ")")
            params = tokens[j + 1:pend]
            j = sig(tokens, pend + 1)
            typ = ""
            if tokens[j][1] == ":":
                typ, j = read_type(tokens, j + 1)
                j = sig(tokens, j)
            body: list[Tok] = []
            if tokens[j][1] == "{":
                bend = match_brace(tokens, j, "{", "}")
                body = tokens[j + 1:bend]
                j = bend + 1
            else:
                j += 1
            cls.members.append(Member(kind=fkind, name=name, static="static" in mods, params=params, body=body, type=typ, private="private" in mods))
            mods = set()
            i = j
            continue
        if k == "id" and t in ("namespace", "use"):
            while i < end and tokens[i][1] != ";":
                i += 1
            i += 1
            mods = set()
            continue
        i += 1
