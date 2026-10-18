#!/usr/bin/env python3
from __future__ import annotations
import xml.etree.ElementTree as ET

from common import ROOT, TPL_DIR, J, connect, copy_rows, load_json, register_source

KEY_ATTRS = ("TemplateId", "Id", "ID", "id", "TemplateID", "CampaignId", "WarSoulId", "TransformId",
             "MapShopId", "DropId", "dropId", "ConfigName", "JobType", "ChildType", "ActionId")


def record_key(attrs: dict) -> str | None:
    for k in KEY_ATTRS:
        if k in attrs:
            return attrs[k]
    return None


def children_json(el):
    if not len(el):
        return None
    return [{"element": c.tag, "attrs": dict(c.attrib), "children": children_json(c)} for c in el]


def main():
    stats = load_json(TPL_DIR / "_fields.json")
    version = stats.pop("_version")
    conn = connect()
    with conn, conn.cursor() as cur:
        cur.execute("TRUNCATE raw.template_sets RESTART IDENTITY CASCADE")
        register_source(cur, "tempinfos.xml", "server_xml",
                        "http://s1264oas.creaction-network.com/xml/tempinfos.xml",
                        ROOT / "data/tpl/tempinfos.xml", version=str(version),
                        notes="baixado em 2026-10-17; decodificado por tools/db/tempinfos.py")
        total = 0
        for name, st in sorted(stats.items(), key=lambda kv: kv[1]["order"]):
            path = TPL_DIR / f"{name}.xml"
            xml = path.read_text(encoding="utf-8")
            root = ET.fromstring(xml)
            cur.execute(
                """INSERT INTO raw.template_sets(name, root_element, item_elements, record_count, xml_bytes,
                       load_order, source_ref)
                   VALUES (%s,%s,%s,%s,%s,%s,%s) RETURNING id""",
                (name, root.tag, sorted(st.get("items", {})), st.get("count", 0), len(xml.encode()),
                 st["order"], "decompiled/core_module/scripts/yishi/manager/TempleteManager.as"))
            set_id = cur.fetchone()[0]
            copy_rows(cur, "raw.template_fields",
                      ["set_id", "attribute", "position", "inferred_type", "present_count", "distinct_count", "sample"],
                      ((set_id, a, i, f["type"], f["n"], f["distinct"], f["sample"])
                       for i, (a, f) in enumerate(st.get("fields", {}).items())))
            total += copy_rows(cur, "raw.template_records",
                               ["set_id", "ordinal", "element", "record_key", "attrs", "children"],
                               ((set_id, i, el.tag, record_key(el.attrib), J(dict(el.attrib)), J(children_json(el)))
                                for i, el in enumerate(root)))
        print(f"raw: {len(stats)} listas, {total} registros (versão {version})")


if __name__ == "__main__":
    main()
