from __future__ import annotations

import json
import pathlib
import pickle
import sys

sys.path.insert(0, str(pathlib.Path(__file__).parent))
import parse

ROOT = pathlib.Path(__file__).resolve().parents[2]
DEC = ROOT / "decompiled"
OUT = ROOT / "build/as3"
MODULE_ORDER = ["core_module", "Loading", "core", "core2", "common"] + [f"m{i}" for i in range(3, 19)]

_ED = "addEventListener removeEventListener dispatchEvent hasEventListener willTrigger".split()
_DO = ("x y z width height scaleX scaleY scaleZ rotation rotationX rotationY rotationZ alpha visible name parent stage root "
       "mask filters blendMode transform cacheAsBitmap scrollRect scale9Grid opaqueBackground mouseX mouseY loaderInfo "
       "getBounds getRect localToGlobal globalToLocal hitTestObject hitTestPoint accessibilityProperties").split()
_IO = "mouseEnabled doubleClickEnabled tabEnabled tabIndex focusRect contextMenu".split()
_DOC = ("numChildren mouseChildren tabChildren addChild addChildAt removeChild removeChildAt removeChildren getChildAt "
        "getChildByName getChildIndex setChildIndex swapChildren swapChildrenAt contains getObjectsUnderPoint").split()
_SP = "graphics buttonMode useHandCursor hitArea dropTarget soundTransform startDrag stopDrag".split()
_MC = ("currentFrame totalFrames currentLabel currentLabels currentScene scenes framesLoaded enabled trackAsMenu "
       "gotoAndPlay gotoAndStop play stop nextFrame prevFrame addFrameScript").split()
_TF = ("text htmlText textColor textWidth textHeight length autoSize wordWrap multiline type selectable embedFonts "
       "defaultTextFormat setTextFormat getTextFormat appendText maxChars restrict border borderColor background "
       "backgroundColor numLines scrollV scrollH maxScrollV maxScrollH bottomScrollV displayAsPassword antiAliasType "
       "sharpness thickness gridFitType condenseWhite mouseWheelEnabled getCharIndexAtPoint getLineMetrics "
       "setSelection selectionBeginIndex selectionEndIndex caretIndex replaceText styleSheet").split()
_BMP = "bitmapData pixelSnapping smoothing".split()
FLASH: dict[str, tuple[str | None, list[str]]] = {
    "flash.events.EventDispatcher": (None, _ED),
    "flash.display.DisplayObject": ("flash.events.EventDispatcher", _DO),
    "flash.display.InteractiveObject": ("flash.display.DisplayObject", _IO),
    "flash.display.DisplayObjectContainer": ("flash.display.InteractiveObject", _DOC),
    "flash.display.Sprite": ("flash.display.DisplayObjectContainer", _SP),
    "flash.display.MovieClip": ("flash.display.Sprite", _MC),
    "flash.display.Shape": ("flash.display.DisplayObject", ["graphics"]),
    "flash.display.Bitmap": ("flash.display.DisplayObject", _BMP),
    "flash.display.SimpleButton": ("flash.display.InteractiveObject", "upState overState downState hitTestState enabled useHandCursor".split()),
    "flash.text.TextField": ("flash.display.InteractiveObject", _TF),
    "flash.display.Stage": ("flash.display.DisplayObjectContainer", "stageWidth stageHeight align scaleMode focus frameRate quality displayState".split()),
    "flash.utils.Timer": ("flash.events.EventDispatcher", "delay repeatCount currentCount running start stop reset".split()),
    "flash.net.URLLoader": ("flash.events.EventDispatcher", "data dataFormat load close bytesLoaded bytesTotal".split()),
    "flash.display.Loader": ("flash.display.DisplayObjectContainer", "content contentLoaderInfo load loadBytes unload unloadAndStop".split()),
    "flash.net.Socket": ("flash.events.EventDispatcher", "connected connect close flush bytesAvailable endian readBytes writeBytes".split()),
    "flash.utils.ByteArray": (None, "length position bytesAvailable endian objectEncoding readByte readUnsignedByte readShort readUnsignedShort readInt readUnsignedInt readFloat readDouble readUTF readUTFBytes readMultiByte readBoolean readBytes readObject writeByte writeShort writeInt writeUnsignedInt writeFloat writeDouble writeUTF writeUTFBytes writeMultiByte writeBoolean writeBytes writeObject compress uncompress clear toString".split()),
    "flash.events.Event": (None, "type target currentTarget bubbles cancelable eventPhase clone stopPropagation stopImmediatePropagation preventDefault isDefaultPrevented formatToString toString".split()),
}


def module_of(path: pathlib.Path) -> str:
    return path.relative_to(DEC).parts[0]


def build() -> dict:
    OUT.mkdir(parents=True, exist_ok=True)
    classes: dict[str, dict] = {}
    parsed: dict[str, parse.ClassDef] = {}
    packages: dict[str, set[str]] = {}
    for mod in MODULE_ORDER:
        base = DEC / mod / "scripts"
        if not base.exists():
            continue
        for f in sorted(base.rglob("*.as")):
            try:
                defs = parse.parse_file(f.read_text(errors="replace"))
            except Exception as e:
                print("falha", f, e)
                continue
            for c in defs:
                if not c.in_package:
                    c.package = str(f.relative_to(base).parent).replace("/", ".").strip(".")
                    c.name = f"{f.stem}$${c.name}"
                fqn = c.fqn
                if fqn in classes:
                    continue
                parsed[fqn] = c
                packages.setdefault(c.package, set()).add(c.name)
                classes[fqn] = {"module": mod, "path": str(f.relative_to(base)), "kind": c.kind,
                                "extends_raw": c.extends, "imports": c.imports, "package": c.package,
                                "inst": {m.name: m.kind for m in c.members if not m.static},
                                "stat": {m.name: m.kind for m in c.members if m.static},
                                "priv": sorted({m.name for m in c.members if m.private and not m.static})}
    for fqn, info in FLASH.items():
        if fqn not in classes:
            classes[fqn] = {"module": "flash", "path": "", "kind": "class", "extends": info[0], "native": True,
                            "inst": {n: "native" for n in info[1]}, "stat": {}, "package": fqn.rsplit(".", 1)[0]}
    for fqn, c in classes.items():
        if "extends_raw" in c:
            raw = c.pop("extends_raw")
            c["extends"] = resolve(raw, c, classes) if raw else None
    index = {"classes": classes, "packages": {k: sorted(v) for k, v in packages.items()}}
    (OUT / "index.json").write_text(json.dumps(index, ensure_ascii=False, separators=(",", ":")))
    with open(OUT / "parsed.pkl", "wb") as fh:
        pickle.dump(parsed, fh)
    return index


FLASH_SIMPLE = {"Sprite": "flash.display.Sprite", "MovieClip": "flash.display.MovieClip", "Shape": "flash.display.Shape",
                "Bitmap": "flash.display.Bitmap", "TextField": "flash.text.TextField", "EventDispatcher": "flash.events.EventDispatcher",
                "Event": "flash.events.Event", "DisplayObject": "flash.display.DisplayObject",
                "DisplayObjectContainer": "flash.display.DisplayObjectContainer", "SimpleButton": "flash.display.SimpleButton"}


def resolve(name: str, cls: dict, classes: dict) -> str:
    if not name:
        return name
    if "." in name and not name.startswith("Vector"):
        return name
    if name in cls.get("imports", {}):
        return cls["imports"][name]
    pkg = cls.get("package", "")
    local = f"{pkg}.{name}" if pkg else name
    if local in classes:
        return local
    if name in classes:
        return name
    for wpkg in filter(None, cls.get("imports", {}).get("*", "").split(",")):
        if f"{wpkg}.{name}" in classes:
            return f"{wpkg}.{name}"
    return FLASH_SIMPLE.get(name, name)


if __name__ == "__main__":
    idx = build()
    print("classes:", len(idx["classes"]))
