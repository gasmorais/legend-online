#!/usr/bin/env python3
from __future__ import annotations

import json
import os
import pathlib
import re
import shutil
import sys

import swflib

ROOT = pathlib.Path(__file__).resolve().parent.parent
SWF_DIR = ROOT / "raw/ui/zh_cn/swf"
FFDEC = ROOT / "build/ffdec_ui"
SCRIPTS = ROOT / "build/ffdec_ui_scripts"
RE_FS = re.compile(r"addFrameScript\(([^;]*)\);")
RE_FN = re.compile(r"function (frame\d+)\(\)[^{]*\{(.*?)\n\s*\}", re.S)
RE_ACT = re.compile(r"\b(stop|play)\(\)|\b(gotoAndPlay|gotoAndStop)\(\s*(\d+|\"[^\"]*\")")


def frame_scripts(swf_name: str) -> dict[str, dict[str, list[str]]]:
    out: dict[str, dict[str, list[str]]] = {}
    base = SCRIPTS / swf_name / "scripts"
    if not base.exists():
        return out
    for path in base.rglob("*.as"):
        text = path.read_text(errors="replace")
        calls = RE_FS.findall(text)
        if not calls:
            continue
        bodies = dict(RE_FN.findall(text))
        frames: dict[str, list[str]] = {}
        for call in calls:
            parts = [x.strip() for x in call.split(",")]
            for idx, fn in zip(parts[0::2], parts[1::2]):
                body = bodies.get(fn.replace("this.", ""), "")
                acts = []
                for m in RE_ACT.finditer(body):
                    if m.group(1):
                        acts.append(m.group(1))
                    else:
                        acts.append(f"{m.group(2)}:{m.group(3).strip(chr(34))}")
                if acts and idx.isdigit():
                    frames[str(int(idx) + 1)] = acts
        if frames:
            out[".".join(path.relative_to(base).with_suffix("").parts)] = frames
    return out
OUT = ROOT / "web/public/lib"
ASSET = {"bitmap": ("images", "img", "png"), "shape": ("shapes", "shp", "svg"),
         "text": ("texts", "txt", "svg")}


def link(src: pathlib.Path, dst: pathlib.Path) -> None:
    dst.parent.mkdir(parents=True, exist_ok=True)
    if dst.exists():
        dst.unlink()
    try:
        os.link(src, dst)
    except OSError:
        shutil.copy2(src, dst)


def build_one(path: pathlib.Path) -> tuple[dict, list[str]]:
    name = path.stem
    lib = swflib.library(path)
    out = OUT / name
    missing = []
    for cid, ch in lib["chars"].items():
        if ch["kind"] not in ASSET:
            continue
        src_dir, dst_dir, ext = ASSET[ch["kind"]]
        src = FFDEC / path.name / src_dir / f"{cid}.{ext}"
        if not src.exists():
            src = next((FFDEC / path.name / src_dir).glob(f"{cid}_*.{ext}"), src)
        if src.exists():
            link(src, out / dst_dir / f"{cid}.{ext}")
            ch["src"] = f"{dst_dir}/{cid}.{ext}"
        else:
            missing.append(f"{name}:{cid}:{ch['kind']}")
    scripts = frame_scripts(path.name)
    for cls, frames in scripts.items():
        cid = lib["linkage"].get(cls)
        if cid is not None and str(cid) in lib["chars"]:
            lib["chars"][str(cid)]["scripts"] = frames
    if lib["main"]["timeline"] and "" in scripts:
        lib["main"]["scripts"] = scripts[""]
    out.mkdir(parents=True, exist_ok=True)
    (out / "library.json").write_text(json.dumps(lib, ensure_ascii=False, separators=(",", ":")))
    return lib, missing


def main() -> None:
    only = set(sys.argv[1:])
    OUT.mkdir(parents=True, exist_ok=True)
    index, linkage, missing = {}, {}, []
    extra = [ROOT / "build/loading_src/Loading.swf"]
    for path in sorted(SWF_DIR.glob("*.swf")) + [e for e in extra if e.exists()]:
        if only and path.stem not in only:
            continue
        lib, miss = build_one(path)
        missing += miss
        index[path.stem] = {"linkage": len(lib["linkage"]), "chars": len(lib["chars"]),
                            "fps": lib["fps"], "stage": lib["stage"]}
        for cls, cid in lib["linkage"].items():
            linkage.setdefault(cls, [path.stem, cid])
    if not only:
        (OUT / "index.json").write_text(json.dumps(index, ensure_ascii=False, indent=0))
        (OUT / "linkage.json").write_text(json.dumps(linkage, ensure_ascii=False, separators=(",", ":")))
    print("swfs:", len(index), "linkage:", len(linkage), "assets faltando:", len(missing))
    by_kind: dict[str, int] = {}
    for m in missing:
        by_kind[m.rsplit(":", 1)[1]] = by_kind.get(m.rsplit(":", 1)[1], 0) + 1
    print("faltando por tipo:", by_kind, missing[:8])


if __name__ == "__main__":
    main()
