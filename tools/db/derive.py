#!/usr/bin/env python3
from __future__ import annotations
import re

from common import RESEARCH_DIR, connect, copy_rows, load_json

FASHION_LAYERS = {109: "wing", 110: "hair_up", 111: "arms", 112: "body"}
EQUIP_LAYERS = {101: "arms", 104: "body"}
EFFECT_TOKEN = re.compile(r"^[A-Za-z][\w]*(\.[\w]+)+$")


def log(cur, table, column, key, value, issue):
    cur.execute("INSERT INTO meta.load_issues(table_name, column_name, record_key, value, issue) VALUES (%s,%s,%s,%s,%s)",
                (table, column, key, value, issue))


def skill_buff_links(cur):
    cur.execute("SELECT id FROM game.buffs")
    buffs = {r[0] for r in cur.fetchall()}
    cur.execute("SELECT id, buff_ids FROM game.skills WHERE buff_ids IS NOT NULL")
    rows, missing = [], []
    for sid, ids in cur.fetchall():
        for i, b in enumerate(ids):
            if b in buffs:
                rows.append((sid, i, b))
            elif b not in (0, -1):
                missing.append(("game.skill_buff_links", "buff_id", str(sid), str(b), "buff inexistente em SkillBufferTempInfos"))
    copy_rows(cur, "game.skill_buff_links", ["skill_id", "ordinal", "buff_id"], rows)
    copy_rows(cur, "meta.load_issues", ["table_name", "column_name", "record_key", "value", "issue"], missing)
    return len(rows)


def hero_ai_soldiers(cur):
    cur.execute("SELECT id FROM game.pawns")
    pawns = {r[0] for r in cur.fetchall()}
    cur.execute("SELECT id, soldiers_raw FROM game.hero_ais WHERE soldiers_raw IS NOT NULL")
    rows = []
    for aid, raw in cur.fetchall():
        for i, part in enumerate(p for p in raw.split("|") if p.strip()):
            try:
                pid, pos = (int(x) for x in part.split(",")[:2])
            except ValueError:
                log(cur, "game.hero_ai_soldiers", "soldiers_raw", str(aid), part, "par pawn,pos inválido")
                continue
            if not 1 <= pos <= 12:
                log(cur, "game.hero_ai_soldiers", "position", str(aid), part, "posição fora de 1..12")
                continue
            rows.append((aid, i, pid if pid in pawns else None, pos))
    return copy_rows(cur, "game.hero_ai_soldiers", ["ai_id", "ordinal", "pawn_id", "position"], rows)


def pet_skill_links(cur):
    cur.execute("SELECT id FROM game.skills")
    skills = {r[0] for r in cur.fetchall()}
    cur.execute("SELECT p.id, follow_skill_ids, change_skill_ids, r.attrs->>'DefaultSkills' FROM game.pets p "
                "JOIN raw.template_records r ON r.id = p.source_record_id")
    rows = []
    for pid, follow, change, default in cur.fetchall():
        for role, ids in (("follow", follow), ("change", change),
                          ("default", [int(default)] if default and default.lstrip('-').isdigit() else [])):
            for i, s in enumerate(ids or []):
                rows.append((pid, role, i, s, s in skills))
    return copy_rows(cur, "game.pet_skill_links", ["pet_id", "role", "ordinal", "skill_id", "skill_exists"], rows)


def suites_and_recipes(cur):
    cur.execute("SELECT id FROM game.items")
    items = {r[0] for r in cur.fetchall()}
    cols = ", ".join(f"piece{i}_item_id, piece{i}_alt_item_id" for i in range(1, 9))
    cur.execute(f"SELECT id, {cols} FROM game.item_suites")
    rows = []
    for r in cur.fetchall():
        for i in range(8):
            for alt, v in ((False, r[1 + 2 * i]), (True, r[2 + 2 * i])):
                if v and v > 0:
                    rows.append((r[0], i + 1, alt, v, v in items))
    n1 = copy_rows(cur, "game.item_suite_pieces", ["suite_id", "slot", "is_alternate", "item_id", "item_exists"], rows)
    rows = []
    cur.execute("SELECT id, " + ", ".join(f"material{i}_item_id, material{i}_count" for i in range(1, 5)) +
                " FROM game.item_compose_recipes")
    for r in cur.fetchall():
        for i in range(4):
            it, q = r[1 + 2 * i], r[2 + 2 * i]
            if it and it > 0:
                rows.append(("compose", r[0], i + 1, it, q, it in items))
    cur.execute("SELECT id, " + ", ".join(f"material{i}_item_id" for i in range(1, 9)) + " FROM game.item_transforms")
    for r in cur.fetchall():
        for i in range(8):
            if r[1 + i] and r[1 + i] > 0:
                rows.append(("transform", r[0], i + 1, r[1 + i], 1, r[1 + i] in items))
    cur.execute("SELECT id, " + ", ".join(f"output{i}_item_id, output{i}_count" for i in range(1, 5)) +
                " FROM game.item_resolves")
    for r in cur.fetchall():
        for i in range(4):
            it, q = r[1 + 2 * i], r[2 + 2 * i]
            if it and it > 0:
                rows.append(("resolve_output", r[0], i + 1, it, q, it in items))
    n2 = copy_rows(cur, "game.recipe_materials",
                   ["recipe_kind", "recipe_id", "slot", "item_id", "quantity", "item_exists"], rows)
    return n1, n2


def item_categories(cur):
    research = {}
    p = RESEARCH_DIR / "items_avatar.json"
    if p.exists():
        for c in load_json(p).get("item_categories") or []:
            try:
                research[(int(c["master_type"]), int(c["son_type"]))] = c
            except (KeyError, TypeError, ValueError):
                continue
    cur.execute("SELECT master_type, son_type, count(*) FROM game.items GROUP BY 1, 2")
    rows = []
    for mt, st, n in cur.fetchall():
        c = research.get((mt, st), {})
        layer = c.get("avatar_layer") or FASHION_LAYERS.get(st) if mt == 1 else c.get("avatar_layer")
        if mt == 1 and not layer:
            layer = EQUIP_LAYERS.get(st)
        if layer not in (None, "body", "arms", "hair_up", "hair_down", "cloak", "wing", "mount", "mount_wing", "pet"):
            layer = {"hair": "hair_up", "weapon": "arms"}.get(layer)
        default_system = "fashion" if (mt == 1 and st in FASHION_LAYERS) else ("equipment" if mt == 1 else None)
        rows.append((mt, st, c.get("name") or f"type_{mt}_{st}", c.get("label_pt"), c.get("system") or default_system,
                     layer, c.get("property_semantics_pt"), n, c.get("source_ref")))
    return copy_rows(cur, "game.item_categories",
                     ["master_type", "son_type", "code", "label_pt", "system", "avatar_layer", "property_semantics",
                      "item_count", "source_ref"], rows)


class Dirs:
    def __init__(self, cur):
        cur.execute("SELECT dir, count(*), array_agg(file_name ORDER BY file_name) FROM client.assets "
                    "WHERE manifest = 'res' GROUP BY dir")
        self.d = {r[0]: (r[1], r[2]) for r in cur.fetchall()}

    def match(self, owner_kind, owner_id, candidates):
        out = []
        for context, variant, d in candidates:
            d = d.lower()
            if d in self.d:
                n, files = self.d[d]
                out.append((owner_kind, owner_id, context, variant, d, n, files))
        return out


def item_candidates(p: str):
    p = "/" + p.strip().strip("/")
    yield "map", "normal", f"swf/avatar{p}"
    yield "map", "mount", f"swf/avatar{p}_mount"
    for half in ("up", "down"):
        yield "map", half, f"swf/avatar{p}{half}"
        yield "map", f"{half}_mount", f"swf/avatar{p}{half}_mount"
    yield "map", "cloak", f"swf/avatar{p}_cloak"
    yield "map", "cloak_mount", f"swf/avatar{p}_cloak_mount"
    yield "battle", "normal", f"equip{p}"
    for half in ("up", "down"):
        yield "battle", half, f"equip{p}{half}"
    yield "show", "normal", f"equip_show{p}"
    yield "show", "front", f"equip_show{p}/front"
    yield "show", "back", f"equip_show{p}/back"
    yield "show", "activity", f"equip_show/activity{p}"
    yield "map", "dragonic", f"swf/avatar/dragonic{p}"
    yield "map", "dragonic_mount", f"swf/avatar/dragonic{p}_mount"
    yield "battle", "dragonic", f"equip/dragonic{p}"
    yield "show", "dragonic", f"equip_show/dragonic{p}"


def avatar_resources(cur):
    dirs = Dirs(cur)
    rows = []
    cur.execute("SELECT id, avatar_path FROM game.items WHERE avatar_path ~ '^/?[A-Za-z]'")
    for iid, p in cur.fetchall():
        rows += dirs.match("item", iid, item_candidates(p))
    cur.execute("SELECT id, avatar_path, wing_avatar_path FROM game.mounts")
    for mid, body, wing in cur.fetchall():
        if body:
            rows += dirs.match("mount", mid, item_candidates(body))
        if wing:
            rows += dirs.match("mount_wing", mid, item_candidates(wing))
    cur.execute("SELECT id, avatar_path FROM game.pets WHERE avatar_path IS NOT NULL")
    for pid, p in cur.fetchall():
        rows += dirs.match("pet", pid, item_candidates(p))
    cur.execute("SELECT row_number() OVER (ORDER BY job_type, grade)::int, job_type * 1000 + grade, res_path FROM game.children "
                "WHERE res_path IS NOT NULL")
    for _n, cid, p in cur.fetchall():
        p = "/" + p.strip("/")
        rows += dirs.match("child", cid, [("battle", "normal", f"equip/hychild{p}"), ("map", "normal", f"swf/avatar/hychild{p}"),
                                          ("show", "normal", f"equip_show/hychild{p}")])
    cur.execute("SELECT grade, avatar_path FROM game.dragon_battle_mounts WHERE avatar_path IS NOT NULL")
    for g, p in cur.fetchall():
        rows += dirs.match("dragon_mount", g, item_candidates(p))
    for kind, sql in (("monster", "SELECT id, res_path FROM game.monsters WHERE res_path IS NOT NULL"),
                      ("pawn", "SELECT id, movie_res FROM game.pawns WHERE movie_res IS NOT NULL"),
                      ("hero_npc", "SELECT id, res_path FROM game.heroes WHERE res_path IS NOT NULL")):
        cur.execute(sql)
        for oid, res in cur.fetchall():
            res = res.strip("/")
            rows += dirs.match(kind, oid, [("battle", "movie", f"swf/{res}")])
    cur.execute("SELECT id, avatar_path FROM game.vehicles WHERE avatar_path IS NOT NULL")
    for vid, p in cur.fetchall():
        p = "/" + p.strip("/")
        rows += dirs.match("vehicle", vid, [("battle", "normal", f"vehicle{p}"), ("map", "normal", f"swf/avatar{p}")])
    uniq = {(r[0], r[1], r[4]): r for r in rows}
    return copy_rows(cur, "game.avatar_resource_dirs",
                     ["owner_kind", "owner_id", "context", "variant", "dir", "asset_count", "files"], uniq.values())


def fashion_items(cur):
    cur.execute("""
      INSERT INTO game.fashion_items
      SELECT i.id, c.avatar_layer, i.son_type, i.avatar_path,
             'swf/avatar' || i.avatar_path || CASE WHEN i.son_type = 110 THEN 'up|down' ELSE '' END,
             EXISTS (SELECT 1 FROM game.avatar_resource_dirs d WHERE d.owner_kind = 'item' AND d.owner_id = i.id AND d.context = 'map'),
             EXISTS (SELECT 1 FROM game.avatar_resource_dirs d WHERE d.owner_kind = 'item' AND d.owner_id = i.id AND d.context = 'battle'),
             EXISTS (SELECT 1 FROM game.avatar_resource_dirs d WHERE d.owner_kind = 'item' AND d.owner_id = i.id AND d.context = 'show')
      FROM game.items i JOIN game.item_categories c USING (master_type, son_type)
      WHERE i.master_type = 1 AND i.son_type IN (109, 110, 111, 112) AND i.avatar_path ~ '^/' AND c.avatar_layer IS NOT NULL""")
    return cur.rowcount


def mount_animations(cur):
    cur.execute("SELECT path, id FROM client.assets WHERE manifest = 'res'")
    assets = dict(cur.fetchall())
    cur.execute("SELECT id, avatar_path, wing_avatar_path FROM game.mounts")
    rows = []
    for mid, body, wing in cur.fetchall():
        for layer, p in (("mount", body), ("mount_wing", wing)):
            if not p:
                continue
            p = "/" + p.strip("/")
            res = f"swf/avatar{p}/2.bswf".lower()
            folder = p.strip("/").replace("/", "_")
            rows.append((mid, "map", "stand", layer, res, f"asset.{folder}_2.S_<frame>_<dir>", 3, 5, assets.get(res)))
            rows.append((mid, "map", "walk", layer, res, f"asset.{folder}_2.W_<frame>_<dir>", 5, 6, assets.get(res)))
    cur.execute("""SELECT m.id, d.avatar_path FROM game.dragon_battle_mounts d JOIN game.mounts m ON m.id = d.mount_template_id""")
    for mid, p in cur.fetchall():
        res = f"equip/dragonic/{p.strip('/')}/2.swf".lower()
        rows.append((mid, "battle", "battle_labels", "mount", res, "ClassExport (rótulos Stand/Walk/Ready/Danny/Die/Victory/Failed)",
                     None, None, assets.get(res)))
    return copy_rows(cur, "game.mount_animations",
                     ["mount_id", "context", "state", "layer", "resource", "frame_class_pattern", "directions", "frames", "asset_id"],
                     rows)


def visual_effects(cur):
    cur.execute("SELECT path, id FROM client.assets WHERE kind = 'skill_effect'")
    assets = dict(cur.fetchall())
    effects: dict[str, list] = {}
    links = []

    def kind_of(name: str, frame_type: int | None) -> str:
        if name.startswith("buff."):
            return "buff_effect"
        if name.startswith("hit."):
            return "hit_effect"
        if name.startswith("dust."):
            return "dust"
        if name.startswith("flying.") or frame_type in (11, 12):
            return "projectile"
        return "skill_effect"

    cur.execute("SELECT row_id, frame_type, params FROM game.action_frames WHERE params IS NOT NULL")
    for rid, ft, params in cur.fetchall():
        for i, p in enumerate(params):
            if p and EFFECT_TOKEN.match(p.strip()):
                name = p.strip()
                effects.setdefault(name, [kind_of(name, ft), 0])[1] += 1
                links.append((rid, i, name))
    cur.execute("SELECT add_effect, action_effect, last_effect FROM game.buffs")
    for row in cur.fetchall():
        for v in row:
            if v:
                name = v.split(",")[0].strip()
                if EFFECT_TOKEN.match(name):
                    effects.setdefault(name, ["buff_effect", 0])[1] += 1
    rows = []
    for name, (kind, n) in effects.items():
        path = "skilleffect/" + name.replace(".", "_").lower() + ".swf"
        rows.append((name, kind, path, assets.get(path), n))
    copy_rows(cur, "game.visual_effects", ["name", "kind", "swf_path", "asset_id", "usage_count"], rows)
    copy_rows(cur, "game.action_frame_effects", ["action_frame_row_id", "param_index", "effect_name"],
              {(a, b): (a, b, c) for a, b, c in links}.values())
    return len(rows), len(links)


def action_frame_layouts(cur):
    p = RESEARCH_DIR / "skills_buffs.json"
    if not p.exists():
        return 0
    n = 0
    for code, v in (load_json(p).get("action_para_layouts") or {}).items():
        try:
            code = int(code)
        except ValueError:
            continue
        cur.execute("""INSERT INTO game.action_frame_types(code, name, label_pt, param_names, description, source_ref)
                       VALUES (%s,%s,%s,%s,%s,%s)
                       ON CONFLICT (code) DO UPDATE SET param_names = EXCLUDED.param_names,
                         description = COALESCE(EXCLUDED.description, game.action_frame_types.description),
                         source_ref = COALESCE(game.action_frame_types.source_ref, EXCLUDED.source_ref)""",
                    (code, v.get("name") or f"type_{code}", v.get("label_pt") or v.get("name") or str(code),
                     v.get("para") or [], v.get("description_pt"), v.get("source_ref")))
        n += 1
    return n


DROP_ALIASES = {
    "entry_id": ("id", "Id"), "drop_id": ("dropId", "DropId"), "site": ("site", "Site", "Times"),
    "param2": ("para2", "Para2"), "item_id": ("itemId", "ItemId", "TemplateId"), "quantity": ("count", "Count", "Data"),
    "is_bound": ("isBind", "IsBind"), "appear_type": ("appearType", "AppearType"),
    "valid_days": ("validDate", "ValidDate"), "is_shown": ("isShow", "IsShow"),
}


def drop_entries(cur):
    cur.execute("""SELECT s.name, r.id, r.attrs FROM raw.template_records r JOIN raw.template_sets s ON s.id = r.set_id
                   WHERE (s.name ~ 'Drop' OR s.name ~ 'Reward(s|Drop)?$' OR s.name = 'RemainsExploreBox')
                     AND (r.attrs ? 'dropId' OR r.attrs ? 'DropId')""")
    rows = []

    def num(v):
        try:
            return int(v)
        except (TypeError, ValueError):
            return None

    for name, rid, a in cur.fetchall():
        get = {k: next((a[x] for x in xs if x in a), None) for k, xs in DROP_ALIASES.items()}
        rows.append((name, num(get["entry_id"]), num(get["drop_id"]), num(get["site"]), get["param2"],
                     num(get["item_id"]), num(get["quantity"]),
                     None if get["is_bound"] is None else get["is_bound"] in ("1", "true"),
                     num(get["appear_type"]), num(get["valid_days"]),
                     None if get["is_shown"] is None else get["is_shown"] in ("1", "true"), rid))
    return copy_rows(cur, "game.drop_entries",
                     ["drop_set", "entry_id", "drop_id", "site", "param2", "item_id", "quantity", "is_bound",
                      "appear_type", "valid_days", "is_shown", "source_record_id"], rows)


def main():
    conn = connect()
    with conn, conn.cursor() as cur:
        cur.execute("DELETE FROM meta.load_issues WHERE table_name IN ('game.skill_buff_links', 'game.hero_ai_soldiers')")
        cur.execute("TRUNCATE game.skill_buff_links, game.hero_ai_soldiers, game.pet_skill_links, game.item_suite_pieces,"
                    " game.recipe_materials, game.item_categories, game.fashion_items, game.avatar_resource_dirs,"
                    " game.mount_animations, game.action_frame_effects, game.visual_effects, game.drop_entries"
                    " RESTART IDENTITY CASCADE")
        print("skill_buff_links", skill_buff_links(cur))
        print("hero_ai_soldiers", hero_ai_soldiers(cur))
        print("pet_skill_links", pet_skill_links(cur))
        print("suite_pieces/recipe_materials", suites_and_recipes(cur))
        print("item_categories", item_categories(cur))
        print("avatar_resource_dirs", avatar_resources(cur))
        print("fashion_items", fashion_items(cur))
        print("mount_animations", mount_animations(cur))
        print("action_frame_types (layouts da pesquisa)", action_frame_layouts(cur))
        print("visual_effects/links", visual_effects(cur))
        print("drop_entries", drop_entries(cur))


if __name__ == "__main__":
    main()
