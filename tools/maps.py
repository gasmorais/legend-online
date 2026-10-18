#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
import zlib

import amf3

ROOT = pathlib.Path(__file__).resolve().parent.parent
SRC = ROOT / "raw/maps"
OUT = ROOT / "web/public/maps"
CELL = 20
ITEM_KEYS = ("name", "url", "x", "y", "type", "baseNum", "alpha", "scaleX", "scaleY", "rotation", "width", "height",
             "visible", "lock", "id")


def clean(v):
    if isinstance(v, dict):
        return {k: clean(x) for k, x in v.items() if k != "display"}
    if isinstance(v, list):
        return [clean(x) for x in v]
    return v


def runs(cells: dict[str, int]) -> tuple[dict[str, list], int, int]:
    by_val: dict[int, dict[int, list[int]]] = {}
    cols = rows = 0
    for k, v in cells.items():
        x, y = (int(p) for p in k.split("_"))
        cols, rows = max(cols, x + 1), max(rows, y + 1)
        by_val.setdefault(v, {}).setdefault(x, []).append(y)
    out: dict[str, list] = {}
    for v, colmap in by_val.items():
        lst = []
        for x, ys in sorted(colmap.items()):
            ys.sort()
            start = prev = ys[0]
            for y in ys[1:]:
                if y != prev + 1:
                    lst.append([x, start, prev])
                    start = y
                prev = y
            lst.append([x, start, prev])
        out[str(v)] = lst
    return out, cols, rows


def items(layer) -> tuple[list[dict], list[dict]]:
    out, nodes = [], []
    for cell, lst in (layer or {}).items():
        for it in lst if isinstance(lst, list) else []:
            if not isinstance(it, dict):
                continue
            rec = {k: it[k] for k in ITEM_KEYS if k in it}
            rec["cell"] = cell
            m = it.get("matrix")
            if isinstance(m, dict) and all(k in m for k in "abcd"):
                rec["matrix"] = [m["a"], m["b"], m["c"], m["d"], m.get("tx", 0), m.get("ty", 0)]
            node = it.get("campaign")
            if isinstance(node, dict) and node:
                node = clean({k: v for k, v in node.items() if not k.startswith("__")})
                node.update(x=it.get("x"), y=it.get("y"), url=it.get("url"), layerName=it.get("name"))
                rec["node"] = node.get("id")
                nodes.append(node)
            out.append(rec)
    out.sort(key=lambda r: (r.get("baseNum", 0), r.get("y", 0)))
    return out, nodes


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    index = {}
    for d in sorted(SRC.iterdir(), key=lambda p: (len(p.name), p.name)):
        mp, tp = d / f"{d.name}.maps", d / f"{d.name}.titles"
        objs = amf3.read_all(zlib.decompress(mp.read_bytes())) if mp.exists() else []
        tiles = amf3.read_all(zlib.decompress(tp.read_bytes()))[0] if tp.exists() else {}
        walk, cols, rows = runs(tiles or {})
        rec: dict = {"id": d.name, "cell": CELL, "cols": cols, "rows": rows, "width": cols * CELL, "height": rows * CELL,
                     "walk": walk, "nodes": []}
        for name, layer in zip(("floor", "movies", "tops"), objs[1:4] if len(objs) == 4 else objs[:3]):
            lst, nodes = items(layer)
            rec[name] = lst
            rec["nodes"] += nodes
        (OUT / f"{d.name}.json").write_text(json.dumps(rec, ensure_ascii=False, separators=(",", ":")))
        index[d.name] = {"width": rec["width"], "height": rec["height"], "walkCells": sum(len(v) for v in tiles.values()) if False else len(tiles),
                         "floor": len(rec.get("floor", [])), "movies": len(rec.get("movies", [])), "tops": len(rec.get("tops", [])),
                         "nodes": len(rec["nodes"])}
    (OUT / "index.json").write_text(json.dumps(index, ensure_ascii=False, indent=0))
    print("mapas:", len(index), "nós:", sum(v["nodes"] for v in index.values()),
          "itens:", sum(v["floor"] + v["movies"] + v["tops"] for v in index.values()))


if __name__ == "__main__":
    main()
