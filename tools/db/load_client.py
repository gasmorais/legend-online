#!/usr/bin/env python3
from __future__ import annotations
import csv
import posixpath

from common import ROOT, J, connect, copy_rows, load_json, register_source


def asset_kind(manifest: str, path: str, ext: str) -> str:
    if manifest == "code":
        return "code_module"
    first = path.split("/", 1)[0]
    if ext == "atf":
        return "stage3d_texture"
    if ext == "bswf" or path.startswith("swf/avatar"):
        return "map_avatar"
    if path.startswith("swf/npc/"):
        return "npc"
    if ext in ("xml", "ini", "xlsx", "html", "spp"):
        return "config"
    simple = {"equip_show": "ui_show", "equip": "battle_equipment", "skilleffect": "skill_effect",
              "skillname": "skill_name", "sceneima": "battle_map", "maps": "map_data", "icon": "icon",
              "images": "image", "planeswar": "planes_war", "vehicle": "vehicle", "goddess": "goddess",
              "ui": "ui_module"}
    if first in simple:
        return simple[first]
    if path.startswith("mapmaterial/land/"):
        return "map_tile"
    if first == "mapmaterial":
        return "map_material"
    if first.startswith("audio"):
        return "audio"
    if first == "swf":
        return "unit_movie"
    return "other"


def load_assets(cur):
    rows = []
    with open(ROOT / "index/manifest_all.csv", newline="", encoding="utf-8") as f:
        for r in csv.DictReader(f):
            path = r["path"]
            ext = (r["ext"] or posixpath.splitext(path)[1].lstrip(".")).lower()
            d, fn = posixpath.split(path)
            rows.append((r["manifest"], path, d, fn, ext, r["md5"], int(r["size"]),
                         asset_kind(r["manifest"], path, ext), r["url"]))
    n = copy_rows(cur, "client.assets",
                  ["manifest", "path", "dir", "file_name", "ext", "md5", "byte_size", "kind", "url"], rows)
    register_source(cur, "manifest_all", "cdn_manifest", "index/manifest_all.csv", ROOT / "index/manifest_all.csv")
    return n


def load_protocol(cur):
    with open(ROOT / "protocol/opcodes.csv", newline="", encoding="utf-8") as f:
        ops = {(r["dir"], int(r["code"]), r["name"]) for r in csv.DictReader(f)}
    copy_rows(cur, "client.opcodes", ["direction", "code", "name"], sorted(ops))
    proto = load_json(ROOT / "protocol/proto.json")
    copy_rows(cur, "client.proto_messages", ["name", "package"], ((k, v["package"]) for k, v in proto.items()))
    copy_rows(cur, "client.proto_fields",
              ["message_name", "field_number", "name", "proto_type", "wire_type", "is_repeated"],
              ((k, fl["num"], fl["name"], fl["type"], fl["wire"], fl["repeated"])
               for k, v in proto.items() for fl in v["fields"]))
    as3_path = ROOT / "data/derived/proto_as3.json"
    if as3_path.exists():
        as3 = load_json(as3_path)
        copy_rows(cur, "client.proto_messages", ["name", "package", "source", "module", "source_ref"],
                  ((k, v["package"], "as3", v["module"], v["source_ref"]) for k, v in as3.items() if k not in proto))
        for k, v in as3.items():
            if k in proto:
                cur.execute("UPDATE client.proto_messages SET module = %s, source_ref = %s WHERE name = %s",
                            (v["module"], v["source_ref"], k))
        cur.execute("CREATE TEMP TABLE pf_as3 (message_name text, field_number int, name text, proto_type text, wire_type smallint,"
                    " is_repeated boolean, message_type text, source_ref text) ON COMMIT DROP")
        copy_rows(cur, "pf_as3", ["message_name", "field_number", "name", "proto_type", "wire_type", "is_repeated", "message_type",
                                  "source_ref"],
                  {(k, f["num"]): (k, f["num"], f["name"], f["type"], f["wire"], f["repeated"], f["message_type"],
                                   f"{v['source_ref']}:{f['line']}") for k, v in as3.items() for f in v["fields"]}.values())
        cur.execute("""INSERT INTO client.proto_fields (message_name, field_number, name, proto_type, wire_type, is_repeated, message_type, source_ref)
                       SELECT * FROM pf_as3 p WHERE EXISTS (SELECT 1 FROM client.proto_messages m WHERE m.name = p.message_name)
                       ON CONFLICT (message_name, field_number) DO UPDATE SET message_type = EXCLUDED.message_type,
                         source_ref = EXCLUDED.source_ref""")
        register_source(cur, "proto_as3", "decompiled_code", "data/derived/proto_as3.json", as3_path)
    pairs = load_json(ROOT / "data/derived/opcode_messages.json")
    copy_rows(cur, "client.opcode_messages", ["direction", "code", "message_name", "handler", "source_ref"],
              ((p["direction"], p["code"], p["message"], p["handler"], p["source_ref"]) for p in pairs))
    for name, path in (("opcodes", "protocol/opcodes.csv"), ("proto", "protocol/proto.json"),
                       ("opcode_messages", "data/derived/opcode_messages.json")):
        register_source(cur, name, "project_index", path, ROOT / path)
    return len(ops), len(proto), len(pairs)


def load_texts_screens_styles(cur):
    lang = load_json(ROOT / "index/language.json")
    copy_rows(cur, "client.localized_texts", ["key", "locale", "text"], ((k, "pt_BR", v) for k, v in lang.items()))
    screens = load_json(ROOT / "index/screens.json")["screens"]
    seen = set()
    rows = []
    for s in screens:
        if s["class"] in seen:
            continue
        seen.add(s["class"])
        st = s.get("stats") or {}
        rows.append((s["class"], s["kind"], s["module"], s.get("title"), s.get("extends") or [],
                     s.get("subviews") or [], st.get("swfs") or [], st.get("size"), J(st)))
    copy_rows(cur, "client.screens",
              ["class_name", "kind", "module", "title_pt", "extends", "subviews", "swfs", "size", "stats"], rows)
    styles = load_json(ROOT / "index/styles.json")
    copy_rows(cur, "client.ui_styles", ["style_name", "file", "source_swf", "tag", "attrs"],
              ((k, v["file"], v.get("source"), v["tag"], J(v.get("attrs") or {})) for k, v in styles.items()))
    routes = load_json(ROOT / "routes/routes.json")
    copy_rows(cur, "client.url_bases", ["key", "value"], routes["bases"].items())
    copy_rows(cur, "client.http_endpoints", ["path", "source_refs"], routes["http_endpoints"].items())
    rows, seen = [], set()
    for fn in routes["path_manager"]:
        for i, v in enumerate(fn["variants"]):
            key = (fn["fn"], i)
            if key in seen:
                continue
            seen.add(key)
            rows.append((fn["fn"], i, J(fn.get("args") or {}), v["template"], v.get("base"),
                         v.get("manifest_hits"), v.get("examples") or []))
    copy_rows(cur, "client.url_templates",
              ["function_name", "variant", "args", "template", "base", "manifest_hits", "examples"], rows)
    for name, path in (("language", "index/language.json"), ("screens", "index/screens.json"),
                       ("styles", "index/styles.json"), ("routes", "routes/routes.json")):
        register_source(cur, name, "project_index", path, ROOT / path)
    return len(lang), len(rows)


def main():
    conn = connect()
    with conn, conn.cursor() as cur:
        cur.execute("TRUNCATE client.assets, client.opcodes, client.proto_messages, client.proto_fields,"
                    " client.opcode_messages, client.localized_texts, client.screens, client.ui_styles,"
                    " client.url_bases, client.url_templates, client.http_endpoints RESTART IDENTITY CASCADE")
        print("assets", load_assets(cur))
        print("opcodes/protos/pares", load_protocol(cur))
        print("textos/url_templates", load_texts_screens_styles(cur))


if __name__ == "__main__":
    main()
