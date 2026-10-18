#!/usr/bin/env python3
from __future__ import annotations

import argparse
import concurrent.futures as futures
import csv
import fnmatch
import json
import os
import re
import ssl
import sys
import threading
import time
import urllib.error
import urllib.request
import zlib
from dataclasses import dataclass, asdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
INDEX = ROOT / "index"
RAW = ROOT / "raw"
LOGS = ROOT / "logs"
ROUTES = ROOT / "routes"
PROTO = ROOT / "protocol"

APP = "https://s1264oas.creaction-network.com"
RES = "https://res1264oas.creaction-network.com"
SITE = "https://lobr.creaction-network.com"
SOCKET_HOST = "s1264oas.creaction-network.com"
SOCKET_PORT = 5004
SITE_ID = "broas_1264"

UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

SSL_CTX = ssl.create_default_context()
SSL_CTX.check_hostname = False
SSL_CTX.verify_mode = ssl.CERT_NONE

MANIFESTS = {
    "code": f"{APP}/client/code_md5.dat",
    "res": f"{APP}/client/res_md5.dat",
}


def inflate_all(data: bytes) -> bytes:
    while len(data) > 2 and data[0] == 0x78:
        try:
            data = zlib.decompress(data)
        except zlib.error:
            break
    return data


@dataclass
class Item:
    name: str
    md5: str
    size: int
    manifest: str = ""

    @property
    def path(self) -> str:
        return self.name.replace("\\", "/")

    @property
    def ext(self) -> str:
        return os.path.splitext(self.path)[1].lstrip(".").lower()

    @property
    def hashed(self) -> str:
        directory, _, filename = self.path.rpartition("/")
        stem, dot, ext = filename.rpartition(".")
        if not dot:
            stem, ext = filename, ""
        hashed = f"{stem}_{self.md5}.{ext}" if ext else f"{filename}_{self.md5}"
        return f"{directory}/{hashed}" if directory else hashed

    @property
    def url(self) -> str:
        return f"{RES}/{self.hashed}"


def http_get(url: str, timeout: int = 40) -> bytes:
    request = urllib.request.Request(url, headers={"User-Agent": UA})
    with urllib.request.urlopen(request, timeout=timeout, context=SSL_CTX) as response:
        return response.read()


def load_manifest(name: str, refresh: bool = False) -> list[Item]:
    cache = INDEX / f"{name}_md5.raw"
    if refresh or not cache.exists():
        cache.write_bytes(http_get(MANIFESTS[name]))
    text = inflate_all(cache.read_bytes()).decode("utf-8-sig", "replace")
    items = []
    for match in re.finditer(r'name="([^"]+)"\s+md5="([0-9a-f]+)"\s+size="(\d+)"', text):
        items.append(Item(match.group(1), match.group(2), int(match.group(3)), name))
    return items


def cmd_manifest(args) -> None:
    INDEX.mkdir(parents=True, exist_ok=True)
    all_items: list[Item] = []
    for name in ("code", "res"):
        items = load_manifest(name, args.refresh)
        payload = [asdict(i) | {"path": i.path, "url": i.url} for i in items]
        (INDEX / f"manifest_{name}.json").write_text(json.dumps(payload, indent=1))
        all_items += items
        print(f"{name}: {len(items)} itens, {sum(i.size for i in items)/1e6:.1f} MB")

    with (INDEX / "manifest_all.csv").open("w", newline="") as handle:
        writer = csv.writer(handle)
        writer.writerow(["manifest", "name", "path", "ext", "md5", "size", "url"])
        for item in all_items:
            writer.writerow([item.manifest, item.name, item.path, item.ext, item.md5, item.size, item.url])

    by_ext: dict[str, list[int]] = {}
    by_top: dict[str, list[int]] = {}
    for item in all_items:
        by_ext.setdefault(item.ext or "(none)", [0, 0])
        by_ext[item.ext or "(none)"][0] += 1
        by_ext[item.ext or "(none)"][1] += item.size
        top = item.path.split("/")[0] if "/" in item.path else "(root)"
        by_top.setdefault(top, [0, 0])
        by_top[top][0] += 1
        by_top[top][1] += item.size

    summary = {
        "total_items": len(all_items),
        "total_bytes": sum(i.size for i in all_items),
        "by_extension": {k: {"count": v[0], "bytes": v[1]} for k, v in sorted(by_ext.items(), key=lambda kv: -kv[1][1])},
        "by_top_dir": {k: {"count": v[0], "bytes": v[1]} for k, v in sorted(by_top.items(), key=lambda kv: -kv[1][1])},
    }
    (INDEX / "summary.json").write_text(json.dumps(summary, indent=1))
    write_summary_md(summary)
    print(f"total: {summary['total_items']} itens, {summary['total_bytes']/1e9:.2f} GB")


def write_summary_md(summary: dict) -> None:
    LABELS = {"(sem)": "(none)", "(raiz)": "(root)"}
    lines = ["# Resource inventory: OAS1264", "",
             f"- Items: **{summary['total_items']}**",
             f"- Size: **{summary['total_bytes']/1e9:.2f} GB**", "",
             "## By extension", "", "| ext | items | size |", "|---|---:|---:|"]
    for ext, data in summary["by_extension"].items():
        lines.append(f"| {LABELS.get(ext, ext)} | {data['count']} | {data['bytes']/1e6:.1f} MB |")
    lines += ["", "## By top-level directory", "", "| dir | items | size |", "|---|---:|---:|"]
    for top, data in summary["by_top_dir"].items():
        lines.append(f"| {LABELS.get(top, top)} | {data['count']} | {data['bytes']/1e6:.1f} MB |")
    (INDEX / "summary.md").write_text("\n".join(lines) + "\n")


ESSENTIAL = [
    "ui/zh_cn/language*.dat", "ui/zh_cn/nameslib*.dat", "audio.swf", "Loading.swf",
    "ui/zh_cn/swf/mainloading*.swf", "ui/zh_cn/swf/mainloadingii*.swf",
    "ui/zh_cn/swf/core*.swf", "ui/zh_cn/swf/common*.swf", "ui/zh_cn/swf/login*.swf",
    "ui/zh_cn/swf/createrole*.swf", "ui/zh_cn/swf/role*.swf",
]


def cmd_fetch(args) -> None:
    sets = {"code": ["code"], "res": ["res"], "all": ["code", "res"]}[args.set]
    items = [item for name in sets for item in load_manifest(name)]
    if args.essential:
        items = [i for i in items if any(fnmatch.fnmatch(i.path, p) for p in ESSENTIAL)]
    if args.filter:
        items = [i for i in items if fnmatch.fnmatch(i.path, args.filter)]
    if args.limit:
        items = items[: args.limit]

    RAW.mkdir(parents=True, exist_ok=True)
    missing: list[tuple[str, int]] = []
    lock = threading.Lock()
    done = [0]
    total_bytes = [0]
    started = time.time()

    def work(item: Item) -> None:
        target = RAW / item.path
        if target.exists() and target.stat().st_size == item.size:
            with lock:
                done[0] += 1
                total_bytes[0] += item.size
            return
        target.parent.mkdir(parents=True, exist_ok=True)
        for attempt in range(3):
            try:
                data = http_get(item.url)
                if args.verify and not _md5_ok(data, item.md5):
                    raise ValueError("md5 divergente")
                target.write_bytes(data)
                with lock:
                    done[0] += 1
                    total_bytes[0] += len(data)
                    _progress(done[0], len(items), total_bytes[0], started)
                return
            except urllib.error.HTTPError as error:
                if error.code in (403, 404):
                    with lock:
                        missing.append((item.path, error.code))
                        done[0] += 1
                        _progress(done[0], len(items), total_bytes[0], started)
                    return
                time.sleep(0.4 * (attempt + 1))
            except Exception:
                time.sleep(0.4 * (attempt + 1))
        with lock:
            missing.append((item.path, 0))
            done[0] += 1

    with futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
        list(pool.map(work, items))

    (INDEX / "missing.json").write_text(json.dumps(missing, indent=1))
    print(f"\nbaixados: {done[0] - len(missing)}/{len(items)}, {total_bytes[0]/1e9:.2f} GB em {int(time.time()-started)}s")
    if missing:
        print(f"ausentes: {len(missing)} (ver index/missing.json)")


def _progress(done: int, total: int, nbytes: int, started: float) -> None:
    if done % 25 and done != total:
        return
    rate = nbytes / max(1.0, time.time() - started) / 1e6
    sys.stdout.write(f"\r{done}/{total}  {nbytes/1e6:.0f} MB  {rate:.1f} MB/s")
    sys.stdout.flush()


def _md5_ok(data: bytes, expected: str) -> bool:
    import hashlib
    return hashlib.md5(data).hexdigest()[8:16] == expected


def cmd_routes(args) -> None:
    ROUTES.mkdir(parents=True, exist_ok=True)
    pattern = re.compile(r"\[(dados|swf|stream)\]\s+(GET|POST|HEAD|PUT)\s+(\S+)")
    hosts: dict[str, dict] = {}
    routes: dict[tuple[str, str], int] = {}
    samples: dict[tuple[str, str], str] = {}
    sources = list(LOGS.glob("*.log")) + [
        Path.home() / "Library/Logs/Legend Online BR/engine-f2955ff6.log",
        Path.home() / "Library/Logs/Legend Remake/requests.log",
    ]
    for source in sources:
        if not source.exists():
            continue
        for line in source.read_text(errors="replace").splitlines():
            match = pattern.search(line)
            if match:
                method, url = match.group(2), match.group(3)
            else:
                legacy = re.search(r"\S+ (GET|POST|HEAD|PUT) (\d{3}) \S+ \d+ ms .+? (\S+)$", line)
                if not legacy:
                    continue
                method, url = legacy.group(1), legacy.group(3)
            host = re.match(r"^[a-z]+://([^/]+)", url)
            host = host.group(1) if host else "?"
            path = re.sub(r"^[a-z]+://[^/]+", "", url).split("?")[0]
            hosts.setdefault(host, {})
            hosts[host][path] = hosts[host].get(path, 0) + 1
            routes[(method, path)] = routes.get((method, path), 0) + 1
            samples.setdefault((method, path), url)

    result = {
        "hosts": hosts,
        "routes": [
            {"method": m, "path": p, "count": c, "sample": samples[(m, p)]}
            for (m, p), c in sorted(routes.items(), key=lambda kv: -kv[1])
        ],
    }
    (ROUTES / "routes.json").write_text(json.dumps(result, indent=1))

    lines = ["# Route map: OAS1264", "", "## Hosts", ""]
    for host, paths in hosts.items():
        lines.append(f"### {host} ({len(paths)} routes)")
        lines.append("")
        for path, count in sorted(paths.items(), key=lambda kv: -kv[1]):
            lines.append(f"- `{path}`: {count}×")
        lines.append("")
    lines += ["## Routes (method, path, hits)", "", "| method | path | n |", "|---|---|---:|"]
    for route in result["routes"]:
        lines.append(f"| {route['method']} | `{route['path']}` | {route['count']} |")
    (ROUTES / "routes.md").write_text("\n".join(lines) + "\n")
    print(f"{len(result['routes'])} rotas em {len(hosts)} hosts -> routes/routes.md")


def cmd_summary(args) -> None:
    path = INDEX / "summary.json"
    if not path.exists():
        print("rode 'manifest' primeiro")
        return
    print(path.read_text())


def main() -> None:
    parser = argparse.ArgumentParser(prog="lobr.py", description=__doc__)
    sub = parser.add_subparsers(dest="cmd", required=True)

    p = sub.add_parser("manifest")
    p.add_argument("--refresh", action="store_true")
    p.set_defaults(func=cmd_manifest)

    p = sub.add_parser("fetch")
    p.add_argument("--set", choices=["code", "res", "all"], default="all")
    p.add_argument("--essential", action="store_true")
    p.add_argument("--filter")
    p.add_argument("--limit", type=int)
    p.add_argument("--jobs", type=int, default=16)
    p.add_argument("--verify", action="store_true")
    p.add_argument("--decompress", action="store_true")
    p.set_defaults(func=cmd_fetch)

    p = sub.add_parser("routes")
    p.set_defaults(func=cmd_routes)

    p = sub.add_parser("summary")
    p.set_defaults(func=cmd_summary)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
