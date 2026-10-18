#!/usr/bin/env python3
from __future__ import annotations

import json
import lzma
import pathlib
import struct
import sys
import zlib

BITMAP_TAGS = {6: "DefineBits", 20: "DefineBitsLossless", 21: "DefineBitsJPEG2",
               35: "DefineBitsJPEG3", 36: "DefineBitsLossless2", 90: "DefineBitsJPEG4"}
SHAPE_TAGS = {2: "DefineShape", 22: "DefineShape2", 32: "DefineShape3", 83: "DefineShape4",
              46: "DefineMorphShape", 84: "DefineMorphShape2"}
TEXT_TAGS = {11: "DefineText", 33: "DefineText2", 37: "DefineEditText"}
OTHER_TAGS = {7: "DefineButton", 34: "DefineButton2", 14: "DefineSound", 87: "DefineBinaryData",
              10: "DefineFont", 48: "DefineFont2", 75: "DefineFont3", 91: "DefineFont4",
              60: "DefineVideoStream", 39: "DefineSprite"}
KIND = {**{k: "bitmap" for k in BITMAP_TAGS}, **{k: "shape" for k in SHAPE_TAGS},
        **{k: "text" for k in TEXT_TAGS}, 7: "button", 34: "button", 14: "sound",
        87: "binary", 10: "font", 48: "font", 75: "font", 91: "font", 60: "video", 39: "sprite"}


def unpack(data: bytes) -> bytes:
    sig = data[:3]
    if sig == b"FWS":
        return data
    if sig == b"CWS":
        return b"FWS" + data[3:8] + zlib.decompressobj().decompress(data[8:])
    if sig == b"ZWS":
        props = data[12:17]
        filt = lzma._decode_filter_properties(lzma.FILTER_LZMA1, props)
        body = lzma.LZMADecompressor(format=lzma.FORMAT_RAW, filters=[filt]).decompress(data[17:])
        return b"FWS" + data[3:8] + body
    raise ValueError("não é SWF")


def rect(data: bytes, pos: int) -> tuple[dict, int]:
    nbits = data[pos] >> 3
    total = 5 + 4 * nbits
    raw = int.from_bytes(data[pos:pos + (total + 7) // 8], "big")
    shift = ((total + 7) // 8) * 8 - 5
    vals = []
    for _ in range(4):
        shift -= nbits
        v = (raw >> shift) & ((1 << nbits) - 1) if nbits else 0
        if nbits and v >> (nbits - 1):
            v -= 1 << nbits
        vals.append(v)
    xmin, xmax, ymin, ymax = vals
    return ({"x": xmin / 20, "y": ymin / 20, "w": (xmax - xmin) / 20, "h": (ymax - ymin) / 20},
            pos + (total + 7) // 8)


def tags(data: bytes, pos: int, end: int):
    while pos + 2 <= end:
        head = struct.unpack_from("<H", data, pos)[0]
        code, ln = head >> 6, head & 0x3F
        pos += 2
        if ln == 0x3F:
            ln = struct.unpack_from("<I", data, pos)[0]
            pos += 4
        yield code, pos, ln
        pos += ln
        if code == 0:
            return


def image_size(blob: bytes) -> tuple[int, int] | None:
    if blob[:8] == b"\x89PNG\r\n\x1a\n":
        return struct.unpack(">II", blob[16:24])
    if blob[:3] == b"GIF":
        return struct.unpack("<HH", blob[6:10])
    i = 0
    while i + 9 < len(blob):
        if blob[i] != 0xFF:
            i += 1
            continue
        marker = blob[i + 1]
        if marker in (0xC0, 0xC1, 0xC2):
            h, w = struct.unpack(">HH", blob[i + 5:i + 9])
            return w, h
        if marker in (0xD8, 0xD9, 0x01) or 0xD0 <= marker <= 0xD7 or marker == 0xFF:
            i += 2
            continue
        i += 2 + struct.unpack(">H", blob[i + 2:i + 4])[0]
    return None


def cstring(data: bytes, pos: int) -> tuple[str, int]:
    end = data.index(b"\x00", pos)
    return data[pos:end].decode("utf-8", "replace"), end + 1


def place_character(code: int, data: bytes, pos: int) -> int | None:
    if code == 26:
        flags = data[pos]
        return struct.unpack_from("<H", data, pos + 3)[0] if flags & 0x02 else None
    if code == 70:
        flags, flags2 = data[pos], data[pos + 1]
        p = pos + 4
        if flags2 & 0x08 or (flags2 & 0x10 and flags & 0x02):
            _, p = cstring(data, p)
        return struct.unpack_from("<H", data, p)[0] if flags & 0x02 else None
    return None


def timeline(data: bytes, pos: int, end: int) -> dict:
    frames, labels, children = 0, [], []
    for code, p, ln in tags(data, pos, end):
        if code == 1:
            frames += 1
        elif code == 43:
            labels.append({"frame": frames, "label": cstring(data, p)[0]})
        elif code in (26, 70):
            cid = place_character(code, data, p)
            if cid is not None and cid not in children:
                children.append(cid)
    return {"frames": frames, "labels": labels, "children": children}


def read(path: pathlib.Path | str) -> dict:
    data = unpack(pathlib.Path(path).read_bytes())
    stage, pos = rect(data, 8)
    rate = data[pos + 1] + data[pos] / 256
    pos += 4
    chars: dict[int, dict] = {}
    linkage: dict[str, int] = {}
    main = {"frames": 0, "labels": [], "children": []}
    for code, p, ln in tags(data, pos, len(data)):
        end = p + ln
        if code in KIND and ln >= 2:
            cid = struct.unpack_from("<H", data, p)[0]
            info: dict = {"kind": KIND[code], "tag": {**BITMAP_TAGS, **SHAPE_TAGS, **TEXT_TAGS, **OTHER_TAGS}[code]}
            try:
                if code in (20, 36):
                    info["w"], info["h"] = struct.unpack_from("<HH", data, p + 3)
                elif code in (6, 21):
                    size = image_size(data[p + 2:end])
                    if size:
                        info["w"], info["h"] = size
                elif code in (35, 90):
                    off = 8 if code == 90 else 6
                    size = image_size(data[p + off:end])
                    if size:
                        info["w"], info["h"] = size
                elif code in SHAPE_TAGS or code in TEXT_TAGS:
                    r, _ = rect(data, p + 2)
                    info.update(r)
                elif code == 39:
                    info.update(timeline(data, p + 4, end))
            except (struct.error, IndexError, ValueError):
                pass
            chars[cid] = info
        elif code in (76, 56):
            count = struct.unpack_from("<H", data, p)[0]
            q = p + 2
            for _ in range(count):
                cid = struct.unpack_from("<H", data, q)[0]
                name, q = cstring(data, q + 2)
                linkage[name] = cid
        elif code == 1:
            main["frames"] += 1
        elif code == 43:
            main["labels"].append({"frame": main["frames"], "label": cstring(data, p)[0]})
        elif code in (26, 70):
            cid = place_character(code, data, p)
            if cid is not None:
                main["children"].append(cid)
    return {"stage": stage, "fps": rate, "version": data[3], "main": main,
            "characters": chars, "linkage": linkage}


def symbol_info(swf: dict, cid: int, depth: int = 0) -> dict:
    info = dict(swf["characters"].get(cid, {"kind": "class-only"}))
    children = info.pop("children", [])
    if info.get("kind") == "sprite":
        info["child_count"] = len(children)
        if children and depth < 4:
            sub = [symbol_info(swf, c, depth + 1) for c in children]
            sized = [s for s in sub if "w" in s]
            if len(children) == 1 and sized:
                info["w"], info["h"] = sized[0]["w"], sized[0]["h"]
            info["contains"] = sorted({s["kind"] for s in sub})
    if not info.get("labels"):
        info.pop("labels", None)
    return info


def summary(path: pathlib.Path | str) -> dict:
    swf = read(path)
    return {"stage": swf["stage"], "fps": swf["fps"], "frames": swf["main"]["frames"],
            "labels": swf["main"]["labels"],
            "symbols": {name: symbol_info(swf, cid) for name, cid in sorted(swf["linkage"].items())}}


if __name__ == "__main__":
    print(json.dumps(summary(sys.argv[1]), indent=1, ensure_ascii=False))
