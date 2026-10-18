#!/usr/bin/env python3
import argparse
import concurrent.futures
import csv
import pathlib
import re
import sys

sys.path.insert(0, str(pathlib.Path(__file__).parent))
import lobr

ROOT = pathlib.Path(__file__).resolve().parent.parent
RAW = ROOT / "raw"
MANIFEST = ROOT / "index/manifest_all.csv"
MISSING = ROOT / "logs/cdn_missing.txt"
BASE = "https://res1264oas.creaction-network.com/"

GROUPS = {
    "space": [r"^mapmaterial/land/10000/"],
    "mapname": [r"^images/mapname/"],
    "castle": [r"^images/[^/]+\.swf$", r"^swf/castle/"],
    "icons": [r"^icon/"],
    "skillname": [r"^images/skillname/"],
}


def load_manifest() -> dict[str, tuple[int, str]]:
    out = {}
    with MANIFEST.open() as f:
        for row in csv.DictReader(f):
            out[row["path"].lower()] = (int(row["size"] or 0), row["url"])
    return out


def wanted_by_groups(manifest, names):
    pats = [re.compile(p) for n in names for p in GROUPS[n]]
    return [p for p in manifest if any(x.search(p) for x in pats)]


def wanted_on_demand(manifest, limit_bytes):
    if not MISSING.exists():
        return []
    seen, out, total = set(), [], 0
    for line in MISSING.read_text().splitlines():
        p = re.sub(r"_[0-9a-f]{8}(?=\.\w+$)", "", line.strip().split("?")[0]).lstrip("/").lower()
        if not p or p in seen:
            continue
        seen.add(p)
        if p not in manifest:
            manifest[p] = (0, BASE + p)
        size = manifest[p][0] or 300000
        if total + size > limit_bytes:
            break
        total += size
        out.append(p)
    return out


def fetch(path, url):
    dest = RAW / path
    if dest.exists():
        return 0
    data = lobr.http_get(url)
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_bytes(data)
    return len(data)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("groups", nargs="*", choices=sorted(GROUPS) + ["missing"])
    ap.add_argument("--limit-mb", type=float, default=50)
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()
    manifest = load_manifest()
    paths = wanted_by_groups(manifest, [g for g in args.groups if g != "missing"])
    if "missing" in args.groups:
        paths += wanted_on_demand(manifest, args.limit_mb * 1048576)
    paths = [p for p in dict.fromkeys(paths) if not (RAW / p).exists()]
    total = sum(manifest[p][0] for p in paths)
    print(f"{len(paths)} files, {total / 1048576:.1f} MB")
    if args.dry_run or not paths:
        return
    done = errors = got = 0
    with concurrent.futures.ThreadPoolExecutor(12) as pool:
        futures = {pool.submit(fetch, p, manifest[p][1]): p for p in paths}
        for fut in concurrent.futures.as_completed(futures):
            try:
                got += fut.result()
                done += 1
            except Exception as exc:
                errors += 1
                print("error", futures[fut], exc, file=sys.stderr)
    print(f"downloaded {done} files ({got / 1048576:.1f} MB), {errors} errors")


if __name__ == "__main__":
    main()
