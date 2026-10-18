#!/usr/bin/env python3
from __future__ import annotations
import re

from common import RESEARCH_DIR, ROOT

MAP = {
    "heroes_combat.md": "units_combat.md",
    "skills_buffs.md": "skills_buffs.md",
    "items_avatar.md": "items_avatar.md",
    "world_progression.md": "world_progression.md",
}
FIX = [(r"docs/BATALHA\.md", "docs/battle/README.md"), (r"docs/GRAFICOS\.md", "docs/client/graphics.md"),
       (r"docs/TELAS\.md", "docs/ui/screens.md"), (r"docs/ARQUITETURA\.md", "docs/overview/architecture.md"),
       (r"docs/PLANO\.md", "docs/overview/roadmap.md"), (r"docs/COMPONENTES\.md", "docs/client/components.md")]


def main():
    out = ROOT / "docs/mechanics"
    out.mkdir(parents=True, exist_ok=True)
    for src, dst in MAP.items():
        p = RESEARCH_DIR / src
        if not p.exists():
            print(f"  missing {src}")
            continue
        text = p.read_text(encoding="utf-8")
        for a, b in FIX:
            text = re.sub(a, b, text)
        header = (f"<!-- Generated from data/research/{src} by tools/db/build_docs.py. "
                  f"Index: docs/mechanics/README.md -->\n\n")
        (out / dst).write_text(header + text, encoding="utf-8")
        print(f"  docs/mechanics/{dst}")


def catalog():
    from common import connect
    conn = connect()
    with conn, conn.cursor() as cur:
        cur.execute("""SELECT m.code, m.name_pt, m.category, coalesce(m.parent_code, ''), coalesce(m.summary_pt, ''),
                              coalesce(m.source_ref, ''), coalesce(m.doc_anchor, ''),
                              (SELECT string_agg(target, ', ' ORDER BY target) FROM meta.mechanic_links l
                                WHERE l.mechanic_code = m.code AND l.target_kind = 'template_set'),
                              (SELECT string_agg(target, ', ' ORDER BY target) FROM meta.mechanic_links l
                                WHERE l.mechanic_code = m.code AND l.target_kind = 'table'),
                              (SELECT count(*) FROM meta.mechanic_links l WHERE l.mechanic_code = m.code AND l.target_kind = 'opcode')
                       FROM meta.mechanics m ORDER BY coalesce(m.parent_code, m.code), m.parent_code IS NOT NULL, m.code""")
        rows = cur.fetchall()
    lines = ["<!-- Generated from the database (meta.mechanics / meta.mechanic_links) by tools/db/build_docs.py. -->", "",
             "# Mechanics and subsystems catalog", "",
             f"{len(rows)} entries. Core mechanics are described in `docs/mechanics/README.md`. Subsystems (those with a parent mechanic) "
             "come from the research in `data/research/*.json` and are detailed in the documents in this folder.", "",
             "| code | name | category | parent | template sets | tables | opcodes | summary |",
             "|---|---|---|---|---|---|---:|---|"]
    for code, name, cat, parent, summary, _ref, _doc, sets, tables, nops in rows:
        s = summary.replace("|", "\\|").replace("\n", " ")
        if len(s) > 220:
            s = s[:217] + "…"
        lines.append(f"| `{code}` | {name} | {cat} | {parent and '`' + parent + '`'} | {sets or ''} | {tables or ''} | {nops} | {s} |")
    (ROOT / "docs/mechanics/catalog.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"  docs/mechanics/catalog.md ({len(rows)} mechanics)")


if __name__ == "__main__":
    main()
    catalog()
