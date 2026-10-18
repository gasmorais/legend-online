#!/usr/bin/env python3
from __future__ import annotations
import argparse
import re
import time

import psycopg2

from common import ROOT, connect

MIG = ROOT / "db/migrations"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--reset", action="store_true", help="apaga schemas meta/client/raw/game e reaplica")
    a = ap.parse_args()
    for attempt in range(60):
        try:
            conn = connect()
            break
        except psycopg2.OperationalError:
            if attempt == 59:
                raise
            time.sleep(2)
    conn.autocommit = True
    cur = conn.cursor()
    if a.reset:
        cur.execute("DROP SCHEMA IF EXISTS game, raw, client, meta CASCADE")
        print("schemas removidos")
    cur.execute("SELECT to_regclass('meta.schema_migrations') IS NOT NULL")
    done = set()
    if cur.fetchone()[0]:
        cur.execute("SELECT version FROM meta.schema_migrations")
        done = {r[0] for r in cur.fetchall()}
    for f in sorted(MIG.glob("*.sql")):
        ver = re.match(r"(\d+)_", f.name).group(1)
        if ver in done:
            continue
        sql = f.read_text(encoding="utf-8")
        conn.autocommit = False
        try:
            cur.execute(sql)
            conn.commit()
        except Exception:
            conn.rollback()
            print(f"FALHOU: {f.name}")
            raise
        finally:
            conn.autocommit = True
        print(f"aplicada {f.name}")
    print("migrations em dia")


if __name__ == "__main__":
    main()
