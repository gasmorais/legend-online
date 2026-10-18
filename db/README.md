# Mechanics database: Legend Online BR (OAS1264)

PostgreSQL 17 in Docker with **all** server template lists (`{TPL}tempinfos.xml`), the protocol, CDN resources, pt-BR texts, screens and an English semantic model of the game mechanics.
Mechanics docs: [`docs/mechanics/README.md`](../docs/mechanics/README.md); see also [`docs/client/animations.md`](../docs/client/animations.md), [`docs/client/asset-catalog.md`](../docs/client/asset-catalog.md) and [`docs/world/maps.md`](../docs/world/maps.md).

## Start and load

```bash
docker compose --profile db up -d db
```

```bash
pip3 install -r tools/db/requirements.txt
```

```bash
python3 tools/db/load_all.py
```

- On first start (empty volume) Postgres applies `db/migrations/*.sql` (initdb). `load_all.py` applies missing migrations and runs the loaders in order; `--reset` drops the schemas and rebuilds everything.
- Connection: `postgresql://lobr:lobr@127.0.0.1:5464/lobr` (override with `LOBR_DB_DSN`). Default `search_path`: `game, client, raw, meta, public`.
- Inputs: `data/tpl/tempinfos.xml` (from `http://s1264oas.creaction-network.com/xml/tempinfos.xml`, version `619099013`), `index/*`, `protocol/*`, `routes/*`, `data/research/*.json` (AS3 code mappings).

## Schemas

| schema | content |
|---|---|
| `meta` | migrations, provenance (`data_sources`), load problems (`load_issues`), 358 enums with 3 501 codes (`enum_types`/`enum_values`), 171 mechanics and subsystems (`mechanics`, `mechanic_links`), 244 formulas |
| `client` | `proto_messages`/`proto_fields` completed with 222 AS3-only messages and submessage types (`parse_as3_protos.py`), `assets` (52 623 manifest resources, with URL, family, variant, job/sex, ids and PathManager function), `swf_symbols`/`swf_frame_labels` (UI timelines), `symbol_linkages`, `name_pool`, `opcodes`, `opcode_messages` (inferred pairs), `localized_texts`, `screens`, `ui_styles`, `url_bases`/`url_templates`/`http_endpoints` |
| `raw` | `template_sets` (292 lists), `template_fields` (attributes with type, example, description, enum, logical FK), `template_records` (190 019 lossless JSONB records) |
| `game` | semantic model (114 tables across the 4 schemas, 11 views): 54 tables generated from the spec + reference (jobs, sexes, avatar layers, z-order, animation labels, battle grid) + derived (links, fashion, avatar resources, visual effects, drops) + animation orders (`avatar_direction_map`, `avatar_frame_sequences`, `battle_label_transitions`, `v_action_timelines`) + maps (`map_points`, `map_bounds`, `map_point_kinds`, `map_file_formats`, and from downloaded files: `map_files`, `map_walk_runs`, `map_border_cells`, `map_scene_objects`, `v_map_overview`) + `v_*` views |

## Files

| path | role |
|---|---|
| `compose.yaml` (service `db`, profile `db`) | postgres:17-alpine, volume `pgdata`, port 127.0.0.1:5464 |
| `db/migrations/0001..0012` | versioned DDL (0005 is **generated** by `tools/db/gen_schema.py`) |
| `tools/db/tempinfos.py` | decodes the tempinfos binary (uint size + zlib(uint version + [u8 name][int len][xml]…)) |
| `tools/db/spec.py` | declarative spec XML → English table/column, types, FKs, comments |
| `tools/db/mechanics.py` | mechanics catalog and links |
| `tools/db/load_*.py`, `derive.py`, `derive_maps.py`, `annotate.py` | loaders (order in `load_all.py`); `load_catalog.py` = manifest catalog, UI timelines, names; `load_map_files.py` = decoded maps (`web/public/maps/*.json` from `raw/maps`) |
| `tools/db/load_world.py` | scenes, transitions, worlds/links, campaign editor nodes, dungeons and room protocol (migration 0013, `index/world.json`, [`docs/world/README.md`](../docs/world/README.md)); run after `load_map_files.py` (not yet in `load_all.py`) |
| `tools/db/infer_opcode_messages.py` | infers opcode ↔ AS3 protobuf message (1 494 opcodes linked) |
| `tools/db/build_docs.py` | generates `docs/mechanics/*.md` (research + DB catalog) |
| `data/research/*.json` | code research: enums, semantics of 3 073 fields, formulas, subsystems |

## Conventions
- Every template table has `source_record_id` (FK to `raw.template_records`) and `source_ref` (`tempinfos.xml#List[ordinal]`).
- A reference to a missing template becomes `NULL` and is logged in `meta.load_issues`; the original value stays in the raw JSONB.
- CSV fields become `integer[]`; `"a|b"` is split into columns when it has semantics (e.g. `mounts.avatar_path` / `wing_avatar_path`).
- `meta.enum_label('enum', code)` returns the pt-BR label of a code.

## Example queries

```sql
-- skill with action, attack labels, effects and buffs
SELECT * FROM game.v_skills WHERE id = 20;
-- mount: map animations (S/W body and wing) with URL
SELECT name, animations FROM game.v_mounts WHERE name ILIKE '%dragão%';
-- fashion and its art folders (map/battle/UI)
SELECT * FROM game.v_fashion WHERE name ILIKE '%balé%';
-- what the server sends on opcode 153
SELECT * FROM client.v_opcode_messages WHERE code = 153;
-- template fields with semantics
SELECT attribute, semantic_column, enum_name, description FROM raw.template_fields f
JOIN raw.template_sets s ON s.id = f.set_id WHERE s.name = 'MountTempInfos';
```
