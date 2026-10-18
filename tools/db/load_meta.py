#!/usr/bin/env python3
from __future__ import annotations
import json

from common import RESEARCH_DIR, connect, copy_rows, register_source
from mechanics import M
from spec import STATS


def as_code(v):
    if isinstance(v, bool):
        return int(v)
    if isinstance(v, int):
        return v
    try:
        s = str(v).strip()
        return int(s, 16) if s.lower().startswith(("0x", "-0x")) else int(float(s))
    except (TypeError, ValueError):
        return None


def research_files():
    for f in sorted(RESEARCH_DIR.glob("*.json")):
        try:
            yield f, json.loads(f.read_text(encoding="utf-8"))
        except json.JSONDecodeError as e:
            print(f"  aviso: {f.name} inválido ({e})")


def main():
    conn = connect()
    with conn, conn.cursor() as cur:
        for t in ("meta.mechanic_links", "meta.formulas", "meta.enum_values", "meta.enum_types", "meta.mechanics", "game.stat_types"):
            cur.execute(f"DELETE FROM {t}")
        copy_rows(cur, "game.stat_types", ["code", "template_attr", "category", "label_pt", "source_ref"],
                  ((col, attr, cat, label, "tools/db/spec.py STATS; rótulos de language.json (StarPowTip/ThaneAttributeView)")
                   for attr, (col, cat, label) in STATS.items()))
        copy_rows(cur, "meta.mechanics", ["code", "name_pt", "category", "summary_pt", "modules", "doc_anchor"],
                  ((m["code"], m["name_pt"], m["category"], m["summary"], m["modules"], m["code"].replace("_", "-")) for m in M))
        links = set()
        for m in M:
            links |= {(m["code"], "template_set", s) for s in m["sets"]}
            links |= {(m["code"], "table", f"game.{t}") for t in m["tables"]}
            links |= {(m["code"], "asset_prefix", a) for a in m["asset_prefixes"]}
            for p in m["opcode_prefixes"]:
                cur.execute("SELECT DISTINCT name FROM client.opcodes WHERE name LIKE %s", (f"%{p}%",))
                links |= {(m["code"], "opcode", r[0]) for r in cur.fetchall()}
            for p in m["proto_packages"]:
                cur.execute("SELECT name FROM client.proto_messages WHERE package = %s", (p,))
                links |= {(m["code"], "proto_message", r[0]) for r in cur.fetchall()}
        set_owner = {s: m["code"] for m in M for s in m["sets"]}
        cat_parent = {"pve": "exploration", "event": "event", "economy": "castle", "guild": "guild", "pvp": "pvp",
                      "social": "social", "progression": "quest"}
        codes = {m["code"] for m in M}
        for f, data in research_files():
            doc = {"world_progression.json": "mechanics/world_progression.md", "items_avatar.json": "mechanics/items_avatar.md",
                   "skills_buffs.json": "mechanics/skills_buffs.md",
                   "heroes_combat.json": "mechanics/units_combat.md"}.get(f.name)
            for sy in data.get("systems") or []:
                code = sy.get("name")
                if not code or code in codes:
                    continue
                cat = sy.get("category") if sy.get("category") in cat_parent else "system"
                parent = next((set_owner[t] for t in sy.get("template_sets") or [] if t in set_owner), cat_parent.get(cat))
                cur.execute("""INSERT INTO meta.mechanics(code, name_pt, category, summary_pt, modules, source_ref, doc_anchor, parent_code)
                               VALUES (%s,%s,%s,%s,%s,%s,%s,%s)""",
                            (code, sy.get("label_pt") or code, cat if cat != "system" else "system", sy.get("description_pt"),
                             [str(x) for x in sy.get("modules") or []], sy.get("source_ref"), doc, parent))
                codes.add(code)
                links |= {(code, "template_set", t) for t in sy.get("template_sets") or []}
                links |= {(code, "opcode", o) for o in sy.get("opcodes") or [] if isinstance(o, str)}
        cur.execute("SELECT DISTINCT name FROM client.opcodes")
        known_ops = {r[0] for r in cur.fetchall()}
        links = {l for l in links if l[1] != "opcode" or l[2] in known_ops}
        copy_rows(cur, "meta.mechanic_links", ["mechanic_code", "target_kind", "target"], sorted(links))

        enums: dict[str, dict] = {}
        values: dict[tuple, tuple] = {}
        formulas: dict[str, tuple] = {}
        skipped = 0
        for f, data in research_files():
            register_source(cur, f"research/{f.name}", "research", f"data/research/{f.name}", f)
            for name, e in (data.get("enums") or {}).items():
                if not isinstance(e, dict):
                    continue
                cur_e = enums.setdefault(name, {"description": e.get("description_pt"), "source_ref": e.get("source_ref"),
                                                "applies_to": set()})
                cur_e["applies_to"] |= set(e.get("applies_to") or [])
                for v in e.get("values") or []:
                    code = as_code(v.get("code"))
                    if code is None:
                        skipped += 1
                        continue
                    values.setdefault((name, code), (name, code, str(v.get("name") or f"code_{code}"), v.get("label_pt"),
                                                     v.get("note_pt"), v.get("source_ref")))
            for fm in data.get("formulas") or []:
                if isinstance(fm, dict) and fm.get("name") and fm.get("expression"):
                    formulas.setdefault(fm["name"], (fm["name"], fm.get("mechanic"), str(fm["expression"]),
                                                     fm.get("description_pt"), fm.get("source_ref")))
        copy_rows(cur, "meta.enum_types", ["name", "description", "source_ref", "applies_to"],
                  ((k, v["description"], v["source_ref"], sorted(v["applies_to"])) for k, v in enums.items()))
        copy_rows(cur, "meta.enum_values", ["enum_name", "code", "name", "label_pt", "note", "source_ref"], values.values())
        mech_codes = {m["code"] for m in M}
        copy_rows(cur, "meta.formulas", ["name", "mechanic", "expression", "description", "source_ref"],
                  ((n, mc if mc in mech_codes else None, e, d, s) for n, mc, e, d, s in formulas.values()))
        print(f"mecânicas {len(codes)}, vínculos {len(links)}, enums {len(enums)} ({len(values)} valores, {skipped} códigos não numéricos ignorados), fórmulas {len(formulas)}")


if __name__ == "__main__":
    main()
