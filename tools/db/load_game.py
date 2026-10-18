#!/usr/bin/env python3
from __future__ import annotations
import xml.etree.ElementTree as ET

from common import TPL_DIR, connect, copy_rows
from spec import TABLES

issues: list[tuple] = []


def convert(raw: str | None, conv: str, table: str, col: str, key: str):
    if raw is None:
        return None
    v = raw.strip()
    if conv == "pipe0":
        return v.split("|")[0] or None
    if conv == "pipe1":
        parts = v.split("|")
        return parts[1] if len(parts) > 1 and parts[1] else None
    if conv == "text":
        return v if v != "" else None
    if v == "":
        return None
    if conv == "bool":
        return v.lower() in ("true", "1")
    if conv in ("int", "bigint"):
        try:
            return int(v)
        except ValueError:
            try:
                return int(float(v))
            except ValueError:
                issues.append((table, col, key, raw, "valor não numérico → NULL"))
                return None
    if conv == "numeric":
        try:
            return float(v)
        except ValueError:
            issues.append((table, col, key, raw, "valor não numérico → NULL"))
            return None
    if conv == "csv_int":
        out = []
        for p in v.replace("|", ",").split(","):
            p = p.strip()
            if p == "":
                continue
            try:
                out.append(int(p))
            except ValueError:
                issues.append((table, col, key, raw, "elemento não numérico ignorado"))
        return out
    if conv == "csv_text":
        return [p for p in v.split(",")]
    raise ValueError(conv)


def load_table(cur, t, raw_ids):
    root = ET.parse(TPL_DIR / f"{t.template_set}.xml").getroot()
    cols = [c.name for c in t.cols] + ["source_record_id", "source_ref"]
    rows = []
    for i, el in enumerate(root):
        key = "/".join(el.get(c.attr) or "" for c in t.cols if c.name in t.pk) or str(i)
        vals = []
        for c in t.cols:
            v = convert(el.get(c.attr), c.conversion, t.name, c.name, key)
            if c.fk and isinstance(v, int) and v in (0, -1):
                v = None
            vals.append(v)
        rows.append((*vals, raw_ids[i], f"tempinfos.xml#{t.template_set}[{i}]"))
    return copy_rows(cur, f"game.{t.name}", cols, rows)


def null_dangling_fks(cur, t):
    for c in t.cols:
        if not c.fk:
            continue
        ref_table, ref_col = c.fk[:-1].split("(")
        cur.execute(f"""
            WITH bad AS (
              SELECT ctid, {c.name}::text AS v, source_ref FROM game.{t.name} s
              WHERE {c.name} IS NOT NULL AND NOT EXISTS (SELECT 1 FROM {ref_table} r WHERE r.{ref_col} = s.{c.name})
            ), logged AS (
              INSERT INTO meta.load_issues(table_name, column_name, record_key, value, issue)
              SELECT %s, %s, source_ref, v, 'referência inexistente em {ref_table} → NULL' FROM bad
            )
            UPDATE game.{t.name} s SET {c.name} = NULL FROM bad WHERE s.ctid = bad.ctid""",
                    (f"game.{t.name}", c.name))


def main():
    conn = connect()
    with conn, conn.cursor() as cur:
        cur.execute("SET CONSTRAINTS ALL DEFERRED")
        cur.execute("DELETE FROM meta.load_issues WHERE table_name LIKE 'game.%'")
        cur.execute("TRUNCATE " + ", ".join(f"game.{t.name}" for t in TABLES) + " RESTART IDENTITY CASCADE")
        cur.execute("SELECT s.name, r.ordinal, r.id FROM raw.template_records r JOIN raw.template_sets s ON s.id = r.set_id")
        raw_ids: dict[str, dict[int, int]] = {}
        for name, ordinal, rid in cur.fetchall():
            raw_ids.setdefault(name, {})[ordinal] = rid
        for t in TABLES:
            n = load_table(cur, t, raw_ids[t.template_set])
            cur.execute("UPDATE raw.template_sets SET semantic_table = %s WHERE name = %s", (f"game.{t.name}", t.template_set))
            for c in t.cols:
                cur.execute("""UPDATE raw.template_fields f SET semantic_column = %s
                               FROM raw.template_sets s WHERE s.id = f.set_id AND s.name = %s AND f.attribute = %s""",
                            (f"game.{t.name}.{c.name}", t.template_set, c.attr))
            print(f"  game.{t.name:28s} {n:6d}")
        for t in TABLES:
            null_dangling_fks(cur, t)
        if issues:
            copy_rows(cur, "meta.load_issues", ["table_name", "column_name", "record_key", "value", "issue"],
                      ((f"game.{a}", b, c, d, e) for a, b, c, d, e in issues))
        cur.execute("SELECT count(*) FROM meta.load_issues WHERE table_name LIKE 'game.%'")
        print("problemas registrados em meta.load_issues:", cur.fetchone()[0])


if __name__ == "__main__":
    main()
