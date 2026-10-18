#!/usr/bin/env python3
from __future__ import annotations
import argparse, json, struct, zlib
from pathlib import Path
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[2]


def decode(blob: bytes):
    if blob[4:5] == b"\x78":
        blob = zlib.decompress(blob[4:])
    p = 4
    version = struct.unpack(">I", blob[:4])[0]
    out = []
    while p < len(blob):
        n = blob[p]; p += 1
        name = blob[p:p + n].decode("utf-8"); p += n
        ln = struct.unpack(">i", blob[p:p + 4])[0]; p += 4
        out.append((name, blob[p:p + ln].decode("utf-8", "replace"))); p += ln
    return version, out


def infer(values):
    t = "int"
    for v in values:
        if v == "":
            continue
        try:
            i = int(v)
            if not -2**31 <= i < 2**31:
                t = "bigint" if t == "int" else t
            continue
        except ValueError:
            pass
        try:
            float(v); t = "numeric" if t in ("int", "bigint") else t; continue
        except ValueError:
            return "text"
    return t


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--src", default=str(ROOT / "data/tpl/tempinfos.xml"))
    ap.add_argument("--out", default=str(ROOT / "data/tpl/tempinfos"))
    a = ap.parse_args()
    version, recs = decode(Path(a.src).read_bytes())
    out = Path(a.out); out.mkdir(parents=True, exist_ok=True)
    stats = {"_version": version}
    for order, (name, xml) in enumerate(recs):
        (out / f"{name}.xml").write_text(xml, encoding="utf-8")
        try:
            root = ET.fromstring(xml)
        except ET.ParseError as e:
            stats[name] = {"order": order, "error": str(e)}
            continue
        kids = list(root)
        fields: dict[str, list] = {}
        tags = {}
        for k in kids:
            tags[k.tag] = tags.get(k.tag, 0) + 1
            for at, v in k.attrib.items():
                fields.setdefault(at, []).append(v)
        stats[name] = {
            "order": order, "root": root.tag, "items": tags, "count": len(kids),
            "nested": sum(1 for k in kids if len(k)),
            "fields": {at: {"n": len(v), "type": infer(v), "distinct": len(set(v)),
                            "sample": next((x for x in v if x not in ("", "0")), v[0])[:80]}
                       for at, v in fields.items()},
        }
    (out / "_fields.json").write_text(json.dumps(stats, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"versão {version}: {len(recs)} templates → {out}")


if __name__ == "__main__":
    main()
