#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
import re
import shutil
import subprocess
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import swflib
from h5build import ASSET, RE_ACT, RE_FN, RE_FS, link

ROOT = pathlib.Path(__file__).resolve().parent.parent
FFDEC_OUT = ROOT / "build/ffdec_battle"
OUT = ROOT / "web/public/battle"
JAVA_CANDIDATES = ["/opt/homebrew/opt/openjdk@21/bin/java", "/opt/homebrew/opt/openjdk/bin/java", "java"]


def sources() -> list[tuple[str, pathlib.Path]]:
    out = [("map", p) for p in sorted((ROOT / "raw/sceneima").glob("*/*.swf"))]
    out += [("unit", p) for p in sorted((ROOT / "raw/swf").glob("*/*.swf")) if p.parent.name != "avatar"]
    if "--effects" in sys.argv:
        out += [("effect", p) for p in sorted((ROOT / "raw/skilleffect").glob("*.swf"))]
    return out


def java() -> str:
    for j in JAVA_CANDIDATES:
        if shutil.which(j) or pathlib.Path(j).exists():
            try:
                subprocess.run([j, "-version"], capture_output=True, check=True)
                return j
            except (OSError, subprocess.CalledProcessError):
                continue
    raise SystemExit("Java não encontrado (FFDec precisa de Java ≥ 8)")


def ffdec(path: pathlib.Path) -> None:
    dst = FFDEC_OUT / path.name
    if dst.exists():
        return
    subprocess.run([java(), "-jar", str(ROOT / "tools/ffdec/ffdec.jar"), "-format", "image:png,shape:svg,text:svg",
                    "-export", "script,image,shape,text", str(dst), str(path)], capture_output=True)


def frame_scripts(swf_name: str) -> dict[str, dict[str, list[str]]]:
    out: dict[str, dict[str, list[str]]] = {}
    base = FFDEC_OUT / swf_name / "scripts"
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
                acts = [m.group(1) if m.group(1) else f"{m.group(2)}:{m.group(3).strip(chr(34))}" for m in RE_ACT.finditer(body)]
                if acts and idx.isdigit():
                    frames[str(int(idx) + 1)] = acts
        if frames:
            out[".".join(path.relative_to(base).with_suffix("").parts)] = frames
    return out


RE_PATTERN = re.compile(r'<pattern height="([\d.]+)"[^>]*patternTransform="matrix\(1\.0, 0\.0, 0\.0, 1\.0, ([-\d.]+), ([-\d.]+)\)"[^>]*width="([\d.]+)"')


def bitmap_fill_to_png(lib: dict) -> None:
    out = OUT / lib.get("_name", "")
    bitmaps = {cid: ch for cid, ch in lib["chars"].items() if ch["kind"] == "bitmap" and ch.get("src")}
    for cid, ch in lib["chars"].items():
        if ch["kind"] != "shape" or not ch.get("src", "").endswith(".svg"):
            continue
        svg = (out / ch["src"]).read_text(errors="replace")
        pats = RE_PATTERN.findall(svg)
        if len(pats) != 1 or svg.count("<image") != 1 or svg.count("<path") > 1:
            continue
        h, tx, ty, w = (float(v) for v in pats[0])
        same = [b for b in bitmaps.values() if b["w"] == w and b["h"] == h]
        if len(same) == 1 and (w, h) == (ch["w"], ch["h"]) and (tx, ty) == (ch["x"], ch["y"]):
            ch["src_svg"] = ch["src"]
            ch["src"] = same[0]["src"]


def build_one(kind: str, path: pathlib.Path) -> tuple[dict, list[str]]:
    name = path.stem
    lib = swflib.library(path)
    lib["_name"] = name
    out = OUT / name
    missing = []
    for cid, ch in lib["chars"].items():
        if ch["kind"] not in ASSET:
            continue
        src_dir, dst_dir, ext = ASSET[ch["kind"]]
        src = FFDEC_OUT / path.name / src_dir / f"{cid}.{ext}"
        if not src.exists():
            src = next((FFDEC_OUT / path.name / src_dir).glob(f"{cid}_*.{ext}"), src)
        if src.exists():
            link(src, out / dst_dir / f"{cid}.{ext}")
            ch["src"] = f"{dst_dir}/{cid}.{ext}"
        else:
            missing.append(f"{name}:{cid}:{ch['kind']}")
    bitmap_fill_to_png(lib)
    for cls, frames in frame_scripts(path.name).items():
        cid = lib["linkage"].get(cls)
        if cid is not None and str(cid) in lib["chars"]:
            lib["chars"][str(cid)]["scripts"] = frames
    lib.pop("_name", None)
    out.mkdir(parents=True, exist_ok=True)
    (out / "library.json").write_text(json.dumps(lib, ensure_ascii=False, separators=(",", ":")))
    return lib, missing


def main() -> None:
    use_ffdec = "--no-ffdec" not in sys.argv
    OUT.mkdir(parents=True, exist_ok=True)
    index, missing = {}, []
    for kind, path in sources():
        if use_ffdec:
            ffdec(path)
        lib, miss = build_one(kind, path)
        missing += miss
        labels = {}
        for cls, cid in lib["linkage"].items():
            ch = lib["chars"].get(str(cid), {})
            if ch.get("labels"):
                labels[cls] = ch["labels"]
        index[path.stem] = {"kind": kind, "linkage": sorted(lib["linkage"]), "labels": labels,
                            "fps": lib["fps"], "stage": lib["stage"]}
    (OUT / "index.json").write_text(json.dumps(index, ensure_ascii=False, indent=1))
    print("swfs:", len(index), "assets faltando:", len(missing), missing[:8])


if __name__ == "__main__":
    main()
