from __future__ import annotations

import hashlib
import io
import json
import os
from pathlib import Path

import psycopg2
import psycopg2.extras

ROOT = Path(__file__).resolve().parents[2]
DSN = os.environ.get("LOBR_DB_DSN", "postgresql://lobr:lobr@127.0.0.1:5464/lobr")
TPL_DIR = ROOT / "data/tpl/tempinfos"
RESEARCH_DIR = ROOT / "data/research"


def connect():
    return psycopg2.connect(DSN, options="-c search_path=game,client,raw,meta,public")


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def register_source(cur, name: str, kind: str, location: str, path: Path | None = None,
                    version: str | None = None, notes: str | None = None):
    digest = size = None
    if path is not None and path.exists():
        digest, size = sha256(path), path.stat().st_size
    cur.execute(
        """INSERT INTO meta.data_sources(name, kind, location, version, sha256, byte_size, notes)
           VALUES (%s,%s,%s,%s,%s,%s,%s)
           ON CONFLICT (name) DO UPDATE SET kind=EXCLUDED.kind, location=EXCLUDED.location,
             version=EXCLUDED.version, sha256=EXCLUDED.sha256, byte_size=EXCLUDED.byte_size,
             notes=EXCLUDED.notes, loaded_at=now()""",
        (name, kind, location, version, digest, size, notes))


class J:
    __slots__ = ("v",)

    def __init__(self, v):
        self.v = v


def _copy_value(v):
    if v is None:
        return r"\N"
    if isinstance(v, J):
        if v.v is None:
            return r"\N"
        v = json.dumps(v.v, ensure_ascii=False)
    if isinstance(v, bool):
        return "t" if v else "f"
    if isinstance(v, (list, tuple)):
        return pg_array(v)
    if isinstance(v, (dict,)):
        v = json.dumps(v, ensure_ascii=False)
    s = str(v)
    return s.replace("\\", "\\\\").replace("\t", "\\t").replace("\n", "\\n").replace("\r", "\\r")


def pg_array(values) -> str:
    out = []
    for x in values:
        if x is None:
            out.append("NULL")
        elif isinstance(x, (int, float)):
            out.append(str(x))
        else:
            out.append('"' + str(x).replace("\\", "\\\\").replace('"', '\\"') + '"')
    return "{" + ",".join(out) + "}"


def copy_rows(cur, table: str, columns: list[str], rows) -> int:
    buf = io.StringIO()
    n = 0
    for r in rows:
        buf.write("\t".join(_copy_value(v) for v in r) + "\n")
        n += 1
    buf.seek(0)
    cur.copy_expert(f"COPY {table} ({', '.join(columns)}) FROM STDIN", buf)
    return n


def load_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))
