#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
import struct
import sys

import swf

BLEND = {0: "normal", 1: "normal", 2: "layer", 3: "multiply", 4: "screen", 5: "lighten", 6: "darken",
         7: "difference", 8: "add", 9: "subtract", 10: "invert", 11: "alpha", 12: "erase",
         13: "overlay", 14: "hardlight"}


class Bits:

    def __init__(self, data: bytes, pos: int):
        self.data, self.pos, self.bit = data, pos, 0

    def ub(self, n: int) -> int:
        v = 0
        for _ in range(n):
            byte = self.data[self.pos]
            v = (v << 1) | ((byte >> (7 - self.bit)) & 1)
            self.bit += 1
            if self.bit == 8:
                self.bit, self.pos = 0, self.pos + 1
        return v

    def sb(self, n: int) -> int:
        v = self.ub(n)
        return v - (1 << n) if n and v >> (n - 1) else v

    def align(self) -> int:
        if self.bit:
            self.bit, self.pos = 0, self.pos + 1
        return self.pos


def matrix(data: bytes, pos: int) -> tuple[list[float], int]:
    b = Bits(data, pos)
    a = d = 1.0
    bb = c = 0.0
    if b.ub(1):
        n = b.ub(5)
        a, d = b.sb(n) / 65536, b.sb(n) / 65536
    if b.ub(1):
        n = b.ub(5)
        bb, c = b.sb(n) / 65536, b.sb(n) / 65536
    n = b.ub(5)
    tx, ty = b.sb(n) / 20, b.sb(n) / 20
    return [round(a, 6), round(bb, 6), round(c, 6), round(d, 6), tx, ty], b.align()


def cxform(data: bytes, pos: int, alpha: bool) -> tuple[list[float], int]:
    b = Bits(data, pos)
    has_add, has_mult, n = b.ub(1), b.ub(1), b.ub(4)
    k = 4 if alpha else 3
    mult, add = [1.0] * 4, [0] * 4
    if has_mult:
        mult[:k] = [b.sb(n) / 256 for _ in range(k)]
    if has_add:
        add[:k] = [b.sb(n) for _ in range(k)]
    return mult + add, b.align()


def rgba(data: bytes, pos: int) -> str:
    r, g, bl, a = data[pos:pos + 4]
    return f"#{r:02x}{g:02x}{bl:02x}{a:02x}"


def fixed(data: bytes, pos: int) -> float:
    return struct.unpack_from("<i", data, pos)[0] / 65536


def fixed8(data: bytes, pos: int) -> float:
    return struct.unpack_from("<h", data, pos)[0] / 256


def filters(data: bytes, pos: int) -> tuple[list[dict], int]:
    out = []
    count = data[pos]
    pos += 1
    for _ in range(count):
        fid = data[pos]
        pos += 1
        if fid in (0, 2):
            f = {"type": "dropShadow" if fid == 0 else "glow", "color": rgba(data, pos)}
            pos += 4
            f["blurX"], f["blurY"] = fixed(data, pos), fixed(data, pos + 4)
            pos += 8
            if fid == 0:
                f["angle"], f["distance"] = fixed(data, pos), fixed(data, pos + 4)
                pos += 8
            f["strength"] = fixed8(data, pos)
            flags = data[pos + 2]
            f.update(inner=bool(flags & 0x80), knockout=bool(flags & 0x40), passes=flags & 0x1F)
            pos += 3
        elif fid == 1:
            f = {"type": "blur", "blurX": fixed(data, pos), "blurY": fixed(data, pos + 4), "passes": data[pos + 8] >> 3}
            pos += 9
        elif fid == 3:
            f = {"type": "bevel", "shadow": rgba(data, pos), "highlight": rgba(data, pos + 4),
                 "blurX": fixed(data, pos + 8), "blurY": fixed(data, pos + 12), "angle": fixed(data, pos + 16),
                 "distance": fixed(data, pos + 20), "strength": fixed8(data, pos + 24)}
            flags = data[pos + 26]
            f.update(inner=bool(flags & 0x80), knockout=bool(flags & 0x40), onTop=bool(flags & 0x10), passes=flags & 0x0F)
            pos += 27
        elif fid in (4, 7):
            n = data[pos]
            colors = [rgba(data, pos + 1 + 4 * i) for i in range(n)]
            ratios = list(data[pos + 1 + 4 * n: pos + 1 + 5 * n])
            pos += 1 + 5 * n
            f = {"type": "gradientGlow" if fid == 4 else "gradientBevel", "colors": colors, "ratios": ratios,
                 "blurX": fixed(data, pos), "blurY": fixed(data, pos + 4), "angle": fixed(data, pos + 8),
                 "distance": fixed(data, pos + 12), "strength": fixed8(data, pos + 16)}
            flags = data[pos + 18]
            f.update(inner=bool(flags & 0x80), knockout=bool(flags & 0x40), onTop=bool(flags & 0x10), passes=flags & 0x0F)
            pos += 19
        elif fid == 5:
            mx, my = data[pos], data[pos + 1]
            divisor, bias = struct.unpack_from("<ff", data, pos + 2)
            mat = list(struct.unpack_from("<%df" % (mx * my), data, pos + 10))
            pos += 10 + 4 * mx * my
            f = {"type": "convolution", "matrixX": mx, "matrixY": my, "divisor": divisor, "bias": bias,
                 "matrix": mat, "color": rgba(data, pos), "flags": data[pos + 4]}
            pos += 5
        elif fid == 6:
            f = {"type": "colorMatrix", "matrix": [round(v, 6) for v in struct.unpack_from("<20f", data, pos)]}
            pos += 80
        else:
            raise ValueError(f"filtro desconhecido {fid}")
        out.append(f)
    return out, pos


def place(code: int, data: bytes, p: int, end: int) -> dict:
    if code == 4:
        cid, depth = struct.unpack_from("<HH", data, p)
        m, q = matrix(data, p + 4)
        op = {"op": "place", "d": depth, "c": cid, "m": m}
        if q < end:
            op["cx"], _ = cxform(data, q, False)
        return op
    flags = data[p]
    flags2 = data[p + 1] if code == 70 else 0
    q = p + (2 if code == 70 else 1)
    depth = struct.unpack_from("<H", data, q)[0]
    q += 2
    op: dict = {"op": "place", "d": depth}
    if flags & 0x01:
        op["move"] = 1
    if code == 70 and (flags2 & 0x08 or (flags2 & 0x10 and flags & 0x02)):
        op["cls"], q = swf.cstring(data, q)
    if flags & 0x02:
        op["c"] = struct.unpack_from("<H", data, q)[0]
        q += 2
    if flags & 0x04:
        op["m"], q = matrix(data, q)
    if flags & 0x08:
        op["cx"], q = cxform(data, q, True)
    if flags & 0x10:
        op["r"] = struct.unpack_from("<H", data, q)[0]
        q += 2
    if flags & 0x20:
        op["n"], q = swf.cstring(data, q)
    if flags & 0x40:
        op["clip"] = struct.unpack_from("<H", data, q)[0]
        q += 2
    if code == 70:
        if flags2 & 0x01:
            op["f"], q = filters(data, q)
        if flags2 & 0x02:
            op["bl"] = BLEND.get(data[q], "normal")
            q += 1
        if flags2 & 0x04:
            op["cab"] = data[q]
            q += 1
        if flags2 & 0x20:
            op["v"] = data[q]
            q += 1
    return op


def timeline(data: bytes, pos: int, end: int) -> dict:
    frames: list[list[dict]] = [[]]
    labels: dict[str, int] = {}
    for code, p, ln in swf.tags(data, pos, end):
        if code == 1:
            frames.append([])
        elif code == 43:
            labels[swf.cstring(data, p)[0]] = len(frames)
        elif code in (4, 26, 70):
            frames[-1].append(place(code, data, p, p + ln))
        elif code == 5:
            frames[-1].append({"op": "remove", "d": struct.unpack_from("<H", data, p + 2)[0]})
        elif code == 28:
            frames[-1].append({"op": "remove", "d": struct.unpack_from("<H", data, p)[0]})
    if not frames[-1]:
        frames.pop()
    return {"frames": max(len(frames), 1), "labels": labels, "timeline": frames}


def button(code: int, data: bytes, p: int, end: int) -> dict:
    q = p + 2
    if code == 34:
        q += 3
    records = []
    while q < end and data[q]:
        flags = data[q]
        rec = {"states": [s for s, bit in (("up", 1), ("over", 2), ("down", 4), ("hit", 8)) if flags & bit]}
        rec["c"], rec["d"] = struct.unpack_from("<HH", data, q + 1)
        rec["m"], q = matrix(data, q + 5)
        if code == 34:
            rec["cx"], q = cxform(data, q, True)
            if flags & 0x10:
                rec["f"], q = filters(data, q)
            if flags & 0x20:
                rec["bl"] = BLEND.get(data[q], "normal")
                q += 1
        records.append(rec)
    return {"kind": "button", "records": records}


def edit_text(data: bytes, p: int, end: int) -> dict:
    bounds, q = swf.rect(data, p + 2)
    f1, f2 = data[q], data[q + 1]
    q += 2
    out = {"kind": "edit", **bounds,
           "wordWrap": bool(f1 & 0x40), "multiline": bool(f1 & 0x20), "password": bool(f1 & 0x10),
           "readOnly": bool(f1 & 0x08), "autoSize": bool(f2 & 0x40), "selectable": not (f2 & 0x10),
           "border": bool(f2 & 0x08), "html": bool(f2 & 0x02), "embedFonts": bool(f2 & 0x01)}
    if f1 & 0x01:
        out["font"], out["size"] = struct.unpack_from("<HH", data, q)
        out["size"] /= 20
        q += 4
    elif f2 & 0x80:
        out["fontClass"], q = swf.cstring(data, q)
        out["size"] = struct.unpack_from("<H", data, q)[0] / 20
        q += 2
    if f1 & 0x04:
        out["color"] = rgba(data, q)
        q += 4
    if f1 & 0x02:
        out["maxChars"] = struct.unpack_from("<H", data, q)[0]
        q += 2
    if f2 & 0x20:
        align, lm, rm, ind, lead = struct.unpack_from("<BHHHh", data, q)
        out.update(align=["left", "right", "center", "justify"][align] if align < 4 else "left",
                   leftMargin=lm / 20, rightMargin=rm / 20, indent=ind / 20, leading=lead / 20)
        q += 9
    out["variable"], q = swf.cstring(data, q)
    if f1 & 0x80:
        out["text"], q = swf.cstring(data, q)
    return out


def font(code: int, data: bytes, p: int) -> dict:
    if code == 10:
        return {"kind": "font"}
    flags = data[p + 2]
    n = data[p + 4]
    name = data[p + 5:p + 5 + n].split(b"\x00")[0].decode("utf-8", "replace")
    return {"kind": "font", "name": name, "bold": bool(flags & 0x01), "italic": bool(flags & 0x02)}


def library(path: pathlib.Path | str) -> dict:
    data = swf.unpack(pathlib.Path(path).read_bytes())
    stage, pos = swf.rect(data, 8)
    fps = data[pos + 1] + data[pos] / 256
    pos += 4
    chars: dict[int, dict] = {}
    linkage: dict[str, int] = {}
    main_start = pos
    for code, p, ln in swf.tags(data, pos, len(data)):
        end = p + ln
        try:
            if code in (46, 84):
                import morph
                chars[struct.unpack_from("<H", data, p)[0]] = morph.parse(code, data, p, end)
            elif code in swf.BITMAP_TAGS or code in swf.SHAPE_TAGS or code in (11, 33):
                info = swf.read_char(code, data, p, end) if hasattr(swf, "read_char") else None
                cid = struct.unpack_from("<H", data, p)[0]
                kind = "bitmap" if code in swf.BITMAP_TAGS else ("text" if code in (11, 33) else "shape")
                entry: dict = {"kind": kind}
                if kind == "bitmap":
                    if code in (20, 36):
                        entry["w"], entry["h"] = struct.unpack_from("<HH", data, p + 3)
                    else:
                        off = {6: 2, 21: 2, 35: 6, 90: 8}[code]
                        size = swf.image_size(data[p + off:end])
                        if size:
                            entry["w"], entry["h"] = size
                else:
                    r, _ = swf.rect(data, p + 2)
                    entry.update(r)
                    if code in swf.SHAPE_TAGS and code in (46, 84):
                        entry["kind"] = "morph"
                chars[cid] = entry
            elif code == 39:
                cid = struct.unpack_from("<H", data, p)[0]
                chars[cid] = {"kind": "sprite", **timeline(data, p + 4, end)}
            elif code in (7, 34):
                chars[struct.unpack_from("<H", data, p)[0]] = button(code, data, p, end)
            elif code == 37:
                chars[struct.unpack_from("<H", data, p)[0]] = edit_text(data, p, end)
            elif code in (10, 48, 75):
                chars[struct.unpack_from("<H", data, p)[0]] = font(code, data, p)
            elif code == 14:
                chars[struct.unpack_from("<H", data, p)[0]] = {"kind": "sound"}
            elif code == 87:
                chars[struct.unpack_from("<H", data, p)[0]] = {"kind": "binary"}
            elif code in (76, 56):
                count = struct.unpack_from("<H", data, p)[0]
                q = p + 2
                for _ in range(count):
                    cid = struct.unpack_from("<H", data, q)[0]
                    name, q = swf.cstring(data, q + 2)
                    linkage[name] = cid
        except (struct.error, IndexError, ValueError) as exc:
            chars.setdefault(struct.unpack_from("<H", data, p)[0] if ln >= 2 else -1, {"kind": "error", "error": str(exc)})
    main = timeline(data, main_start, len(data))
    return {"stage": stage, "fps": fps, "linkage": linkage,
            "chars": {str(k): v for k, v in sorted(chars.items())}, "main": main}


if __name__ == "__main__":
    lib = library(sys.argv[1])
    print(json.dumps(lib, ensure_ascii=False)[:4000])
