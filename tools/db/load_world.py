#!/usr/bin/env python3
from __future__ import annotations

from common import ROOT, J, connect, copy_rows, load_json, register_source

WORLD = ROOT / "index/world.json"
MAPS = ROOT / "web/public/maps"


def ints(s) -> list[int]:
    if not s:
        return []
    return [int(x) for x in str(s).replace("|", ",").split(",") if x.strip().lstrip("-").isdigit()]


def issue(cur, table, column, key, value, text):
    cur.execute("INSERT INTO meta.load_issues(table_name, column_name, record_key, value, issue) VALUES (%s,%s,%s,%s,%s)",
                (table, column, key, None if value is None else str(value), text))


def main():
    data = load_json(WORLD)
    conn = connect()
    with conn, conn.cursor() as cur:
        cur.execute("""TRUNCATE game.room_protocol, game.dungeon_types, game.world_links, game.worlds,
                       game.scene_transitions, game.scenes, game.campaign_nodes RESTART IDENTITY CASCADE""")
        cur.execute("DELETE FROM meta.load_issues WHERE table_name IN ('scene_transitions','room_protocol','worlds','world_links','campaign_nodes','dungeon_types')")
        cur.execute("SELECT direction, code, name FROM client.opcodes")
        opcodes = {}
        for d, c, n in cur.fetchall():
            opcodes.setdefault((d, c), set()).add(n)
        cur.execute("SELECT id, name, width, height, map_file_id, campaign_id, min_level FROM game.maps")
        maps = {r[0]: r[1:] for r in cur.fetchall()}
        cur.execute("SELECT code, name FROM meta.enum_values WHERE enum_name = 'pos_type'")
        pos_type = dict(cur.fetchall())
        cur.execute("SELECT map_file_id FROM game.map_files")
        map_files = {r[0] for r in cur.fetchall()}

        def check_op(table, key, direction, code, name):
            if code is None:
                return
            names = opcodes.get((direction, code))
            if not names:
                issue(cur, table, "opcode", key, code, f"opcode {direction} {code} missing from client.opcodes")
            elif name and name not in names:
                issue(cur, table, "opcode_name", key, name, f"name differs from client.opcodes: {sorted(names)}")

        scenes = data["scenes"]
        cols = ["scene_type", "scene_type_id", "name_pt", "class_name", "class_module", "class_source_ref", "project_png",
                "ui_resources", "client_state", "enter_castle_flag", "map_ids", "map_rule", "layers", "entities",
                "requirements", "enter_summary", "exit_summary", "is_hub", "is_room", "is_dead_code", "source_ref"]
        copy_rows(cur, "game.scenes", cols, (
            tuple(s.get(c, [] if c in ("ui_resources", "map_ids", "layers") else
                        False if c.startswith("is_") else None) for c in cols) for s in scenes))
        known = {s["scene_type"] for s in scenes}

        rows = []
        for i, t in enumerate(data["scene_transitions"]):
            for k in ("from_scene", "to_scene"):
                if t.get(k) and t[k] not in known:
                    raise SystemExit(f"cena desconhecida em scene_transitions[{i}]: {t[k]}")
            check_op("scene_transitions", str(i), t.get("opcode_direction"), t.get("opcode"), t.get("opcode_name"))
            rows.append((t.get("from_scene"), t["to_scene"], t["trigger_pt"], t.get("opcode_direction"), t.get("opcode"),
                         t.get("opcode_name"), t.get("proto_message"), t.get("condition_pt"), t["source_ref"]))
        n_tr = copy_rows(cur, "game.scene_transitions",
                         ["from_scene", "to_scene", "trigger_pt", "opcode_direction", "opcode", "opcode_name",
                          "proto_message", "condition_pt", "source_ref"], rows)

        node_rows, node_map = [], {}
        files = sorted((p for p in MAPS.glob("*.json") if p.stem.isdigit()), key=lambda p: int(p.stem))
        for p in files:
            fid = int(p.stem)
            nodes = load_json(p).get("nodes") or []
            if nodes and fid not in map_files:
                issue(cur, "campaign_nodes", "map_file_id", str(fid), fid, "map has no row in game.map_files (run load_map_files.py)")
                continue
            for ordinal, n in enumerate(nodes):
                nid = n.get("id")
                if nid:
                    node_map.setdefault(int(nid), fid)
                x, y = n.get("x"), n.get("y")
                pawns = {k: n.get(k) for k in ("pawn1", "pawnNum1", "pawn2", "pawnNum2")}
                params = {k: n.get(k) for k in ("Param1", "Param2", "Param3", "Param4", "Param5", "Param6")}
                node_rows.append((
                    fid, ordinal, nid, n["itemType"], pos_type.get(n["itemType"]), n.get("name") or None, x, y,
                    None if x is None else int(x) // 20, None if y is None else int(y) // 20,
                    n.get("startPos") or None, ints(n.get("nextNodeIds")), ints(n.get("moveToNodeIds")),
                    n.get("patrolmanPoint") or None, n.get("BattleType"), n.get("AI") or None,
                    bool(n.get("existHero")), bool(n.get("existPawn")), J(n.get("hero")), J(pawns),
                    n.get("HandlerRange"), n.get("Toward"), n.get("AttackTypes"), bool(n.get("IsRepeat")),
                    n.get("NodeState"), n.get("nameColor"), n.get("resource"), J(params), n.get("property3"),
                    n.get("property4"), n.get("url") or None, J(n)))
        n_nodes = copy_rows(cur, "game.campaign_nodes",
                            ["map_file_id", "ordinal", "node_id", "item_type", "item_type_name", "name_zh", "x_px", "y_px",
                             "cell_x", "cell_y", "start_cells", "next_node_ids", "move_to_node_ids", "patrol_cells",
                             "battle_type", "ai_class", "exist_hero", "exist_pawn", "hero", "pawns", "handler_range",
                             "toward", "attack_types", "is_repeat", "node_state", "name_color", "resource", "params",
                             "property3", "property4", "building_url", "raw"], node_rows)

        wrows = []
        for w in data["worlds"]:
            m = maps.get(w["map_id"])
            if m is None:
                issue(cur, "worlds", "map_id", str(w["map_id"]), w["map_id"], "map missing from game.maps")
                m = (None,) * 6
            name, width, height, mfid, cid, minlv = m
            wrows.append((w["map_id"], w["world_kind"], w.get("name_pt") or name, w.get("scene_type"),
                          w.get("width_px", width), w.get("height_px", height), w.get("tile_px"), w.get("tile_grid"),
                          w.get("coord_unit"), w.get("map_file_id", mfid), w.get("campaign_id", cid),
                          w.get("min_level", minlv), w.get("notes"), w["source_ref"]))
        n_w = copy_rows(cur, "game.worlds", ["map_id", "world_kind", "name_pt", "scene_type", "width_px", "height_px",
                                             "tile_px", "tile_grid", "coord_unit", "map_file_id", "campaign_id",
                                             "min_level", "notes", "source_ref"], wrows)

        lrows = [(l["from_map_id"], l["to_map_id"], l.get("via_node_id"), l["link_kind"], l.get("direction", "one_way"),
                  l.get("condition_pt"), l["source_ref"]) for l in data["world_links"]]
        for (fid, ordinal, nid, itype, _tn, name, *_rest) in node_rows:
            raw = _rest[-1].v
            targets = ints(raw.get("moveToNodeIds"))
            if itype == 62 and targets:
                for t in targets:
                    dest = node_map.get(t)
                    if dest is None:
                        issue(cur, "world_links", "via_node_id", f"{fid}:{nid}", t, "portal target outside the downloaded maps")
                        continue
                    lrows.append((fid, dest, nid, "editor_portal", "one_way", f"editor node 62 → node {t}",
                                  f"web/public/maps/{fid}.json (node {nid}, moveToNodeIds={t})"))
            elif itype == 41 and name == "退出副本":
                lrows.append((fid, 0, nid, "editor_exit", "one_way", "node 41 \"退出副本\" (leave instance → returnScene)",
                              f"web/public/maps/{fid}.json (node {nid})"))
        n_l = copy_rows(cur, "game.world_links", ["from_map_id", "to_map_id", "via_node_id", "link_kind", "direction",
                                                  "condition_pt", "source_ref"], lrows)

        dcols = ["code", "name_pt", "room_type", "scene_type", "campaign_types", "map_ids", "min_players", "max_players",
                 "min_level", "entry_pt", "flow_pt", "rewards_pt", "requirements_pt", "source_ref"]
        for d in data["dungeon_types"]:
            if d.get("scene_type") and d["scene_type"] not in known:
                raise SystemExit(f"cena desconhecida em dungeon_types: {d['scene_type']}")
        n_d = copy_rows(cur, "game.dungeon_types", dcols, (
            tuple(d.get(c, [] if c in ("campaign_types", "map_ids") else None) for c in dcols) for d in data["dungeon_types"]))
        prow = []
        for i, s in enumerate(data["room_protocol"]):
            check_op("room_protocol", str(i), s["direction"], s["opcode"], s.get("opcode_name"))
            prow.append((s.get("dungeon_code"), s["phase"], s.get("step_order", i), s["direction"], s["opcode"],
                         s.get("opcode_name"), s.get("proto_message"), s.get("client_method"), s.get("notes_pt"),
                         s["source_ref"]))
        n_p = copy_rows(cur, "game.room_protocol", ["dungeon_code", "phase", "step_order", "direction", "opcode",
                                                    "opcode_name", "proto_message", "client_method", "notes_pt",
                                                    "source_ref"], prow)

        register_source(cur, "world_index", "project_index", "index/world.json", WORLD,
                        notes="Scenes, transitions, worlds, dungeons and room protocol (docs/world/README.md)")
        cur.execute("SELECT count(*) FROM meta.load_issues WHERE table_name IN ('scene_transitions','room_protocol','worlds','world_links','campaign_nodes','dungeon_types')")
        n_issues = cur.fetchone()[0]
    print(f"scenes={len(scenes)} transitions={n_tr} campaign_nodes={n_nodes} worlds={n_w} world_links={n_l} "
          f"dungeon_types={n_d} room_protocol={n_p} issues={n_issues}")


if __name__ == "__main__":
    main()
