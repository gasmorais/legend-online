# Maps: spawns, portals, nodes, borders and formats (Legend Online BR)

This document describes map geometry: coordinate units, spawn and birth points, portals and nodes, walkable areas and borders, camera rules, map file formats and the coordinates hardcoded in the client. Scene flow and world links are in [README.md](README.md); rendering formats in [../client/graphics.md](../client/graphics.md) §4; the battle scene in [../battle/README.md](../battle/README.md) §4.

**Sources**
- Templates (`tempinfos.xml`), the protocol, the manifest and code constants.
- The **142 downloaded map files** in `raw/maps/**` (59 MapFileIds), decoded by `tools/maps.py` into `web/public/maps/<id>.json` and loaded into the DB by `tools/db/load_map_files.py`.
- Background tiles of the Reino do Céu (map 10000): 600 tiles + `small.jpg` in `raw/mapmaterial/land/10000`, used by the HTML5 rebuild's 2D map engine.
- Detailed research: `data/research/maps_geometry.json` (13 enums, 558 fixed coordinates, 17 formulas) and [maps_protocol_positions.md](../../data/research/maps_protocol_positions.md) (every message carrying a position).

**Conventions:** **CM** = `decompiled/core_module/scripts`, **M3, M4, …** = `decompiled/mN/scripts`; `file:line` is relative to those roots.

## Database tables

| table | content |
|---|---|
| `game.map_bounds` | bounds of the 1 112 maps (`MapInfos`): px rectangle, tile and walk grids, manifest files |
| `game.map_points` | 2 038 points (248 from map files, `ref_table = 'map_file'`): space map nodes and birth points, portals, Crisis/Outyard/Exploration nodes, campaign icons, building slots, battle grid and 558 hardcoded coordinates |
| `game.map_files`, `map_walk_runs`, `map_border_cells`, `map_scene_objects` | map file content: 20 px grid as runs (773k cells), border (105k cells), scene objects (267) |
| `game.v_map_overview` | per map: bounds, grid, border, objects, spawns and portals from the files |
| `game.map_point_kinds` | 67 point kinds, source (template / map file / message / constant) and unit |
| `game.map_file_formats` | format of `.maps` (floor/movies/tops), `.titles` (values), `.rd`, `.path`, tiles |
| `game.map_nodes`, `crisis_map_nodes`, `outyard_map_nodes`, `monster_explore_nodes`, `castle_building_art` | typed template lists with coordinates |
| `meta.enum_values` | `pos_type`, `node_state`, `space_node_type`, `titles_cell_value`, `army_state`, `fog_grid_type`, `move_speed`… |

## 1. Units

| unit | used by |
|---|---|
| **20 px cell** | the walk grid and almost every server position field (`pos_x/pos_y`, `cur_pos_x/y`, `end_pos`, `reset_x/y`, `tar_x/y`, `BossMsg`/`BoxMsg` x/y…) and `MapNodeInfos.PosX/PosY`. px = cell × 20 (`CM/map/internals/data/MapPhysics.as:52`) |
| **pixel** | `MapNodeInfos.FixX/FixY` and `CampaignNodeMsg.fix_x/fix_y` (draw position), `PosMoveMsg.routes[]`, small maps (`CrisisMapInfos.X/Y`, `HugeHeadMapNodeTempInfos.PosX/PosY`, `MonsterExploreTemplates.PosX/PosY`, `BuildingTempInfos.PosX/PosY`, `Campaigns.PosX/PosY`) |
| **displayed coordinate** | UI/minimap = cell / 2.5 = px / 50 (`CM/map/internals/constant/MapGrid.as:8-20`, `CM/mainBar/SmallMapBar.as:1023`); minimap = position / 16 (`UIConfig.SMALL_MAP_SCALE`) |
| **1000 px block** | `floor(x/1000)` + `,` (or `_`) + `floor(y/1000)`: `.maps` chunks and world map paging (`PosMoveMsg.grid_str`, `PhysicUpdateReqMsg.req_grid`) |
| **background tile** | 300 px in instances and the space map (`tile_<x>_<y>.jpg`, x first, `ceil(W/300)×ceil(H/300)`); 512 px in worlds 1 to 5 (20×20, `.jpg` 2D or `.png.atf` Stage3D, folder = mapId) |
| **speed** | 7 px/frame (mounted: `7·(100+bonus)/100`); NPC 2 to 6 (`move_speed`) |

## 2. Spawns and birth points

| context | source | unit |
|---|---|---|
| instance/campaign (real data) | editor nodes in `.maps`: 20 type-40 nodes (start) in 10 maps, with `startPos` = spawn cells `"gx,gy|…"` (28 cells; e.g. Templo de Tara 2351: (85,89) (81,89) (82,86) (77,87)) and 5 type-41 nodes (exit) | cell / px |
| entering campaign/instance | `RoomEnterMsg.player[].cur_pos_x/y` (U_C_CAMPAIGN_ENTER 21; `CM/map/campaign/CampaignManager.as:636`); if outside `[0,W]×[0,H]`, the client uses the first type-40 node (COPY_START), in PvP/svs the team's one (`CampaignMapModel.as:716-744`) | cell |
| space map ("Reino do Céu", 10000) | `RoomPlayerMsg.cur_pos` in 4595/4606; with no walkable start, snaps to the type-40 node (node 14 at (175,98) cells = (3500,1960) px). `MapNodeInfos.BornPoints` (9 cells 172..181 × 98..104) is **not read** by the client | cell |
| outer city | camera on the own castle (`BaseCastleMsg`, 4153); army in `ArmyMsg.cur_pos`; opening the world map targets (5000,5000) | cell |
| reposition / revive | `StandPosMsg` (4126) or `ArmyPosUpdatedMsg` (4104: teleports if > 150 px, otherwise walks via A*). The client never computes a respawn point | cell |
| newbie | fixed positions per `newbieProcess`: (3000,1080), (1285,1045), (1320,860), (1340,700) (`M3/map/campaign/view/layer/CampaignWalkView.as:516-541`) | px |
| space map robots | 19 fixed cells (`CM/yishi/manager/SpaceTemplateManager.as:56-74`) | cell |
| battle | 3×4 grid per side (`BattleUtils.get9GridPos`) | px |

## 3. Portals and nodes

### Node types (`pos_type`)

| type | meaning |
|---|---|
| 40 | start |
| 41 | end |
| 42 | NPC/trigger |
| 61 | dialog |
| **62** | **portal to another map** |
| **63/171** | **same-map teleport** |
| 67 | moving NPC |
| 91 | gather |
| 92 | chest |
| 201 | scene animation |
| 191 to 197 | steel map |
| 202 to 206 | shooting minigame |

The full enum (including 53, 64, 121/131, 1001/1002) is in [README.md](README.md) §3.1.

### Nodes per map kind

| map kind | nodes |
|---|---|
| campaign | arrive via `CampaignNodeMsg` (127/4264): `pos` (cell), `cur` (cell, walking NPC), `fix` (px), `reset_x/y` (where the player stands after interacting), `pre/next_node_ids` (graph), `handler_range` (radius). `resource == 1` → walking avatar; otherwise building `mapmaterial/build/<sonType>.swf`. Interaction: 5125 `CampaignReqMsg.paraInt1 = campDataId`. Teleport: the `TRANSPORT_END` animation moves to the node, then to `reset*20` |
| space map | 58 nodes in `MapNodeInfos` (`CM/map/space/SpaceManager.as:344-398`): single portal node 5 "Ilha dos Einherjars, Transmissor" (429,96) → map 20001 node 2000101; 20 gift piles (300); 36 NPCs (61). `HandlerRange` 0/4/8 = diamond over walkable cells (`CM/map/internals/data/SpaceNode.as:81-114`) |
| small maps | Crisis (295 nodes in 3 maps of 2659×2320, `LineNode`), Outyard (69 nodes + fixed routes between 11 battle nodes), Monster Exploration (145 nodes, lines at (PosX+25, PosY+25)), Planes (`Size` "C_R", 100 px cell), Hermitage (hexagons from `SecretMapDataTemplates.MapDatas`), Dark Labyrinth (22 fixed nodes), Theseus Dungeon (45 cells 9×5), Minos (16×10 cells of 91 px) |
| map files | `.maps` embed the editor nodes (`campaign` of each item: type, px position, `startPos`, `nextNodeIds`, `moveToNodeIds`, troops, AI, `HandlerRange`). 220 nodes: 98 type 42, 42 static, 36 dialog, 20 start, 8 portals (Templo de Tara 2351 to 2353, 传送阵 in 7601/7602, Ilha dos Einherjars in the space map), 5 end, gather, crossings. Editor names are Chinese; pt-BR names come from the server |
| campaign selection map | 128 icons at `Campaigns.PosX/PosY` over `swf/singlecampaign1/<chapter>/map/<chapter>.swf` |

## 4. Borders, bounds and camera

### Map rectangle

`MapInfos.Width × Height` (default 2000 if 0).

| map size | background layer |
|---|---|
| instances ≤ 5000 px | one bitmap (`MapRenderLayer`) |
| larger | 1000 px blocks (`OuterCityStaticLayer`) |
| fixed list of maps and modes (labyrinths, forbidden boss, Theseus) | `BgLayer` with 300 px tiles |

### Walkable area

Defined by the `"{x}_{y}"` keys of `.titles`:

| maps | convention |
|---|---|
| campaign/space | truthy = walkable; 2 = barrier (blocks vehicles); 1/3/4 = steel map zones (crossing requires an open door); 4 = semi-transparent cell |
| outer city | **inverted**: truthy = obstacle (`M3/map/outercity/path/PathMapHitTester.as:19-22`, `CM/map/outercity/OuterCityModel.as:510-515`) |

The border is the outline of the walkable set; cells outside the `W/20 × H/20` grid are blocked (FindPath8). The auxiliary A* is limited to 100×100 cells.

### Camera

| mode | rule |
|---|---|
| campaign | `x = max(min(x,−10), stageW>W ? (stageW−W)/2 : stageW−W)` (same for y); follows the hero with lerp 0.2 and dead zone 10+speed |
| outer city | `x ∈ [stageW−W, −30]`, `y ∈ [stageH−H, 0]`; arrows move 50 px; instant jump > 1000 px; darkened 150 px border strip |
| space/BgLayer | `x ∈ [stageW−W·scale, 0]`, zoom 0.75 to 1 |
| castle | bounds = size of the background image `castle.InnerCityBg1`; 88 px border fog |
| battle | scene `clamp(stageW,1000,1500) × clamp(stageH,600,900)`, `CAMERA_X = 650`, `CAMERA_Y = 900 − height/2` |

### Campaign fog

110×86 px hexagons (odd rows shifted 55), reveal 1 to 5 rings (`fog_grid_type`).

## 5. File formats

| file | structure |
|---|---|
| `maps/<id>/<id>.maps` | zlib + 3 AMF3 objects. `floorData[chunk][baseNum][] = {url,x,y,rotation,baseNum}`: `baseNum 101` = repeated background, only `> 101` is drawn (numeric order), `rotation` in degrees is mandatory. `moviesData`/`topsData[chunk][] = {url,x,y,rotation,scaleX?,scaleY?}`: scene SWFs below/above the avatar (`CM/map/campaign/preload/PreCampaignData.as:69-141`, `M3/map/internals/view/layer/MapRenderLayer.as:95-229`) |
| `maps/<id>/<id>.titles` | zlib + 1 AMF3 object `{"gx_gy": int}` (see §4) |
| `maps/<id>/<id>.rd`, `.path` | dead code |
| `mapmaterial/land/<id>/tile_<x>_<y>.jpg` (+ `small.jpg` thumbnail) | tiled background |

## 6. Hardcoded coordinates

558 rows in `game.map_points` with `ref_table = 'hardcoded'`:
- castle (client-only buildings, action bubbles, paths of 8 NPCs);
- space robots, newbie;
- secret war 2023 (17 nodes + links);
- farm (10 mount slots, 2 paths, 30 animal slots);
- Outyard (18 routes, 11 nodes, per-map offsets);
- auto-chess (8 slots → battle positions 3,6,9,12,1,4,7,10);
- Golden Road (36 squares), Perkin Lab, guild PvE (5 areas × 12 nodes), guild war towers, Sky Box Road;
- Glory Road (nodes/chests/buffs), Shadow Land, Spirit Expedition, cat yard, Planes War;
- Dark Labyrinth (22 nodes), Theseus Dungeon (45 cells);
- alchemy mines, magic cards, Molong chest ring, Bloody chests.

```sql
SELECT kind, name, x_px, y_px, source_ref FROM game.map_points WHERE ref_table = 'hardcoded' ORDER BY kind;
```

## 7. Real grid and border (downloaded files)

- 59 maps decoded: 54 campaign/space maps with **walkable** semantics (418k cells, 42.8k border cells) and worlds 1 to 5 with **obstacle** semantics (outer city).
- `game.map_walk_runs` stores the grid as vertical runs (`col`, `row_from..row_to`, `value`).
- `game.map_border_cells` stores the cells with an unmarked neighbor and which sides are open (bits 1 left, 2 right, 4 up, 8 down). This is the map border.
- Campaign `.maps` are small: almost no floor (13 items) and 254 `tops` objects (buildings/NPCs `mapmaterial/build/*.swf`). The background comes from `mapmaterial/land` tiles; of those, only map 10000 is downloaded (`raw/mapmaterial/land/10000`).
- The other 167 MapFileIds referenced by `MapInfos` have no file in the manifest.
