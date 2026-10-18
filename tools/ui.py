#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
import re
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict

ROOT = pathlib.Path(__file__).resolve().parent.parent
DECOMPILED = ROOT / "decompiled"
STYLE_DIR = ROOT / "raw/ui/zh_cn/xml/decoded"
SYMBOLS = ROOT / "index/ui_symbols.json"
DOCS = ROOT / "docs"

MODULE_ORDER = ["core_module", "Loading", "core", "core2", "common"] + [f"m{i}" for i in range(3, 19)]
FRAME = "com.pickgliss.ui.controls.Frame"
ROOT_KINDS = {
    "frame": FRAME,
    "scene": "yishi.scene.BaseSceneView",
    "tip": "yishi.view.tips.BaseTip",
}
DISPLAY_BASES = {"flash.display.Sprite", "flash.display.MovieClip", "flash.display.DisplayObjectContainer",
                 "com.pickgliss.ui.core.Component", "flash.display.Bitmap", "flash.display.Shape"}
REF_ATTRS = re.compile(r"(Style|resourceLink|Link)$")
NUM = ("x", "y", "width", "height")

PACKAGE = re.compile(r"^package\s+([\w.]*)", re.M)
CLASS = re.compile(r"public\s+(?:final\s+|dynamic\s+)*class\s+(\w+)(?:\s+extends\s+([\w.]+))?")
IMPORT = re.compile(r"^\s*import\s+([\w.]+);", re.M)
STRING = re.compile(r'"([A-Za-z_][\w.]*\.[\w.]+)"')
NEW = re.compile(r"new\s+([A-Z]\w*)\s*\(")
TRANSL = re.compile(r'LanguageMgr\.GetTranslation\("([^"]+)"')
TITLE = re.compile(r'titleText\s*=\s*LanguageMgr\.GetTranslation\("([^"]+)"')
TAGS = re.compile(r"<[^>]+>")
LANGUAGE = ROOT / "index/language.json"
FACTORY = re.compile(r'ComponentFactory\.Instance\.(\w+)\("([^"]+)"')


def clean(text: str) -> str:
    return text.replace("\u2014", "-").replace("\u2013", "-")


def load_styles() -> dict[str, dict]:
    styles: dict[str, dict] = {}
    for path in sorted(STYLE_DIR.glob("*.xml")):
        text = path.read_text(encoding="utf-8", errors="replace")
        try:
            root = ET.fromstring(text)
        except ET.ParseError:
            root = ET.fromstring(re.sub(r"&(?!\w+;|#)", "&amp;", text))
        source = root.get("source", "")
        for el in root.iter():
            name = el.get("stylename")
            if not name and el.tag in ("bitmapData", "bitmap"):
                name = el.get("resourceLink")
            if not name:
                continue
            attrs = {k: v for k, v in el.attrib.items() if k != "stylename"}
            styles.setdefault(name, {"file": path.name, "source": source, "tag": el.tag, "attrs": attrs})
    return styles


def load_symbols() -> dict[str, dict]:
    data = json.loads(SYMBOLS.read_text())
    out: dict[str, dict] = {}
    for swf_name, swf in data.items():
        for name, info in swf["symbols"].items():
            out.setdefault(name, {"swf": f"ui/zh_cn/swf/{swf_name}.swf", **info})
    return out


def load_classes() -> dict[str, dict]:
    classes: dict[str, dict] = {}
    for module in MODULE_ORDER:
        base = DECOMPILED / module / "scripts"
        if not base.exists():
            continue
        for path in base.rglob("*.as"):
            text = path.read_text(errors="replace")
            pm, cm = PACKAGE.search(text), CLASS.search(text)
            if not cm:
                continue
            pkg = pm.group(1) if pm else ""
            fqn = f"{pkg}.{cm.group(1)}" if pkg else cm.group(1)
            if fqn in classes:
                continue
            imports = {i.rsplit(".", 1)[-1]: i for i in IMPORT.findall(text)}
            classes[fqn] = {
                "module": module, "path": str(path.relative_to(base)), "package": pkg,
                "extends_raw": cm.group(2), "imports": imports,
                "strings": sorted(set(STRING.findall(text))),
                "factory": FACTORY.findall(text),
                "news": sorted(set(NEW.findall(text))),
                "texts": list(dict.fromkeys(TRANSL.findall(text))),
                "title_key": (TITLE.search(text) or [None, None])[1],
            }
    for fqn, c in classes.items():
        c["extends"] = resolve_name(c["extends_raw"], c, classes) if c["extends_raw"] else None
    return classes


def resolve_name(name: str, cls: dict, classes: dict) -> str:
    if "." in name:
        return name
    if name in cls["imports"]:
        return cls["imports"][name]
    local = f"{cls['package']}.{name}" if cls["package"] else name
    if local in classes:
        return local
    return {"Sprite": "flash.display.Sprite", "MovieClip": "flash.display.MovieClip",
            "Bitmap": "flash.display.Bitmap", "Shape": "flash.display.Shape",
            "EventDispatcher": "flash.events.EventDispatcher"}.get(name, name)


def ancestry(fqn: str, classes: dict) -> list[str]:
    chain, cur = [], fqn
    while cur and cur not in chain:
        chain.append(cur)
        cur = classes.get(cur, {}).get("extends")
    return chain


class Resolver:
    def __init__(self, styles: dict, symbols: dict, classes: dict, lang: dict | None = None):
        self.styles, self.symbols, self.classes = styles, symbols, classes
        self.lang = lang or {}
        self.views: dict[str, dict] = {}
        self.class_styles: dict[str, list[str]] = defaultdict(list)
        for name, st in styles.items():
            if cn := st["attrs"].get("classname"):
                self.class_styles[cn].append(name)

    def ref(self, name: str, depth: int = 0) -> dict | None:
        if name in self.styles:
            st = self.styles[name]
            a = st["attrs"]
            node = {"style": name, "type": a.get("classname") or a.get("type") or st["tag"]}
            for k in NUM:
                if k in a:
                    node[k] = a[k]
            if "args" in a:
                node["args"] = a["args"]
            if st["tag"] in ("bitmapData", "bitmap"):
                node["type"] = "bitmap"
                if name in self.symbols:
                    s = self.symbols[name]
                    node["parts"] = [{"via": "resourceLink", "symbol": name, "kind": s["kind"], "swf": s["swf"],
                                      **{k: s[k] for k in ("w", "h") if k in s}}]
                return node
            if depth < 4:
                parts = []
                for attr, value in a.items():
                    if attr == "parentStyle" or not REF_ATTRS.search(attr):
                        continue
                    for item in filter(None, (v.strip() for v in value.split(","))):
                        if sub := self.ref(item, depth + 1):
                            parts.append({"via": attr, **sub})
                if parts:
                    node["parts"] = parts
                if parent := a.get("parentStyle"):
                    node["parentStyle"] = parent
            return node
        if name in self.symbols:
            s = self.symbols[name]
            node = {"symbol": name, "kind": s["kind"], "swf": s["swf"]}
            for k in ("w", "h", "frames"):
                if k in s:
                    node[k] = s[k]
            if s.get("labels"):
                node["labels"] = [l["label"] for l in s["labels"]]
            return node
        return None

    def class_refs(self, fqn: str) -> tuple[list[str], list[str]]:
        c = self.classes[fqn]
        refs = [n for _, n in c["factory"]]
        refs += [s for s in c["strings"] if (s in self.styles or s in self.symbols) and s not in refs]
        subs = []
        for simple in c["news"]:
            sub = resolve_name(simple, c, self.classes)
            if sub in self.classes and sub != fqn and self.is_display(sub):
                subs.append(sub)
        return refs, subs

    def is_display(self, fqn: str) -> bool:
        chain = ancestry(fqn, self.classes)
        return any(x in DISPLAY_BASES or x == FRAME for x in chain)

    def view(self, fqn: str) -> dict:
        c = self.classes[fqn]
        refs, subs = self.class_refs(fqn)
        node: dict = {"class": fqn, "module": c["module"], "path": c["path"],
                      "extends": c["extends"]}
        own = self.class_styles.get(fqn, [])
        if len(own) > 1:
            simple = fqn.rsplit(".", 1)[-1]
            node["instance_styles"] = len(own)
            own = [s for s in own if s == fqn or s.endswith("." + simple)][:1]
        if own:
            node["own_style"] = [self.ref(s) for s in own]
        elements, unresolved = [], []
        for r in refs:
            res = self.ref(r)
            (elements.append(res) if res else unresolved.append(r))
            if res and res.get("type") in self.classes and not res["type"].startswith("com.pickgliss."):
                subs.append(res["type"])
        if elements:
            node["elements"] = elements
        if unresolved:
            node["unresolved"] = unresolved
        node["subviews"] = sorted(set(subs) - {fqn})
        title_key = c["title_key"]
        for st in own:
            title_key = title_key or self.styles[st]["attrs"].get("titleText")
        if title_key:
            node["title"] = {"key": title_key, "text": self.text(title_key)}
        if c["texts"]:
            node["texts"] = {k: self.text(k) for k in c["texts"]}
        return node

    def text(self, key: str) -> str | None:
        value = self.lang.get(key)
        return TAGS.sub("", value).strip() if value else None

    def closure(self, fqn: str, max_depth: int = 4) -> list[str]:
        seen, frontier = [fqn], [fqn]
        for _ in range(max_depth):
            nxt = []
            for cur in frontier:
                for sub in self.views[cur]["subviews"] if cur in self.views else []:
                    if sub not in seen:
                        seen.append(sub)
                        nxt.append(sub)
            frontier = nxt
        return seen[1:]


def walk(node: dict):
    yield node
    for key in ("own_style", "elements", "parts"):
        for sub in node.get(key, []) or []:
            if sub:
                yield from walk(sub)


def screen_stats(tree: dict, sub_nodes: list[dict]) -> dict:
    nodes = [n for t in [tree, *sub_nodes] for n in walk(t)]
    swfs = sorted({n["swf"] for n in nodes if "swf" in n})
    size = None
    for st in tree.get("own_style") or []:
        if not st:
            continue
        if "width" in st:
            size = f"{st['width']}×{st.get('height', '?')}"
        for part in st.get("parts", []):
            if size is None and part.get("via") == "backStyle":
                cand = [part] + part.get("parts", [])
                for c in cand:
                    w, h = c.get("width") or c.get("w"), c.get("height") or c.get("h")
                    if w is not None:
                        size = f"{w}×{h}"
                        break
    return {"elements": sum(1 for n in nodes if "style" in n),
            "symbols": sum(1 for n in nodes if "symbol" in n),
            "unresolved": sum(len(n.get("unresolved", [])) for n in nodes),
            "subviews": len(sub_nodes), "swfs": swfs, "size": size}


def fmt_node(node: dict, indent: int, lines: list[str]) -> None:
    pad = "  " * indent
    if "class" in node:
        title = node.get("title") or {}
        name = f": “{title.get('text') or title.get('key')}”" if title else ""
        lines.append(f"{pad}- **{node['class'].rsplit('.', 1)[-1]}**{name} (`{node['module']}:{node['path']}`)")
        for key in ("own_style", "elements"):
            for el in node.get(key, []) or []:
                if el:
                    fmt_node(el, indent + 1, lines)
        if node.get("unresolved"):
            lines.append(f"{pad}  - _no style/symbol_: {', '.join(f'`{u}`' for u in node['unresolved'][:12])}")
        texts = [f"`{k}` “{v[:60]}”" for k, v in (node.get("texts") or {}).items() if v][:8]
        if texts:
            lines.append(f"{pad}  - texts: " + "; ".join(texts))
        if node.get("subviews"):
            lines.append(f"{pad}  - subviews: {', '.join(f'`{v.rsplit(chr(46), 1)[-1]}`' for v in node['subviews'])}")
        return
    if "style" in node:
        geo = " ".join(f"{k}={node[k]}" for k in NUM if k in node)
        parent = f" ← `{node['parentStyle']}`" if node.get("parentStyle") else ""
        fonts = [p["args"] for p in node.get("parts", []) if p.get("type") == "flash.text.TextFormat" and p.get("args")]
        font = f" font `{fonts[0]}`" if fonts else ""
        lines.append(f"{pad}- `{node['style']}` · {node['type'].rsplit('.', 1)[-1]} {geo}{font}{parent}")
    else:
        dims = f" {node['w']}×{node['h']}" if "w" in node else ""
        frames = f" {node['frames']} frames" if node.get("frames", 0) > 1 else ""
        labels = f" labels: {', '.join(node['labels'][:8])}" if node.get("labels") else ""
        lines.append(f"{pad}- `{node['symbol']}` · {node['kind']}{dims}{frames}{labels} ({node['swf'].rsplit('/', 1)[-1]})")
    for part in node.get("parts", []):
        if part.get("type") != "flash.text.TextFormat":
            fmt_node(part, indent + 1, lines)


def main() -> None:
    styles, symbols, classes = load_styles(), load_symbols(), load_classes()
    (ROOT / "index/styles.json").write_text(json.dumps(styles, ensure_ascii=False))
    (ROOT / "index/classes.json").write_text(json.dumps(
        {k: {"module": v["module"], "path": v["path"], "extends": v["extends"]} for k, v in classes.items()},
        indent=0, ensure_ascii=False))
    lang = json.loads(LANGUAGE.read_text()) if LANGUAGE.exists() else {}
    res = Resolver(styles, symbols, classes, lang)

    display = [f for f in classes if res.is_display(f) and not f.startswith(("com.pickgliss.", "flash."))]
    for fqn in display:
        res.views[fqn] = res.view(fqn)
    screens = []
    for fqn in sorted(display):
        chain = ancestry(fqn, classes)
        kind = next((k for k, base in ROOT_KINDS.items() if base in chain[1:]), None)
        if not kind:
            continue
        subs = res.closure(fqn)
        title = res.views[fqn].get("title") or {}
        screens.append({"kind": kind, "class": fqn, "module": classes[fqn]["module"],
                        "title": title.get("text") or title.get("key"),
                        "extends": chain[1:5], "subviews": subs,
                        "stats": screen_stats(res.views[fqn], [res.views[x] for x in subs if x in res.views])})
    (ROOT / "index/screens.json").write_text(json.dumps(
        {"screens": screens, "views": res.views}, ensure_ascii=False))

    by_kind = Counter(s["kind"] for s in screens)
    by_module = defaultdict(list)
    for s in screens:
        by_module[s["module"]].append(s)
    used = {n["style"] for v in res.views.values() for n in walk(v) if "style" in n}
    comp_types = Counter(st["attrs"].get("classname", st["tag"]) for st in styles.values())
    prefixes = Counter(".".join(n.split(".")[:2]) for n in symbols)
    vnodes = [n for v in res.views.values() for n in walk(v)]
    total_res = sum(1 for n in vnodes if "style" in n or "symbol" in n)
    total_unres = sum(len(v.get("unresolved", [])) for v in res.views.values())

    L = ["# UI composition", "",
         "How the client builds its screens from PickGliss styles and SWF symbols, with counts, a legend of the",
         "style attributes and an index of the per-module pages that show the full composition tree of every view.",
         "Generated by `tools/ui.py` (with `tools/swf.py`). Data: `index/screens.json`, `index/styles.json`,",
         "`index/ui_symbols.json`, `index/classes.json`.", "",
         "Related: [screen index](screens.md), [navigation map](navigation.md),",
         "[PickGliss components](../client/components.md), [renderer](../client/renderer.md),",
         "[architecture overview](../overview/architecture.md).", "",
         "## Terminology", "",
         "| Term | Meaning |", "|---|---|",
         "| view | Any game class that extends a Flash display class (`Sprite`, `MovieClip`, `Bitmap`, `Shape`, `DisplayObjectContainer`) or a PickGliss `Component`, excluding the `com.pickgliss` and `flash` packages themselves |",
         "| screen | A view that is shown as a whole: a frame, a scene or a tip |",
         "| frame | Subclass of `com.pickgliss.ui.controls.Frame`: a window or dialog |",
         "| scene | Subclass of `yishi.scene.BaseSceneView`: a full-stage state switched by `SceneManager.setScene` |",
         "| tip | Subclass of `yishi.view.tips.BaseTip`: a tooltip |",
         "| controller | Class registered under a key with `FrameControllerManager`; `openControllerByInfo` creates it and it opens and drives a frame (see the [navigation map](navigation.md)) |",
         "| style | Named entry (`stylename`) in the PickGliss style XMLs; it sets the component class, geometry and parts |",
         "| symbol | Class exported from a UI SWF (`SymbolClass` linkage), drawn as a bitmap, shape or MovieClip |",
         "| subview | A view that another view instantiates with `new` or through a style whose class is a game view |", "",
         "## How a screen is built", "",
         "1. The screen class requests its parts from `ComponentFactory.Instance.creatComponentByStylename(\"<stylename>\")`",
         "   (or `creatBitmap`, `creatCustomObject`).",
         "2. The style name resolves to a `<component>`, `<bitmapData>`, `<set>` or `<custom>` element in the style XMLs.",
         "   They ship in `ui/zh_cn/xml/xml.png` (zlib, then a package of `[u8 len][name][u32 BE len][xml]` entries)",
         "   and are unpacked to `raw/ui/zh_cn/xml/decoded/` (297 files). The element sets `classname`, `x`, `y`,",
         "   `width`, `height`, inheritance (`parentStyle`) and parts (`backStyle`, `iconStyle`, `resourceLink`,",
         "   `textFormatStyle` and others).",
         "3. Parts point to other style names or to exported **symbols** in the SWF named by the XML `source`",
         "   attribute (`ui/zh_cn/swf/<name>.swf`).",
         "4. `imageRectString` and `*InnerRectString` position sub-images; `scaleGridString` defines a 9-slice grid.", "",
         "## Style attribute legend", "",
         "Checked against the PickGliss code.", "",
         "- **`TextFormat` `args`**: constructor arguments of `flash.text.TextFormat(font, size, color, bold, italic,",
         "  underline, url, target, align, leftMargin, rightMargin, indent, leading)`; an empty value keeps the default.",
         "- **Lists** are comma-separated (`ComponentFactory.parasArgs`). In `imageRectString` each item becomes an",
         "  `InnerRectangle` with `|`-separated fields; an empty item means no rectangle.",
         "- **`InnerRectangle(p1, p2, p3, p4 = -9999, lock = 0)`** (`com/pickgliss/geom/InnerRectangle.as`): with three",
         "  values, `lock = p3`. The rectangle is relative to a parent of size `W×H`; the table gives the formula per",
         "  `lock` value (source: `index/inner_rect.json`).", "",
         "| Lock | x | y | Width | Height |", "|---:|---|---|---|---|"]
    rects = json.loads((ROOT / "index/inner_rect.json").read_text()) if (ROOT / "index/inner_rect.json").exists() else {}
    for k in sorted(rects, key=int):
        r = rects[k]
        L.append(f"| {k} | `{r['x']}` | `{r['y']}` | `{r['width']}` | `{r['height']}` |")
    L += ["",
          "## Counts", "",
         f"- Styles: **{len(styles)}** in {len({s['file'] for s in styles.values()})} XML files; referenced by code: **{len(used)}**.",
         f"- Views: **{len(res.views)}**.",
         f"- UI symbols: **{len(symbols)}** in {len(json.loads(SYMBOLS.read_text()))} SWFs.",
         f"- Indexed classes: **{len(classes)}** across all modules.",
         f"- Screens: " + ", ".join(f"**{n}** {k}s" for k, n in by_kind.most_common()) + ".",
         f"- References resolved to a style or symbol: **{total_res}**; style-like strings with no definition: **{total_unres}**.", "",
         "## Most used component classes", "",
         "Number of styles per `classname` attribute (or per element tag when the style has no class).", "",
         "| Component class | Styles |", "|---|---:|"]
    L += [f"| `{k}` | {n} |" for k, n in comp_types.most_common(30)]
    L += ["", "## Symbol name prefixes", "",
          "Exported symbols follow an `a.b.Name` convention; the table counts symbols per `a.b` prefix.", "",
          "| Prefix | Symbols |", "|---|---:|"]
    L += [f"| `{k}` | {n} |" for k, n in prefixes.most_common(40)]
    L += ["", "## Screens by module", "",
          "Each module page lists the module's screens and the composition tree of each of its views.", "",
          "| Module | Frames | Scenes | Tips |", "|---|---:|---:|---:|"]
    for mod in sorted(by_module, key=lambda m: MODULE_ORDER.index(m) if m in MODULE_ORDER else 99):
        c = Counter(s["kind"] for s in by_module[mod])
        L.append(f"| [`{mod}`](modules/{mod}.md) | {c['frame']} | {c['scene']} | {c['tip']} |")
    L += ["", "## Largest screens", "",
          "The 40 screens with the most styles, counting their subviews. **Styles** and **Symbols** count resolved",
          "style entries and SWF symbols; **Subviews** counts display classes reached transitively (up to 4 levels).", "",
          "| Screen | Module | Size | Styles | Symbols | Subviews |", "|---|---|---|---:|---:|---:|"]
    for s in sorted(screens, key=lambda s: -s["stats"]["elements"])[:40]:
        st = s["stats"]
        L.append(f"| `{s['class']}` | [{s['module']}](modules/{s['module']}.md) | {st['size'] or ''} | {st['elements']} | {st['symbols']} | {st['subviews']} |")
    (ROOT / "docs/ui/README.md").write_text(clean("\n".join(L) + "\n"))

    ui_dir = DOCS / "ui" / "modules"
    ui_dir.mkdir(exist_ok=True)
    for old_doc in ui_dir.glob("*.md"):
        old_doc.unlink()
    views_by_module = defaultdict(list)
    for v in res.views.values():
        views_by_module[v["module"]].append(v)
    for mod in sorted(set(by_module) | set(views_by_module)):
        items = by_module.get(mod, [])
        M = [f"# UI module `{mod}`", "",
             f"Screens defined in the decompiled module `{mod}` (`decompiled/{mod}/scripts`) and the composition tree of",
             "every view class in it that uses styles or symbols. Subviews defined in other modules are described on",
             "their own module page.", "",
             "Related: [UI composition](../README.md), [screen index](../screens.md), [navigation map](../navigation.md).", "",
             "## How to read this", "",
             "Screen table columns:", "",
             "| Column | Meaning |", "|---|---|",
             "| Screen | Fully qualified class name |",
             "| Title (pt-BR) | Resolved title text, or the raw language key; truncated to 50 characters |",
             "| Kind | frame, scene or tip (see [terminology](../README.md#terminology)) |",
             "| Extends | Direct superclass |",
             "| Size | `width×height` of the screen style or of its `backStyle` |",
             "| Styles, Symbols | Resolved style entries and SWF symbols, subviews included |",
             "| Subviews | Display classes reached transitively, up to 4 levels |",
             "| UI SWFs | First four SWF files that provide the symbols |", "",
             "Composition tree notation:", "",
             "- **Class** (`module:path`): a view class; the path is relative to `decompiled/<module>/scripts`.",
             "- `` `style` · Class x=… y=… width=… height=… ``: a style entry, the component class it creates and its",
             "  geometry from the XML; `font` shows the `TextFormat` arguments; `← parent` is the `parentStyle` it inherits.",
             "- `` `symbol` · kind W×H N frames labels: … (file.swf) ``: an exported SWF symbol with its size, frame",
             "  count, frame labels and source SWF.",
             "- Nested items are parts of the item above (`backStyle`, `resourceLink` and similar attributes).",
             "- _no style/symbol_: style-like strings in the code that match no style or symbol.",
             "- texts: language keys used by the class and their pt-BR text (first eight).",
             "- subviews: display classes the view instantiates.", "",
             "## Screens", ""]
        if items:
            M += ["| Screen | Title (pt-BR) | Kind | Extends | Size | Styles | Symbols | Subviews | UI SWFs |",
                  "|---|---|---|---|---|---:|---:|---:|---|"]
        else:
            M.append("This module defines no frame, scene or tip.")
        for s in sorted(items, key=lambda s: (s["kind"], s["class"])):
            st = s["stats"]
            M.append(f"| `{s['class']}` | {clean(s['title'] or '').replace('|', '/')[:50]} | {s['kind']} | `{s['extends'][0].rsplit('.', 1)[-1]}` | {st['size'] or ''} | "
                     f"{st['elements']} | {st['symbols']} | {st['subviews']} | "
                     f"{', '.join(x.rsplit('/', 1)[-1] for x in st['swfs'][:4])} |")
        M += ["", "## View composition", ""]
        for v in sorted(views_by_module[mod], key=lambda v: v["class"]):
            if not (v.get("own_style") or v.get("elements")):
                continue
            M += [f"### {v['class']}", ""]
            fmt_node(v, 0, M)
            M.append("")
        (ui_dir / f"{mod}.md").write_text(clean("\n".join(M) + "\n"))

    print("estilos:", len(styles), "símbolos:", len(symbols), "classes:", len(classes))
    print("telas:", dict(by_kind), "resolvidas:", total_res, "não resolvidas:", total_unres)


if __name__ == "__main__":
    main()
