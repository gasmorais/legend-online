#!/usr/bin/env python3
from __future__ import annotations
import json

from common import ROOT, J, connect, copy_rows, register_source

SRC = ROOT / "web/public/maps"
RAW = ROOT / "raw/maps"
OUTER_CITY = {1, 2, 3, 4, 5}
PORTALS = {62: "copy_map_send", 63: "copy_node_send", 171: "copy_node_send2"}
NODE_KIND = {40: "copy_start", 41: "copy_end"}


def cells_from_runs(walk: dict) -> dict[tuple[int, int], int]:
    cells = {}
    for value, runs in walk.items():
        for col, r0, r1 in runs:
            for r in range(r0, r1 + 1):
                cells[(col, r)] = int(value)
    return cells


def border(cells):
    out = []
    for (c, r) in cells:
        mask = (((c - 1, r) not in cells) * 1 | ((c + 1, r) not in cells) * 2 |
                ((c, r - 1) not in cells) * 4 | ((c, r + 1) not in cells) * 8)
        if mask:
            out.append((c, r, mask))
    return out


def context_of(fid: int) -> str:
    return "world_map" if fid in OUTER_CITY else "space_map" if fid == 10000 else "campaign_map"


def main():
    files = sorted((p for p in SRC.glob("*.json") if p.stem.isdigit()), key=lambda p: int(p.stem))
    raw_ids = {int(p.name) for p in RAW.iterdir() if p.name.isdigit()} if RAW.exists() else set()
    conn = connect()
    with conn, conn.cursor() as cur:
        cur.execute("TRUNCATE game.map_files CASCADE")
        cur.execute("DELETE FROM game.map_points WHERE ref_table = 'map_file'")
        for code, label, desc in (("copy_start", "Nó de início (nascimento) da instância", "Nó tipo 40; startPos lista as células de spawn."),
                                  ("copy_end", "Nó de fim/saída", "Nó tipo 41."),
                                  ("portal", "Portal / transferência de mapa", "Nó tipo 62/63/171."),
                                  ("player_spawn", "Ponto de nascimento do jogador", "Célula de spawn."),
                                  ("campaign_node", "Nó de campanha", "NPC, monstro, gatilho, coleta...")):
            cur.execute("""INSERT INTO game.map_point_kinds(code, label_pt, source, description) VALUES (%s, %s, 'map_file', %s)
                           ON CONFLICT DO NOTHING""", (code, label, desc))
        cur.execute("SELECT path, id FROM client.assets WHERE manifest = 'res'")
        assets = dict(cur.fetchall())
        summary, runs_rows, border_rows, objects, points = [], [], [], [], []
        for p in files:
            m = json.loads(p.read_text(encoding="utf-8"))
            fid = int(m["id"])
            cells = cells_from_runs(m.get("walk") or {})
            b = border(cells)
            counts = {}
            for v in cells.values():
                counts[str(v)] = counts.get(str(v), 0) + 1
            bbox = None
            if cells:
                cs = [c for c, _ in cells]
                rs = [r for _, r in cells]
                bbox = [min(cs), min(rs), max(cs), max(rs)]
            for value, runs in (m.get("walk") or {}).items():
                runs_rows += [(fid, int(value), c, r0, r1) for c, r0, r1 in runs]
            border_rows += [(fid, c, r, mask) for c, r, mask in b]
            for layer, key in (("floor", "floor"), ("movie", "movies"), ("top", "tops")):
                for i, o in enumerate(m.get(key) or []):
                    url = o.get("url")
                    objects.append((fid, layer, i, o.get("name"), url, o.get("x"), o.get("y"), o.get("baseNum"), o.get("rotation"),
                                    o.get("scaleX"), o.get("scaleY"), o.get("alpha"), o.get("width"), o.get("height"), o.get("cell"),
                                    o.get("node"), assets.get((url or "").lower())))
            ctx = context_of(fid)
            src = f"raw/maps/{fid}/{fid}.maps"
            for n in m.get("nodes") or []:
                t = n.get("itemType")
                x, y = n.get("x"), n.get("y")
                kind = NODE_KIND.get(t) or ("portal" if t in PORTALS else "campaign_node")
                extra = {k: v for k, v in n.items() if k not in ("x", "y") and v not in (None, "", 0)}
                gx = int(x) // 20 if isinstance(x, (int, float)) else None
                gy = int(y) // 20 if isinstance(y, (int, float)) else None
                points.append((ctx, fid, kind, n.get("name") or None, "map_file", str(n.get("id")), x, y, gx, gy, None, None,
                               J(extra), src))
                for i, part in enumerate(s for s in (n.get("startPos") or "").split("|") if s.strip()):
                    try:
                        sx, sy = (int(v) for v in part.split(",")[:2])
                    except ValueError:
                        continue
                    points.append((ctx, fid, "player_spawn", f"nó {n.get('id')} #{i + 1}", "map_file", str(n.get("id")),
                                   sx * 20, sy * 20, sx, sy, None, None, J({"node_item_type": t, "ordinal": i}), src))
            summary.append((fid, m.get("width") or 0, m.get("height") or 0, m.get("cols") or 0, m.get("rows") or 0,
                            "obstacle" if fid in OUTER_CITY else "walkable", len(cells), J(counts), bbox, len(b),
                            len(m.get("floor") or []), len(m.get("movies") or []), len(m.get("tops") or []), len(m.get("nodes") or []),
                            f"raw/maps/{fid}/{fid}.maps|.titles → web/public/maps/{fid}.json"))
        copy_rows(cur, "game.map_files", ["map_file_id", "width_px", "height_px", "cols", "rows", "cell_semantics", "marked_cells",
                                          "value_counts", "marked_bbox", "border_cells", "floor_items", "movie_items", "top_items",
                                          "node_count", "source_ref"], summary)
        copy_rows(cur, "game.map_walk_runs", ["map_file_id", "value", "col", "row_from", "row_to"], runs_rows)
        copy_rows(cur, "game.map_border_cells", ["map_file_id", "col", "row", "open_sides"], border_rows)
        copy_rows(cur, "game.map_scene_objects", ["map_file_id", "layer", "ordinal", "name", "url", "x", "y", "base_num", "rotation",
                                                  "scale_x", "scale_y", "alpha", "width", "height", "chunk", "node_id", "asset_id"], objects)
        copy_rows(cur, "game.map_points", ["context", "map_id", "kind", "name", "ref_table", "ref_id", "x_px", "y_px", "grid_x", "grid_y",
                                           "target_map_id", "target_node_id", "extra", "source_ref"], points)
        register_source(cur, "map_files", "server_xml", "raw/maps/** (CDN maps/<id>/<id>.maps|.titles) via web/public/maps/*.json")
        missing = sorted(raw_ids - {int(p.stem) for p in files})
        print(f"mapas {len(summary)}, runs {len(runs_rows)}, borda {len(border_rows)}, objetos {len(objects)}, pontos {len(points)}"
              + (f"; sem JSON decodificado: {missing}" if missing else ""))


if __name__ == "__main__":
    main()
