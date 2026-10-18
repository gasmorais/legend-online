#!/usr/bin/env python3
from __future__ import annotations

import argparse
import concurrent.futures as futures
import csv
import hashlib
import json
import re
import sys
import time
import urllib.error
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from lobr import http_get

ROOT = Path(__file__).resolve().parent.parent
CSV = ROOT / "index" / "manifest_all.csv"
OUT = ROOT / "raw"
PATTERN = re.compile(r"chess|chesspvp|autochess|selfchess", re.I)


def md5_ok(data: bytes, expected: str) -> bool:
    return hashlib.md5(data).hexdigest()[8:16] == expected


def select() -> list[dict]:
    with CSV.open(newline="") as fh:
        rows = [r for r in csv.DictReader(fh) if PATTERN.search(r["path"])]
    return sorted(rows, key=lambda r: r["path"])


def fetch(row: dict) -> dict:
    target = OUT / row["path"]
    size = int(row["size"])
    result = {"path": row["path"], "manifest": row["manifest"], "url": row["url"],
              "size_expected": size}
    if target.exists() and target.stat().st_size == size and md5_ok(target.read_bytes(), row["md5"]):
        return result | {"status": "presente", "size": size}
    target.parent.mkdir(parents=True, exist_ok=True)
    last = ""
    for attempt in range(3):
        try:
            data = http_get(row["url"])
            if len(data) != size:
                last = f"tamanho {len(data)} != {size}"
            elif not md5_ok(data, row["md5"]):
                last = "md5 divergente"
            else:
                target.write_bytes(data)
                return result | {"status": "baixado", "size": len(data)}
        except urllib.error.HTTPError as error:
            if error.code in (403, 404):
                return result | {"status": f"HTTP {error.code}"}
            last = f"HTTP {error.code}"
        except Exception as error:
            last = repr(error)
        time.sleep(0.5 * (attempt + 1))
    return result | {"status": f"falha: {last}"}


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--jobs", type=int, default=6)
    ap.add_argument("--report", type=Path)
    args = ap.parse_args()

    rows = select()
    print(f"{len(rows)} caminhos de xadrez no manifesto -> {OUT.relative_to(ROOT)}/")
    if args.dry_run:
        for r in rows:
            print(f"  {r['manifest']:4} {r['size']:>8}  {r['path']}")
        return
    with futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
        results = list(pool.map(fetch, rows))
    for r in results:
        print(f"  {r['status']:10} {r.get('size', 0):>8}  {r['path']}")
    bad = [r for r in results if r["status"] not in ("baixado", "presente")]
    ok = len(results) - len(bad)
    print(f"ok: {ok}/{len(results)}, {sum(r.get('size', 0) for r in results)/1e6:.2f} MB; falhas: {len(bad)}")
    if args.report:
        args.report.write_text(json.dumps(results, indent=1, ensure_ascii=False))


if __name__ == "__main__":
    main()
