# World map: outer city scene, chunks and visibility

Area: world-map, module `scene`. Covers entering and leaving the outer city ("Arredores", `OUTER_CITY_SCENE`), which world is shown, the map files, the 1000 px chunk subscription protocol (5004, 5181, 8201 → 169, 4129), incremental map updates (140), the client visibility rules (660 px, fog) and the own castle record at login (4153).

Conventions:

- `CM` = `decompiled/core_module/scripts`, `M3` = `decompiled/m3/scripts`, `M11` = `decompiled/m11/scripts`.
- C>S = client to server, S>C = server to client.
- Units: entity positions on the wire are **20 px cells** (`pos_x/pos_y`, `cur_pos_x/y`); walk routes (`RouteMsg`) are **pixels**; chunks are 1000 × 1000 px blocks keyed `"floor(x/1000)_floor(y/1000)"`. The UI shows cell × 2 / 5 (`int(posX * 2 / 5)`).

## 1. Overview

The outer city is the big strategic map: five worlds of 10000 × 10000 px (ids 1 to 5) plus the newbie coast (id 100, 2000 × 1800 px). Each player owns one castle on one world; the scene shows the world of the own castle (or the world given by a battle exit). Castles, wild lands (fields, monsters, treasures) and hero armies are streamed per 1000 px chunk: when the camera reveals new chunks the client asks for their armies and their castles and wild lands, and the server keeps pushing changes (140, 4167, 4168) to the players watching those chunks. Other players' entities are drawn only within 660 px of the own army or castle, unless a fog removal is active.

| Id | Name (`MapInfos.MapName`) | Size px | Notes |
|---:|---|---|---|
| 1 | Pasto Livre | 10000 × 10000 | world |
| 2 | Floresta Nublada | 10000 × 10000 | world |
| 3 | Pântano Sem Fim | 10000 × 10000 | world |
| 4 | Deserto da Morte | 10000 × 10000 | world |
| 5 | Terra do Julgamento | 10000 × 10000 | world |
| 100 | Costa do Crepúsculo | 2000 × 1800 | newbie coast; when a `MapInitData` points to 100 the castle world is used instead (`M3/map/outercity/OuterCityController.as:154`) |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `map.outercity.OuterCityController` (`M3/map/outercity/OuterCityController.as:98`) + `OuterCityMap` (`M3/map/outercity/view/OuterCityMap.as`) | map name movie (`MapNameMovie`), loading text "Entrando no Atlas..............." | The scene | `SceneManager.setScene("OUTER_CITY_SCENE", data)` | castles, wild lands, armies, fog, clouds, boss panel, archaeology panel |
| `SmallMapBar` state 6 (`CM/mainBar/SmallMapBar.as:544-660`, case 5) | "Transferir Herói para qualquer lugar", "Atacar outro jogador \nAtalho:X", "Localizar coordenadas do Herói", "Transferir de volta à cidade", "Localizar coordenadas do castelo", "Localizar entrada de coordenadas" | Outer city minimap tools; teleport and attack buttons only at level ≥ 15 | scene enter (`OuterCityController.as:443`) | coordinates input (UI units) |
| `OuterCityBossInfoView` | "Montro Normal: {0}/{1}", "Monstro Elite: {0}/{1}", "Chefão: {0}/{1}" | Map boss panel ([map-boss.md](map-boss.md)) | scene enter (`:456-457`) | kill counters, boss list |
| `OuterCityArchaeologyView` | archaeology panel | Only when `mapId < 100` and level ≥ 15 (`:458-462`); owned by [../archaeology/README.md](../archaeology/README.md) | scene enter | |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| W1 | Main tool bar "Arredores" button; key Q from castle or hub (confirm "Entrar no cenário dos Arredores"); guide jumps (`SwitchPageHelp.gotoOuterCity`); battle exit for battleType 1 to 5 and 3841 with `MapInitData` | `MainToolBar.__gotoOuterCityHandler` (`CM/ui/maintoolbar/MainToolBar.as:1372-1383`), `KeyBoardRegister.__showOuterCityResponse` (`CM/yishi/keyboard/KeyBoardRegister.as:733-750`), `SwitchPageHelp.gotoOuterCity` (`CM/yishi/SwitchPageHelp.as:721-744`) → `SceneManager.setScene("OUTER_CITY_SCENE")` | `gotoOuterCity`: level ≥ 13 ("Nível baixo, função habilitada no Nv. {0}"), not in bot mode ("Modo Bot em andamento"), not in `CAMPAIGN_MAP_SCENE` ("Saia da tela atual"); key Q only from `CASTLE_SCENE` / `SPACE_SCENE` | C>S 5035 0x13ab `U_PLAYER_CLIENT_STATE` | `LoginStateMsg` (player): `player_id (#1, INT32)` unused, `state (#2, INT32)` = 3 outer city (`CM/yishi/datas/consant/ClientStateType.as:25-44`) | none. The server marks the player as viewing the outer city and removes it from the hub ([../sky-realm/scene.md](../sky-realm/scene.md)) |
| W2 | Camera shows new chunks (scene enter, drag, arrow keys, minimap jumps) | `OuterCityController.moveMapCallBack` → `sendRefreshScreen` (`OuterCityController.as:760-781`) → `OuterCitySocketOutManager.sendCurrentScreen` (`M3/map/outercity/manager/OuterCitySocketOutManager.as:21-28`) | only when the nine-slice set changed (`FloorMapInfo.checkUpdateConfig`, `CM/map/internals/data/FloorMapInfo.as:48-74`) | C>S 5004 0x138c `U_C_USER_DISPLAY` | `OutercityReqMsg` (outercity): `map_id (#1, INT32)` shown world, `position (#2, STRING)` all chunks of the current view, `"cx_cy,cx_cy,..."` | none (no listener for 8). Server stores the view set used for fan-out |
| W3 | same trigger | `OuterCitySocketOutManager.sendGetArmyByGrid` (`OuterCitySocketOutManager.as:30-37`) | same | C>S 5181 0x143d `U_C_ARMY_UPDATE_GRID` | `OutercityReqMsg`: `map_id (#1)`, `files (#3, STRING)` only the newly visible chunks, same format | 169 with the armies standing in those chunks |
| W4 | same trigger | `OuterCitySocketOutManager.sendGetWildLandByGrid` (`OuterCitySocketOutManager.as:39-46`) | same | C>S 8201 0x2009 `C_PHYSICLIST_BYGRID` | `PhysicUpdateReqMsg` (army): `req_grid (#1, STRING)` newly visible chunks, `map_id (#2, INT32)` | 4129 with the castles and wild lands of those chunks |
| W5 | Own castle "Entrar no Castelo" (menu `BTN_ENTER`, city info "Cidade" button), key Q from the outer city (confirm "Entrar no cenário da Cidade") | `MapPhysicsCastle.enterCastle` (`M3/map/outercity/view/mapphysics/MapPhysicsCastle.as:90-93`), `CityInfoFrame.__attackHandler` (`M3/map/outercity/view/frame/CityInfoFrame.as:30-45`) → `setScene("CASTLE_SCENE")` | none | C>S 8747 0x222b `C_ENTER_CASTLE` and 5035 state 0 | `PropertyMsg`: `param7 (#7, BOOL)` = true | none; server removes the player from outer city fan-out |

The other unused senders of `OuterCitySocketOutManager`: `setAddAttackCount` (9506 `C_CASTLE_ATTACK`, `OutercityReqMsg.attack_count (#6)`, `type (#5)`) has no caller.

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 4153 0x1039 `U_C_LOAD_CASTLE` | `BaseCastleMsg` (army), fields below | `LoginInitDataAccept.__loadCastleHandler` (`CM/yishi/lunch/LoginInitDataAccept.as:817-847`) | Login burst | Fills `PlayerModel.mapNodeInfo` (own castle: id, map, cell, state, type, name, grade, VIP view), `defenceLeftTime`; creates the Transmissor pseudo building -11 with `property1 = left_energy` ([../castle/transmitter.md](../castle/transmitter.md)) |
| S>C 169 0x00a9 `U_C_ARMY_UPDATE_GRID` | `ArmyUpdatedGridMsg` (army): `updatedArmy (#1, ArmyMsg, repeated)` | `OuterCityController.__updateScreenArmysHandler` (`OuterCityController.as:1030-1094`) | Reply to W3; may also be pushed when armies enter watched chunks | For each `ArmyMsg`: own army (`player_id == self`) updates `ArmyManager.army`; others create or update a `UserArmy` (`ThaneInfoHelper.readOuterCityArmyInfo`) and lay it on the map |
| S>C 4129 0x1021 `U_C_PHYSIC_LIST_UPDATE` | `PhysicListUpdateMsg` (army): `req_grid (#1, STRING)` echo, `wildLand (#2, WildLandMsg, repeated)`, `baseCastle (#3, BaseCastleMsg, repeated)` | `OuterCityController.__physicListByBridHandler` (`OuterCityController.as:898-916`) | Reply to W4 | Reads every castle (`readBaseCastle`, `:918-956`) and wild land (`readWildLand`, `:958-1028`); a wild land with `state 0` removes an existing one at that position (`CM/map/outercity/OuterCityModel.as:229-253`) |
| S>C 140 0x008c `U_C_MAPDATA_SYNC` | `MapUpdatedMsg` (army): `updated_type (#1, INT32)` 1 wild land, 2 castle, 3 army; `army (#2, ArmyMsg)`, `wild_land (#3, WildLandMsg)`, `base_castle (#4, BaseCastleMsg)` | `SocketManager.mapDataSync` (`CM/yishi/service/managers/SocketManager.as:181-196`) → `UPDATE_WILDLAND` / `UPDATE_CASTLE` (outer city controller `:1112-1125`) / `UPDTAE_ARMY` (`CM/yishi/manager/ArmyManager.as:335-370`, forwards army types 2, 4, 5 to the scene `:1127-1142` and updates hub army states) | Push to watchers of the chunk whenever one entity changes (occupation, battle state, castle move, army state) | Updates or adds the entity |
| S>C 4168 0x1048 `U_C_ARMY_REMOVE` | `ArmyRemoveMsg` (army): `army_id (#1, INT32)` | `OuterCityController.__armyExitOuterCityHandler` (`:863-869`) | An army leaves the world (owner logs out, enters a battle scene elsewhere, moves to another world) | Removes the army view |
| S>C 118 0x0076 `U_C_CASTLE_DEFENSE` | `CastleDefenseRspMsg` (outercity): `pos_x (#1)`, `pos_y (#2)`, `left_time (#3)` seconds | `OuterCityController.__updateStatusHandler` (`:1096-1110`) | Protection of a castle changed ([castle-pvp.md](castle-pvp.md)) | Updates the own `defenceLeftTime` and the castle at that cell |

### `BaseCastleMsg` (army)

| Field | Tag, type | Meaning |
|---|---|---|
| `id` | #1, INT32 | castle site id |
| `map_id` | #2, INT32 | world |
| `pos_x`, `pos_y` | #3, #4, INT32 | cell |
| `template_id` | #5, INT32 | unused by the outer city reader |
| `type` | #6, INT32 | `SonType`: 100 empty site, 201 normal castle, 202 VIP castle |
| `occupy_player_id` | #7, INT32 | owner (0 = empty) |
| `occupy_player_name`, `occupy_league_name` | #8, #9, STRING | owner nickname, guild name |
| `state` | #10, INT32 | 4 = under attack (blocks new attacks, "Alvo está em combate") |
| `defence_lefttime` | #11, INT32 | protection seconds |
| `castle_name` | #12, STRING | label |
| `left_energy` | #13, INT32 | Transmissor energy (only meaningful in 4153) |
| `grade` | #14, INT32 | owner level (attack level gap rule) |
| `is_defenceBuffer` | #15, BOOL | unused by the reader |
| `vip_castleView`, `vip_type` | #16, #17, INT32 | VIP castle skin |

`WildLandMsg` and `ArmyMsg` are detailed in [wild-lands.md](wild-lands.md) and [army-movement.md](army-movement.md).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| SC1 | Entry level 13 (`gotoOuterCity`), tool bar button visible above 12; the minimap world map button ("Mapa do Mundo (Atalho: M)") needs 15. | `SwitchPageHelp.as:724-729`, `CM/ui/maintoolbar/MainToolBar.as:1244`, `SmallMapBar.as:555` |
| SC2 | Shown world: `MapInitData.mapTempInfo.Id` (100 → castle world) or the own castle world (`mapNodeInfo.info.mapId`); camera on `MapInitData.targetPoint` or the own castle. | `OuterCityController.as:146-162` |
| SC3 | Files: `maps/<MapFileId>/<MapFileId>.maps` and `.titles` (`CM/yishi/manager/PathManager.as:208-216`); tiles `mapmaterial/land/<mapId>/tile_<x>_<y>.jpg`, 512 px (see [../../docs/world/README.md](../../docs/world/README.md) §2.1). `raw/maps/1..5` exist; map 100 files and all outer city tiles are missing from `raw/`. | `CM/map/outercity/preload/PreLoadOuterCityData.as:36-60` |
| SC4 | Walkable semantics are inverted in the outer city: a truthy `.titles` cell is an **obstacle**. | `CM/map/outercity/OuterCityModel.as:510-515`, `M3/map/outercity/path/PathMapHitTester.as:19-22` |
| SC5 | Chunk set ("nine slice"): the 1000 px blocks covering the screen plus a margin (`Utils.getNineSliceScaling`, `CM/map/internals/utils/Utils.as:15-44`); chunk id `floor(x/1000)_floor(y/1000)`; 5004 sends all current ids, 5181/8201 only the ids not in the previous set. Entities in chunks that leave the set are dropped client side (`OuterCityModel.as:355-366`). | `OuterCityController.as:760-785`, `Utils.as:82-115` |
| SC6 | Visibility (every 200 ms): another player's castle, wild land or army is drawn only if within 660 px (both axes) of the own army view, or of the own castle when the army is not drawn, or of an offline free-team member's army; all are drawn while `bossInfo.leftFogTime > 0`. Team members' armies are always drawn and punch fog holes. Own entities are always drawn. | `OuterCityController.as:117, 181-437` |
| SC7 | Fog layer `OuterCityDenseFogLayer` (alpha 0.8) with holes at the own castle and team; removed while `leftFogTime > 0` (4938/4939). Clouds not drawn on map 100. | `M3/map/outercity/view/layer/OuterCityDenseFogLayer.as`, `M3/map/outercity/view/OuterCityMap.as:262-272` |
| SC8 | Client state: entering sends 5035 state 3; the outer city never sends 8747. | `CM/yishi/scene/SceneManager.as:160-181`, `ClientStateType.as:25-44` |
| SC9 | Music "outercity"; archaeology only on worlds (< 100) at level ≥ 15. | `OuterCityController.as:448, 458-462` |
| SC10 | Newbie coast: config `GiveCastle_Grade = 11` ("离开新手岛等级", level to leave the newbie island); `RemoveMap_Day = 7` and `RemoveMap_Persent = 80` (inactive castles are moved back to the newbie island after 7 days when a world is 80 % full). Server only. | `raw/xml/tempinfos/ConfigInfos.xml` |

## 6. Templates

| File | Records | Fields |
|---|---|---|
| `raw/xml/tempinfos/MapInfos.xml` | ids 1 to 5, 100 | `MapName`, `Width`, `Height`, `MapFileId`, `BattleGround`, `MusicPath`, `Type` 0 |
| `raw/maps/<id>/<id>.titles`, `.maps` | worlds 1 to 5 | obstacles, floor and decoration |
| `raw/xml/tempinfos/ConfigInfos.xml` | `GiveCastle_Grade`, `RemoveMap_Day`, `RemoveMap_Persent`, `Castle_Building` | newbie coast and castle seeding rules |

## 7. Persistent state

Schema `world_map`.

```sql
CREATE SCHEMA IF NOT EXISTS world_map;

CREATE TABLE world_map.worlds (
    map_id         INTEGER PRIMARY KEY,
    name           TEXT NOT NULL,
    width_px       INTEGER NOT NULL,
    height_px      INTEGER NOT NULL,
    is_newbie      BOOLEAN NOT NULL DEFAULT FALSE,
    is_open        BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE world_map.castle_sites (
    site_id            INTEGER PRIMARY KEY,
    map_id             INTEGER NOT NULL REFERENCES world_map.worlds(map_id),
    cell_x             INTEGER NOT NULL,
    cell_y             INTEGER NOT NULL,
    chunk_id           TEXT GENERATED ALWAYS AS ((cell_x * 20 / 1000)::TEXT || '_' || (cell_y * 20 / 1000)::TEXT) STORED,
    owner_player_id    BIGINT UNIQUE REFERENCES player.players(player_id) ON DELETE SET NULL,
    castle_type        SMALLINT NOT NULL DEFAULT 100 CHECK (castle_type IN (100, 201, 202)),
    castle_name        TEXT NOT NULL DEFAULT '',
    state              SMALLINT NOT NULL DEFAULT 0,
    protected_until    TIMESTAMPTZ,
    vip_castle_view    INTEGER NOT NULL DEFAULT 0,
    occupied_at        TIMESTAMPTZ,
    UNIQUE (map_id, cell_x, cell_y)
);
CREATE INDEX castle_sites_chunk_idx ON world_map.castle_sites (map_id, chunk_id);
```

`castle_sites` is the castle node referenced by [../castle/README.md](../castle/README.md) (4153) and [../castle/transmitter.md](../castle/transmitter.md) (relocation). Sites are pre-seeded per world (layout from the original server is unknown, see §9). Viewer sets (map, chunks) are in memory.

## 8. Backend implementation notes

- `world_map::scene::handle_client_state` (5035, shared dispatcher): on state 3 register the player as an outer city viewer of its castle world; on any other state unregister (and for 0 also notify the hub, see sky-realm).
- `world_map::scene::handle_user_display` (5004): store `{map_id, chunk set}` for the viewer; no reply.
- `world_map::scene::handle_army_grid` (5181): parse `files`, return 169 with every army whose cell falls in those chunks of `map_id` (own army included when inside).
- `world_map::scene::handle_physic_list` (8201): return 4129 with castles (occupied and empty sites) and active wild lands of those chunks; echo `req_grid`.
- Fan-out helper `world_map::scene::push_to_chunk(map_id, chunk_id, packet)`: send to viewers whose chunk set contains the chunk. Used by 140, 4167, 4168, 118.
- Login: `castle::buildings::handle_login_load` builds 4153 from `world_map.castle_sites` (owner row) and the Transmissor energy.
- New players: allocate a free site on map 100 (newbie coast) or directly on a world (assumption: worlds when level ≥ 11, see SC10).

## 9. Open questions and assumptions

- The castle site layout (positions of the type 100 empty sites) of each world is not in the client; it must be generated (assumption: grid with spacing ≥ 12 cells on non obstacle cells).
- 5004's response opcode 8 has no client listener; assumed to be a fire-and-forget subscription.
- 169 and 4129 may contain many entities; chunk them if over 200 entities (assumption).
- `ArmyMsg.type` values 2, 4, 5 are forwarded to the scene by `ArmyManager`; the meaning of each type is unknown ([../army/README.md](../army/README.md)).
- Outer city tiles (`mapmaterial/land/1..5`) and map 100 files are missing from `raw/`; fetching them needs approval.

## 10. Implementation checklist

- [ ] Screen: outer city loads worlds 1 to 5 (`.maps`, `.titles`, tiles)
- [ ] Route W1 5035 state 3 viewer registration
- [ ] Route W2 5004 `world_map::scene::handle_user_display`
- [ ] Route W3 5181 → 169
- [ ] Route W4 8201 → 4129
- [ ] Route W5 8747 / 5035 state 0 unregistration
- [ ] Server message 4153 at login from `castle_sites`
- [ ] Server message 140 types 1, 2, 3 fan-out
- [ ] Server message 4168 army removal
- [ ] Server message 118 protection change
- [ ] Tables `world_map.worlds`, `world_map.castle_sites`
- [ ] Site seeding per world
- [ ] Test: scrolling the map requests only new chunks and receives their entities
- [ ] Test: two players on the same world see each other within 660 px
