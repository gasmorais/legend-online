#!/usr/bin/env python3
from __future__ import annotations
import json
import re

from common import ROOT, connect, copy_rows, load_json, register_source

AVATAR_KINDS = {"map_avatar", "battle_equipment", "ui_show", "npc", "unit_movie"}
DEFAULT_RE = re.compile(r"^(warrior|hunter|wizard|dragonman|mystery|sword)_(default|sitdown)")


def compile_templates(routes):
    out = []
    for fn in routes["path_manager"]:
        for i, v in enumerate(fn["variants"]):
            t = v["template"]
            if v.get("base") != "RES" or not t.startswith("{RES}"):
                continue
            body = t[len("{RES}"):].lower()
            parts = re.split(r"(\{[^}]*\})", body)
            literal = "".join(p for p in parts if not p.startswith("{"))
            if len(literal.strip("/._")) < 4:
                continue
            rx = ""
            for k, p in enumerate(parts):
                if not p.startswith("{"):
                    rx += re.escape(p)
                else:
                    prev = parts[k - 1] if k else ""
                    nxt = parts[k + 1] if k + 1 < len(parts) else ""
                    multi = prev and not prev.endswith("/") and (nxt == "" or nxt.startswith("/"))
                    rx += "(.+?)" if multi else "([^/]+)"
            rx = "^" + rx + ("" if body.endswith("/") else "$")
            out.append((len(literal), fn["fn"], i, re.compile(rx)))
    out.sort(key=lambda x: -x[0])
    return out


def classify(path: str, kind: str):
    d, _, fname = path.rpartition("/")
    variant = "normal"
    folder = d
    if kind in AVATAR_KINDS:
        if folder.endswith("/front") or folder.endswith("/back"):
            variant = folder.rsplit("/", 1)[1]
            folder = folder.rsplit("/", 1)[0]
        last = folder.rsplit("/", 1)[-1]
        mods = []
        for suf in ("_mount", "_follow", "_cloak"):
            if last.endswith(suf):
                mods.insert(0, suf[1:])
                last = last[: -len(suf)]
        if last.startswith("fashion_hat"):
            for half in ("up", "down"):
                if last.endswith(half):
                    mods.insert(0, half)
                    last = last[: -len(half)]
                    break
        if mods:
            variant = "_".join(mods) if variant == "normal" else variant + "_" + "_".join(mods)
        if "/dragonic/" in path + "/" and variant == "normal":
            variant = "dragonic"
        folder = folder.rsplit("/", 1)[0] + "/" + last if "/" in folder else last
        if folder.endswith("/front") or folder.endswith("/back"):
            folder = folder.rsplit("/", 1)[0]
        name = last
        m = DEFAULT_RE.match(name)
        if m:
            family = f"{m.group(1)}_{m.group(2)}"
        elif name.startswith("fashion_"):
            family = "_".join(name.split("_")[:2])
        else:
            family = re.split(r"[\d_]", name, maxsplit=1)[0] or name
        if folder.startswith("equip/hychild") or folder.startswith("equip_show/hychild") or folder.startswith("swf/avatar/hychild"):
            family = "hychild"
    else:
        segs = path.split("/")
        family = "/".join(segs[:2]) if len(segs) > 2 else segs[0]
    job = sex = None
    m = re.match(r"^([1-4])_([01])\.b?swf$", fname)
    if m:
        job, sex = int(m.group(1)), int(m.group(2))
    elif kind in ("map_avatar", "battle_equipment", "ui_show") and re.match(r"^[01]\.b?swf$", fname):
        sex = int(fname[0])
    nums = [int(n) for n in re.findall(r"\d+", path) if int(n) < 2**31][:12]
    return family, folder, variant, job, sex, nums


def enrich_assets(cur):
    routes = load_json(ROOT / "routes/routes.json")
    tpls = compile_templates(routes)
    cur.execute("SELECT id, path, kind FROM client.assets")
    rows = []
    hits = 0
    for aid, path, kind in cur.fetchall():
        family, folder, variant, job, sex, nums = classify(path, kind)
        fn = var = None
        params = None
        for _score, name, i, rx in tpls:
            m = rx.match(path)
            if m:
                fn, var, params = name, i, list(m.groups())
                hits += 1
                break
        rows.append((aid, family, folder, variant, job, sex, nums, fn, var, params))
    cur.execute("""CREATE TEMP TABLE asset_enrich (id integer, family text, owner_folder text, variant text, job_id smallint,
                   sex_id smallint, numeric_ids integer[], path_function text, path_variant smallint, path_params text[]) ON COMMIT DROP""")
    copy_rows(cur, "asset_enrich", ["id", "family", "owner_folder", "variant", "job_id", "sex_id", "numeric_ids",
                                    "path_function", "path_variant", "path_params"], rows)
    cur.execute("""UPDATE client.assets a SET family = e.family, owner_folder = e.owner_folder, variant = e.variant,
                     job_id = e.job_id, sex_id = e.sex_id, numeric_ids = e.numeric_ids, path_function = e.path_function,
                     path_variant = e.path_variant, path_params = e.path_params
                   FROM asset_enrich e WHERE e.id = a.id""")
    return len(rows), hits


def mark_downloaded(cur):
    raw = ROOT / "raw"
    cur.execute("SELECT id, path FROM client.assets WHERE manifest = 'res'")
    hits = [(aid, f"raw/{path}") for aid, path in cur.fetchall() if (raw / path).is_file()]
    cur.execute("CREATE TEMP TABLE asset_local (id integer, local_path text) ON COMMIT DROP")
    copy_rows(cur, "asset_local", ["id", "local_path"], hits)
    cur.execute("UPDATE client.assets a SET local_path = l.local_path FROM asset_local l WHERE l.id = a.id")
    return len(hits)


def load_swf_libraries(cur):
    lib_dir = ROOT / "web/public/lib"
    syms, labels = [], []
    for f in sorted(lib_dir.glob("*/library.json")):
        swf = f.parent.name
        try:
            lib = json.loads(f.read_text(encoding="utf-8"))
        except (json.JSONDecodeError, OSError):
            continue
        link_by_id = {}
        for name, cid in (lib.get("linkage") or {}).items():
            link_by_id.setdefault(int(cid), name)
        fps = lib.get("fps")
        for cid, ch in (lib.get("chars") or {}).items():
            cid = int(cid)
            tl = ch.get("timeline")
            ops = sum(len(fr) for fr in tl) if isinstance(tl, list) else None
            lab = ch.get("labels") or {}
            syms.append((swf, cid, ch.get("kind") or "unknown", link_by_id.get(cid), ch.get("w"), ch.get("h"),
                         ch.get("frames"), len(lab) if "frames" in ch else None, ops, fps))
            for i, (name, frame) in enumerate(sorted(lab.items(), key=lambda kv: kv[1])):
                labels.append((swf, cid, name, int(frame), i))
    copy_rows(cur, "client.swf_symbols", ["swf", "char_id", "kind", "linkage", "width", "height", "frames", "label_count",
                                          "place_ops", "fps"], syms)
    copy_rows(cur, "client.swf_frame_labels", ["swf", "char_id", "label", "frame", "ordinal"], labels)
    link = load_json(lib_dir / "linkage.json")
    copy_rows(cur, "client.symbol_linkages", ["linkage", "swf", "char_id"], ((k, v[0], int(v[1])) for k, v in link.items()))
    register_source(cur, "swf_libraries", "project_index", "web/public/lib/*/library.json (tools/swflib.py)")
    register_source(cur, "linkage", "project_index", "web/public/lib/linkage.json", lib_dir / "linkage.json")
    return len(syms), len(labels), len(link)


def load_names(cur):
    p = ROOT / "raw/ui/zh_cn/decoded/nameslib.txt"
    names = []
    for line in p.read_text(encoding="utf-8").splitlines():
        if line.startswith("#"):
            continue
        names += [n.strip() for n in line.split(",") if n.strip()]
    copy_rows(cur, "client.name_pool", ["ordinal", "name", "locale"], ((i, n, "pt_BR") for i, n in enumerate(names)))
    register_source(cur, "nameslib", "project_index", "raw/ui/zh_cn/decoded/nameslib.txt", p)
    return len(names)


def main():
    conn = connect()
    with conn, conn.cursor() as cur:
        cur.execute("TRUNCATE client.swf_frame_labels, client.swf_symbols, client.symbol_linkages, client.name_pool")
        print("assets enriquecidos / com função do PathManager", enrich_assets(cur))
        print("baixados em raw/", mark_downloaded(cur))
        print("símbolos / rótulos / linkages", load_swf_libraries(cur))
        print("nomes", load_names(cur))


if __name__ == "__main__":
    main()
