#!/usr/bin/env python3
from __future__ import annotations

import struct

import swf
from swflib import Bits, matrix, rgba


def style_count(data: bytes, pos: int) -> tuple[int, int]:
    n = data[pos]
    pos += 1
    if n == 0xFF:
        n = struct.unpack_from("<H", data, pos)[0]
        pos += 2
    return n, pos


def morph_fill(data: bytes, pos: int) -> tuple[dict, int]:
    t = data[pos]
    pos += 1
    if t == 0x00:
        return {"type": "solid", "start": rgba(data, pos), "end": rgba(data, pos + 4)}, pos + 8
    if t in (0x10, 0x12, 0x13):
        sm, pos = matrix(data, pos)
        em, pos = matrix(data, pos)
        n = data[pos] & 0x0F
        pos += 1
        stops = []
        for _ in range(n):
            stops.append([data[pos], rgba(data, pos + 1), data[pos + 5], rgba(data, pos + 6)])
            pos += 10
        if t == 0x13:
            pos += 4
        return {"type": "linear" if t == 0x10 else "radial", "startMatrix": sm, "endMatrix": em, "stops": stops}, pos
    if 0x40 <= t <= 0x43:
        bid = struct.unpack_from("<H", data, pos)[0]
        sm, pos = matrix(data, pos + 2)
        em, pos = matrix(data, pos)
        return {"type": "bitmap", "bitmap": bid, "startMatrix": sm, "endMatrix": em,
                "repeat": t in (0x40, 0x42), "smooth": t in (0x40, 0x41)}, pos
    raise ValueError(f"morph fill {t:#x}")


def morph_lines(data: bytes, pos: int, v2: bool) -> tuple[list[dict], int]:
    n, pos = style_count(data, pos)
    out = []
    for _ in range(n):
        sw, ew = struct.unpack_from("<HH", data, pos)
        pos += 4
        st: dict = {"startWidth": sw / 20, "endWidth": ew / 20}
        if v2:
            f1, f2 = data[pos], data[pos + 1]
            pos += 2
            join = (f1 >> 4) & 3
            has_fill = bool(f1 & 0x08)
            if join == 2:
                pos += 2
            if has_fill:
                st["fill"], pos = morph_fill(data, pos)
            else:
                st["start"], st["end"] = rgba(data, pos), rgba(data, pos + 4)
                pos += 8
        else:
            st["start"], st["end"] = rgba(data, pos), rgba(data, pos + 4)
            pos += 8
        out.append(st)
    return out, pos


def shape_records(data: bytes, pos: int, end: int) -> list[dict]:
    b = Bits(data, pos)
    nfill, nline = b.ub(4), b.ub(4)
    recs = []
    while b.pos < end:
        if b.ub(1) == 0:
            flags = b.ub(5)
            if flags == 0:
                break
            r: dict = {"t": "style"}
            if flags & 0x01:
                n = b.ub(5)
                r["move"] = (b.sb(n) / 20, b.sb(n) / 20)
            if flags & 0x02:
                r["f0"] = b.ub(nfill)
            if flags & 0x04:
                r["f1"] = b.ub(nfill)
            if flags & 0x08:
                r["l"] = b.ub(nline)
            if flags & 0x10:
                raise ValueError("NewStyles em morph")
            recs.append(r)
        elif b.ub(1):
            n = b.ub(4) + 2
            if b.ub(1):
                dx, dy = b.sb(n), b.sb(n)
            elif b.ub(1):
                dx, dy = 0, b.sb(n)
            else:
                dx, dy = b.sb(n), 0
            recs.append({"t": "line", "d": (dx / 20, dy / 20)})
        else:
            n = b.ub(4) + 2
            cx, cy, ax, ay = b.sb(n), b.sb(n), b.sb(n), b.sb(n)
            recs.append({"t": "curve", "c": (cx / 20, cy / 20), "a": (ax / 20, ay / 20)})
    return recs


def edges(start: list[dict], end: list[dict]) -> list[dict]:
    out = []
    sx = sy = ex = ey = 0.0
    f0 = f1 = ln = 0
    ei = 0
    end_edges = [r for r in end]
    for r in start:
        if r["t"] == "style":
            if "move" in r:
                sx, sy = r["move"]
                while ei < len(end_edges) and end_edges[ei]["t"] == "style" and "move" not in end_edges[ei]:
                    ei += 1
                if ei < len(end_edges) and end_edges[ei]["t"] == "style":
                    ex, ey = end_edges[ei]["move"]
                    ei += 1
            f0 = r.get("f0", f0)
            f1 = r.get("f1", f1)
            ln = r.get("l", ln)
            continue
        while ei < len(end_edges) and end_edges[ei]["t"] == "style":
            if "move" in end_edges[ei]:
                ex, ey = end_edges[ei]["move"]
            ei += 1
        e = end_edges[ei] if ei < len(end_edges) else r
        ei += 1

        def seg(rec, x, y):
            if rec["t"] == "line":
                dx, dy = rec["d"]
                return (x + dx / 2, y + dy / 2), (x + dx, y + dy)
            (cx, cy), (ax, ay) = rec["c"], rec["a"]
            return (x + cx, y + cy), (x + cx + ax, y + cy + ay)

        (sc, sa), (ec, ea) = seg(r, sx, sy), seg(e, ex, ey)
        out.append({"s0": (sx, sy), "sc": sc, "s1": sa, "e0": (ex, ey), "ec": ec, "e1": ea,
                    "f0": f0, "f1": f1, "l": ln, "curve": r["t"] == "curve" or e["t"] == "curve"})
        sx, sy = sa
        ex, ey = ea
    return out


def key(p) -> tuple:
    return (round(p[0], 2), round(p[1], 2))


def contours(segs: list[dict]) -> list[list[dict]]:
    by_start: dict[tuple, list[int]] = {}
    for i, s in enumerate(segs):
        by_start.setdefault(key(s["s0"]), []).append(i)
    used = [False] * len(segs)
    paths = []
    for i in range(len(segs)):
        if used[i]:
            continue
        path = [segs[i]]
        used[i] = True
        cur = segs[i]
        while True:
            nxt = next((j for j in by_start.get(key(cur["s1"]), []) if not used[j]), None)
            if nxt is None:
                break
            used[nxt] = True
            cur = segs[nxt]
            path.append(cur)
        paths.append(path)
    return paths


def reverse(s: dict) -> dict:
    return {**s, "s0": s["s1"], "s1": s["s0"], "e0": s["e1"], "e1": s["e0"]}


def to_cmds(path: list[dict], which: str) -> list[list]:
    p0, pc, p1 = ("s0", "sc", "s1") if which == "start" else ("e0", "ec", "e1")
    cmds: list[list] = [["M", *map(lambda v: round(v, 2), path[0][p0])]]
    for s in path:
        if s["curve"]:
            cmds.append(["Q", round(s[pc][0], 2), round(s[pc][1], 2), round(s[p1][0], 2), round(s[p1][1], 2)])
        else:
            cmds.append(["L", round(s[p1][0], 2), round(s[p1][1], 2)])
    return cmds


def parse(code: int, data: bytes, p: int, end: int) -> dict:
    sb, q = swf.rect(data, p + 2)
    eb, q = swf.rect(data, q)
    v2 = code == 84
    if v2:
        _, q = swf.rect(data, q)
        _, q = swf.rect(data, q)
        q += 1
    offset = struct.unpack_from("<I", data, q)[0]
    q += 4
    end_edges_pos = q + offset
    nf, q = style_count(data, q)
    fills = []
    for _ in range(nf):
        f, q = morph_fill(data, q)
        fills.append(f)
    lines, q = morph_lines(data, q, v2)
    start = shape_records(data, q, end_edges_pos)
    endr = shape_records(data, end_edges_pos, end)
    segs = edges(start, endr)
    paths = []
    for fi in range(1, len(fills) + 1):
        oriented = [s for s in segs if s["f1"] == fi] + [reverse(s) for s in segs if s["f0"] == fi]
        for path in contours(oriented):
            paths.append({"fill": fi - 1, "start": to_cmds(path, "start"), "end": to_cmds(path, "end")})
    for li in range(1, len(lines) + 1):
        for path in contours([s for s in segs if s["l"] == li]):
            paths.append({"line": li - 1, "start": to_cmds(path, "start"), "end": to_cmds(path, "end")})
    return {"kind": "morph", "x": sb["x"], "y": sb["y"], "w": sb["w"], "h": sb["h"],
            "endBounds": eb, "fills": fills, "lines": lines, "paths": paths}
