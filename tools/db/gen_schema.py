#!/usr/bin/env python3
from __future__ import annotations
import json
import re

from common import RESEARCH_DIR, ROOT
from spec import TABLES

OUT = ROOT / "db/migrations/0005_game_templates.sql"


def q(s: str) -> str:
    return "'" + s.replace("'", "''") + "'"


def research_fields() -> dict:
    out = {}
    for f in sorted(RESEARCH_DIR.glob("*.json")):
        try:
            data = json.loads(f.read_text(encoding="utf-8"))
        except (json.JSONDecodeError, OSError):
            continue
        for k, v in (data.get("fields") or {}).items():
            if isinstance(v, dict) and v.get("description_pt") and "(suposição)" not in v["description_pt"][:12]:
                out.setdefault(k, v)
    return out


def main():
    rf = research_fields()
    lines = ["-- 0005_game_templates.sql — GERADO por tools/db/gen_schema.py a partir de tools/db/spec.py. Não edite à mão.",
             "SET search_path = game, client, raw, meta, public;", ""]
    fks, idx = [], []
    for t in TABLES:
        defs = []
        if t.surrogate:
            defs.append("  row_id serial")
        for c in t.cols:
            defs.append(f"  {c.name} {c.sql}" + (" NOT NULL" if c.not_null or c.name in t.pk else ""))
            if c.fk:
                ref_table = c.fk.split("(")[0]
                fks.append(f"ALTER TABLE game.{t.name} ADD CONSTRAINT {t.name}_{c.name}_fkey FOREIGN KEY ({c.name}) "
                           f"REFERENCES {c.fk} DEFERRABLE INITIALLY DEFERRED;")
                idx.append(f"CREATE INDEX ON game.{t.name} ({c.name});")
            elif c.name in ("master_type", "son_type") and c.name not in t.pk:
                idx.append(f"CREATE INDEX ON game.{t.name} ({c.name});")
        defs.append("  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE")
        defs.append("  source_ref text NOT NULL")
        defs.append(f"  PRIMARY KEY ({', '.join(t.pk)})")
        lines.append(f"CREATE TABLE game.{t.name} (\n" + ",\n".join(defs) + "\n);")
        lines.append(f"COMMENT ON TABLE game.{t.name} IS {q(t.comment + f' Origem: tempinfos.xml/{t.template_set}.')};")
        if t.surrogate:
            lines.append(f"COMMENT ON COLUMN game.{t.name}.row_id IS 'Chave substituta (a lista de origem não tem id único).';")
        for c in t.cols:
            parts = [c.comment.strip()] if c.comment else []
            r = rf.get(f"{t.template_set}.{c.attr}")
            if r:
                desc = re.sub(r"\s+", " ", r["description_pt"]).strip()
                if desc and desc not in " ".join(parts):
                    parts.append(desc)
                if r.get("enum"):
                    parts.append(f"Enum: meta.enum_values.enum_name='{r['enum']}'.")
                if r.get("source_ref"):
                    parts.append(f"[{r['source_ref']}]")
            parts.append(f"XML: {t.template_set}.{c.attr}" + (f" ({c.conversion})" if c.conversion.startswith("pipe") else ""))
            lines.append(f"COMMENT ON COLUMN game.{t.name}.{c.name} IS {q(' '.join(parts))};")
        lines.append(f"COMMENT ON COLUMN game.{t.name}.source_record_id IS 'Registro bruto de origem em raw.template_records.';")
        lines.append(f"COMMENT ON COLUMN game.{t.name}.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';")
        lines.append("")
    lines += fks + [""] + sorted(set(idx)) + [""]
    lines.append("INSERT INTO meta.schema_migrations(version, description) VALUES ('0005', 'game template tables (generated)') ON CONFLICT DO NOTHING;")
    OUT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"{len(TABLES)} tabelas, {len(fks)} FKs, {len(rf)} descrições de pesquisa → {OUT.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
