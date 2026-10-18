# Game world: scenes, linked worlds, campaign and multiplayer (Legend Online BR)

This document describes how the client is organized into **scenes** and **worlds**, how it switches between them and which opcodes drive each transition. It covers the castle, the **Reino do Céu** lobby (`SPACE_SCENE`, map 10000), the **outer city** (worlds 1-5 and the world map), the **campaign** and instances, and **multiplayer rooms** (dungeons). Map geometry and file formats are in [maps.md](maps.md).

**Conventions**

| item | meaning |
|---|---|
| **CM** | `decompiled/core_module/scripts` (module 2.png) |
| **M3, M4, …** | `decompiled/mN/scripts` (module N.png) |
| `file:line` | relative to those roots; a bare `:line` refers to the file last named |
| opcodes | numbers and names from `protocol/opcodes.csv`, with the protobuf message used in the `.as` |
| `PropertyMsg` | always `CM/com/road/yishi/proto/simple/PropertyMsg.as` (fields `param1..param12`); the `PropertyMsg` in `protocol/proto.json` is a different message (stargazing) |
| "send" / "recv" | client → server / server → client |

**Structured data**
- `index/world.json`: scenes, transitions, worlds, links, dungeons, room protocol.
- DB tables `game.scenes`, `scene_transitions`, `worlds`, `world_links`, `campaign_nodes`, `dungeon_types`, `room_protocol` (migration `db/migrations/0013_world.sql`, loader `tools/db/load_world.py`). See §5.

**Related:** [maps.md](maps.md) (geometry, units, formats), [../battle/README.md](../battle/README.md), [../battle/rules.md](../battle/rules.md) §11 (battleType), [../ui/screens.md](../ui/screens.md), [../mechanics/world_progression.md](../mechanics/world_progression.md) (map and campaign templates; research copy in `data/research/world_progression.md`).

**HTML5 rebuild status.** The transpiled client (`http://localhost:5173/?boot=1`) reaches the castle, the Reino do Céu lobby and battles against the Rust server (`server/`). The lobby runs on the 2D map path (`BgLayer`, 300 px tiles from `raw/mapmaterial/land/10000`). Server rules implement the space protocol (8688 → 4595 with spawn cell (175,98), 8690 relay, 8692 node click, 8689 leave), the classic room flow (5026, 5023, 5024, 5034, 5036, 5039, 5025) and battles (`server/flows/battle.json`, `server/src/battle.rs`); see `server/flows.json` and `server/flows/navigation.json`.

---

## 1. Scenes

### 1.1 Scene switching

`SceneManager.setScene(type, data, force, _, loadType)` in `CM/yishi/scene/SceneManager.as:129-191`:

1. **Lock.** Ignored if `lock` is set (:131).
2. **Animation.** `BATTLE_SCENE` uses `EnterBattleSceneSwitchAnimation`; others use `SceneSwitchAninmation` (:193-205).
3. **Client state.** Sends **5035 U_PLAYER_CLIENT_STATE** (`LoginStateMsg.state`) with `ClientStateType.getClientState` (`CM/yishi/datas/consant/ClientStateType.as:25-44`):

   | state | scene |
   |---:|---|
   | 0 | castle |
   | 2 | PvE room |
   | 3 | outer city |
   | 4 | campaign |
   | 5 | battle |
   | 6 | PvP room |

   Other scenes send nothing. Value 1 (room list) is unused.
4. **Same scene with `force = true`.** Goes through `EMPTY_SCENE` and re-enters (`forceSetScene`/`emptyScene`, :207-244). This is how a campaign reloads when crossing a portal.
5. **Castle or space.** Sends **8747 C_ENTER_CASTLE** with `PropertyMsg.param7`: `true` for `CASTLE_SCENE` and `FARM`, `false` for `SPACE_SCENE` (:169-181).
6. **Creation.** Scene is reused from cache or created async by `SceneCreate.createAsync` (:182-190), which:
   - loads the **code module** (`getProjectUrlByState`, `CM/yishi/scene/SceneCreate.as:134-186`) and **UI packages** (`getSceneResources`, :292-527);
   - instantiates the class from `getClassByType` (:41-110) via `applicationDomain`. `PVE_ROOM_SCENE`, `PVP_ROOM_SCENE` and `EMPTY_SCENE` are created directly in core (:121-131).
7. **Lifecycle** (`BaseSceneView`): `preLoadingStart` → `preLoadingBack` → animation → previous scene `leaving()` → `enter(prevScene, data)` → `enterOver()`. Then the client fires `SWITCH_SCENE`.
   - `data` ("preSceneData") is how a battle or room tells the hub which frame to reopen: `isOpenPveRoomList`, `isOpenColosseum`, `isAbysmBattle`, etc. Full list: `M3/map/space/SpaceSceneController.as:237-511` and `M4/castle/CastleSceneView.as:88-388`.

**Return scene.** `SwitchPageHelp.returnScene` (`CM/yishi/SwitchPageHelp.as:1955-1970`) is `CASTLE_SCENE` if any of:
- `spaceMapId == 0`;
- `inCastle` set;
- level < 16.

Otherwise `SPACE_SCENE`. `returnToSpace(data)` (:1972-1979) calls `setScene(returnScene, data)`.

**Packets deferred per scene.** The server may send packets for the next scene before it exists. `SocketDataProxyManager` (`CM/proxy/SocketDataProxyManager.as:57-107`) buffers **125** and **4595** and delivers them once the scene module has loaded.

### 1.2 Scene catalog

- "id": value from `SceneType.getSceneTypeById` (`CM/yishi/scene/SceneType.as:85-133`), used by the tutorial. Unknown id becomes `SPACE_SCENE`.
- "png": code module.
- In the resource column, "?" marks a conditional resource.
- Names are pt-BR game names where applicable.

| SceneType | id | name | class (module) | png | UI resources (SceneCreate.as) | 5035 state |
|---|---:|---|---|---|---|---:|
| `CASTLE_SCENE` | 1 | Castelo (castle) | `castle.CastleSceneView` (M4, :389) | 4 | castlemap1, core, common, castle, queuebar, flytocastle?newbie=19000 (:298-308) | 0 |
| `SPACE_SCENE` | 10 | **Reino do Céu** (hub) | `map.space.SpaceSceneController` (M3, :918) | 3 | queuebar, map, campaign (:433-437) | none |
| `OUTER_CITY_SCENE` | 2 | Outer city (worlds 1-5) | `map.outercity.OuterCityController` (M3, :576) | 3 | map, outercity, maphorse, tips, framebg (:441-447) | 3 |
| `CAMPAIGN_MAP_SCENE` | 3 | Campaign/instance | `map.campaign.CampaignMapController` (M3, :598) | 3 | map + 15 conditional by mapId (:309-386) | 4 |
| `BATTLE_SCENE` | 4 | Battle | `battle.BattleSceneView` (M10, :185) | 10 | qte?!newbie (:387-392) | 5 |
| `PVE_ROOM_SCENE` | 5 | PvE room | `mvc.controler.RoomControl` (CM, :127) | 9 | baseroom, room | 2 |
| `PVP_ROOM_SCENE` | 6 | PvP room | `mvc.controler.PvpRoomControl` (CM, :112) | 9 | baseroom, pvproomlist, roompvp | 6 |
| `FARM` | 7 | Fazenda (**legacy**) | `farm.FarmSceneView` (M3, :49) | 7 | farmmap, farm, water | none |
| `VEHICLE` | 8 | Vehicle race | `com.map.vehicle.VehicleSceneController` (M17, :52) | 17 | map, vehicle, vehicleroomlist, campaign | none |
| `CHANLLENGE_ROOM_SCENE` | 11 | Coliseu | `colosseum.ChallengeSceneControl` (M13, :31) | 13 | colosseum | none |
| `MULTILORDS_ROOM` | 13 | Multi-Senhores room | `mvc.controler.MultilordsRoomController` (CM, :88) | 9 | baseroom, warlordsroom, multilordsroom | none |
| `MATELORDS_ROOM` | none | Mate Lords room | `mvc.controler.MatelordsRoomController` (CM, :93) | 9 | baseroom, warlordsroom, matelordsroom | none |
| `ARESLORDS_ROOM` | none | Ares Lords room | `mvc.controler.AresLordsRoomController` (CM, :93) | 9 | baseroom, warlordsroom, areslordsroom | none |
| `APEX_ROOM` | none | Liga do Pico room | `mvc.controler.ApexRoomController` (CM, :93) | 9 | baseroom, apexroom | none |
| `GLORY_GAME_SCENE` | none | Jogo da Glória | `mvc.controler.GloryGameRoomController` (CM, :93) | 9 | baseroom, glorygameroom | none |
| `UNREAL_SHOOTING_ROOM` | 23 | Caça Fantástica room | `mvc.controler.UnrealShootingRoomController` (CM, :28) | 9 | map, baseroom, warlordsroom, unrealshootingroom, vehicle | none |
| `THESE_Double_PVP_SCENE` | 32 | Arena Multiplayer de Teseu | `theseusDoublepvpscene.TheseusDoublePvpScene` (M3, :125) | 3 | baseroom, roompvp, theseuspvp, christmas, campaign | none |
| `THESE_PVP_SCENE` | 29 | Arena de Teseu 1v1 | `theseuspvpscene.TheseusPvpScene` (M3, :65) | 3 | theseuspvp | none |
| `PLANES_WAR_SCENE` | 20 | Guerra dos Planos | `planeswar.PlanesWarSceneView` (M3, :54) | 3 | map, planes | none |
| `PLANE_CRISRIS` | none | Crise dos Planos | `crisis.PlaneCrisisSecenView` (M3, :54) | 3 | map, planecrisis | none |
| `SANDBOX_SCENE` | 25 | Matança de Madrugada | `sandbox.SandboxSceneController` (M3, :106) | 3 | queuebar, map, campaign, daylight? | none |
| `GAME_HALL_SCENE` | 26 | Salão do Jogo | `gamehall.GameHallSceneController` (M3, :141) | 3 | map, gamehall | none |
| `STARAREA_SCENE` | 27 | Exploração Espaço-Tempo | `stararea.StarareaController` (M3, :42) | 3 | stararea, map | none |
| `SECRET_ADVENTURE_SCENE` | 28 | Expedição do Eremitério | `secretadventure.SecretAdventureScene` (M3, :46) | 3 | map, secretadventure | none |
| `SECRET_WAR_SCENE` | 30 | Guerra Secreta 2023 | `war2023.view.SecretWarSecen` (M3, :47) | 3 | secretwar | none |
| `CHILD_NS_WAR_SCENE` | 31 | Arena do Espírito de Proteção | `childnswar.ChildNswarScene` (M3, :66) | 3 | theseuspvp, childnswar | none |
| `SELF_CHESS_SCENE` | none | Auto-xadrez | `chess.SelfChessSceneController` (M3, :41) | 3 | selfchess | none |
| `CROSS_GUILD_SCENE` | none | Guerra de Guildas Inter-Servidor | `consortia.view.crossguild.CrossGuildWarSceneView` (M6, :44) | 6 | map, crossguild | none |
| `SKYBOX_ROAD_SCENE` | none | Estrada da Caixa Celeste | `skyboxroad.SkyBoxRoadFrame` (M11, :236) | 11 | skyboxroad | none |
| `INCREASINGLY_ROAD_SCENE` | none | Estrada Progressiva | `increasinglyroad.IncreasinglyRoadFrame` (M11, :441) | 11 | increasinglyroad | none |
| `DARK_MAZE_SCENE` | none | Labirinto Negro | `darkmaze.DarkMazeMainFrame` (M11, :390) | 11 | darkmaze | none |
| `FINAL_DEFENSE_SCENE` | none | Defesa Final | `finaldefense.FinalDefenseScene` (M11, :79) | none | finaldefense | none |
| `EMPTY_SCENE` | none | Empty scene (transition) | `yishi.scene.EmptyScene` (CM, :87) | none | none | none |
| `TRAINER_SCENE`, `SINGLE_CAMPAIGN_MAP_SCENE`, `WARLORDS_ROOM`, `VEHICLE_ROOM_SCENE` | none | constants **with no class** (dead code) | none | none | `TRAINER_SCENE`: novice | none |

Notes:
- **FARM is legacy.** No `setScene("FARM")` exists. Current farm/home are `CAMPAIGN_MAP_SCENE` on maps 5501-5505 (`WorldBossHelper.checkInHome/checkFarm`) and 5601-5605 (`checkInHouse`). Entry: **8873 C_HOME_OP** (`ChildrenOpMsg`, opType 1002 = house/farm, 1003 = residence; `CM/home/HomeSender.as:114-130`). `FarmSceneView` lives in M3, although `getProjectUrlByState("FARM")` loads 7.png.
- **Multi-Senhores.** View `multilordsroom.MultilordsRoomView` (`MultilordsRoomController.as:48`) is missing from the decompiled code.

### 1.3 Main scenes

#### CASTLE_SCENE (M4)

**Map.** No `MapInfos`. Background is `castle.InnerCityBg1` (castlemap1); camera bounds = image size ([maps.md](maps.md) §4).

**Layers** (`M4/castle/view/CastleMapViewII.as:60-104`, `CastleSceneView.as:71-81`), bottom to top:
1. `CastleBackgroundLayer`
2. `CastleAnimalLayer`
3. `CastleWalkLayer` (buildings `CastleBuildingView`, NPCs `CastleNPCView`, hero)
4. `CastleAirlayer`
5. `FogBorderLayer` (88 px fog)
6. `CastleNameLayer` (offset −130, −180)

**Buildings.** From `BuildingTempInfos`; details in [world_progression.md](../mechanics/world_progression.md), section "Castle buildings (BuildingTempInfos)". Click level requirements (`M4/castle/view/CastleBuildingView.as:276-402`):

| SonType | building | level | action |
|---|---|---|---|
| 1501 | | 7 | forge |
| 1503 | | 16 | `goSpaceAndFind(6)` → NPC Glorya |
| 1502 | | 20 | `goSpaceAndFind(2)` → **Tina, Portal dos Heróis** |
| 1510 | | | `goSpaceAndFind(1)` |
| 1506 | | | `goSpaceAndFind(8)` |
| 1507 | Labirinto | 12 | maze |
| 1505 | | 35 | vehicle |
| 1509 | Residence/farm | 12 | |
| 1511 | Transmissor | 15 | |
| 1801 | Mina | 25 | |
| 1601 | Bar | 32 | |
| 1701 | Laboratório | 1st advancement | |

`goSpaceAndFind` stores `spaceNodeId`, requests space, and on entry walks to the NPC (`SwitchPageHelp.as:1981-1999`, `SpaceSceneController.__findNodeHandler` :612-621).

**Entry.**
- Normal login: `BaseManager.__loginStateHandler`, `CM/yishi/manager/BaseManager.as:1949-1959`.
- Minimap Castle button, level ≥ 11 (`CM/mainBar/SmallMapBar.as:551,859-862`).
- Q key.
- Own castle `BTN_ENTER` in the outer city (`M3/map/outercity/view/mapphysics/MapPhysicsCastle.as:92`).
- `returnScene` with level < 16.

Every entry sends 8747(`true`) and 5035(0).

**Requirements.** Tutorial ends at `newbieProcess == 19000`, which adds the `flytocastle` movie (`SceneCreate.as:304-307`).

#### SPACE_SCENE: Reino do Céu (lobby, M3)

**Map.** Always **10000**: `MapInfos.Type` 5, 9000×6000 px, MapFileId 10000. `BaseManager` forces `RoomPlayerMsg.campaignId = 10000` (`BaseManager.as:1351`).

**Layers** (`M3/map/space/view/SpaceSceneMapView.as:138-164`), bottom to top:
1. `BgLayer`, 300 px tiles from `mapmaterial/land/10000`
2. `_footLayer` (footprints)
3. `SpaceBuildingLayer` (nodes with `Resource=2`: `mapmaterial/build/<SonType>.swf`)
4. `SpaceWalkLayer` (players; contains `SpaceNpcLayer` and `SpaceApexLayer`)
5. `_topLayer`
6. `MapNameLayer` (Stage3D)

Pathfinding: `FindPath8` over `.titles`, ground and "fly" variants (`SpaceSceneController.as:193-198`).

**Entities.** The 58 nodes of `MapNodeInfos` (table `game.map_nodes`, `CM/map/space/SpaceManager.as:344-398`):
- **36 dialog NPCs** (type 61). Dialog options follow enum `space_npc_option_type` (`M3/map/space/view/frame/DialogOptionItem.as:349-900`). World-relevant NPCs:
  - node 2 **Tina, Portal dos Heróis** (option 2 → PvE room list, level 20);
  - node 6 Glorya (Coliseu/Caminho da Glória);
  - node 1 Recompensas;
  - node 20 Caminho do Céu (60);
  - node 23 Labirinto Negro;
  - node 41 Portal do Tempo;
  - node 42 Abismo Sem Fim;
  - node 43 Cavernas do Tempo;
  - node 44 **Salão do Jogo** (option 135);
  - node 49 Zona Proibida;
  - node 54 Domínio da Arena.
- **1 portal**: node 5, "Ilha dos Einherjars, Transmissor", type 171, `MoveToMapId` 20001, node 2000101, level 50.
- **1 spawn**: node 14, type 40, cell (175,98).
- **20 Pilhas de Presentes** (type 300).
- **Terralém entrances**: nodes 35 and 36, lead to the yard (`TopToolsBar.enterOutyardScene`, :680-683).
- **Wedding cart**: node 21.

Also shown: other players (`RoomPlayerMsg`) and 19 bots (`CM/yishi/manager/SpaceTemplateManager.as:56-74`).

**Entry.** `SwitchPageHelp.enterToSpace` (`SwitchPageHelp.as:1950-1953`) sends **8688 C_PLAYER_SPACE_ENTER** (`PropertyMsg.param1 = 10000`, `CM/map/space/manager/SpaceSocketOutManager.as:48-54`). Server replies **4595 U_C_PLAYER_SPACE_CREATE** (`RoomEnterMsg{result, []player:RoomPlayerMsg}`); `BaseManager.__createSpaceHandler` (:1345-1372) then:
1. `SpaceManager.setup(10000)`;
2. loads nodes from `SpaceTemplateManager`;
3. reads the player;
4. `setScene("SPACE_SCENE", {isShowLoading:false}, force)` if `isEnterSpaceNow()` (`SwitchPageHelp.as:2001-2037`).

Returning from an activity: **4606 U_C_PLAYER_RETURN_TO_SPACE** (:1374-1402).

**Requirements.** Button at level ≥ 16 (`SmallMapBar.as:553`). Not in a campaign room, login battle, or castle, and not logged into sandbox, Salão do Jogo or Guerra Secreta.

**In-scene protocol:**

| opcode | name | dir | message / purpose |
|---:|---|---|---|
| 8690 | C_PLAYER_SPACE_MOVE | send | `SpacePlayerMoveMsg{players[SpacePlayerMsg{playerId, path[PosMsg]}]}` |
| 8692 | C_PLAYER_SPACE_NODE_TRIGGER | send | `param1` = node |
| 8700 | | send | position reset |
| 8701 | | send | army info |
| 9547 | C_SPACEMAP_ATTACK | send | PK, `HangupAttackMsg` |
| 8689 | C_PLAYER_SPACE_LEAVE | send | defined, no callers |
| 4592 | | recv | enter (`RoomEnterMsg`) |
| 4593 | | recv | leave (`CampaignExitMsg`) |
| 4594 | | recv | position sync |
| 4601 | | recv | event |
| 4597 | | recv | player list |
| 4607 | | recv | removal |
| 4126 | | recv | `StandPosMsg` |

Sources: `CM/map/space/manager/SpaceSocketManager.as:86-106`, `SpaceManager.as:114-125`.

**Exit.** Dialogs (open frames or rooms), portal, Castle button, outer city (Q), campaign creation (125) or room creation (12).

#### OUTER_CITY_SCENE (M3)

Details in §2.1.
- **Entry:** level ≥ 13 (`SwitchPageHelp.gotoOuterCity`, :721-744).
- **No enter/leave opcode.** 5035(3) signals the scene; **5004 U_C_USER_DISPLAY / 5181 / 8201** request visible chunks.
- **Exit:** castle `BTN_ENTER`, Q key, or minimap buttons.

#### CAMPAIGN_MAP_SCENE (M3)

See §3. Summary:
- **Entry:** **125 U_C_CAMPAIGN_CREATE**, `RoomCreatedMsg{created_type, room:RoomMsg, is_cross, campignId}` (`BaseManager.__createCampaignHandler`, :2530-2619). `created_type` (`CM/map/internals/constant/CreateCampaignType.as:6-14`):

  | value | meaning |
  |---:|---|
  | 1 | create |
  | 2 | enter |
  | 3 | transfer (portal, no loading screen) |
  | 4 | invite |
  | −1 | already in game |

- **Exit:** **22 U_C_CAMPAIGN_EXIT** → `exitBack` → `returnToSpace` or Salão do Jogo (`M3/map/campaign/CampaignSocketManger.as:1937-2044`).

**Layers** (`M3/map/campaign/view/CampaignMapView.as:440-510`), bottom to top:
1. Background, one of:
   - `BgLayer` (300 px tiles): mazes, fixed list at :447, Zona Proibida/Teseu;
   - `MapRenderLayer` (single bitmap): maps up to 5000 px;
   - `OuterCityStaticLayer` (1000 px blocks): larger maps.
2. `_footLayer`
3. `_farmLayer`
4. `CampaignMainBuidingLayer` (static nodes)
5. `CampaignWalkLayer`, containing `NpcLayer`
6. `_skillLayer`
7. `_effectLayer`
8. `_topUILayer`
9. `FogView` (hex fog on `checkFogMap` maps)

Solo trail campaign (`checkPve`: Types 0, Capacity 1, DungeonId ≠ 0) replaces all of this with `SingleCampaignMapView`. Formação Mágica (9997) uses `FantasyMatrixMapView` (`CampaignMapController.as:239-289`).

#### BATTLE_SCENE (M10)

**Entry.** **157 U_B_PREPARE** → `CreateGameTransaction` → `EnterBattleController.switchToBattle` → `setScene("BATTLE_SCENE", {isShowLoading:false})` (`CM/battle/control/EnterBattleController.as:221-240`). Details in [../battle/README.md](../battle/README.md).

**Exit.** `BattleResultHandler.exitBattle` (`CM/battle/handler/BattleResultHandler.as:93-551`) uses `BattleManager.preScene`, set by whoever started the battle:
- `CampaignManager.setup` sets `CAMPAIGN_MAP_SCENE` (`CM/map/campaign/CampaignManager.as:204`);
- `RoomManager.setup` sets it per room type;
- `challengeSelf` sets `SPACE_SCENE` or `CASTLE_SCENE` (`SwitchPageHelp.as:696-719`).

Then `battleType` picks the destination:

| battleType | destination |
|---|---|
| 1-5, 3841 | `OUTER_CITY_SCENE`, with castle `MapInitData` |
| 16 | colosseum |
| 293 | `SKYBOX_ROAD_SCENE` |
| 3893 | `INCREASINGLY_ROAD_SCENE` |
| 3898 | `DARK_MAZE_SCENE` |
| 3876 | `SANDBOX_SCENE` |
| 3877 | `PLANE_CRISRIS` |
| 3843 | `PLANES_WAR_SCENE` or castle |
| 296 | `CROSS_GUILD_SCENE` |
| 3892 | `STARAREA_SCENE` |
| 349 | `SELF_CHESS_SCENE` |
| 3904 | `SECRET_ADVENTURE_SCENE` |
| 3907 | `THESE_PVP_SCENE` |
| 3912 | `THESE_Double_PVP_SCENE` |
| 3908 | `SECRET_WAR_SCENE` |
| 17/19/20/22/23/306/307 | `CAMPAIGN_MAP_SCENE` |

Other types set a flag in preSceneData (:356-526).

**Fall-through bugs:**
- `case 291` falls into `CAMPAIGN_MAP_SCENE` (:193-209);
- `case 3911` (`CHILD_NS_WAR_SCENE`) falls into `SPACE_SCENE` (:323-327).

#### Room scenes

`RoomControl`, `PvpRoomControl`, `*LordsRoomController`, `ApexRoomController`, `GloryGameRoomController` and `TheseusDoublePvpScene` share one pattern:
- **Entry:** **12 U_C_CAMPAIGN_ROOM_CREATE** (`RoomMsg`) → `BaseManager.__createRoomHandler` (:2636-2690), scene chosen by `room_type`. See §4.
- **Exit:** `returnToSpace({isOpenPveRoomList:true})` or `({isOpenPvpRoomList:true})`.

### 1.4 Scene transitions

Main ones below; all 87 are in `game.scene_transitions` / `index/world.json`. "*" = any scene or login.

| scene A → scene B | trigger | opcode | condition |
|---|---|---|---|
| * → CASTLE | normal login: server sends **6 U_C_PLAYER_LOGINSTATEE** (`LoginStateMsg{player_id, state}`) (BaseManager.as:1904-1960) | 6 (recv) | `newbieProcess` ≥ 19000; if level > 16 and `newbieProcess` < 36000, saves 36000 |
| * → CAMPAIGN (tutorial 10002) | newbie login (BaseManager.as:1941-1947) | **5127 U_C_CAMPAIGN_TRAINING** (`NoviceReqMsgMsg.type=1`) → 125 | `newbieProcess` < 19000 |
| * → CAMPAIGN / BATTLE / SANDBOX / GAME_HALL / SECRET_WAR | reconnect inside an activity | 6 (recv) | `state` 4 / 5 / 6 / 7 / 8 |
| CASTLE, OUTER_CITY, CHANLLENGE... → SPACE | Reino do Céu button → `enterToSpace` | **8688** (send) → **4595** (recv) | level ≥ 16 and `isEnterSpaceNow()` |
| * → SPACE | return from activity | **4606** (recv) | scene ≠ SPACE, no type 16 battle |
| SPACE → CASTLE | Castle button | 8747(`true`) + 5035(0) | level ≥ 11 |
| CASTLE / SPACE → OUTER_CITY | Q, bar, guide → `gotoOuterCity` | 5035(3) | level ≥ 13, not in campaign or sweep |
| OUTER_CITY → CASTLE | own castle `BTN_ENTER` / Q | 8747 | |
| OUTER_CITY → OUTER_CITY (other world) | world map → move castle (`WorldMapControler.as:45-80`) | **5176** (send) → **105** (recv) | Transmissor energy ≥ 200 or paid; army idle; not in campaign or room |
| SPACE / CASTLE → CAMPAIGN | portal (8692), campaign select, room start, invite | **125** (recv) | `campaignId` ≠ 3001 and no `loginToBattleFlag` |
| SPACE → VEHICLE | 125 with `campaignId` 3001 (BaseManager.as:2621-2634) | 125 | |
| CAMPAIGN → CAMPAIGN (other map) | portal: reach node with **5125 U_C_CAMPAIGN_ARRIVE** | 5125 → 125 (`created_type=3`) | |
| CAMPAIGN → SPACE / CASTLE / GAME_HALL | Back → 5025 / 5120 → **22** (recv) → `exitBack` | 22 | `returnScene`; Salão do Jogo team |
| CAMPAIGN → PVE_ROOM | room campaign ends (`CM/map/internals/transaction/CampaignOverTransaction.as:40`) | | no Salão do Jogo team |
| SPACE → PVE_ROOM / PVP_ROOM / MULTILORDS / MATELORDS / ARESLORDS / APEX / GLORY_GAME / THESE_Double | create 5023 / enter 5024 → **12** | 12 | `room_type` 0/1/5/8/9/14/15/16 |
| PVE_ROOM → CAMPAIGN | owner starts (**5039**) | 5039 → 125 | campaign chosen |
| PVP_ROOM → BATTLE | `room_state` 2→3 (25) and **157** | 157 | |
| rooms → SPACE | leave (5025) → **15** → `returnToSpace({isOpenPveRoomList})` | 15 | own player |
| * → BATTLE | 157 U_B_PREPARE (EnterBattleController.as:234) | 157 | |
| BATTLE → (preScene / by battleType) | `exitBattle` | | see §1.3 |
| SPACE / CASTLE ↔ CHANLLENGE_ROOM | preSceneData / `QueueBar.as:291`; return per `ChallengeManager.enterScene` (MainToolBar.as:1639-1649) | | |
| SPACE ↔ GAME_HALL | NPC Angelina → `GameHallManager.as:573`; return via `returnToSpace({isOpenGameHall})` | 8646 | |
| SPACE → SKYBOX / INCREASINGLY / DARK_MAZE / FINAL_DEFENSE (return via `enterToSpace`) | managers (SkyboxRoadManager:195, IncreasinglyRoadManager:143, DarkMazeManager:99, GameBoxManager:182) / MainToolBar.as:1650-1684 | 8688 on return | |
| any → same scene | `setScene(..., force=true)` via `EMPTY_SCENE` | | |

**Back button** of the main bar (`CM/ui/maintoolbar/MainToolBar.as:1549-1760`): first closes activity frames, then branches on current scene: FARM, PLANES_WAR, LORDS, CHANLLENGE, SKYBOX, FINAL_DEFENSE, SANDBOX, PLANE_CRISRIS, GAME_HALL, CROSS_GUILD, INCREASINGLY, DARK_MAZE, SELF_CHESS, SECRET_*, THESE_*, CHILD_NS, UNREAL, APEX, STARAREA, GLORY. In a campaign it sends 5025/5120 (special cases for monopoly and market).

**Minimap** (`CM/mainBar/SmallMapBar.as:544-660`):
- buttons: Castle ≥ 11, Reino do Céu ≥ 16, outer city/world map ≥ 15;
- `switchSmallMapState`: 1 space, 2 campaign, 4 castle, 5 farm (transmit/attack at level ≥ 15);
- in a campaign the three navigation buttons are disabled.

---

## 2. Linked worlds

The client "world" has three independent layers, linked by scene switches and the server. There is no generic "teleport to map X" opcode.

```
      Castle ──Q / button──► Outer city (castle's world 1..5) ◄──5176/105──► other world 1..5
         │  ▲                         │
   8688  │  │ button                  │ 8688
         ▼  │                         ▼
   Reino do Céu 10000 ──node 5 (8692 → 125)──► Ilha de Einherjar 20001 → 20002 → 20003 → 20004
         │  NPC/room (12/125)
         ▼
   Instances (CAMPAIGN_MAP_SCENE): floors linked by portals 62/171 (5125 → 125 created_type 3)
```

### 2.1 Outer city: worlds 1-5 and Costa do Crepúsculo

**Worlds** (`MapInfos.Type` 0, `game.maps`):

| id | name | size (px) | MapFileId |
|---:|---|---|---|
| 1 | Pasto Livre | 10000×10000 | 1 |
| 2 | Floresta Nublada | 10000×10000 | 2 |
| 3 | Pântano Sem Fim | 10000×10000 | 3 |
| 4 | Deserto da Morte | 10000×10000 | 4 |
| 5 | Terra do Julgamento | 10000×10000 | 5 |
| 100 | Costa do Crepúsculo (levels 8-10) | 2000×1800 | 100 |

**Which world is shown** (`M3/map/outercity/OuterCityController.as:150-161`):
- with `MapInitData`: `mapTempInfo.Id`; if 100, uses the castle's world;
- without a parameter: `PlayerManager.currentPlayerModel.mapNodeInfo.info.mapId` (the player's castle world). Arrives in `BaseCastleMsg` via **4153 U_C_LOAD_CASTLE** (`CM/yishi/lunch/LoginInitDataAccept.as:101,820-830`), updated by **105**.

**Background tiles.**
- `MapBackgroundView3D`: **512 px** tiles (`CELL_UNIT_WIDTH/HEIGHT = 512`, `M3/map/internals3D/mapbackground/model/MapBackgroundBaseModel3D.as:13-15`).
- URL: `mapmaterial/land/<mapId>/tile_<x>_<y>.jpg`, or `.png.atf` in Stage3D (`MapBackgroundCellInfo3D.as:44-56`). Folder is the scene **mapId**, not `MapFileId` (`MapBackgroundMaxModel3D.as:113-116`).
- Grid: 10000/512 ≈ **20×20** tiles. Only the screen window ± 512 px is loaded.
- Stage3D used if `VersionSwitch.OUTCITY_3D` and Flash ≥ 11.4 (`CM/yishi/scene/SceneCreateSwitch.as:40-75`). Map 100 (< 5000 px) uses single-bitmap `MapRenderLayer` (`M3/map/outercity/view/OuterCityMap.as:123-133,171-222`).
- Data from `maps/<MapFileId>/<id>.maps|.titles` (`CM/yishi/manager/PathManager.as:208-215`). In worlds 1-5, `.titles` has **obstacle semantics** ([maps.md](maps.md) §4).

**Layers** (`OuterCityMap.as:134-155`), bottom to top:
1. background
2. `OuterCityMainBuidingLayer` (castles, lands 20/22, movies 201)
3. `OuterCityNpcLayer` (lands 21)
4. `WorldWalkLayer` (armies; A* `SceneScene`)
5. `OuterCityBorderLayer` (150 px)
6. `OuterCityDenseFogLayer` (alpha 0.8, holes at castle and team)
7. `OuterCityCloudView` (not on map 100)
8. chests, boss info, archaeology

**Entities:**
- **Castles `BaseCastle`.** `sonType` 100 = empty, 201 = normal, 202 = VIP. Menu depends on owner (`M3/map/internals/view/displaye/PhysicsMenu.as:289-306`):
  - own castle: enter;
  - empty castle, level ≥ 10: "move castle here";
  - other player's castle: attack, friend, mail (requires level ≥ 8).
- **Wild lands `WildLand`.** 20 = field/mine, 21 = monster, 22 = treasure.
- **Armies `UserArmy`.**
- **Map boss and chests**: 4938-4940, 9525/9526.
- **Archaeology**: 297, only with mapId < 100 and level ≥ 15.
- **Visibility**: others' entities beyond 660 px are hidden (`OuterCityController.as:117,184-404`).

**Coordinates.**
- Server uses **20 px cells**.
- UI shows cell/2.5 (`CM/map/internals/constant/MapGrid.as:17-29`).
- View chunks are **1000 px**, keyed `"floor(x/1000)_floor(y/1000)"` (`CM/map/internals/utils/Utils.as:82-120`; `PosMoveMsg.grid_str`).
- Minimap uses x/16.

**Scene protocol:**

| opcode | name | dir | message / purpose |
|---:|---|---|---|
| 5004 | U_C_USER_DISPLAY | send | `OutercityReqMsg{map_id, position}` |
| 5181 | U_C_ARMY_UPDATE_GRID | send |  |
| 8201 | C_PHYSICLIST_BYGRID | send |  |
| 8254 | C_MOVE_POS | send | `PosMoveMsg{map_id, army_id, routes[px], grid_str}` |
| 5160 | U_C_ARMY_ATTACK | send | `MapPhysicAttackMsg{map_id, pos_x, pos_y}` |
| 5161 | U_C_ARMY_RETURNHOME | send |  |
| 8488 | C_WORLDMAP_PVPFIGHT | send | `ChallengeMsg.tar_userId`, within 50 px |
| 8328 | C_ARMYPOS_REQUEST | send |  |
| 9506 | C_CASTLE_ATTACK | send | number of raids; no caller |
| 169 |  | recv |  |
| 4129 |  | recv | `PhysicListUpdateMsg` |
| 140 | U_C_MAPDATA_SYNC | recv | 1 = land, 2 = castle, 3 = army |
| 4167 |  | recv | movement |
| 4168 |  | recv | removal |
| 4241 |  | recv | position |
| 98 |  | recv | recall |
| 118 |  | recv | defense |

Sources: sends in `M3/map/outercity/manager/OuterCitySocketOutManager.as:21-103`; receives in `OuterCityController.as:820-832`. **5159 / 97 U_C_ARMY_ATTACK_CASTLE** exist only as constants; castle attack uses 5160.

### 2.2 Teleports and transfers

| what | how | opcodes | condition | source |
|---|---|---|---|---|
| **Change world** (1-5) | world map `WorldMapFrame` (buttons map1..map5) → `WorldMapControler.sendMap` → move castle to (0,0) of the new world; reply plays `TransferOuterCityAction` and reloads the scene | **5176 U_C_BUILDING_TRANSCASTLE** `CastleReqMsg{mag_id=mapId, pos_x, pos_y, pay_type 1/2}` → **105** (+4159) | Transmissor energy (building −11) ≥ 200, else paid (`transport_charge_cost`); not in campaign or room; army idle; target ≠ current | `CM/mvc/controler/WorldMapControler.as:45-80`, `M11/worldmap/WorldMapFrame.as:72-201`, `CM/yishi/manager/PlayerManager.as:1850-1872`, `CM/yishi/actions/map/TransferOuterCityAction.as:164-196` |
| Move castle within world | `BTN_PORTAL` on empty castle | 5176 → 105 | level ≥ 10, energy ≥ 100 | `M3/map/outercity/view/mapphysics/MapPhysicsCastle.as:95-158` |
| Teleport hero (fixed point) | minimap "transmit" button → `TransmitHandler` | **8326 C_ARMY_POSATION** `ArmyPositionMsg{pos_x, pos_y, pay_type}` → **4237** / **4263** (fail) | energy ≥ 100 or paid; free spot | `M3/map/outercity/mediator/mapview/TransmitHandler.as:99-288` |
| Reino do Céu ↔ Ilha de Einherjar | node 5 portal (8692) and auto-path `CrossMapSearchActionQueue` | 8692 → 125 | level 50 | `CM/yishi/actions/map/crossmapsearch/CrossMapSearchActionQueue.as:26-116` |
| Portal between instance floors | node 62/171 → 5125 → server recreates campaign | 5125 → 125 (`created_type=3`) | | `M3/map/campaign/helper/hero/CampaignArmyViewHelper.as:121-186` |
| Teleport within map (63/171) | movie `TRANSPORT_START/END` → hero moves to `resetPos*20` | 143 U_C_PLAY_MOVIE | | `M3/yishi/actions/map/CampaignActionsFactory.as:39-44`, `TranseferEndAction.as` |

`C_DRAGON_TRANSFER` 8643, `C_THIRD/FOURTH_TRANSFER` and `U_C_TRANSFER` 4556 are **class change**, not teleport.

**Route embedded in the client** (`CrossMapSearchActionQueue.as:26-59`). `SwitchPageHelp.walkToCrossMapTarget("mapId,nodeId|...")` (:960-1060) walks to each map's node and waits for the scene switch (`CrossMapSearchAction`).

| forward (from → to, node) | back (from → to, node) |
|---|---|
| 10000 → 20001, node 5 | 20004 → 20003, 2000401 |
| 20001 → 20002, 2000102 | 20003 → 20002, 2000301 |
| 20002 → 20003, 2000202 | 20002 → 20001, 2000201 |
| 20003 → 20004, 2000341 | 20001 → 10000, 2000150 |

- Path starts at 10000 when scene is CASTLE, FARM or SPACE. From the castle it enters space first.
- Special case: 10000 → 9995 (Sala de Sacrifício) via node 99 (:1021-1028).
- Refused in the outer city.

**Servers.** Single socket (`CM/yishi/lunch/Yishi.as:354`). No shard list or `serverId` in the client.
- **Cross-server** uses the same socket; player identified by `server_name`/`player_uuid` in `RoomPlayerMsg`, `ArmyMsg`, `PosMoveMsg`.
- Signals: `RoomCreatedMsg.is_cross` and `room.masterServerName` (`BaseManager.as:2552-2568`), plus `CR_*` opcodes (25024-25256).

Worlds 1-5 belong to the same server and are linked only by moving the castle.

### 2.3 DB tables

`game.worlds`: 28 maps:
- 1-5 and 100: outer city worlds;
- 10000: hub;
- 20001-20004: Ilha de Einherjar floors;
- 10002: tutorial;
- 2351-2353 and 7601-7602: floors with portals;
- activity maps.

`game.world_links`: 25 edges:
- space portal;
- 9 from the fixed route;
- 10 castle moves between worlds;
- scene switch;
- 2 `editor_portal` and 2 `editor_exit`, derived from `.maps`.

View `game.v_world_graph` adds map names.

---

## 3. Campaign

### 3.1 CampaignManager and CampaignMapController

**`CampaignManager.setup(mapId)`** (`CM/map/campaign/CampaignManager.as:164-206`):
1. creates `CampaignMapModel` and helper models (world boss, judgment, map PvP, active vehicle, Formação Mágica, mineral, market, prison...);
2. sets `BattleManager.preScene = "CAMPAIGN_MAP_SCENE"`;
3. listens to (:208-214):

| opcode | name | message / effect |
|---:|---|---|
| 21 | U_C_CAMPAIGN_ENTER | `RoomEnterMsg`; players via `readMember`, :539-748 |
| 127 | U_C_CAMPAIGN_NODE | `CampaignNodeListMsg` → `readNodeInfo`, :251-306 |
| 335 | | Bloody |
| 4517 | | player HP |

**`CampaignNodeMsg`** fields: `node_id, camp_data_id, node_name, master_type, son_type, pre_node_ids, next_node_ids, state, pos_x/y, cur_x/y, level, attack_types, name_color, toward, resource, reset_x/y, visitUserIds, fix_x/y, hero_tempId, handler_range, fight_capaity, param1..6, currentCount, army_id`. Mapped to `CampaignNode` + `PhysicInfo`.

**`CampaignMapController`** (`M3/map/campaign/CampaignMapController.as`):
- **Preload (:172-210).** If `CampaignManager.exit`, returns to space. Otherwise:
  - solo trail (`checkPve`): loads nothing;
  - cached bitmap of the same map: reused;
  - else runs **`PreCampaignData`** (`CM/map/campaign/preload/PreCampaignData.as:55-271`): loads `maps/<MapFileId>/<id>.maps` and `.titles`, name image `images/mapName/<MapFileId>.png` (MapFileId > 100000 becomes 100), scenery movies (`PreLoadCampaignStaticMovie`), floor (`PreLoadFloorData`), and the player's avatar.
- **`enter` (:239-289).** Builds `FindPath8(W/20, H/20, titles)` and the matching view. For Types 3/10/11/99 stores `FarmManager.preMapId`.
- **`enterOver` (:434-554).** Shows/hides bars per map type, preloads the next campaign (`PreLoadNextCampaign`). In the tutorial fires `UI_OUT_SCENE`. Starts Molong, Bloody and vehicle managers.
- **`leaving` (:297-411).** Keeps the map bitmap (`MapData`) for returning from battle. If `exit`, discards everything.
- **Network.** `CampaignSocketManger` (M3, :327-412) registers ~80 opcodes. Navigation ones:

  | opcode | purpose |
  |---:|---|
  | 22 | exit |
  | 23 / 4104 / 4185 / 4213 | movement |
  | 128 / 4264 / 4831 | nodes |
  | 130 / 19 | fog |
  | 134 | end |
  | 137 | result |
  | 4126 | position |
  | 4122 | walking NPC |

**Sends** (`M3/map/net/MapSocketOuterManager.as`, `CM/map/campaign/CampaignSocketOutManager.as`):

| opcode | name | message / purpose |
|---:|---|---|
| 5124 | U_C_CAMPAIGN_SYNCPOS | `PosMoveMsg{army_id, map_id, routes px}` |
| **5125** | **U_C_CAMPAIGN_ARRIVE** | `CampaignReqMsg{para_int1 = campDataId, para_bool1}`; interact with node |
| 8255 | | reinforce (`CampaignNodeMsg.campDataId`) when node is in combat (state 4) and Capacity > 1 |
| 5121 | | choose army |
| 5033 | U_C_CAMPAIGN_CONFIRM | dialog answer |
| 5038 | U_C_CAMPAIGN_SYSTEM_ARMY | |
| 5180 | U_C_CAMPAIGN_FINISH | finish |
| 5122 | | card |
| 5129 | | chest |
| 5025 / 5120 | | leave |
| 5039 | U_C_CAMPAIGN_ENTER | start |
| 8666 | C_NEW_SINGLE_CAMPAIGN_FIGHT | fight on solo trail |

**Node interaction** (`M3/map/campaign/helper/hero/CampaignArmyViewHelper.as:46-220`):
1. Hero reaches node within `handler_range` (`getHandlerNode`).
2. Return point `reset_x/y` is computed.
3. Type 92 (chest) is collected locally.
4. Node in combat (state 4):
   - PvP maps, Crepúsculo/Fogo e Gelo, Terra dos Sonhos, Crepúsculo dos Deuses, team pet boss → 5125;
   - team campaign → reinforce 8255.
5. Otherwise `delayCall` sends 5125.

Server replies with one of:
- battle (157);
- dialog (138/126);
- teleport movie (143);
- campaign recreated on the new map (125 `created_type=3`, for portal 62/171).

**Node types** (enum `pos_type`, `CM/map/internals/constant/PosType.as`): 40 start, 41 end/boss, 42 monster/trigger, 53 toll, 61 dialog, 62 portal to another map, 63/171 teleport, 64 AI, 67 moving NPC, 91 gather, 92 chest, 121/131 crossings, 191-197 steel map, 201 movie, 202-206 shooting, 1001/1002 farm campfires.

`CampaignMapModel.getSendNode` treats types 63/41/62/171 as "send nodes" (`CM/map/campaign/data/CampaignMapModel.as:1452-1462`).

### 3.2 Campaign types, progression, requirements

Templates: `Campaigns` (`game.campaigns`, 285 rows) and `MapInfos` (`game.maps`, 1112 maps). Details in [world_progression.md](../mechanics/world_progression.md), section "Campaigns / PvE instances (Campaigns)".

**`Types`** (enum `campaign_type`) selects the target dictionary (`CM/yishi/manager/TempleteManager.as:2580-2600`):

| Types | target |
|---|---|
| 0, 13, 51 | PvE |
| 5, 50, 12 | map PvP |
| 9 | vehicle |
| 26 | Vórtice do Tempo |
| other | activities (`worldBossDic`) |

**BR distribution (`game.campaigns` × `game.maps`):**

| Types | Capacity | LandId | campaigns | maps | level | role |
|---:|---:|---:|---:|---:|---|---|
| 0 | 1 | 1 | 83 | 170 | 11-70 | **solo trail** (campaign select, 1001-1602) |
| 0 | 4 | 0 | 56 | 137 | 20-80 | **team instances** (Portal dos Heróis) |
| 0 | 1 | 0 | 2 | 2 | 1-80 | tutorial 10002 and one other |
| 4 | 1 | 0 | 3 | 160 | 1 | Labirinto (8001-8100, 8101-8130, 8401-8430: one map per floor) |
| 26 | 1 | 1 | 45 | 0 | 1 | Vórtice do Tempo (direct fight, no map) |
| 29 | 1 | 1 | 21 | 530 | 1 | Desafio de Teseu (40101-43000) |
| 51 | 10000 | 0 | 47 | 47 | 241 | Zona Proibida (31001-35020) |
| 1, 6-8, 10, 12, 14, 16-20, 22, 24, 25, 30, 50 | 10000 | 0 | 1-3 each | | 1-80 | open activity maps |
| 9, 13, 23 | 4 | 0 | 1-2 each | | 35-80 | vehicle, Roleta, Fase rápida |

**Hierarchy** (`CampaignTemplateManager.as:47-127`): `LandId` → `DungeonId` (chapter) → `AreaId` (area) → difficulties 1-3.

**Progression** (`checkCanChoose`, :135-160):
- `PreCampaignId` chains campaigns;
- unlocked when the previous one has a rank (**4151 U_C_RANK_LIST**);
- difficulties 2/3 require the previous difficulty (`m9/room/view/pve/RoomRightView.as:1280-1370`).

**Requirements:**
- `MinLevel`;
- `NeedTransfer`, `NeedChangeJob`, `NeedThirdTransfer`, `NeedTransferType=4`;
- `NeedFightPower` (cross-server);
- `EnterNumb`: minimum players;
- energy: 20 per campaign.

Shortcut `SwitchPageHelp.gotoCampaignById` (:1067-1136):
- team campaign: level ≥ 20, goes to NPC 2 (`goSpaceAndFind(2)`);
- solo campaign: `MinLevel`, opens `selectcampaign`;
- Labirinto 2 goes to the castle.

**mapId ranges with special rules** (`CM/yishi/utils/WorldBossHelper.as`):

| mapId | rule |
|---|---|
| 10001/10002 | newbie |
| 10003 | newbie town |
| 10004/10005 | newbie trail |
| 5000-5100 | world boss |
| 8000-8430 | mazes |
| 4202 | Molong |
| 9996 | Bloody |
| 4101 | Templo das Chamas |
| 4701 | Fogo e Gelo |
| 4901 | Crepúsculo |
| 5401 | SvS |
| 5101 | quiz |
| 5201 | monopoly |
| 7701 | Terra dos Sonhos |
| 7501 | guild secret land |
| 4301-4303 | wedding |
| 5501-5505 | farm/home |
| 5601-5605 | house |
| 5701 | steel |
| 5703 | Caça Fantástica |
| 5801 | market |
| 6001-6009 | summer |
| 6011/6021/6031 | prison |
| 7000 | garden |
| 8501 | Crepúsculo dos Deuses |
| 9995 | sacrifice |
| 9997 | Formação Mágica |
| 20001-25000 | pet land |
| 30000/30001 | ore |
| 31001-39999 | Zona Proibida |
| 40101-43000 | Teseu box |
| **2291-2294** | **Grupo FB** |

### 3.3 Tutorial (campaign 10002)

Map 10002, "Monte do Dragão Divino" (campaign 10002, solo, `MapFileId` 10002, not downloaded).

1. **Before login.** With `newbieProcess` < 15000, the startup loader pre-registers map 10002 (`CM/yishi/lunch/StartupResourcesLoader.as:209-228`).
2. **At login.** With `newbieProcess` < 19000, client sends **5127 U_C_CAMPAIGN_TRAINING** (`NoviceReqMsgMsg{type=1}`, `BaseManager.as:1941-1947`). Server creates the campaign (125); scene is `CAMPAIGN_MAP_SCENE`. `SmallMapBar` shows the "skip tutorial" button (`SmallMapBar.as:562`).
3. **During.** Script is XML `raw/ui/zh_cn/decoded/newbie.xml`, 681 nodes `actionType` / `conditions` / `saveId`. Milestones saved via `sendSaveProcess`: 11300, 12500, 14000, 15200..., 19000, ..., 36000, ..., 50000.
   - Action `a5` = `NewbieBaseActionMediator.sendEnterScene(id, param)` (`M8/mediators/NewbieBaseActionMediator.as:117-138`) uses `SceneType.getSceneTypeById`:
     - 1 → castle;
     - 10 → `enterToSpace`;
     - 3 → **5127** with `type=param`.
   - Cases 102/103 of `NewbieSpecialActionMediator.enterSceneCall` (:398-416) reach node 1000211 and leave (5025).
4. **Exit.** At 19000 the castle plays `flytocastle`. Campaign select unlocks only with `newbieProcess` > 23000 (`SwitchPageHelp.gotoSingleCampaign`, :899-904).

Fixed newbie positions: [maps.md](maps.md) §2.

### 3.4 Editor nodes of downloaded maps (cross-check with `web/public/maps`)

The 220 nodes embedded in the `.maps` of 14 maps are in `game.campaign_nodes`. They are the editor layout; in game the server sends the real nodes via 127.

**`BattleType` is 0 and `nextNodeIds` is empty in all of them.** Real progression comes from the server (`pre/next_node_ids` in `CampaignNodeMsg`). Maps are chained by **`moveToNodeIds`** on type 62 portals.

| map | nodes | types | highlights |
|---|---:|---|---|
| 10000 Reino do Céu | 18 | 42×15, 40, 62×2 | spawn 1000001 (3510,1971); "英灵岛" (Ilha de Einherjar) 1000018 at (8590,1930); editor NPCs (Chinese names) |
| 2351 Templo de Tara floor 1 | 3 | 40, 42, 62 | boss 水灵佩顿 with AI `CNRoomBossNodeAi`; portal 235103 → **235201** (floor 2); spawn (85,89)... |
| 2352 Templo de Tara floor 2 | 3 | 62×2, 42 | arrival 235201 (with `startPos`), boss `CNDevourBossNodeAi`, portal 235203 → **235301** |
| 2353 Templo de Tara floor 3 | 5 | 62, 42×3, 41 | boss `CNControlBossNodeAi`, 2 patrols (`patrolmanPoint`), **exit "退出副本"** 235305 |
| 2361 Pântano da Praga | 6 | 40, 42×4, 41 | 3 bosses + patrols; end = boss 艾拉齐娜 |
| 2371 / 2372 Caverna do Ouro Negro (Nomeação/Avançado) | 6 | 40, 42×4, 41 | same layout on both maps |
| 2381 Corrente Mágica Arruinada | 8 | 40, 42×6, 41 | 4 elementals + light/dark; exit 238102 |
| 3002 Artilharia do Ano Novo | 30 | 40×8, 61×22 | 8 start positions (vehicle) |
| 4901 Terra do Crepúsculo (PvP) | 37 | 42×16, 61×13, 40×2, 53/121/131 | 2 sides (`Param1` 1/2); AIs `CNWarNpcAi`, `CNOccupieAi` (5 towers), `CNWarPickResourceAi` (mines), `CNWarTransStopAi` (delivery), `CNWarTollgateAi` (toll) |
| 5301 Domínio do Diabo | 28 | 42×22, 40, 53, 61, 121, 91×2 | gather `CNPickReosurceAi` "巨龙墓园" |
| 7601 / 7602 Altar Divino | 52 / 9 | 62 "传送阵", 0×42 / 42×8, 62 | 8 bosses on floor 2 (`HandlerRange` 9) |
| 9996 Inferno Sangrento | 9 | 40×4, 42×5 | 4 spawns, central boss |

The loader derives `editor_portal` (2351 → 2352 → 2353) and `editor_exit` (2353, 2381) edges of `game.world_links` from these nodes. The 7601/7602 portal has no `moveToNodeIds`, so the floor link is server-side.

---

## 4. Multiplayer: rooms and dungeons

### 4.1 Classes

**Why there are several room scenes.** Every room is a scene created by `BaseManager.__createRoomHandler` (opcode 12) from `RoomMsg.room_type` (enum `room_type`, `CM/yishi/datas/consant/RoomType.as:6-36`).

**Management.**
- **`RoomManager`** (`CM/managers/RoomManager.as`) holds the current room. Single manager; no PvpRoomManager.
- Senders:
  - `RoomListSocketOutManager` (CM): list, create, enter;
  - `RoomSocketOutManager` (CM): slot, kick, leader, match;
  - `RoomSocketOuterManager` (M9): edit, ready, start, invite, password.
- Room lists:
  - `PVERoomListControler`;
  - `PVPRoomListControler`;
  - `TheseusRoomListControler`;
  - `VehicleDaimonTrialController`.
- Views in M9:
  - `room/view/pve`: `RoomView`, `RoomRightView`, `AnteroomView`;
  - `room/view/pvp`;
  - `apex/room`, `matelords/room`, `areslords/room`, `gloryGame`, `unrealshooting/room`, `groupfb`.
- Other systems:
  - **Grupo FB**: `CM/managers/GroupfbManager.as` + `CM/mvc/module/groupfb/GroupfbSender.as`;
  - **Free team**: `CM/managers/FreedomTeamManager.as` (M5 `teammanager` only has formation screens);
  - **SinglePass**: `CM/managers/SinglePassManager.as`, solo, no room;
  - **Teseu**: `CM/managers/TheseusPvpManager.as` (M5 `theseus` is equipment).

### 4.2 Classic room flow: create, enter, ready, start, leave

```
NPC Tina (node 2, option 2) → pveroomlist frame
  5026 U_C_CAMPAIGN_ROOM_LIST RoomReqMsg{room_type, name_key}      → 13 RoomListRspMsg{[]RoomMsg}; 4270 update
  5023 U_C_CAMPAIGN_ROOM_CREATE RoomReqMsg{capacity, room_type, password}   (anti-flood 5 s)
  5024 U_C_CAMPAIGN_ROOM_ENTER  RoomReqMsg{room_id, password, room_type, is_invite, is_get}
  8465 U_C_ROOM_FIND (search by id) → 4370 (asks password if is_set_password)
→ 12 U_C_CAMPAIGN_ROOM_CREATE RoomMsg → RoomManager.setup → setScene(scene by room_type)
  120 members (RoomPlayerListMsg; slot = current_room_index) · 17 slots · 32 room edited · 25 state
  owner: 5034 choose instance RoomReqMsg{room_id, dungeon_id, campaign_id} · 5029 open/close slot
         8344 password (RoomEditMsg) · 5031 kick → 28 · 5030 transfer leadership → 121 · 5028 invite → (16 on invitee)
  members: 5036 U_C_PLAYER_READY_STATE RoomReqMsg{state 1/0, is_get} → 24
  owner: 5039 U_C_CAMPAIGN_ENTER CampaignReqMsg{para_int2=campaignId, para_bool1=isNoGet, isCross}  (anti-flood 3 s)
→ 125 U_C_CAMPAIGN_CREATE RoomCreatedMsg → CAMPAIGN_MAP_SCENE → 21 RoomEnterMsg (members on map) → 127 nodes
  ... 5125 on fights → battles 157 ... 135 cards → 5122 → 26
leave: 5025 U_C_CAMPAIGN_ROOM_EXIT RoomExitMsg{msg} → 15 (room) / 22 (map) → returnToSpace({isOpenPveRoomList:true})
```

References:
- `CM/yishi/manager/RoomListSocketOutManager.as:22-92`;
- `CM/managers/RoomManager.as:106-117,184-590`;
- `M9/room/net/RoomSocketOuterManager.as:28-133`;
- `CM/managers/RoomSocketOutManager.as:19-95`;
- `CM/yishi/manager/BaseManager.as:2248-2490` (invite 16), 2636-2690 (12), 2530-2619 (125);
- `M9/room/view/pve/RoomRightView.as:885-955` (start).

All 51 steps are in `game.room_protocol`.

**Create room per mode:**

| mode | `sendCreateRoom` call |
|---|---|
| PVE | (1, 0, "") |
| PVP | (3, 1, "") |
| vehicle | (4, 2, "") |
| Teseu | (1, 16, "") |

Actual capacity arrives in 12/32.

**Invite (16).**
- `RoomInviteMsg{room_id, player_id, nick_name, name, sign_str (= password), room_type, ..., isCross}`.
- Ignored if level < 20 with `room_type` 0, or if the player is in Grupo FB.
- Accept sends 5024 with `is_invite`; if cross, sends **9557 C_CROSS_INVITE_CHOOSE**.
- Invitable list: 5027 answered by 4161. Chat announcement: 8353 `C_CAPTAIN_SPEAK`.

**Cross-server matchmaking (PvE):**
- `crossPveStartBtn` → 5039 with `isCross`;
- server sends **4994 U_C_MATCH_COMFIRE** (`p1` remaining bosses, `p5` `campaignUid`, `p6` room);
- reply **25157 CR_MULTI_MATCH_CHOOSE**;
- **4995** enables continue/cancel, which sends **25156 CR_MULTICAMPAIGN_MATCH**;
- kick vote: **4984**, answered by **25152**;
- room link in chat: **8780** → **4913** → 5024.

**PvP.** No campaign choice; 5039 is sent with `campaignId` 0. Room state goes to 2 (matching) then 3 (in game) via 25; battle arrives via 157/4103. `WorldBossHelper.checkPvp` always returns `false`.

### 4.3 Limits, states, types

**Room state** (`RoomState.as:8-14`):

| value | meaning |
|---:|---|
| 0 | free |
| 1 | waiting |
| 2 | matching |
| 3 | in game |

**Player state** (`RoomPlayerState.as`):

| value | meaning |
|---:|---|
| 0 | waiting |
| 1 | ready |
| 2 | owner |

`allPlayerReader` (`RoomInfo.as:201-211`): all ≠ 0 except the owner.

**Slot (`placesState`):**

| value | meaning |
|---|---|
| −1 | closed |
| 0 | open/empty |
| other | occupied |

Sources: `M9/room/view/anteroom/RoomPlayerFigure.as:872,926-945`; `SimpleRoomInfo.existEmptyPos` :63-80.

**Password.** Sent in 5023/5024 (`password`), changed by 8344; list shows `RoomMsg.is_set_password`.

**Max players (drawn slots):**

| mode | slots | source |
|---|---:|---|
| PVE | 4 | `AnteroomView.as:88,195-202`; counter `count/capacity` |
| PVP | 4 | hardcoded text "/ 4" |
| vehicle | 4 | |
| Apex | 4 | |
| Glory | 4 | |
| Teseu double | 4 | |
| Mate Lords | 2 | |
| Ares Lords | 1 | |
| Grupo FB | 2 teams × 4 = 8 | |
| free team | 4 | |

- Effective capacity: `RoomMsg.capacity`.
- Template `Campaigns.Capacity`: 1 = solo, 4 = team, 10000 = open map.
- `EnterNumb`: minimum to start.

**Levels** (`CM/yishi/OpenGradesII.as`): MULTI_PLAYER_CAMP 20, PVE 20, PVP_MUTI 22, VEHICLE 35, TEAM 36, MATELORD 36, ARESLORDS 36, RAPID_THROUGH 36, WARLORD 50, MULTILORD 50, SINGLE_PASS 60, APEX 80, CHALLENGE 16.

### 4.4 Dungeon types and multiplayer modes

| mode | room_type / scene | entry (opcodes) | players | rewards |
|---|---|---|---|---|
| **Team instance (Portal dos Heróis)** | 0 / PVE_ROOM → CAMPAIGN_MAP | 5026 → 5023/5024 → 5034 → 5036 → 5039 → 125 | 1-4 (`EnterNumb`) | showcase `Campaigns.Item`; **cards** 135 `CampaignCardsMsg{card_count, pay_card_count, price, dropItems}` → 5122 → 26; chest 5129; `BaseGp`; 20 energy |
| PvP room | 1 / PVP_ROOM → BATTLE | 5026(1) → 5023(3,1) → 5036 → 5039(0) | 4 | report 4103 |
| Vehicle race | 2 / frame → VEHICLE (map 3001) | 5023(4,2), 5024, 8608 quick game | 4 | `Vehicle*Template` |
| Multi-Senhores | 5 / MULTILORDS_ROOM | 8841-8856 only in CSV; 8849 create | ? | none (view missing) |
| Mate Lords | 8 / MATELORDS_ROOM | 8979, 8975 sign-up, 8976 create, 8981, 9611 (`MatelordsManager.as:327-358`) | 2 | `MateLordsListMsg` (points, rounds) |
| Ares Lords | 9 / ARESLORDS_ROOM | 9615 `AresLordsListMsg{op 1-5}` (`AresLordsManager.as:66-138`) | 1 | ranking |
| Liga do Pico (Apex) + team | 14 / APEX_ROOM | 5439 `CommonMsg{param1 1-18}`; team 191 (`ApexManager.as:485-623`) | 4 | `ApexRewardDropTemp` |
| Jogo da Glória | 15 / GLORY_GAME_SCENE | 9694 `PropertyMsg{param1 1-6}`, 9699 bet | 4 | `GloryRewardTemplate` |
| Arena Multiplayer de Teseu | 16 / THESE_Double_PVP | 5026(16) → 5023(1,16) → 5036/5039; 9712/9736 | 4 | `TheseusMultiPvpTempInfo` |
| **Grupo FB** (2-team raid) | 7 / CAMPAIGN_MAP 2291-2294 | all via **8972 C_TEAM_CAMPAIGN_OP** `MarriageOpMsg{op_type 1 create ... 17}`; 4785 list, 4786/4791 room (`TeamRoomMsg{..., infos[TeamPlayerMsg], boss_count}`), 4784 state; on map 4790/4792 | 2-8 (≥ 1 per team) | remaining bosses (`boss_count`) |
| Free team | none | 8738/8734/8736/8739/8740/8741/8737/8807/8808; cross 25135-25140 → 4620-4630 | 4 (level ≥ 36) | none |
| Caça Fantástica | none / UNREAL_SHOOTING_ROOM (map 5703) | 9662 `PropertyMsg{param1 1-6}` → 4828 | ? | `UnrealShootingRewardInfo` |
| Salão do Jogo | GAME_HALL_SCENE | 8646 `GameHallOpMsg{op 1-14}`, 8647-8649 → 4561-4565 | none | `GamehallEastDropTemplate` |
| Open maps (Capacity 10000) | CAMPAIGN_MAP | NPC/activity → 125, no room | unlimited | per activity: world boss, Zona Proibida, map PvP... |
| Solo pass | none | 8753, 8755, 8636, 8637 → 4551-4554 | 1 (level ≥ 60) | `SinglePassArea/BossRewardData` |

**Multiplayer dungeon catalog.** View `game.v_multiplayer_campaigns`: 131 campaigns with Capacity > 1 (requirements, reward showcase, maps/floors).

Special team areas (`AreaId`, `CampaignTemplate.as:131-296`):

| AreaId | area |
|---:|---|
| 400 | Templo de Tara (2351-2353) |
| 401 | Ruínas de Narendra |
| 402 | Corrente Mágica (2381) |
| 403 | Santuário da Arma Divina (5904/5905) |
| 404 | Batalha dos Guardiões (5911-5935, difficulties 1-3) |
| 405 | Prisão do Abismo (6011-6031) |
| 406 | Abismo de Gelo e Fogo (6501) |

**Real drops are server-side.** The client only shows the `Item` showcase and receives cards. Generic drop templates: `CommonDropTempInfo`, `AreaMapDropTemplate`.

---

## 5. Database

Migration `db/migrations/0013_world.sql`, loader `tools/db/load_world.py`. Run the loader after `load_map_files.py`; it reads `index/world.json` and `web/public/maps/*.json`.

| table / view | rows | content |
|---|---:|---|
| `game.scenes` | 37 | SceneType, class, module, png, UI resources, 5035 state, 8747 flag, maps, layers, entities, requirements, enter/exit, hub/room/dead-code flags |
| `game.scene_transitions` | 87 | A → B, trigger, opcode (direction, name, message), condition, source |
| `game.worlds` | 28 | navigable world maps (kind, tile, coordinate unit) |
| `game.world_links` | 25 | portals, fixed route, world change, editor portals/exits |
| `game.campaign_nodes` | 220 | typed editor nodes (type, position, spawn, `moveTo`, patrol, AI, hero/troops, params, raw JSON) |
| `game.dungeon_types` | 15 | multiplayer/dungeon modes |
| `game.room_protocol` | 51 | room protocol steps per phase |
| `game.v_scene_graph`, `v_world_graph`, `v_multiplayer_campaigns` | | views with pt-BR names |

Opcodes are validated against `client.opcodes`; mismatches go to `meta.load_issues`. Currently one: map 9995 is not in `MapInfos`.

Example queries:

```sql
SELECT from_scene, to_scene, trigger_pt, opcode, opcode_name FROM game.v_scene_graph WHERE to_scene = 'SPACE_SCENE';
SELECT * FROM game.v_world_graph WHERE link_kind <> 'server_transfer';
SELECT map_file_id, node_id, item_type_name, name_zh, cell_x, cell_y, move_to_node_ids, ai_class FROM game.campaign_nodes WHERE item_type IN (40,41,62);
SELECT phase, direction, opcode, opcode_name, proto_message FROM game.room_protocol WHERE dungeon_code IS NULL ORDER BY step_order;
SELECT campaign_id, name, capacity, enter_count, min_level, map_ids FROM game.v_multiplayer_campaigns WHERE campaign_type = 0 ORDER BY min_level;
```

## 6. Known gaps

- **Portal destinations.** Server-decided. Client only sends 5125/8692 and receives 125; no local portal → map table besides `MapNodeInfos.MoveToMapId` (node 5 only) and the fixed `CrossMapSearchActionQueue` route.
- **Maps without files.** Missing map files for 10002 (tutorial), 20001-20004 (Ilha de Einherjar), 2291-2294 (Grupo FB) and most instances: only 59 MapFileIds downloaded. Their nodes are therefore not in `game.campaign_nodes`.
- **Incomplete editor nodes.** `BattleType`, `hero`, `pawn*` and `nextNodeIds` are empty in `.maps`. Each node's enemy, progression and battle type only arrive in `CampaignNodeMsg` at runtime; would need traffic capture.
- **Multi-Senhores.** No view in the decompiled code and no sender (opcodes 8841-8856 only in CSV).
- **Constants missing from CSV.** Opcodes 4798, 4799, 4801, 8807, 8808 are missing from `opcodes.csv` but exist in `AcceptProtocolType.as:1286-1290` and `ProtocolType.as:922-924`.
- **Dead code.** Per-world level world map (`WorldMapHelper.chcekMapId`: 11/21/31/41/51), `lookMap`, `_unopenList=[5]` and the AMF methods of `OuterCityServiceManager` have no callers.
- **Rewards.** Only the showcase (`Item`) and card format are known; server drop tables are not in the client.
