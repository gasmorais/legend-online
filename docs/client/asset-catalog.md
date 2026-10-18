# Manifest catalog (Legend Online BR)

This document describes the catalog of the full CDN manifest: where it comes from, how each file is classified, how many files each kind has and how the catalog links to game data. The catalog was built **without downloading anything**; files are fetched on demand by `tools/fetch_assets.py` (see [renderer.md](renderer.md) §0). Formats of the cataloged resources are in [graphics.md](graphics.md).

## Sources and storage

| item | value |
|---|---|
| entries | 52 623: 52 275 from `res_md5.dat` + 348 modules from `code_md5.dat` |
| index files | `index/manifest_all.csv`, `index/manifest_res.json`, `index/manifest_code.json` |
| DB | `client.assets` (one row per file) and summary view `client.v_asset_catalog` |
| loaders | `tools/db/load_client.py` + `tools/db/load_catalog.py` |
| real URL (column `url`) | `https://res1264oas.creaction-network.com/<path without extension>_<md5>.<ext>`; without the md5 the CDN returns 403 |

The manifest is **partial** (e.g. only 66 of ~350 referenced skill effects appear), so absence from the manifest does not prove the file is missing.

## Derived columns

| column | derivation |
|---|---|
| `kind` | path prefix (enum `client.asset_kind`): `swf/avatar*`/`.bswf` → map_avatar, `equip/` → battle_equipment, `equip_show/` → ui_show, `mapmaterial/land` → map_tile, `.atf` → stage3d_texture... |
| `family` | owner folder name: `fashion_cloth`, `fashion_hat`, `fashion_weapon`, `wing`, `mount`, `pet`, `hychild`, `warrior_default`...; for non-avatars, the first 2 segments (`icon/appell`, `mapmaterial/land`) |
| `owner_folder` | folder without variant suffixes; matches `ItemTempInfos.Avata`, `MountTempInfos.AvatarPath`, `PetTempInfos.PetAvatar` (see `game.avatar_resource_dirs`) |
| `variant` | `mount` (`_mount`, used when mounted without standing pose), `up`/`down` (hat halves), `front`/`back` (show), `cloak`, `follow` (follower pet), `dragonic` |
| `job_id`, `sex_id` | file `<job>_<sex>.(b)swf` (fashion/wing) or `<sex>.(b)swf` (equipment); 0 female, 1 male; `2.*` = mount/pet/child (no sex) |
| `numeric_ids` | every number in the path (map id, tile x/y, icon ids, levels) |
| `local_path` | `raw/<path>` when already downloaded (≈300 at catalog time: the 142 of `maps/`, skill effects, battle scenes, boss/monster MovieClips; recomputed on each load) |
| `path_function`, `path_variant`, `path_params` | `PathManager` function (`routes/routes.json`) whose template produces the path, plus the captured values; the most specific template wins. **51 868 of 52 623** paths match |

Paths with no matching function: the 348 code modules, 294 images built by concatenation outside PathManager, 45 `swf/singlecampaign1/*`, 38 configs, 19 `skillname/`, 10 goddess, 1 audio.

## Counts by kind

| kind | files | MB | main PathManager functions |
|---|---:|---:|---|
| map_avatar | 16 484 | 4 503 | `wingAvatarResourcePath` (15 575: `swf/avatar<res>/<job>_<sex>.bswf`), `avatarResourcePath` (693: `.../<n>.bswf`) |
| map_tile | 8 579 | 190 | `getMapBackPaths` (`mapmaterial/land/<id>/tile_<col>_<row>.jpg`, 300 px; worlds 1-5: 20×20 tiles of 512 px) |
| ui_show | 8 341 | 1 473 | `getAvatarResourcePath`, `getPetMorphShowPath`, `getChildShowByJobAndGrade` |
| icon | 7 628 | 65 | `getMagicPubIconPath` (generic `icon<...>`), `getAppellPicPath`, `getGoldRoadIconPath`... |
| battle_equipment | 7 544 | 5 240 | `solveWingAvatarPath` (15 105 incl. show: `equip<res>/<job>_<sex>.swf`), `solveChildAvatarPath`, `solveRoleDefaultPath` |
| stage3d_texture | 2 000 | 274 | `getMapBackPaths` (`tile_x_y.png.atf` of worlds 1-5, Stage3D) |
| image | 1 000 | 59 | instances, titles, furniture, map names |
| code_module | 348 | 186 | (none) (modules `N.png`, UI `ui/zh_cn/*.swf`) |
| map_material | 197 | 33 | `solveMapPhysicsBySonType` (`mapmaterial/build/<SonType>.swf`) |
| map_data | 117 | 2 | `getOuterCityMapsData` (58 `.maps`), `getOuterCityTilesData` (59 `.titles`) |
| skill_effect | 81 | 25 | `solveSkillResPath` (`skilleffect/<link with . → _>.swf`) |
| unit_movie / npc | 68 / 58 | 25 / 32 | `solveRolePath` (`swf/<res>/<res>.swf`), `NpcAvatarResourcePath`, `getForbiddenBossPath` |
| planes_war, vehicle, goddess, battle_map, skill_name, config, audio | 52, 26, 25, 17, 19, 38, 1 | | `planesMapByLandTypeAndSize`, `getVehicleAvatarPath`, `getGoddessAvaterPath`, `getBattleMapPath` (`sceneima/<id>/map<id>.swf`) |

### Fashion by family

| family | map | battle | UI |
|---|---:|---:|---:|
| hat | 4 409 | 1 860 | 2 069 |
| cloth | 3 762 | 1 869 | 1 873 |
| weapon | 3 754 | 1 864 | 1 867 |
| wing | 3 746 | 1 854 | 1 858 |

About 340 pieces each, in the 6 combinations `{1,2,3}_{0,1}` (+ `4_x` draconian in `.../dragonic/`) and the `_mount` variants.

## Link to game data

| table | link |
|---|---|
| `game.avatar_resource_dirs` | for each item, mount, mount wing, pet, child, dragon mount, troop, NPC and monster: the manifest folders holding its art, per context (map/battle/show) |
| `game.fashion_items`, `game.mount_animations`, `game.visual_effects` | point to `client.assets` when the file is in the manifest |
| `client.url_templates` + `client.assets.path_params` | the templates and the captured values, so the PathManager call that would request each file can be rebuilt |

## Related name tables

| source | table | content |
|---|---|---|
| `index/language.json` | `client.localized_texts` (locale `pt_BR`) | 12 716 UI texts |
| `raw/ui/zh_cn/decoded/nameslib.txt` | `client.name_pool` | 20 109 random-name pool names (disabled by the file header) |
| `index/screens.json` | `client.screens` | 1 097 screens with pt-BR title |
| `web/public/lib/linkage.json` | `client.symbol_linkages` | 17 875 class names → UI SWF |
| `web/public/lib/<swf>/library.json` | `client.swf_symbols`, `client.swf_frame_labels` | 37 723 characters from 320 SWFs, 120 frame labels |
| `tempinfos.xml` | `raw.template_records`, `game.*` | pt-BR names of heroes, items, skills, mounts, maps... |

## Example queries

```sql
SELECT * FROM client.v_asset_catalog ORDER BY files DESC;
SELECT path, url FROM client.assets WHERE owner_folder = 'swf/avatar/fashion_cloth_ballet';
SELECT path_function, count(*) FROM client.assets GROUP BY 1 ORDER BY 2 DESC;
```
