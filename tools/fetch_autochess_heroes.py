#!/usr/bin/env python3
from __future__ import annotations

import argparse
import concurrent.futures as futures
import csv
import hashlib
import json
import sys
import urllib.error
import xml.etree.ElementTree as ET
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from lobr import RES, http_get

ROOT = Path(__file__).resolve().parent.parent
XML = ROOT / "data" / "tpl" / "tempinfos" / "AutoChessHeroInfos.xml"
CSV = ROOT / "index" / "manifest_all.csv"
OUT = ROOT / "raw"


def resources() -> dict[str, list[str]]:
    used: dict[str, list[str]] = {}
    for node in ET.parse(XML).getroot():
        a = node.attrib
        kind, res = a["ResType"], a["ResPath"]
        if kind == "1":
            body = f"swf/{res}/{res}.swf"
        elif kind == "2":
            body = f"equip{res}/2.swf"
        else:
            body = res.lstrip("/")
        for path in (body, a["Icon"].lstrip("/")):
            used.setdefault(path, []).append(a["TemplateId"])
    return used


def fetch(path: str, manifest: dict[str, dict]) -> dict:
    row = manifest.get(path)
    url = row["url"] if row else f"{RES}/{path}"
    result = {"path": path, "url": url, "in_manifest": bool(row)}
    target = OUT / path
    if target.exists() and target.stat().st_size > 0:
        if not row or hashlib.md5(target.read_bytes()).hexdigest()[8:16] == row["md5"]:
            return result | {"status": "presente", "size": target.stat().st_size}
    try:
        data = http_get(url)
    except urllib.error.HTTPError as error:
        return result | {"status": f"HTTP {error.code}"}
    except Exception as error:
        return result | {"status": f"falha: {error!r}"}
    if row and hashlib.md5(data).hexdigest()[8:16] != row["md5"]:
        return result | {"status": "md5 divergente"}
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes(data)
    return result | {"status": "baixado", "size": len(data)}


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--jobs", type=int, default=6)
    ap.add_argument("--report", type=Path)
    args = ap.parse_args()
    with CSV.open(newline="") as fh:
        manifest = {r["path"]: r for r in csv.DictReader(fh)}
    used = resources()
    if args.dry_run:
        for path, ids in sorted(used.items()):
            print(("M " if path in manifest else "- ") + path, ",".join(ids))
        return
    with futures.ThreadPoolExecutor(args.jobs) as pool:
        results = list(pool.map(lambda p: fetch(p, manifest), sorted(used)))
    for item in results:
        item["templates"] = used[item["path"]]
        print(f"{item['status']:>14}  {item.get('size', 0):>9}  {item['path']}")
    ok = sum(r["status"] in ("baixado", "presente") for r in results)
    print(f"{ok}/{len(results)} ok")
    if args.report:
        args.report.write_text(json.dumps(results, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()
