# Sky realm: scene lifecycle

Area: sky-realm, module `scene`. Covers entering and leaving the "Reino do Céu" hub (`SPACE_SCENE`, map 10000), the scene creation messages, the return from activities, the map files and templates the client loads, the overview map frame ("Mapa", key M), the minimap buttons and the client side robots.

Conventions:

- `CM` = `decompiled/core_module/scripts`, `M3` = `decompiled/m3/scripts`. Citations are `path.as:line`.
- C>S = client to server (`send` rows of `protocol/opcodes.csv`), S>C = server to client (`accept` rows).
- `PropertyMsg` is always the AS3 class `CM/com/road/yishi/proto/simple/PropertyMsg.as` (not the stargazing `PropertyMsg` of `protocol/proto.json`). Fields: `param1 (#1, INT32)`, `param2 (#2, INT32)`, `param3 (#3, INT32)`, `param4 (#4, STRING)`, `param5 (#5, STRING)`, `param6 (#6, STRING)`, `param7 (#7, BOOL)`, `param8 (#8, BOOL)`, `param9 (#9, BOOL)`, `param10 (#10, INT32)`, `param11 (#11, INT32)`, `param12 (#12, STRING)` (`PropertyMsg.as:300-361`).
- Coordinates: server positions are 20 px cells; `cur_pos_x/y` in `RoomPlayerMsg` are cells; draw position = cell × 20.

## 1. Overview

The Reino do Céu is the social hub unlocked at hero level 16. It is a single shared map (id 10000, `MapInfos` Type 5, 9000 × 6000 px, MapFileId 10000) where every online player of the server walks, sees the others, talks to 36 NPCs and opens most activities. The client never decides when the scene exists: the server creates it with **4595** (login or first entry) or **4606** (return), and the client switches scene when those arrive.

The scene is a pure presence room: no rewards, no costs. All persistent effects come from the modules that the NPCs open ([npc-catalog.md](npc-catalog.md)).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `map.space.SpaceSceneController` (`M3/map/space/SpaceSceneController.as:81`) + `SpaceSceneMapView` (`M3/map/space/view/SpaceSceneMapView.as`) | "Reino dos Céus" (`mainBar.SmallMapBar.spaceTitle`) | The hub scene: background tiles, nodes, NPCs, players, robots | `SceneManager.setScene("SPACE_SCENE")` from 4595 / 4606 handlers (`CM/yishi/manager/BaseManager.as:1366, 1399`) | Map 10000, 58 template nodes, players from 4592/4597 |
| `map.space.SpaceMapFrame` (`M3/map/space/view/frame/SpaceMapFrame.as:133`), controller `space` openType 1 (`CM/mvc/controler/SpaceController.as:41-42`) | tabs "NPC/Func.", "Trans.", "NPC/Miss." (`map.space.SpaceMapFrame.OptionBtnTxt1..3`) | Overview map; click to walk, list of NPC and portal buttons, team member markers | Key M (`CM/yishi/keyboard/KeyBoardRegister.as:113, 470-517`, level ≥ 16, only in `SPACE_SCENE`), task trace `SpaceMapButtonView` (`CM/ui/tasktracebar/view/SpaceMapButtonView.as:53`), treasure map and marriage task frames (openType 1) | Nodes with MasterType 61 and 171 (`_showTypes`, `SpaceMapFrame.as:131`) sorted by `Sort`; own path; team positions |
| `SmallMapBar` state 1 (`CM/mainBar/SmallMapBar.as:544-660`) | "Ir ao Castelo", "Mostrar Jogadores" / "Ocultar Jogadores" | Minimap buttons while in the hub | Scene `enter` calls `switchSmallMapState(1)` (`SpaceSceneController.as:205`) | Castle button (level ≥ 11), show/hide others toggle |
| `LoadingSceneView` | none | Loading screen while map files load | `SpaceSceneController.preLoadingStart` (`SpaceSceneController.as:131-165`) | none |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Expected server response |
|---|---|---|---|---|---|---|
| S1 | Minimap "Ir ao Reino dos Ceús" button, key-less; also `goSpaceAndFind` (castle buildings, task jumps), return from activity frames (`enterToSpace` callers: SkyboxRoadManager, IncreasinglyRoadManager, DarkMazeManager, GameBoxManager, MainToolBar back button) | `SmallMapBar.__spaceClickHandler` (`CM/mainBar/SmallMapBar.as:854-857`) → `SwitchPageHelp.enterToSpace` (`CM/yishi/SwitchPageHelp.as:1950-1953`) → `SpaceSocketOutManager.enterSpace` (`CM/map/space/manager/SpaceSocketOutManager.as:48-54`) | button enabled at level ≥ 16 (`SmallMapBar.as:553`); disabled during bot mode (mopup) and inside campaigns (`SmallMapBar.as:584-605, 644-647`); `goSpaceAndFind` refuses in `OUTER_CITY_SCENE` ("Você não está nesse mapa, não é possível transferência direta", `SwitchPageHelp.as:1981-1999`) | C>S 8688 0x21f0 `C_PLAYER_SPACE_ENTER` | `PropertyMsg`: `param1 (#1, INT32)` = map id, always 10000 (default argument) | 4606 (preferred, see Rules R3) or 4595; then 4597 (players already in the hub) |
| S2 | Any switch to `SPACE_SCENE` | `SceneManager.setScene` (`CM/yishi/scene/SceneManager.as:169-181`) → `SocketSendManager.enterCastle(false)` (`CM/yishi/service/managers/SocketSendManager.as:529-535`) | none | C>S 8747 0x222b `C_ENTER_CASTLE` | `PropertyMsg`: `param7 (#7, BOOL)` = false (true means castle or farm) | none (state notification). 5035 `U_PLAYER_CLIENT_STATE` is **not** sent for `SPACE_SCENE` (`CM/yishi/datas/consant/ClientStateType.as:25-44`) |
| S3 | Leave the hub | `SpaceSocketOutManager.leaveSpace` (`SpaceSocketOutManager.as:56-62`) | **no caller** in the client | C>S 8689 0x21f1 `C_PLAYER_SPACE_LEAVE` | `PropertyMsg`: `param1` = 0 | Assumption: treat as presence removal (push 4593 to others). The real leave signal is the scene change: 8747 with `param7 = true` (castle), 5035 with any state (campaign, room, outer city, battle) or 125/12 created by the server |
| S4 | Map frame click on empty ground | `SpaceMapFrame.__mapClickHandler` (`SpaceMapFrame.as:304-329`): local x, y × 16.6, clamped to map → `SpaceSceneController.moveArmyByPos(x, y, true)` | see [movement.md](movement.md) | 8690 (movement module) | see movement.md | none |
| S5 | Map frame NPC or portal button | `SpaceMapFrame.__nodeClickHandler` (`SpaceMapFrame.as:960-965`) → `SpaceManager.visitSpaceNPC(nodeId)` (`CM/map/space/SpaceManager.as:72-81`) | none | walk then 8692 ([npc-interaction.md](npc-interaction.md)) | | |
| S6 | "Mostrar Jogadores" / "Ocultar Jogadores" | `SmallMapBar.__othersShowHander` / `__othersHideHander` (`SmallMapBar.as:781-793`) | none | none (local only, saved in `SharedManager.hideOthers`) | | none |
| S7 | Castle button / key Q | `SmallMapBar.__castleClickHandler` (`SmallMapBar.as:859-862`), Q → `KeyBoardRegister.showOuterCity` (`KeyBoardRegister.as:713-721`) | Castle at level ≥ 11 | 8747 `param7 = true` + 5035 state 0 (castle) or 5035 state 3 (outer city) | | Server removes the player from the hub (push 4593 to others) |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 4595 0x11f3 `U_C_PLAYER_SPACE_CREATE` | `RoomEnterMsg` (room): `result (#1, INT32)` (unused by the client), `player (#2, RoomPlayerMsg, repeated)`; only `player[0]` is read and it must be the receiver | `BaseManager.__createSpaceHandler` (`CM/yishi/manager/BaseManager.as:1345-1372`), registered at :323 | At login inside the login burst (after `6 U_C_PLAYER_LOGINSTATEE`), and in reply to 8688 for the first entry of the session | Forces `campaign_id = 10000`; ignores the packet if `player_id != own userId`; `SpaceManager.setup(10000)`; sets `spaceMapId`; loads nodes from `SpaceTemplateManager`; buffers the packet for the scene (`SocketDataProxyManager.addCreateSceneQueue`); `readMember(player[0])`; switches to `SPACE_SCENE` only if `SwitchPageHelp.isEnterSpaceNow()` is true (`SwitchPageHelp.as:2001-2037`) |
| S>C 4606 0x11fe `U_C_PLAYER_RETURN_TO_SPACE` | `RoomEnterMsg`, same shape | `BaseManager.__returnSpaceHandler` (`BaseManager.as:1374-1402`), registered at :324 | Reply to 8688 when the client is in the castle or any non-hub scene; also pushed by activities that end in the hub | Ignored if `player[0].player_id` is not self; sets up the model if missing (same steps as 4595); `readMember`; switches to `SPACE_SCENE` unless the current scene is `BATTLE_SCENE` with battleType 16 |
| S>C 4597 0x11f5 `U_C_PLAYER_SPACE_SEND_EXSIT` | `RoomEnterMsg`: every other player currently in the hub | `SpaceManager.__initPlayerListHandler` (`CM/map/space/SpaceManager.as:128-138`), listening once `SpaceManager.setup` ran (`:114-119`) | Right after 4595/4606, the full list (may be chunked) | `readMember` for each; views are created by the walk layer queue ([players.md](players.md)) |
| S>C 4126 0x101e `U_C_SEND_STANDPOS` | `StandPosMsg` | [movement.md](movement.md) | Position correction | see movement.md |

`RoomPlayerMsg` fields used by `readMember` are listed in [players.md](players.md) §4.

Packet buffering: 4595 resets the scene buffer (`CM/proxy/SocketDataProxyManager.as:57-107`); `SpaceSocketDataProxy` keeps 4592, 4593, 4594, 149 and 4601 that arrive before the scene module is loaded and replays them when the scene enters (`CM/proxy/scene/SpaceSocketDataProxy.as:16-20`, `CM/map/space/manager/SpaceSocketManager.as:53-84`). The server may therefore send the player list and moves immediately after 4595.

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| R1 | Hub level gate: 16 (button, key M, `returnScene`). Players below 16 return to the castle after any activity. | `SmallMapBar.as:553`, `KeyBoardRegister.as:492`, `SwitchPageHelp.as:1955-1970` |
| R2 | `returnScene` = `CASTLE_SCENE` if `spaceMapId == 0`, or `inCastle`, or level < 16; else `SPACE_SCENE`. `spaceMapId` is set only by 4595/4606, so a player who never received them always returns to the castle. | `SwitchPageHelp.as:1955-1970` |
| R3 | `isEnterSpaceNow()` is false while `inCastle` is true (set by `setScene("CASTLE_SCENE")`, `SceneManager.as:169-173`), in a room campaign, during login-to-battle, sandbox, Salão do Jogo or Guerra Secreta. Consequence: a 4595 received while in the castle does not switch scene. The server must answer 8688 with **4606** whenever the player is not already in the hub (4606 switches unconditionally) and use 4595 only in the login burst. Assumption derived from the two handlers. | `SwitchPageHelp.as:2001-2037`, `BaseManager.as:1364-1368, 1396-1400` |
| R4 | Login placement: with `newbieProcess ≥ 19000`, level > 16 and `newbieProcess ≥ 36000` the client does not force the castle, so the login 4595 opens the hub directly; level ≤ 16 goes to the castle. | `BaseManager.as:1940-1960` |
| R5 | Spawn: `RoomPlayerMsg.cur_pos_x/y` (cells). If the start cell is not walkable and no walkable neighbor exists within 9 rings, the client snaps the hero to the MasterType 40 node (node 14, cell (175,98)). `MapNodeInfos.BornPoints` is not read. The server should use the last stored hub position, else a random walkable cell around (175,98). | `SpaceSceneController.as:754-765`, `SpaceModel.as:229-244` |
| R6 | Map 10000 data: `maps/10000/10000.maps` (floor, movies, tops), `maps/10000/10000.titles` (walkable cells), thumbnail `mapmaterial/land/10000/small.jpg`, 300 px tiles `mapmaterial/land/10000/tile_<x>_<y>.jpg`. All exist under `raw/`. | `CM/map/campaign/preload/SpacePreCampaignData.as:31-40`, [../../docs/world/maps.md](../../docs/world/maps.md) |
| R7 | Robots (dead code): `SpaceTemplateManager` builds up to 19 fake players from `{TEMPLATE_PATH}skycastlerobot_unzip.xml` (HTTP POST) on 19 fixed cells, and `SpaceRobotMediator` would show them when fewer than 10 armies are rendered. The mediator is never registered (the hub mediator list is `SpaceMouseEventMediator, SpaceMapCameraMediator, FreedomTeamListMediator, FreedomTeamFollowMediator, SpaceActivationMovieMediator, SpaceCursorMediator, SpaceUIMediator, LockTargetMediator, SpacePKMediator`), so robots never appear. The XML is not in `raw/`; the client tolerates the ioError. The server never sends robots. | `CM/yishi/manager/SpaceTemplateManager.as:54-131, 151-194`, `M3/map/space/mediator/mapview/SpaceRobotMediator.as:25, 54-71, 145-193`, `M3/map/space/view/SpaceSceneMapView.as:117` |
| R8 | `preSceneData` flags (`isOpenPveRoomList`, `isOpenColosseum`, `isAbysmBattle`, ...) are set by the client when it returns from a battle or room; they reopen the activity frame after entering. Server does not send them. After the flags, a pending `SpaceManager.serchId > 0` starts `walkToCrossMapTarget("10000," + id)`. | `SpaceSceneController.as:237-511` |
| R9 | On `enterOver` the client also calls `__findNodeHandler` so a pending `spaceNodeId` (set by `goSpaceAndFind` / `visitSpaceNPC`) makes the hero walk to that NPC. | `SpaceSceneController.as:520, 612-621` |
| R10 | Music "space"; `SmallMapBar` state 1; `OuterCityServiceManager.setup(userId, key, 10000)` (AMF, unused). | `SpaceSceneController.as:205-207` |
| R11 | Map frame scale: frame px = cell × 1.2 + 1 for nodes; click px = local × 16.6. | `SpaceMapFrame.as:310-311, 947-950` |
| R12 | Nodes 32 (Papai Noel) visible only inside the new year window (`ConfigManager.info.NEW_YEAR_*`); node 35 visible when the Terralém head states are not 3, node 36 when one of them is 3 (`OutyardModel.stateMsg`). Nodes 8, 16, 23, 47, 48, 52, 53 also depend on `VersionSwitch` flags for their name buttons. | `CM/yishi/manager/BaseManager.as:1628-1646`, `M3/map/space/mediator/mapview/SpaceUIMediator.as:87-165` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/MapInfos.xml` | `MapInfo Id=10000` | `Width` 9000, `Height` 6000, `MapFileId`, `MusicPath`, `Type` 5 |
| `raw/xml/tempinfos/MapNodeInfos.xml` | 58 `MapNodeInfo` rows, all `MapId=10000` | see [npc-interaction.md](npc-interaction.md) §6 |
| `{TEMPLATE_PATH}skycastlerobot_unzip.xml` | `Robot` | robot avatars (client only; missing) |

## 7. Persistent state

Schema `sky_realm`.

```sql
CREATE SCHEMA IF NOT EXISTS sky_realm;

CREATE TABLE sky_realm.player_positions (
    player_id      BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    map_id         INTEGER NOT NULL DEFAULT 10000,
    cell_x         INTEGER NOT NULL CHECK (cell_x BETWEEN 0 AND 449),
    cell_y         INTEGER NOT NULL CHECK (cell_y BETWEEN 0 AND 299),
    updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

Live presence (who is in the hub, current path, view list) is runtime state kept in memory by the realm service; only the last position is persisted (written on leave and every N moves). Grid bounds come from 9000/20 × 6000/20.

## 8. Backend implementation notes

- `sky_realm::scene::handle_enter` (8688): validate level ≥ 16 (silently ignore otherwise), validate the player is not in a campaign, room or battle (ignore). Load the last position (or spawn rule R5). Add the player to the in-memory hub room. Send to self: 4606 (or 4595 if this is the login burst) with one `RoomPlayerMsg` for self (fields in [players.md](players.md) §4, `room_id` 10000, `campaign_id` 10000); then 4597 with every other present player (chunk by 50, assumption). Push 4592 with the self `RoomPlayerMsg` to every other present player.
- `sky_realm::scene::handle_enter_castle` (8747): when `param7` is false, mark the client as in the hub scene (no reply); when true, remove the player from the hub (see leave).
- `sky_realm::scene::handle_leave` (8689) and the implicit leave on 8747(true), 5035 (any state), room creation (12), campaign creation (125), disconnect: remove from the room, persist the position, push 4593 `CampaignExitMsg{result 1, player_id, army_id, server_name}` to the others (or batched 4607, see players.md).
- Login: the login flow pushes 4595 for players with level ≥ 16; the hub service must register presence at that moment (the client switches scene by itself).
- No transactions beyond the position upsert. Presence fan-out is per hub instance (one per server); cross-server players are not in the hub.

## 9. Open questions and assumptions

- Assumption: 8688 must be answered with 4606 outside the login burst (R3). The current Rust rule (`server/flows.json`, `on: 8688`) sends 4595, which only works while `inCastle` is false.
- Assumption: 4597 is the "existing players" list; the client handles it identically to 4592.
- 8689 has no caller; leave detection relies on other packets.
- The robot XML is not available and the robot mediator is unregistered; nothing to implement.
- `RoomEnterMsg.result` values are never read in this path.

## 10. Implementation checklist

- [ ] Screen: hub scene loads map 10000 files and tiles from `/cdn`
- [ ] Screen: `SpaceMapFrame` (key M) lists nodes 61/171 and walks on click
- [ ] Route S1 8688 `sky_realm::scene::handle_enter`
- [ ] Route S2 8747 `sky_realm::scene::handle_enter_castle`
- [ ] Route S3 8689 `sky_realm::scene::handle_leave`
- [ ] Server message 4595 in the login burst (level ≥ 16)
- [ ] Server message 4606 as the 8688 reply
- [ ] Server message 4597 initial player list
- [ ] Push 4592 to others on enter, 4593 on leave
- [ ] Rule R5 spawn and last position
- [ ] Table `sky_realm.player_positions`
- [ ] Test: castle → hub → castle → hub keeps working (R3)
- [ ] Test: player below 16 cannot enter
- [ ] Test: two clients see each other after entering in any order
