#!/usr/bin/env python3
from __future__ import annotations
import json
import re

from common import RESEARCH_DIR, connect
from mechanics import M

LOADERS = RESEARCH_DIR / "template_loaders.txt"
TM = "decompiled/core_module/scripts/yishi/manager/TempleteManager.as"


def main():
    fields = {}
    for f in sorted(RESEARCH_DIR.glob("*.json")):
        try:
            data = json.loads(f.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            continue
        for k, v in (data.get("fields") or {}).items():
            if isinstance(v, dict) and "." in k:
                old = fields.get(k)
                guess = "(suposição)" in (v.get("description_pt") or "")[:15]
                if old is None or (old[1] and not guess):
                    fields[k] = (v, guess)
    conn = connect()
    with conn, conn.cursor() as cur:
        for m in M:
            for s in m["sets"]:
                cur.execute("UPDATE raw.template_sets SET mechanic_code = %s WHERE name = %s AND mechanic_code IS NULL",
                            (m["code"], s))
        if LOADERS.exists():
            for line in LOADERS.read_text(encoding="utf-8").splitlines():
                p = line.split()
                if len(p) >= 3 and p[0].isdigit():
                    cur.execute("UPDATE raw.template_sets SET source_ref = %s, description = COALESCE(description, %s) WHERE name = %s",
                                (f"{TM}:{p[0]}", f"Carregada em {p[2]}", p[1]))
        cur.execute("SELECT name FROM meta.enum_types")
        enums = {r[0] for r in cur.fetchall()}
        n = 0
        for key, (v, _guess) in fields.items():
            set_name, attr = key.split(".", 1)
            ref = v.get("references")
            if isinstance(ref, list):
                ref = ", ".join(map(str, ref))
            cur.execute("""UPDATE raw.template_fields f SET description = %s, enum_name = %s, references_field = %s, source_ref = %s
                           FROM raw.template_sets s WHERE s.id = f.set_id AND s.name = %s AND f.attribute = %s""",
                        (re.sub(r"\s+", " ", v.get("description_pt") or "").strip() or None,
                         v.get("enum") if v.get("enum") in enums else None, ref, v.get("source_ref"), set_name, attr))
            n += cur.rowcount
        cur.execute("SELECT count(*), count(description) FROM raw.template_fields")
        total, described = cur.fetchone()
        cur.execute("SELECT count(*), count(mechanic_code) FROM raw.template_sets")
        sets, mapped = cur.fetchone()
        print(f"campos anotados {n}; descritos {described}/{total}; listas com mecânica {mapped}/{sets}")


if __name__ == "__main__":
    main()
