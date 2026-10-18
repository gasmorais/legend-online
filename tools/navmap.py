#!/usr/bin/env python3
from __future__ import annotations

import csv
import json
import pathlib
import re
import sys
import xml.etree.ElementTree as ET
from collections import defaultdict

ROOT = pathlib.Path(__file__).resolve().parent.parent
DEC = ROOT / "decompiled"
OUT = ROOT / "data" / "navigation.json"

MAX_DEPTH = 3
SUB_DEPTH = 2
MAX_MANAGER_LISTENS = 60

SKIP_CLASSES = {
    "SoundManager", "MessageTipManager", "LanguageMgr", "ComponentFactory", "LayerManager", "ObjectUtils",
    "TweenMax", "TweenLite", "StageReferance", "SharedManager", "LoadingSceneView", "ShowTipManager",
    "CursorManagerII", "ComponentSetting", "Math", "String", "int", "uint", "Number", "Array", "Dictionary",
    "DisplayUtils", "DateUtils", "ExternalInterface", "TempleteManager", "KeyboardManager", "Vector",
    "PathManager", "LoaderManagerII", "UIModuleLoader", "NotificationManager", "MsgMan", "SocketManager",
    "TimeManager", "StringHelper", "ConfigManager", "Point", "Rectangle", "Sprite", "Bitmap", "MovieClip",
    "Event", "MouseEvent", "Timer", "XML", "JSON", "Object", "Boolean", "Date", "RegExp", "setTimeout",
    "clearTimeout", "ArrayUtils", "Tween", "SimpleAlertHelper", "AlertManager", "FilterFrameText",
    "TextField", "BitmapData", "FrameControllerManager", "SceneManager", "ColorMatrixFilter",
    "GlowFilter", "Matrix", "ByteArray", "Loader", "URLRequest", "URLLoader", "SimpleAlert", "TipManager",
    "BaseAlerFrame", "Logger", "Log", "trace", "getTimer", "describeType", "getDefinitionByName",
}
NOFOLLOW_EVENTS = {
    "click", "mouseOver", "mouseOut", "rollOver", "rollOut", "mouseDown", "mouseUp", "keyDown", "keyUp",
    "change", "select", "enterFrame", "timer", "timerComplete", "mouseMove", "doubleClick", "mouseWheel",
    "focusIn", "focusOut", "textInput", "removedFromStage", "dispose", "resize",
}
FOLLOW_EVENT = re.compile(r"complete|Complete|COMPLETE|loaded|Loaded|LOADED|addedToStage|ADDED")
GUARD_HINT = re.compile(r"grades|Grade|level|Level|vocation|VersionSwitch|isOpen|Open|ConfigManager|consortia|Consortia|vip|Vip|VIP|isChangeJob|hasTeam|switch|Switch")

HUD_VIEWS = [
    ("castle_hud", "mainBar.SmallMapBar"),
    ("castle_hud", "ui.maintoolbar.MainToolBar"),
    ("castle_hud", "ui.toptoolbar.TopToolsBar"),
    ("castle_hud", "ui.resourcebar.ResourcesBar"),
    ("castle_hud", "ui.resourcebar.view.ResourceView"),
    ("castle_hud", "ui.tasktracebar.TaskTraceBar"),
    ("castle_hud", "ui.queuebar.QueueBar"),
    ("castle_hud", "mainBar.ChatBar"),
    ("castle_hud", "mainBar.TimeBoxView"),
    ("castle_hud", "mainBar.TipsBar"),
    ("castle_hud", "mainBar.FullBar"),
    ("castle_hud", "mainBar.view.MessageBtnListView"),
    ("castle_hud", "mainBar.view.MessageBtnView"),
    ("castle_hud", "ui.toptoolbar.view.TopBtnActiveBoxView"),
    ("castle_hud", "ui.toptoolbar.view.TimeActiveBoxView"),
    ("castle_hud", "ui.toptoolbar.view.TargetSelectView"),
    ("castle_hud", "ui.tasktracebar.view.TaskTraceView"),
    ("castle_hud", "ui.tasktracebar.view.TaskTraceItem"),
    ("castle_hud", "ui.tasktracebar.view.SelfHelpButtonView"),
    ("castle_hud", "ui.tasktracebar.view.SpaceMapButtonView"),
    ("castle_hud", "ui.tasktracebar.view.NewbieTaskTraceView"),
    ("castle_hud", "ui.resourcebar.view.ChildrenFigureView"),
    ("castle_hud", "ui.toptoolbar.TopBtnItemView"),
    ("castle_scene", "castle.CastleSceneView"),
    ("castle_scene", "castle.view.CastleBuildingView"),
    ("castle_scene", "castle.view.CastleNPCView"),
    ("castle_scene", "castle.view.CastleMapViewII"),
]
HUD_SET = {f for _, f in HUD_VIEWS}
DISPATCH = [
    ("castle_hud", "ui.toptoolbar.TopToolsBar", "__onTopBtnClickHandler", "ui.toptoolbar.TopToolsBar.tipData_{}"),
    ("castle_scene", "castle.view.CastleBuildingView", "mouseClickHandler", None),
    ("castle_hud", "ui.queuebar.QueueBar", "__itemClickHandler", None),
]
EXTRA_ROOTS = [
    ("space", "scene", "SPACE_SCENE"),
    ("world_map", "scene", "OUTER_CITY_SCENE"),
    ("campaign", "scene", "CAMPAIGN_MAP_SCENE"),
    ("castle", "scene", "CASTLE_SCENE"),
    ("rooms", "scene", "PVE_ROOM_SCENE"),
    ("rooms", "scene", "PVP_ROOM_SCENE"),
    ("arena", "scene", "CHANLLENGE_ROOM_SCENE"),
    ("world_map", "controller", "worldmap"),
    ("campaign", "controller", "selectcampaign"),
    ("rooms", "controller", "pveroomlist"),
    ("rooms", "controller", "pvproomlist"),
    ("arena", "controller", "colosseum"),
    ("bag", "controller", "army", "EQUIP_PANEL"),
    ("hero", "controller", "army", "ATTRIBUTE_PANEL"),
    ("skills", "controller", "army", "SKILL_PANEL"),
    ("shop", "controller", "shop"),
    ("mail", "controller", "email", "email.EmailFrame"),
    ("friends", "controller", "friends"),
    ("guild", "controller", "consortia"),
    ("tasks", "controller", "task"),
]


def load_json(path: pathlib.Path, default):
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return default


LANG = load_json(ROOT / "index/language.json", {})
STYLES = load_json(ROOT / "index/styles.json", {})
SCREENS = {s["class"]: s for s in load_json(ROOT / "index/screens.json", {"screens": []}).get("screens", [])}
CONTROLLERS = load_json(ROOT / "web/public/layout/controllers.json", {})
PROTO = load_json(ROOT / "protocol/proto.json", {})
OPNAME: dict[tuple[str, int], str] = {}
with open(ROOT / "protocol/opcodes.csv", newline="") as fh:
    for row in csv.DictReader(fh):
        OPNAME[(row["dir"], int(row["code"]))] = row["name"]
DERIVED: dict[tuple[str, int], str] = {}
for e in load_json(ROOT / "data/derived/opcode_messages.json", []):
    DERIVED.setdefault((e["direction"], e["code"]), e["message"])

FILES: dict[str, pathlib.Path] = {}
MODULE: dict[str, str] = {}
SIMPLE: dict[str, list[str]] = defaultdict(list)
for mod in sorted(DEC.iterdir()):
    sd = mod / "scripts"
    if not sd.is_dir():
        continue
    for p in sorted(sd.rglob("*.as")):
        fqn = ".".join(p.relative_to(sd).with_suffix("").parts)
        if fqn in FILES:
            continue
        FILES[fqn] = p
        MODULE[fqn] = mod.name
        SIMPLE[p.stem].append(fqn)

METHOD_RE = re.compile(r"\n([ \t]*)((?:override\s+)?(?:public|protected|private|internal)(?:\s+static)?(?:\s+override)?\s+function\s+(get\s+|set\s+)?(\w+)\s*\(([^)]*)\)[^{;]*)\{")
FIELD_RE = re.compile(r"(?:public|private|protected|internal)(?:\s+static)?\s+(?:var|const)\s+(\w+)\s*:\s*([\w.*]+)")
CONST_RE = re.compile(r"static\s+(?:var|const)\s+(\w+)\s*:\s*\w+\s*=\s*(\"[^\"]*\"|-?\d+)")


class Cls:
    cache: dict[str, "Cls"] = {}

    def __init__(self, fqn: str):
        self.fqn = fqn
        self.path = FILES[fqn]
        self.module = MODULE[fqn]
        self.text = self.path.read_text(encoding="utf-8", errors="replace")
        self.name = fqn.rsplit(".", 1)[-1]
        self.package = fqn.rsplit(".", 1)[0] if "." in fqn else ""
        self.imports = {i.rsplit(".", 1)[-1]: i for i in re.findall(r"^\s*import\s+([\w.]+);", self.text, re.M)}
        m = re.search(r"class\s+\w+\s+extends\s+([\w.]+)", self.text)
        self.extends = m.group(1).rsplit(".", 1)[-1] if m else None
        self.fields = {n: t.rsplit(".", 1)[-1] for n, t in FIELD_RE.findall(self.text)}
        self.consts = {n: v.strip('"') for n, v in CONST_RE.findall(self.text)}
        self.methods: dict[str, str] = {}
        self.method_line: dict[str, int] = {}
        for mm in METHOD_RE.finditer(self.text):
            indent = mm.group(1)
            end = self.text.find("\n" + indent + "}", mm.end())
            if end < 0:
                end = len(self.text)
            key = ("get " if (mm.group(3) or "").startswith("get") else "set " if (mm.group(3) or "").startswith("set") else "") + mm.group(4)
            if key in self.methods:
                continue
            self.methods[key] = self.text[mm.start() + 1:end + len(indent) + 2]
            self.method_line[key] = self.text.count("\n", 0, mm.start() + 1) + 1

    @classmethod
    def get(cls, fqn: str | None) -> "Cls | None":
        if not fqn or fqn not in FILES:
            return None
        if fqn not in cls.cache:
            cls.cache[fqn] = Cls(fqn)
        return cls.cache[fqn]

    def resolve(self, simple: str) -> str | None:
        if simple in self.imports and self.imports[simple] in FILES:
            return self.imports[simple]
        if simple == self.name:
            return self.fqn
        cand = f"{self.package}.{simple}" if self.package else simple
        if cand in FILES:
            return cand
        hits = SIMPLE.get(simple, [])
        if len(hits) == 1:
            return hits[0]
        for h in hits:
            if MODULE[h] == self.module:
                return h
        return hits[0] if hits else None

    def parent(self) -> "Cls | None":
        return Cls.get(self.resolve(self.extends)) if self.extends else None

    def find_method(self, name: str) -> tuple["Cls", str] | None:
        c: Cls | None = self
        for _ in range(8):
            if c is None:
                return None
            if name in c.methods:
                return c, name
            c = c.parent()
        return None

    def field_type(self, name: str) -> str | None:
        c: Cls | None = self
        for _ in range(8):
            if c is None:
                return None
            if name in c.fields:
                return c.fields[name]
            c = c.parent()
        return None

    def ref(self, method: str | None = None) -> str:
        line = self.method_line.get(method, 1) if method else 1
        return f"{self.path.relative_to(ROOT)}:{line}"


def tr(key: str | None) -> str | None:
    if not key:
        return None
    return LANG.get(key)


def opname(direction: str, code: int) -> str:
    return OPNAME.get((direction, code), "?")


def first_proto_msg(body: str) -> str | None:
    for name in re.findall(r"new\s+(\w+)\s*\(", body):
        if name in PROTO:
            return name
    for name in re.findall(r"\bas\s+(\w+)", body):
        if name in PROTO:
            return name
    for name in re.findall(r":\s*(\w+)\s*=", body):
        if name in PROTO:
            return name
    return None


SEND_INDEX: dict[tuple[str, str], list[dict]] = {}
SEND_BY_NAME: dict[str, list[tuple[str, str]]] = defaultdict(list)


MANAGER_REFS: dict[str, int] = defaultdict(int)
GLOBAL_REFS = 150


def build_send_index() -> None:
    for fqn, path in FILES.items():
        try:
            raw = path.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        for n in set(re.findall(r"\b([A-Z]\w*Manager)\.(?:instance|Instance|getInstance\(\))", raw)):
            MANAGER_REFS[n] += 1
        if "new PackageOut(" not in raw:
            continue
        c = Cls.get(fqn)
        for mname, body in c.methods.items():
            codes = [int(x) for x in re.findall(r"new\s+PackageOut\(\s*(\d+)\s*\)", body)]
            if not codes:
                continue
            msg = first_proto_msg(body)
            items = []
            for code in dict.fromkeys(codes):
                m = msg or DERIVED.get(("send", code))
                items.append({"code": code, "name": opname("send", code), "msg": m})
            SEND_INDEX[(fqn, mname)] = items
            SEND_BY_NAME[mname].append((fqn, mname))


def class_listens(c: Cls) -> list[dict]:
    out = []
    seen = set()
    pairs = re.findall(r'addEventListener\(\s*"SLGSocketEvent"\s*\+\s*(\d+)\s*,\s*(\w+)', c.text)
    pairs += re.findall(r'\.listener\(\s*(\d+)\s*,\s*(\w+)', c.text)
    for code, handler in pairs:
        code = int(code)
        if (code, handler) in seen:
            continue
        seen.add((code, handler))
        body = c.methods.get(handler, "")
        msg = None
        m = re.search(r"readBody\(\s*new\s+(\w+)\s*\(", body)
        if m and m.group(1) in PROTO:
            msg = m.group(1)
        if not msg and "readBody" in body:
            msg = first_proto_msg(body)
        if not msg:
            msg = DERIVED.get(("accept", code))
        out.append({"code": code, "name": opname("accept", code), "msg": msg, "handler": handler, "class": c.fqn, "ref": c.ref(handler) if handler in c.methods else c.ref()})
    return out


SCENE_CLASS: dict[str, str] = {}
FCM_GETTERS: dict[str, str] = {}


def build_scene_and_fcm() -> None:
    sc = Cls.get("yishi.scene.SceneCreate")
    if sc:
        for scene, cls in re.findall(r'case\s+"(\w+)":\s*\n\s*return\s+"([\w.]+)"', sc.text):
            SCENE_CLASS.setdefault(scene, cls)
        for scene, cls in re.findall(r'case\s+"(\w+)":\s*\n\s*return\s+new\s+(\w+)\(', sc.text):
            fq = sc.resolve(cls)
            if fq:
                SCENE_CLASS.setdefault(scene, fq)
    fcm = Cls.get("yishi.manager.FrameControllerManager")
    if fcm:
        for name, typ in re.findall(r"public function get (\w+)\(\)\s*:\s*(\w+)", fcm.text):
            fq = fcm.resolve(typ)
            if fq:
                FCM_GETTERS[name] = fq


def style_class(style: str) -> str | None:
    s = STYLES.get(style)
    if isinstance(s, dict):
        cn = s.get("attrs", {}).get("classname")
        if cn:
            return cn
    return style if style in FILES else None


def controller_fqn(simple: str | None) -> str | None:
    if not simple:
        return None
    fcm = Cls.get("yishi.manager.FrameControllerManager")
    if fcm:
        r = fcm.resolve(simple)
        if r:
            return r
    hits = SIMPLE.get(simple, [])
    return hits[0] if hits else None


def resolve_value(c: Cls, expr: str) -> str | None:
    expr = expr.strip()
    if re.fullmatch(r"(?:param\d+|_loc\d+_|[a-z_]\w*)", expr) and expr not in ("true", "false", "null"):
        return None
    m = re.fullmatch(r'"([^"]*)"', expr)
    if m:
        return m.group(1)
    m = re.fullmatch(r"(\w+)\.(\w+)", expr)
    if m:
        tc = Cls.get(c.resolve(m.group(1)))
        if tc and m.group(2) in tc.consts:
            return tc.consts[m.group(2)]
        return m.group(2)
    return expr


OWN_FRAMES: dict[str, dict] = {}


def own_frames(ctrl_simple: str | None) -> dict:
    if not ctrl_simple:
        return {}
    if ctrl_simple in OWN_FRAMES:
        return OWN_FRAMES[ctrl_simple]
    out: dict = {}
    OWN_FRAMES[ctrl_simple] = out
    c = Cls.get(controller_fqn(ctrl_simple))
    body = c.methods.get("get frameClassName") if c else None
    if not body:
        return out
    if re.search(r"^\s*switch\s*\(", body, re.M):
        for labels, seg in switch_segments(body):
            r = re.search(r'return\s+"([\w.]+)"', seg)
            if not r:
                continue
            for lab in labels:
                if lab == "default":
                    out["frame"] = r.group(1)
                else:
                    out.setdefault("byType", {})[lab] = r.group(1)
        return out
    lines = body.splitlines()
    base = None
    cond = None
    by_type: dict[str, str] = {}
    conditional: list[dict] = []
    default = None
    for line in lines[1:]:
        st = line.strip()
        if not st or st in ("{", "}"):
            continue
        ind = len(line) - len(line.lstrip())
        if base is None:
            base = ind
        m = re.match(r"(?:else\s+)?if\s*\((.*)\)\s*$", st)
        if m and ind == base:
            cond = m.group(1)
            continue
        r = re.search(r'return\s+"([\w.]+)"', st)
        if not r:
            continue
        if ind > base and cond:
            keys = [a or b or d for a, b, d in re.findall(r'==\s*(?:"([^"]+)"|[\w]+\.(\w+)|(-?\d+))', cond)]
            if keys and re.search(r"openType|currentOpenPanel|_type|Type", cond):
                for k in keys:
                    by_type.setdefault(k, r.group(1))
            else:
                conditional.append({"when": cond, "frame": r.group(1)})
        elif ind == base:
            default = r.group(1)
            cond = None
    if default:
        out["frame"] = default
    if by_type:
        out["byType"] = by_type
    if conditional:
        out["conditional"] = conditional
    return out


BUILDING_CASES: dict[str, str] = {}


def building_cases() -> dict[str, str]:
    if BUILDING_CASES:
        return BUILDING_CASES
    bc = Cls.get("mvc.controler.BuildingControler")
    if bc and "getModelNameByInfo" in bc.methods:
        for labels, seg in switch_segments(bc.methods["getModelNameByInfo"]):
            r = re.search(r'return\s+"([^"]+)"', seg)
            if r:
                BUILDING_CASES.setdefault(r.group(1), labels[0])
    return BUILDING_CASES


def frame_for(key: str | None, ctrl_simple: str | None, arg: str | None) -> str | None:
    info = CONTROLLERS.get(key) if key else None
    if info is None and ctrl_simple:
        for v in CONTROLLERS.values():
            if v.get("controller") == ctrl_simple:
                info = v
                break
    if info and info.get("controller") == "BuildingControler" and key:
        case = building_cases().get(key)
        fr = own_frames("BuildingControler").get("byType", {}).get(case) if case else None
        if fr:
            return fr
    if info:
        own = own_frames(info.get("controller"))
        if own.get("frame") or own.get("byType"):
            info = {"controller": info.get("controller"), "frame": own.get("frame") or info.get("frame"), "byType": {**info.get("byType", {}), **own.get("byType", {})}}
    if not info:
        return arg if arg and arg in STYLES else None
    if arg is not None:
        bt = info.get("byType", {})
        if arg in bt:
            return bt[arg]
        if not info.get("frame") and arg in STYLES:
            return arg
    return info.get("frame")


def split_args(s: str) -> list[str]:
    out, depth, cur = [], 0, ""
    for ch in s:
        if ch in "([{":
            depth += 1
        elif ch in ")]}":
            if depth == 0:
                break
            depth -= 1
        if ch == "," and depth == 0:
            out.append(cur.strip())
            cur = ""
            continue
        cur += ch
    if cur.strip():
        out.append(cur.strip())
    return out


def returns_of(c: Cls, expr: str) -> list[str]:
    m = re.match(r"(\w+)\.(\w+)\(", expr)
    if not m:
        return []
    tc = Cls.get(c.resolve(m.group(1)))
    if not tc or m.group(2) not in tc.methods:
        return []
    return sorted(set(re.findall(r'return\s+"([^"]+)"', tc.methods[m.group(2)])))


def local_types(body: str) -> dict[str, str]:
    return {n: t.rsplit(".", 1)[-1] for n, t in re.findall(r"var\s+(\w+)\s*:\s*([\w.]+)", body)}


class Analyzer:
    def __init__(self, skip_hud: bool = False):
        self.visited: set[tuple[str, str]] = set()
        self.skip_hud = skip_hud

    def run(self, c: Cls, body: str, depth: int, via: list[str]) -> list[dict]:
        acts: list[dict] = []
        locs = local_types(body)
        msg = first_proto_msg(body)
        for line in body.splitlines()[1:]:
            s = line.strip()
            if not s or s.startswith("//"):
                continue
            acts.extend(self.line_actions(c, s, depth, via, locs, msg))
        return acts

    def line_actions(self, c: Cls, s: str, depth: int, via: list[str], locs: dict[str, str], msg: str | None = None) -> list[dict]:
        acts: list[dict] = []
        consumed: set[tuple[int, int]] = set()
        for m in re.finditer(r"openControllerByInfo\(", s):
            args = split_args(s[m.end():])
            if not args:
                continue
            first = args[0]
            arg = resolve_value(c, args[1]) if len(args) > 1 and args[1] != "null" else None
            keys = [first[1:-1]] if first.startswith('"') else returns_of(c, first)
            for key in keys or [first]:
                info = CONTROLLERS.get(key, {})
                frame = frame_for(key, None, arg)
                acts.append({"type": "controller", "key": key, "arg": arg, "controller": controller_fqn(info.get("controller")), "frame": frame, "frame_class": style_class(frame) if frame else None, "via": via, "dynamic": not first.startswith('"')})
            consumed.add((m.start(), m.end()))
        for m in re.finditer(r"FrameControllerManager\.instance\.(\w+)\.(\w+)\(", s):
            getter, meth = m.group(1), m.group(2)
            if getter == "openControllerByInfo":
                continue
            ctrl = FCM_GETTERS.get(getter)
            args = split_args(s[m.end():])
            arg = resolve_value(c, args[0]) if args else None
            simple = ctrl.rsplit(".", 1)[-1] if ctrl else None
            frame = frame_for(None, simple, arg)
            acts.append({"type": "controller", "key": None, "getter": getter, "method": meth, "arg": arg, "controller": ctrl, "frame": frame, "frame_class": style_class(frame) if frame else None, "via": via})
        for m in re.finditer(r'SceneManager\.instance\.setScene\(\s*"(\w+)"', s):
            acts.append({"type": "scene", "scene": m.group(1), "class": SCENE_CLASS.get(m.group(1)), "via": via})
        for m in re.finditer(r'creat(?:e)?Component(?:Group)?ByStylename\(\s*"([\w.]+)"', s):
            cn = style_class(m.group(1))
            if cn and cn in SCREENS and SCREENS[cn].get("kind") == "frame":
                acts.append({"type": "frame", "style": m.group(1), "class": cn, "via": via})
        for m in re.finditer(r"new\s+(\w+)\s*\(", s):
            name = m.group(1)
            if name == "PackageOut" or name in PROTO or name.endswith("Event"):
                continue
            fq = c.resolve(name)
            if fq and fq in SCREENS and SCREENS[fq].get("kind") == "frame":
                acts.append({"type": "frame", "class": fq, "via": via})
        for m in re.finditer(r"new\s+PackageOut\(\s*(\d+)\s*\)", s):
            code = int(m.group(1))
            acts.append({"type": "send", "code": code, "name": opname("send", code), "msg": msg or DERIVED.get(("send", code)), "via": via + [f"{c.name}"]})
        for target, meth in self.calls(c, s, locs):
            acts.extend(self.follow(target, meth, depth, via))
        return acts

    def calls(self, c: Cls, s: str, locs: dict[str, str]) -> list[tuple[str | None, str]]:
        out: list[tuple[str | None, str]] = []
        spans: list[tuple[int, int]] = []

        def taken(a: int) -> bool:
            return any(x <= a < y for x, y in spans)

        for m in re.finditer(r"\b([A-Z]\w*)\.(?:instance|Instance|getInstance\(\)|instance\(\)|Instance\(\))\.(\w+)\s*\(", s):
            if m.group(1) in SKIP_CLASSES:
                spans.append(m.span())
                continue
            out.append((c.resolve(m.group(1)), m.group(2)))
            spans.append(m.span())
        for m in re.finditer(r"(?<![\w.])([A-Z]\w*)\.(\w+)\s*\(", s):
            if taken(m.start()) or m.group(1) in SKIP_CLASSES:
                continue
            out.append((c.resolve(m.group(1)), m.group(2)))
            spans.append(m.span())
        for m in re.finditer(r"(?<![\w.])(?:this\.)?(_?[a-z_]\w*)\.(\w+)\s*\(", s):
            if taken(m.start()):
                continue
            var = m.group(1)
            typ = locs.get(var) or c.field_type(var)
            if typ and typ not in SKIP_CLASSES:
                out.append((c.resolve(typ), m.group(2)))
            elif m.group(2).startswith(("send", "req", "request")) and m.group(2) in SEND_BY_NAME:
                out.append((None, m.group(2)))
            spans.append(m.span())
        for m in re.finditer(r"(?<![\w.])(?:this\.)?(\w+)\s*\(", s):
            if taken(m.start()):
                continue
            name = m.group(1)
            if name in ("if", "for", "while", "switch", "return", "function", "super", "new", "catch", "each", "trace"):
                continue
            if c.find_method(name):
                out.append((c.fqn, name))
        for m in re.finditer(r'addEventListener\(\s*"([^"]+)"\s*,\s*(\w+)', s):
            if FOLLOW_EVENT.search(m.group(1)) and c.find_method(m.group(2)):
                out.append((c.fqn, m.group(2)))
        for m in re.finditer(r"(?:load|Load|addUIModule\w*|show|Show)\w*\([^;]*?,\s*(__\w+)\s*[,)]", s):
            if c.find_method(m.group(1)):
                out.append((c.fqn, m.group(1)))
        return out

    def follow(self, target: str | None, meth: str, depth: int, via: list[str]) -> list[dict]:
        if target is None:
            cands = SEND_BY_NAME.get(meth, [])
            if len(cands) != 1:
                return []
            target = cands[0][0]
        tc = Cls.get(target)
        if tc is None or tc.name in SKIP_CLASSES or (self.skip_hud and tc.fqn in HUD_SET):
            return []
        found = tc.find_method(meth)
        if not found:
            return []
        owner, mname = found
        tag = f"{owner.name}.{mname}"
        if (owner.fqn, mname) in SEND_INDEX:
            return [{"type": "send", **it, "via": via + [tag]} for it in SEND_INDEX[(owner.fqn, mname)]] + self.nested(owner, mname, depth, via + [tag])
        return self.nested(owner, mname, depth, via + [tag])

    def nested(self, owner: Cls, mname: str, depth: int, via: list[str]) -> list[dict]:
        if depth >= MAX_DEPTH or (owner.fqn, mname) in self.visited:
            return []
        self.visited.add((owner.fqn, mname))
        acts = self.run(owner, owner.methods[mname], depth + 1, via)
        return [a for a in acts if not (a["type"] == "send" and a["via"][-1] == owner.name and (owner.fqn, mname) in SEND_INDEX)]


def dedupe(acts: list[dict]) -> list[dict]:
    seen, out = set(), []
    for a in acts:
        k = json.dumps({x: y for x, y in a.items() if x != "via"}, sort_keys=True)
        if k in seen:
            continue
        seen.add(k)
        out.append(a)
    return out


def block_end(lines: list[str], i: int) -> int:
    base = len(lines[i]) - len(lines[i].lstrip())
    j = i + 1
    if j < len(lines) and lines[j].strip() == "{":
        depth = 0
        while j < len(lines):
            st = lines[j].strip()
            depth += st.count("{") - st.count("}")
            if depth <= 0 and st.endswith("}"):
                return j
            j += 1
        return j
    while j < len(lines) and (len(lines[j]) - len(lines[j].lstrip())) > base and lines[j].strip():
        j += 1
    return j - 1


def guards(body: str) -> list[dict]:
    lines = body.splitlines()
    out = []
    for i, line in enumerate(lines):
        st = line.strip()
        m = re.match(r"(?:else\s+)?if\s*\((.*)\)\s*$", st)
        if not m:
            continue
        end = block_end(lines, i)
        blk = "\n".join(lines[i + 1:end + 1])
        if "return" not in blk or len(blk.splitlines()) > 12:
            continue
        cond = m.group(1)
        if not GUARD_HINT.search(cond):
            continue
        key = re.search(r'GetTranslation\(\s*"([^"]+)"', blk)
        g = {"blocked_if": cond}
        if key:
            g["message_key"] = key.group(1)
            if tr(key.group(1)):
                g["message"] = tr(key.group(1))
        out.append(g)
    return out


def enclosing_condition(lines: list[str], idx: int) -> str | None:
    ind = len(lines[idx]) - len(lines[idx].lstrip())
    for j in range(idx - 1, max(-1, idx - 60), -1):
        st = lines[j].strip()
        if not st or st in ("{", "}"):
            continue
        jind = len(lines[j]) - len(lines[j].lstrip())
        if jind < ind:
            m = re.match(r"(?:else\s+)?if\s*\((.*)\)\s*$", st)
            if m:
                return m.group(1)
            m = re.match(r"case\s+(.+):", st)
            if m:
                return f"case {m.group(1)}"
            if st.startswith("else"):
                return "else"
            if "function" in st:
                return None
            ind = jind
    return None


def button_conditions(c: Cls, field: str) -> list[str]:
    out: list[str] = []
    lines = c.text.splitlines()
    pat = re.compile(r"(?<![\w.])(?:this\.)?" + re.escape(field) + r"(?:\.buttonBtn|\.buttonChildBtn)?\.(enable|visible|enabled)\s*=\s*(.+?);")
    for i, line in enumerate(lines):
        for m in pat.finditer(line):
            prop, expr = m.group(1), m.group(2)
            while "=" in expr and re.match(r"\s*[\w.]+\.(enable|visible|enabled)\s*=", expr):
                expr = expr.split("=", 1)[1]
            expr = expr.strip()
            if expr in ("true", "false"):
                cond = enclosing_condition(lines, i)
                if not cond or not GUARD_HINT.search(cond):
                    continue
                item = f"{prop} = {expr} when {cond}"
            else:
                item = f"{prop} = {expr}"
            if item not in out:
                out.append(item)
    return out[:12]


TOOL_NAME = {
    "ShopBtn": "ShopTip", "PackBtn": "BagTip", "storeBtn": "StoreTip", "SkillBtn": "SkillTip", "StarBtn": "StarTip",
    "HeroBtn": "ArmyTip", "FriendsBtn": "FriendsTip", "GuildBtn": "ConsortiaTip", "BattleBtn": "CampanhaTip",
    "OuterCityBtn": "ArredoresTip", "CastleBtn": "CidadeTip", "mountBtn": "MountTip", "PetBtn": "PetTip",
}


def text_suffix(c: Cls, field: str, prop: str) -> str:
    m = re.search(r"(?<![\w.])(?:this\.)?" + re.escape(field) + r"(?:\.buttonBtn)?\." + prop + r'\s*=\s*LanguageMgr\.GetTranslation\(\s*"[^"]+"\s*\)\s*\+\s*"([^"]*)"', c.text)
    return m.group(1) if m else ""


def text_key(c: Cls, field: str, prop: str) -> str | None:
    m = re.search(r"(?<![\w.])(?:this\.)?" + re.escape(field) + r"(?:\.buttonBtn)?\." + prop + r'\s*=\s*LanguageMgr\.GetTranslation\(\s*"([^"]+)"', c.text)
    if m:
        return m.group(1)
    if prop == "tipData":
        p = re.search(r"(?<![\w.])(?:this\.)?(\w+)\.addChild\(\s*" + re.escape(field) + r"\s*\)", c.text)
        if p and p.group(1) != field and re.search(r"StripView", c.fields.get(p.group(1), "")):
            return text_key(c, p.group(1), prop)
    return None


TOOL_OPEN: dict[str, str] = {}
TOOL_TIP: dict[str, str] = {}


def build_tool_open() -> None:
    c = Cls.get("ui.maintoolbar.constant.MainToolCheckBtnOpen")
    if not c:
        return
    for meth, dest in (("getBtnKeyIsOpen", TOOL_OPEN), ("getBtnKeyTips", TOOL_TIP)):
        for labels, seg in switch_segments(c.methods.get(meth, "")):
            r = re.search(r"return\s+(.+?);", seg)
            if not r:
                continue
            val = r.group(1).strip()
            if meth == "getBtnKeyTips":
                k = re.search(r'GetTranslation\(\s*"([^"]+)"\s*\)\s*\+\s*"([^"]*)"', val)
                val = f"{tr(k.group(1)) or k.group(1)} {k.group(2)}" if k else val
            for lab in labels:
                dest[lab] = val


def button_style(c: Cls, field: str) -> str | None:
    m = re.search(r"(?<![\w.])(?:this\.)?" + re.escape(field) + r'\s*=\s*ComponentFactory\.Instance\.creat\w*\(\s*"([^"]+)"', c.text)
    if m:
        return m.group(1)
    m = re.search(r"(?<![\w.])(?:this\.)?" + re.escape(field) + r'\s*=\s*(\w+)\(\s*"([^"]+)"', c.text)
    if m and m.group(1) in c.methods:
        h = re.search(r'creat\w*\(\s*"([^"]+)"\s*\+\s*param1', c.methods[m.group(1)])
        if h:
            return h.group(1) + m.group(2)
    return None


def style_tip(style: str | None) -> str | None:
    s = STYLES.get(style or "")
    if isinstance(s, dict):
        a = s.get("attrs", {})
        for k in ("tipData", "tipdata", "text", "label"):
            if a.get(k):
                return a[k]
    return None


def branch_segments(body: str) -> dict[str, str]:
    lines = body.splitlines()
    segs: dict[str, str] = {}
    for i, line in enumerate(lines):
        m = re.match(r"\s*(?:else\s+)?if\s*\(.*==\s*(?:this\.)?(_\w+)\.(buttonBtn|buttonChildBtn)\b", line)
        if not m:
            continue
        end = block_end(lines, i)
        segs[f"{m.group(1)}.{m.group(2)}"] = "\n".join(lines[i:end + 1])
    return segs


def switch_segments(body: str) -> list[tuple[list[str], str]]:
    lines = body.splitlines()
    start = next((i for i, l in enumerate(lines) if re.match(r"\s*switch\s*\(", l)), None)
    if start is None:
        return []
    end = block_end(lines, start)
    case_ind = None
    segs: list[tuple[list[str], list[str]]] = []
    for l in lines[start + 1:end + 1]:
        st = l.strip()
        ind = len(l) - len(l.lstrip())
        m = re.match(r"case\s+(.+?):$", st) or (re.match(r"(default):$", st))
        if m and (case_ind is None or ind == case_ind):
            case_ind = ind
            label = m.group(1).strip('"')
            if segs and not segs[-1][1]:
                segs[-1][0].append(label)
            else:
                segs.append(([label], []))
            continue
        if segs:
            segs[-1][1].append(l)
    return [(labels, "\n" + "\n".join(code)) for labels, code in segs]


def summarize(acts: list[dict]) -> list[dict]:
    out = []
    for a in dedupe(acts):
        b = dict(a)
        b["via"] = " > ".join(a.get("via", []))
        if not b["via"]:
            del b["via"]
        out.append({k: v for k, v in b.items() if v not in (None, [], "")})
    return out


def handler_entry(c: Cls, handler: str, body: str | None = None) -> tuple[list[dict], list[dict]]:
    if body is None:
        found = c.find_method(handler)
        if not found:
            return [], []
        body = found[0].methods[found[1]]
    an = Analyzer()
    an.visited.add((c.fqn, handler))
    acts = an.run(c, "\n" + body if not body.startswith("\n") else body, 0, [])
    return summarize(acts), guards(body)


def view_buttons(group: str, c: Cls) -> list[dict]:
    out = []
    seen = set()
    found_clicks = [(m.group(1), m.group(2), m.group(3)) for m in re.finditer(r"(?<![\w.])(?:this\.)?(\w+)((?:\.\w+)*)\.addEventListener\(\s*\"click\"\s*,\s*(\w+)\s*\)", c.text)]
    found_clicks += [("self", "", m.group(1)) for m in re.finditer(r"(?<![\w.])addEventListener\(\s*\"click\"\s*,\s*(\w+)\s*\)", c.text)]
    for field, sub, handler in found_clicks:
        if (field, sub, handler) in seen:
            continue
        seen.add((field, sub, handler))
        if field.startswith("_loc") or re.fullmatch(r"param\d+", field) or not c.find_method(handler):
            continue
        style = button_style(c, field)
        tip_key = text_key(c, field, "tipData")
        label_key = text_key(c, field, "text") or text_key(c, field, "label")
        base = {
            "group": group, "view": c.fqn, "field": field + sub, "style": style,
            "style_class": style_class(style) if style else None,
            "tip_key": tip_key, "tip": ((tr(tip_key) or "") + (" " + text_suffix(c, field, "tipData") if text_suffix(c, field, "tipData") else "")).strip() or style_tip(style), "label_key": label_key, "label": tr(label_key),
            "handler": handler, "ref": c.ref(handler), "conditions": button_conditions(c, field),
        }
        if style and style.startswith("mainToolBtn."):
            sfx = style.split(".", 1)[1]
            if sfx in TOOL_NAME:
                base["label_key"] = f"mainBar.MainToolBar.hotKey.{TOOL_NAME[sfx]}"
                base["label"] = tr(base["label_key"])
            if sfx in TOOL_OPEN and TOOL_OPEN[sfx] != "true":
                base["conditions"] = base["conditions"] + [f"open when {TOOL_OPEN[sfx]}"]
            if sfx in TOOL_TIP and not base["tip"]:
                base["tip"] = TOOL_TIP[sfx]
        found = c.find_method(handler)
        body = found[0].methods[found[1]]
        segs = branch_segments(body)
        mine = {k: v for k, v in segs.items() if k.startswith(field + ".")}
        if mine:
            for k, seg in mine.items():
                acts, gd = handler_entry(c, handler, "\n" + seg)
                e = dict(base, field=k.replace(".buttonBtn", "").replace(".buttonChildBtn", ".child"), actions=acts, guards=gd)
                out.append({x: y for x, y in e.items() if y not in (None, [], "")})
            continue
        acts, gd = handler_entry(c, handler)
        e = dict(base, actions=acts, guards=gd)
        out.append({x: y for x, y in e.items() if y not in (None, [], "")})
    return out


def building_names() -> dict[str, dict]:
    out: dict[str, dict] = {}
    p = ROOT / "raw/xml/tempinfos/BuildingTempInfos.xml"
    try:
        root = ET.parse(p).getroot()
    except (OSError, ET.ParseError):
        return out
    for e in root:
        a = e.attrib
        out.setdefault(a.get("SonType", ""), {"name": a.get("BuildingName"), "master": int(a.get("MasterType", "0") or 0)})
    return out


def dispatch_buttons(group: str, fqn: str, method: str, tip_fmt: str | None) -> list[dict]:
    c = Cls.get(fqn)
    if not c or method not in c.methods:
        return []
    body = c.methods[method]
    out = []
    bnames = building_names() if "Building" in fqn else {}
    titles: dict[str, str] = {}
    if "initTipData" in c.methods:
        for labels, seg in switch_segments(c.methods["initTipData"]):
            t = re.search(r'\.title\s*=\s*LanguageMgr\.GetTranslation\(\s*"([^"]+)"', seg)
            if t and tr(t.group(1)):
                for lab in labels:
                    titles[lab] = tr(t.group(1))
    covered = set()
    default_seg = None
    for labels, seg in switch_segments(body):
        if labels == ["default"]:
            default_seg = seg
            continue
        acts, gd = handler_entry(c, method, seg)
        for lab in labels:
            if lab == "default":
                default_seg = seg
                continue
            covered.add(lab)
            tip_key = tip_fmt.format(lab) if tip_fmt else None
            e = {"group": group, "view": fqn, "field": f"{method}[{lab}]", "dispatch": lab, "handler": method, "ref": c.ref(method), "tip_key": tip_key, "tip": tr(tip_key) or titles.get(lab) or (bnames.get(lab, {}).get("name")), "actions": acts, "guards": gd}
            out.append({x: y for x, y in e.items() if y not in (None, [], "")})
    if default_seg and bnames:
        bc = Cls.get("mvc.controler.BuildingControler")
        mapping = {}
        if bc and "getModelNameByInfo" in bc.methods:
            for labels, seg in switch_segments(bc.methods["getModelNameByInfo"]):
                r = re.search(r'return\s+"([^"]*)"', seg)
                for lab in labels:
                    if lab.lstrip("-").isdigit() and r:
                        mapping[int(lab) + 1] = r.group(1)
        for son, info in sorted(bnames.items(), key=lambda x: int(x[0] or 0)):
            if son in covered:
                continue
            key = mapping.get(info["master"])
            if not key:
                continue
            ci = CONTROLLERS.get(key, {})
            frame = frame_for(key, None, None)
            e = {"group": group, "view": fqn, "field": f"{method}[{son}]", "dispatch": son, "handler": method, "ref": c.ref(method), "tip": info["name"], "actions": [{"type": "controller", "key": key, "controller": controller_fqn(ci.get("controller")), "frame": frame, "frame_class": style_class(frame) if frame else None}]}
            out.append({x: y for x, y in e.items() if y not in (None, [], "")})
    return out


OPEN_ENTRY = ("start", "startFrameByType", "showFrame", "createFrame", "startPreLoad", "show", "enter", "prepare", "enterOver", "preLoadingStart", "setup", "init", "initView", "initData", "initEvent", "addEvent", "addEvents", "initEvents", "onShow", "set data", "setData", "set info", "loadData", "requestData", "open")


def open_flow(c: Cls, extra: tuple[str, ...] = ()) -> tuple[list[dict], set[str]]:
    an = Analyzer(skip_hud=True)
    acts: list[dict] = []
    entries = [c.name] + [m for m in OPEN_ENTRY + extra if m in c.methods]
    for e in entries:
        if e not in c.methods or (c.fqn, e) in an.visited:
            continue
        an.visited.add((c.fqn, e))
        acts.extend(an.run(c, c.methods[e], 0, [f"{c.name}.{e}" if e != c.name else f"{c.name}()"]))
    owners = set()
    for a in acts:
        if a["type"] == "send":
            for v in a.get("via", []):
                n = v.split(".")[0].rstrip("()")
                owners.add(n)
    return acts, owners


def referenced_managers(c: Cls) -> set[str]:
    out = set()
    for n in re.findall(r"\b([A-Z]\w*Manager)\.(?:instance|Instance|getInstance\(\))", c.text):
        if n not in SKIP_CLASSES and MANAGER_REFS.get(n, 0) <= GLOBAL_REFS:
            out.add(n)
    return out


def global_managers(c: Cls) -> set[str]:
    return {n for n in re.findall(r"\b([A-Z]\w*Manager)\.(?:instance|Instance|getInstance\(\))", c.text) if n not in SKIP_CLASSES and MANAGER_REFS.get(n, 0) > GLOBAL_REFS}


def manager_listens(owner_names: set[str], skip: set[str]) -> list[dict]:
    out = []
    names = set(owner_names)
    for n in owner_names:
        for suf in ("SocketOutManager", "SocketOuterManager", "SocketSendManager", "SocketManager"):
            if n.endswith(suf) and len(n) > len(suf):
                names.add(n[: -len(suf)] + "Manager")
    for n in sorted(names):
        if MANAGER_REFS.get(n, 0) > GLOBAL_REFS:
            continue
        for fq in SIMPLE.get(n, []):
            if fq in skip:
                continue
            c = Cls.get(fq)
            ls = class_listens(c)
            if 0 < len(ls) <= MAX_MANAGER_LISTENS:
                out.extend(ls)
    return out


SCREEN_CACHE: dict[str, dict] = {}


def screen(kind: str, fqn: str | None, label: str | None = None, arg: str | None = None, key: str | None = None) -> str | None:
    if not fqn:
        return None
    sid = f"{kind}:{key or fqn}" if kind == "controller" else f"{kind}:{fqn}"
    if kind == "controller" and key and arg and frame_for(key, None, arg) != CONTROLLERS.get(key, {}).get("frame"):
        sid += f"#{arg}"
    if sid in SCREEN_CACHE:
        return sid
    c = Cls.get(fqn)
    entry: dict = {"id": sid, "kind": kind, "class": fqn, "label": label}
    SCREEN_CACHE[sid] = entry
    if not c:
        entry["missing"] = True
        return sid
    entry["module"] = c.module
    entry["ref"] = c.ref()
    sends, listens = [], []
    classes = [c]
    if kind == "controller":
        info = CONTROLLERS.get(key or "", {})
        entry["key"] = key
        frame = frame_for(key, None, arg) if key else None
        entry["frame"] = frame
        entry["byType"] = info.get("byType") or None
        cf = own_frames(info.get("controller")).get("conditional") or []
        entry["conditional_frames"] = cf or None
        entry["conditional_screens"] = [x for x in (screen("frame", style_class(f["frame"])) for f in cf) if x] or None
        fc = style_class(frame) if frame else None
        if fc:
            entry["frame_class"] = fc
            f = Cls.get(fc)
            if f:
                classes.append(f)
                entry["title"] = SCREENS.get(fc, {}).get("title")
    elif kind in ("frame", "scene"):
        entry["title"] = SCREENS.get(fqn, {}).get("title")
    subs = []
    for cl in list(classes):
        for sv in SCREENS.get(cl.fqn, {}).get("subviews", [])[:40]:
            s = Cls.get(sv)
            if s and s not in classes:
                subs.append(s)
    owners: set[str] = set()
    for cl in classes:
        a, o = open_flow(cl)
        sends.extend(x for x in a if x["type"] == "send")
        owners |= o
        listens.extend(class_listens(cl))
    for s in subs:
        a, o = open_flow(s)
        sends.extend(x for x in a if x["type"] == "send")
        owners |= o
        listens.extend(class_listens(s))
    gm: set[str] = set()
    for cl in classes + subs:
        owners |= referenced_managers(cl)
        gm |= global_managers(cl)
    entry["global_managers"] = sorted(gm) or None
    skip = {cl.fqn for cl in classes} | {s.fqn for s in subs}
    listens.extend(manager_listens(owners - {cl.name for cl in classes}, skip))
    entry["subviews"] = [s.fqn for s in subs] or None
    entry["sends_on_open"] = summarize(sends)
    seen = set()
    ul = []
    for l in listens:
        k = (l["code"], l["class"], l["handler"])
        if k in seen:
            continue
        seen.add(k)
        ul.append(l)
    for l in ul:
        l["scope"] = "screen" if l["class"] in skip else "manager"
    entry["listens"] = ul
    return sid


def target_screens(actions: list[dict]) -> list[str]:
    ids = []
    for a in actions:
        sid = None
        if a["type"] == "controller" and (a.get("key") or a.get("controller")):
            if a.get("key") and a["key"] in CONTROLLERS:
                sid = screen("controller", a.get("controller"), a.get("key"), arg=a.get("arg"), key=a["key"])
            elif a.get("controller"):
                simple = a["controller"].rsplit(".", 1)[-1]
                cands = [k for k, v in CONTROLLERS.items() if v.get("controller") == simple]
                stem = re.sub(r"Contro(?:l)?ler$", "", simple).lower()
                key = next((k for k in cands if k in (stem, stem + "s")), None) or next((k for k in cands if k.startswith(stem)), None) or (cands[0] if cands else None)
                a["key"] = key
                sid = screen("controller", a["controller"], key, arg=a.get("arg"), key=key)
            if a.get("frame_class") and a["frame_class"] != SCREEN_CACHE.get(sid or "", {}).get("frame_class"):
                fid = screen("frame", a["frame_class"])
                if fid:
                    ids.append(fid)
        elif a["type"] == "scene" and a.get("class"):
            sid = screen("scene", a["class"], a["scene"])
        elif a["type"] == "frame" and a.get("class"):
            sid = screen("frame", a["class"])
        if sid:
            a["screen"] = sid
            ids.append(sid)
    return ids


FLOWS_MAIN = ROOT / "server" / "flows.json"
FLOWS_DIR = ROOT / "server" / "flows"
DOC = ROOT / "docs/ui/navigation.md"
INT_TYPES = {"INT32", "INT64", "UINT32", "UINT64", "SINT32", "SINT64", "FIXED32", "FIXED64", "SFIXED32", "SFIXED64", "ENUM", "INT"}


def flow_files() -> list[pathlib.Path]:
    return [FLOWS_MAIN] + sorted(FLOWS_DIR.glob("*.json"))


def flow_rules() -> list[tuple[str, dict]]:
    out = []
    for f in flow_files():
        d = load_json(f, {})
        for r in d.get("rules", []):
            out.append((f.relative_to(ROOT).as_posix(), r))
    return out


def answered_map() -> dict[int, str]:
    out: dict[int, str] = {}
    for f, r in flow_rules():
        if isinstance(r.get("on"), int):
            out.setdefault(r["on"], f)
    return out


def check_value(msg: str, data, path: str, errs: list[str]) -> None:
    if isinstance(data, str) and data.startswith("$"):
        return
    if msg not in PROTO:
        errs.append(f"{path}: unknown message {msg}")
        return
    if not isinstance(data, dict):
        errs.append(f"{path}: {msg} expects an object")
        return
    if "$type" in data:
        t = data["$type"]
        if t not in PROTO:
            errs.append(f"{path}: unknown $type {t}")
            return
        msg = t
    fields = {f["name"]: f for f in PROTO[msg]["fields"]}
    for k, v in data.items():
        if k == "$type":
            continue
        f = fields.get(k)
        if not f:
            errs.append(f"{path}.{k}: not a field of {msg}")
            continue
        vals = v if f["repeated"] and isinstance(v, list) else [v]
        if f["repeated"] and not isinstance(v, list) and not (isinstance(v, str) and v.startswith("$")):
            errs.append(f"{path}.{k}: repeated field needs a list")
        if f["repeated"] and isinstance(v, list) and v and f["type"] not in ("MESSAGE", "STRING", "BYTES"):
            errs.append(f"{path}.{k}: non-empty repeated scalar is sent unpacked")
        for i, x in enumerate(vals):
            sub = f"{path}.{k}" + (f"[{i}]" if f["repeated"] else "")
            if isinstance(x, str) and x.startswith("$"):
                continue
            t = f["type"]
            if t == "MESSAGE":
                check_value(f.get("msg", ""), x, sub, errs)
            elif t == "BOOL":
                if not isinstance(x, bool):
                    errs.append(f"{sub}: BOOL needs true or false")
            elif t == "STRING":
                if not isinstance(x, str):
                    errs.append(f"{sub}: STRING needs a string")
            elif t == "BYTES":
                if not isinstance(x, (str, list)) and not f["repeated"]:
                    errs.append(f"{sub}: BYTES needs a list or string")
                if isinstance(v, list) and f["repeated"]:
                    break
            elif t in INT_TYPES:
                if isinstance(x, bool) or not isinstance(x, int):
                    errs.append(f"{sub}: {t} needs an integer")
            elif t in ("FLOAT", "DOUBLE"):
                if not isinstance(x, (int, float)):
                    errs.append(f"{sub}: {t} needs a number")


def check_flows(files: list[pathlib.Path]) -> list[str]:
    errs: list[str] = []
    for f in files:
        try:
            d = json.loads(f.read_text(encoding="utf-8"))
        except (OSError, ValueError) as e:
            errs.append(f"{f.name}: {e}")
            continue
        for i, r in enumerate(d.get("rules", [])):
            base = f"{f.name}#{i}(on {r.get('on')})"
            on = r.get("on")
            if isinstance(on, int) and not any(OPNAME.get((d_, on)) for d_ in ("send",)):
                errs.append(f"{base}: {on} is not a client request opcode")
            if r.get("req") and r["req"] not in PROTO:
                errs.append(f"{base}: unknown req {r['req']}")
            for j, it in enumerate(r.get("send", [])):
                code = it.get("code")
                if not isinstance(code, int) or ("accept", code) not in OPNAME:
                    errs.append(f"{base}.send[{j}]: {code} is not a server push opcode")
                msg = it.get("msg", "")
                if msg:
                    check_value(msg, it.get("data", {}), f"{base}.send[{j}]", errs)
                elif it.get("data") not in ({}, None):
                    errs.append(f"{base}.send[{j}]: data without msg")
    return errs


def md(v) -> str:
    s = "" if v is None else str(v)
    s = s.replace("\u2014", "-").replace("\u2013", "-").replace("|", "/").replace("\n", " ").replace("\\n", " ")
    s = re.sub(r"<[^>]+>", "", s)
    return s.strip()


def short(fqn: str | None) -> str:
    return fqn.rsplit(".", 1)[-1] if fqn else ""


def act_text(a: dict, screens: dict) -> str:
    t = a["type"]
    if t == "controller":
        sc = screens.get(a.get("screen", ""), {})
        title = sc.get("title")
        name = f"{a.get('getter')}.{a.get('method')}" if a.get("getter") else (a.get("key") or short(a.get("controller")))
        arg = f"({a['arg']})" if a.get("arg") else ""
        frame = short(a.get("frame_class") or a.get("frame"))
        return f"`{name}`{arg} > {frame}" + (f" ({md(title)})" if title else "")
    if t == "scene":
        return f"scene `{a['scene']}`"
    if t == "frame":
        title = SCREENS.get(a.get("class", ""), {}).get("title")
        return f"{short(a.get('class'))}" + (f" ({md(title)})" if title else "")
    if t == "send":
        return f"send {a['code']} {a['name']}"
    return t


def acts_cell(b: dict, screens: dict, limit: int = 3) -> str:
    acts = b.get("actions", [])
    nav = [a for a in acts if a["type"] != "send"]
    sends = [a for a in acts if a["type"] == "send"]
    items = [act_text(a, screens) for a in nav[:limit]]
    if len(nav) > limit:
        items.append(f"+{len(nav) - limit}")
    if sends and len(items) < limit + 1:
        items.append(", ".join(f"{a['code']}" for a in sends[:4]) and "sends " + ", ".join(str(a["code"]) for a in sends[:4]) + ("..." if len(sends) > 4 else ""))
    return "<br>".join(items) if items else "local only"


def cond_cell(b: dict) -> str:
    out = list(b.get("conditions", []))
    for g in b.get("guards", [])[:2]:
        out.append("blocked if " + g["blocked_if"])
    return md("; ".join(out[:3]))


def req_cell(s: dict, answered: dict[int, str]) -> tuple[str, str]:
    codes = []
    for x in s.get("sends_on_open", []):
        if x["code"] not in [c for c, _ in codes]:
            codes.append((x["code"], x["name"]))
    if not codes:
        return "none", "nothing to answer"
    req = ", ".join(f"{c} {n}" for c, n in codes[:5]) + ("..." if len(codes) > 5 else "")
    ok = [c for c, _ in codes if c in answered]
    status = f"{len(ok)}/{len(codes)} answered"
    return req, status


def render(data: dict, answered: dict[int, str]) -> str:
    screens = data["screens"]
    sm = data["summary"]
    L: list[str] = []
    L.append("# Navigation map")
    L.append("")
    L.append("Every button of the castle HUD, what its click handler opens, and the socket traffic of each opened screen: the request opcodes it sends on open, the push opcodes it listens to and whether the local server answers them. Use it to follow a click from the HUD to a frame or scene and to find which flow rules are still missing.")
    L.append("Generated by `tools/navmap.py` from the decompiled AS3 in `decompiled/*/scripts`. Full data: `data/navigation.json`. Server rules for these screens: `server/flows/navigation.json`.")
    L.append("")
    L.append("Related: [screen index](screens.md), [UI composition](README.md), [castle module m4](modules/m4.md), [socket protocol](../../protocol/socket.md), [protobuf messages](../../protocol/proto.md), [architecture overview](../overview/architecture.md).")
    L.append("")
    L.append("## Regenerate")
    L.append("")
    L.append("| Command | Effect |")
    L.append("|---|---|")
    L.append("| `python3 tools/navmap.py` | Rebuilds `data/navigation.json` and this file |")
    L.append("| `python3 tools/navmap.py --check` | Validates every rule in `server/flows.json` and `server/flows/*.json` against `protocol/proto.json` |")
    L.append("")
    L.append("## Totals")
    L.append("")
    L.append("| Item | Count |")
    L.append("|---|---:|")
    L.append(f"| Buttons mapped | {sm['buttons']} |")
    L.append(f"| HUD and castle buttons | {sm['hud_buttons']} |")
    L.append(f"| Buttons inside opened screens | {sm['buttons'] - sm['hud_buttons']} |")
    L.append(f"| Screens (controllers, frames, scenes) | {sm['screens']} |")
    L.append(f"| Request opcodes seen | {sm['send_opcodes']} |")
    L.append(f"| Push opcodes listened | {sm['listen_opcodes']} |")
    L.append(f"| Request opcodes answered by the server | {sm['answered_opcodes']} |")
    L.append("")
    L.append("## How to read this")
    L.append("")
    L.append("Terms: a **request opcode** is a socket message the client sends (`send` in `protocol/opcodes.csv`); a **push opcode** is a message the server sends (`accept`). A **controller** is a class registered with `FrameControllerManager` that opens a frame; a **frame** is a PickGliss window; a **scene** is a full-stage state set by `SceneManager.setScene`.")
    L.append("")
    L.append("| Column | Meaning |")
    L.append("|---|---|")
    L.append("| Button | Field of the view class. `.child` is the small second button of a `MainToolButton` |")
    L.append("| Style | PickGliss style name of the button |")
    L.append("| Label | Tooltip or text, resolved through `index/language.json` (pt-BR) |")
    L.append("| Opens | `key`(arg) > frame class: `FrameControllerManager.openControllerByInfo`. `getter.method`: a controller getter such as `armyController.startFrameByType`. `scene X`: `SceneManager.setScene`. `sends N, M`: request opcodes sent on click. `+N`: further targets not shown. `local only`: the handler neither opens a screen nor sends a request |")
    L.append("| Conditions | `enable`/`visible` assignments of the button and early `return` guards of the handler |")
    L.append("| Requests on open | Opcodes reached from the constructor, `start`, `show`, `init*`, `enter` of the controller, frame and its subviews. Static analysis: branches are not evaluated, so the list is an upper bound |")
    L.append("| Server | How many of those request opcodes have a rule in `server/flows.json` or `server/flows/*.json` |")
    L.append("| Listens | Number of push opcodes handled by the screen itself (manager listeners excluded) |")
    L.append("")
    hud = [b for b in data["buttons"] if not b["group"].startswith("screen:") and "dispatch" not in b]
    hud.sort(key=lambda b: [v for _, v in HUD_VIEWS].index(b["view"]) if b["view"] in [v for _, v in HUD_VIEWS] else 99)
    by_view: dict[str, list[dict]] = defaultdict(list)
    for b in hud:
        by_view[b["view"]].append(b)
    L.append("## Castle HUD")
    L.append("")
    L.append("One table per HUD view class, in the order the HUD is built.")
    L.append("")
    for view, bs in by_view.items():
        L.append(f"### {view}")
        L.append("")
        L.append("| Button | Style | Label | Opens | Conditions |")
        L.append("|---|---|---|---|---|")
        for b in bs:
            lab = " / ".join(x for x in dict.fromkeys([md(b.get("label")), md(b.get("tip"))]) if x)
            L.append(f"| `{b['field']}` | {md(b.get('style'))} | {lab} | {acts_cell(b, screens)} | {cond_cell(b)} |")
        L.append("")
    top = [b for b in data["buttons"] if b.get("dispatch") and b["view"] == "ui.toptoolbar.TopToolsBar"]
    if top:
        L.append("## Activity icons")
        L.append("")
        L.append("Icons of `TopToolsBar` are data driven (`TopToolBtnTempInfo`); a click notifies `TOPTOOLBAR_BUTTON_CLICK` with the icon key, handled by `TopToolsBar.__onTopBtnClickHandler`.")
        L.append("")
        L.append("| Icon key | Label | Opens | Conditions |")
        L.append("|---|---|---|---|")
        for b in top:
            L.append(f"| `{b['dispatch']}` | {md(b.get('tip'))} | {acts_cell(b, screens)} | {cond_cell(b)} |")
        L.append("")
    qb = [b for b in data["buttons"] if b.get("dispatch") and b["view"] == "ui.queuebar.QueueBar"]
    if qb:
        L.append("## Queue items")
        L.append("")
        L.append("Items of `QueueBar`. `QueueBar.__itemClickHandler` switches on `QueueItem.type - 5`; case 4 (type 9, daily queue) switches again on `orderId - 1`.")
        L.append("")
        L.append("| Case | Opens | Conditions |")
        L.append("|---|---|---|")
        for b in qb:
            L.append(f"| {b['dispatch']} | {acts_cell(b, screens, 6)} | {cond_cell(b)} |")
        L.append("")
    blds = [b for b in data["buttons"] if b.get("dispatch") and "CastleBuildingView" in b["view"]]
    if blds:
        L.append("## Castle buildings")
        L.append("")
        L.append("Click dispatch of `CastleBuildingView.mouseClickHandler` in module [m4](modules/m4.md). Switch on `BuildingTempInfos.SonType`; the default branch uses `BuildingControler.getModelNameByInfo` (MasterType).")
        L.append("")
        L.append("| SonType | Building | Opens | Conditions |")
        L.append("|---|---|---|---|")
        for b in blds:
            L.append(f"| {b['dispatch']} | {md(b.get('tip'))} | {acts_cell(b, screens)} | {cond_cell(b)} |")
        L.append("")
    L.append("## Scenes")
    L.append("")
    L.append("Scene keys registered in `yishi.scene.SceneCreate`, with the request opcodes sent when the scene is entered.")
    L.append("")
    L.append("| Scene key | Class | Requests on enter | Server |")
    L.append("|---|---|---|---|")
    for k, cls in sorted(data["scenes"].items()):
        s = screens.get(f"scene:{cls}")
        req, st = req_cell(s, answered) if s else ("not mapped", "")
        L.append(f"| `{k}` | {cls} | {md(req)} | {st} |")
    L.append("")
    L.append("## Main screens")
    L.append("")
    L.append("Entry points of the main game areas. **Entry** is the controller key or scene key used to open the area.")
    L.append("")
    L.append("| Area | Entry | Frame | Title | Requests on open | Server |")
    L.append("|---|---|---|---|---|---|")
    for r in data["roots"]:
        s = screens.get(r["screen"], {})
        req, st = req_cell(s, answered)
        frame = s.get("frame_class") or (s["class"] if s.get("kind") == "scene" else "")
        L.append(f"| {r['group']} | `{r['name']}` | {frame} | {md(s.get('title'))} | {md(req)} | {st} |")
    L.append("")
    cond = [s for s in screens.values() if s.get("conditional_frames")]
    if cond:
        L.append("### Conditional frames")
        L.append("")
        L.append("Controllers that open a different frame depending on player state.")
        L.append("")
        L.append("| Controller | When | Frame |")
        L.append("|---|---|---|")
        seen_c = set()
        for s in cond:
            for c in s["conditional_frames"]:
                k = (s.get("key"), c["when"], c["frame"])
                if k in seen_c:
                    continue
                seen_c.add(k)
                L.append(f"| `{s.get('key')}` | `{md(c['when'])}` | {c['frame']} |")
        L.append("")
    L.append("## All opened screens")
    L.append("")
    L.append("Every screen reached from a mapped button. **Screen** ids are `controller:<key>[#arg]`, `frame:<class>` or `scene:<class>`.")
    L.append("")
    L.append("| Screen | Title | Requests on open | Server | Listens |")
    L.append("|---|---|---|---|---:|")
    for sid, s in sorted(screens.items()):
        req, st = req_cell(s, answered)
        own = sum(1 for l in s.get("listens", []) if l.get("scope") == "screen")
        L.append(f"| `{sid}` | {md(s.get('title'))} | {md(req)} | {st} | {own} |")
    L.append("")
    prio = {r["screen"] for r in data["roots"]}
    inner = [b for b in data["buttons"] if b["group"][7:] in prio and b.get("actions")]
    if inner:
        L.append("## Buttons inside the main screens")
        L.append("")
        L.append("Buttons of the main screens whose handler opens another screen or sends a request.")
        L.append("")
        L.append("| Screen | Button | Label | Opens |")
        L.append("|---|---|---|---|")
        for b in inner:
            L.append(f"| {short(b['view'])} | `{b['field']}` | {md(b.get('tip') or b.get('label'))} | {acts_cell(b, screens)} |")
        L.append("")
    L.append("## Server answers")
    L.append("")
    L.append("Rules in `server/flows/navigation.json`, loaded after `server/flows.json`. The first matching rule wins; `stop: false` lets the next matching rule run too. **On** is the request opcode, **Answer** lists the push opcodes and messages sent back.")
    L.append("")
    L.append("| On | Request | Answer | Purpose |")
    L.append("|---|---|---|---|")
    for f, r in flow_rules():
        if not f.endswith("navigation.json"):
            continue
        on = r["on"]
        name = opname("send", on) if isinstance(on, int) else ""
        ans = ", ".join(f"{x['code']} {x.get('msg') or opname('accept', x['code'])}" for x in r.get("send", [])) or "nothing"
        L.append(f"| {on} | {name} | {md(ans)} | {md(r.get('note'))} |")
    L.append("")
    L.append("## Key flows")
    L.append("")
    L.append("Hand-checked click paths for the most used areas, from the button to the screen and the opcodes involved.")
    L.append("")
    L.append("| Flow | Path |")
    L.append("|---|---|")
    for a, b in NOTES:
        L.append(f"| {a} | {b} |")
    L.append("")
    L.append("## Gaps")
    L.append("")
    L.append("Known limits of the local server, followed by request opcodes of the main screens that have no rule yet.")
    L.append("")
    L.append("| Area | Gap |")
    L.append("|---|---|")
    for area, gap in GAPS:
        L.append(f"| {area} | {gap} |")
    for r in data["roots"]:
        s = screens.get(r["screen"], {})
        miss = sorted({f"{x['code']} {x['name']}" for x in s.get("sends_on_open", []) if x["code"] not in answered})
        if miss:
            L.append(f"| {r['group']} | No rule for {md(', '.join(miss[:6]))} |")
    L.append("")
    L.append("## Data file layout")
    L.append("")
    L.append("Keys of `data/navigation.json`.")
    L.append("")
    L.append("| Key | Content |")
    L.append("|---|---|")
    L.append("| `summary` | Counts and the list of view classes with mapped buttons |")
    L.append("| `buttons[]` | `group`, `view`, `field`, `style`, `style_class`, `tip_key`/`tip`, `label_key`/`label`, `handler`, `ref` (file:line), `conditions`, `guards`, `actions[]`. Dispatch entries (icons, buildings, queue items) also carry `dispatch` |")
    L.append("| `actions[]` | `type` controller/scene/frame/send. Controller: `key`, `arg`, `controller`, `frame`, `frame_class`, `screen`. Send: `code`, `name`, `msg`. `via` is the call chain |")
    L.append("| `screens{}` | Keyed `controller:<key>[#arg]`, `frame:<class>`, `scene:<class>`: `frame_class`, `title`, `subviews`, `sends_on_open[]` (with `answered_by`), `listens[]` (`code`, `msg`, `handler`, `class`, `scope` screen/manager), `global_managers`, `conditional_frames` |")
    L.append("| `roots[]` | Entry points per area (bag, hero, skills, shop, mail, friends, guild, tasks, arena, rooms, campaign, world map, space) |")
    L.append("| `scenes{}` | `SceneManager` key to class, from `yishi.scene.SceneCreate` |")
    L.append("| `opcodes` | Every request and push opcode seen, with message and `answered_by` |")
    L.append("")
    return md_clean("\n".join(L) + "\n")


def md_clean(text: str) -> str:
    return text.replace("\u2014", "-").replace("\u2013", "-")


NOTES = [
    ("Reino do Céu enter", "`SmallMapBar._spaceBtn` > `SwitchPageHelp.enterToSpace` > 8688 C_PLAYER_SPACE_ENTER > 4595 RoomEnterMsg (`server/flows.json`) > `BaseManager.__createSpaceHandler` > `setScene(SPACE_SCENE)`"),
    ("Reino do Céu node", "Click on a node > `SpaceArmyViewHelper.nodeTrigger` > 8692 > 4601 (node id) > `SpaceSceneController.__selectNodeHandler` opens the node dialog or frame"),
    ("Reino do Céu leave", "Client side only: `MainToolBar._returnBtn` or `_castleBtn` > `setScene(CASTLE_SCENE)`; 8689 is never sent by the client"),
    ("World map", "`SmallMapBar._outercityBtn` opens `worldmap` (WorldMapFrame, template data only). `MainToolBar._outerCityBtn` enters `OUTER_CITY_SCENE`, which asks 8328 and 9525"),
    ("Bag and hero", "`MainToolBar._bagBtn` > `armyController.startFrameByType(EQUIP_PANEL)` > ArmyFrameII. Items come from 115 pushes kept by `GoodsManager` (bagType 1 bag, bagType 4 + objectId hero id for equipment)"),
    ("Skills", "`MainToolBar._skillBtn` > `startFrameByType(SKILL_PANEL)` > SkillFrame. Skills come from the job templates and `SimpleHeroInfoMsg` in 150 ArmyMsg"),
    ("Quests", "112 first load adds the accepted quests, then the client sends 5012 with every available template; the answer is another 112"),
    ("Guild", "`MainToolBar._consortiaBtn` > `consortia`(1). With `consortia_id` 0 the controller opens ConsortiaSearchFrame, which asks 8213 (guild list) and 8209"),
    ("Mail", "`SmallMapBar._mailBtn` > `email`(email.EmailFrame) > emailII.EmailFrame. The list is loaded over HTTP (`maillist`), new mail arrives as 148"),
]


GAPS = [
    ("mail", "The mail list comes from the HTTP servlet `maillist` (zlib XML), not from the socket. `server/src/main.rs` answers it with `Result value=false`, so the Email frame opens empty"),
    ("world map", "Castle and wild land grids come from AMF (`/messagebroker/amf`) and opcode 5004 `sendCurrentScreen`; not answered"),
    ("login data", "`server/flows.json` consumes every `8224` login load, so bag, fashion, quests and friends are pushed on `8322 C_LEED_CLIENT` (templateId 1), which the client sends once right after the castle load"),
    ("proto names", "`protocol/proto.json` keeps one message per simple name. 25 names collide (ItemInfoMsg, PropertyMsg, PosMsg, ArmyMsg...). Rules use a donor with the same field numbers through `$type` (bag items use `SimpleItemInfoMsg`) or the field-1 alias (`PropertyMsg.temp_data` = `simple.PropertyMsg.param1`)"),
    ("repeated scalars", "The Rust encoder writes one tag per element of a repeated scalar. Fields that the AS3 reader decodes with `readPackedRepeated` need packed encoding, so rules leave those lists empty"),
    ("Reino do Céu", "No other players are injected (4597 player list) and node actions only work for nodes whose feature opens client side"),
]


def main() -> None:
    if "--check" in sys.argv:
        errs = check_flows(flow_files())
        for e in errs:
            print(e)
        print(f"{len(errs)} problems in {len(flow_files())} files", file=sys.stderr)
        sys.exit(1 if errs else 0)
    build_send_index()
    build_scene_and_fcm()
    build_tool_open()
    buttons: list[dict] = []
    for group, fqn in HUD_VIEWS:
        c = Cls.get(fqn)
        if c:
            buttons.extend(view_buttons(group, c))
    for group, fqn, method, tip in DISPATCH:
        buttons.extend(dispatch_buttons(group, fqn, method, tip))
    for b in buttons:
        target_screens(b.get("actions", []))
    roots = []
    for group, kind, name, *rest in EXTRA_ROOTS:
        if kind == "scene":
            sid = screen("scene", SCENE_CLASS.get(name), name)
        else:
            info = CONTROLLERS.get(name, {})
            sid = screen("controller", controller_fqn(info.get("controller")), name, arg=rest[0] if rest else None, key=name)
        if sid:
            roots.append({"group": group, "kind": kind, "name": name, "arg": rest[0] if rest else None, "screen": sid})
    for name, cls in sorted(SCENE_CLASS.items()):
        screen("scene", cls, name)
    level1 = [s for s in list(SCREEN_CACHE.values())]
    done = set()
    for s in level1:
        for cname in filter(None, [s.get("frame_class"), s["class"] if s["kind"] in ("frame", "scene") else None]):
            c = Cls.get(cname)
            if not c or cname in done:
                continue
            done.add(cname)
            inner = view_buttons(f"screen:{s['id']}", c)
            for b in inner:
                target_screens(b.get("actions", []))
            buttons.extend(inner)
    answered = answered_map()
    for s in SCREEN_CACHE.values():
        for x in s.get("sends_on_open", []):
            x["answered_by"] = answered.get(x["code"])
        for k in [k for k, v in s.items() if v in (None, [], "")]:
            del s[k]
    send_codes = sorted({x["code"] for s in SCREEN_CACHE.values() for x in s.get("sends_on_open", [])} | {x["code"] for b in buttons for x in b.get("actions", []) if x["type"] == "send"})
    listen_codes = sorted({x["code"] for s in SCREEN_CACHE.values() for x in s.get("listens", [])})
    data = {
        "summary": {
            "buttons": len(buttons),
            "hud_buttons": sum(1 for b in buttons if not b["group"].startswith("screen:")),
            "screens": len(SCREEN_CACHE),
            "send_opcodes": len(send_codes),
            "listen_opcodes": len(listen_codes),
            "answered_opcodes": sum(1 for c in send_codes if c in answered),
            "views": sorted({b["view"] for b in buttons}),
        },
        "scenes": SCENE_CLASS,
        "roots": roots,
        "buttons": buttons,
        "screens": SCREEN_CACHE,
        "opcodes": {
            "send": [{"code": c, "name": opname("send", c), "msg": DERIVED.get(("send", c)), "answered_by": answered.get(c)} for c in send_codes],
            "listen": [{"code": c, "name": opname("accept", c), "msg": DERIVED.get(("accept", c))} for c in listen_codes],
        },
    }
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(data, ensure_ascii=False, indent=1))
    DOC.write_text(render(data, answered), encoding="utf-8")
    sm = data["summary"]
    print(f"buttons {sm['buttons']} (hud {sm['hud_buttons']}) screens {sm['screens']} send {sm['send_opcodes']} (answered {sm['answered_opcodes']}) listen {sm['listen_opcodes']} -> {OUT.relative_to(ROOT)}, {DOC.relative_to(ROOT)}", file=sys.stderr)


if __name__ == "__main__":
    main()
