# Campaign map session (instance lifecycle)

Module `map-session` of [campaign](README.md). A campaign instance is a server object that owns one map, its nodes, its members and its fog. This module covers creating and entering it, the node list, movement, fog, NPC moves, presence, reconnect and leaving. Node interaction and combat are in [node-combat.md](node-combat.md); the shared routes used by other features are summarized in [generic-routes.md](generic-routes.md).

## 1. Overview

- **Entry.** Any feature that puts the player on a campaign map sends **125 U_C_CAMPAIGN_CREATE** `RoomCreatedMsg`. `BaseManager.__createCampaignHandler` (`CM/yishi/manager/BaseManager.as:2530-2619`) stops the Reino do Céu, builds a `RoomInfo` from `RoomCreatedMsg.room` (reusing the current room if one exists), calls `RoomManager.setup` when there was no room, `CampaignManager.setup(room.campaignId)` (**map id**, see [README.md](README.md) "Shared identifiers"), stores `created_type` and `is_cross`, and switches to `CAMPAIGN_MAP_SCENE`. `room.campaignId == 3001` goes to the vehicle scene instead (artillery feature, :2544-2549).
- **Bootstrap.** `CampaignManager.setup` registers 21 and 127 (`CM/map/campaign/CampaignManager.as:164-214`). The M3 `CampaignSocketManger` registers about 80 opcodes while the scene is alive (`M3/map/campaign/CampaignSocketManger.as:325-415`). Packets that arrive during the loading screen are buffered by `SocketDataProxyManager`/`CampaignSocketDataProxy` and replayed when the scene is ready (`M3/map/campaign/CampaignSocketManger.as:283-315`).
- **Map types.** Solo trail instances skip the map and use [single-campaign.md](single-campaign.md). Walkable instances load `maps/<MapFileId>/<id>.maps|.titles` (`CM/map/campaign/preload/PreCampaignData.as`) and render the node list from 127.
- **Leaving.** The back button sends **5025** with `RoomExitMsg{msg ""}`; the server replies **22** `CampaignExitMsg{result > 0, player_id, army_id}`. The self 22 disposes the room and returns to Reino do Céu (or the Salão do Jogo team). A completed instance ends with **134** (`CampaignOverTransaction`), see [node-combat.md](node-combat.md).

Typical sequence for a walkable instance:

```
C>S 5039 (start) | 5125 portal | NPC/activity trigger
S>C 125 RoomCreatedMsg{created_type, room{room_id, campaignId=mapId, master_id, capacity, room_type}, is_cross}
S>C 21  RoomEnterMsg{result 1, player[RoomPlayerMsg...]}        (members with positions)
S>C 127 CampaignNodeListMsg{node[...]}                          (all nodes)
S>C 130 CampaignFogMsg{row, col, forArray, map_tempId}          (fog maps only)
S>C 4282 / 4199 / mode specific pushes
C>S 5038 CampaignReqMsg{para_int1 = mapId}  -> S>C 20 SystemArmyMsg (preload of enemy art)
... movement 5124 -> 4185/4213, node pushes 128/4264/4831, 5125 interactions ...
C>S 5025 RoomExitMsg{msg ""} -> S>C 22 CampaignExitMsg -> returnToSpace
```

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `CampaignMapController` + `CampaignMapView` (`M3/map/campaign/CampaignMapController.as`, `M3/map/campaign/view/CampaignMapView.as`) | map name image `images/mapName/<MapFileId>.png` | Walkable instance | 125 | layers: background, foot, farm, static nodes, walk layer with NPCs, skills, effects, top UI, fog (`docs/world/README.md` CAMPAIGN_MAP_SCENE) |
| `SingleCampaignMapView` | none | Solo trail | 125 with a solo template | [single-campaign.md](single-campaign.md) |
| `FantasyMatrixMapView` | "Formação Mágica" | map 9997 | 125 | other feature |
| `ArmyManageFrame` (`CM/map/campaign/view/frame/ArmyManageFrame.as`) | team management | In-instance team: invite, change leader, kick, formation | campaign HUD | room members; actions in [rooms.md](rooms.md) |
| `PrepareBattleFrame1` / `PrepareBattleFrame2` (`M3/map/campaign/view/frame/`) | boss team invite and team list | Join a boss fight with other members | 132 / 133 | [node-combat.md](node-combat.md) |
| Main bar back button (`CM/ui/maintoolbar/MainToolBar.as:1735-1795, 1982-2020, 2134-2144`) | confirmation "Mapa ainda não concluído, se sair do mapa não poderá obter os preciosos prêmios de conclusão!" (Types 13: "A campanha ainda terminou, após sair não poderá obter mais prêmios!") | Leave the instance | HUD | sends 5025 |

## 3. Routes (client to server)

| # | Action | Sender (file:line) | Client checks | Route | Request fields | Server response |
|---|---|---|---|---|---|---|
| R1 | Leave the instance (back button, room quit, team frame, many activity HUDs) | `CampaignSocketOutManager.sendReturnCampaignRoom(armyId, killSelf=false)` (`CM/map/campaign/CampaignSocketOutManager.as:68-82`), callers `CM/ui/maintoolbar/MainToolBar.as:1755-1810, 2134-2149` | not `CampaignOverState`; confirmation when the map is not finished (`getExitCampaignMessage`, :1982); monopoly and market have special cases | C>S **5025 (0x13a1) U_C_CAMPAIGN_ROOM_EXIT** | `room.RoomExitMsg`: `msg (#1, STRING)` = "" or "kill self" (`RoomTimeMediator.as:149` when a room timer expires) | **22** to the leaver and to the other members (`result 1`); for rooms also **15** ([rooms.md](rooms.md)). The army id argument is not serialized |
| R2 | Leave (alternative) | `CampaignSocketOutManager.sendExitCampaignScene` (:84-90) | **dead code**: only caller `CampaignMapController.exitSubmitBack` (`M3/map/campaign/CampaignMapController.as:1023-1029`) has no caller | C>S **5120 (0x1400) U_C_CAMPAIGN_EXIT** | `room.RoomExitMsg{msg ""}` | treat exactly like 5025 ([generic-routes.md](generic-routes.md)) |
| R3 | Walk | `MapSocketOuterManager.sendCampaignArmyMove(armyId, path, mapId)` (`M3/map/net/MapSocketOuterManager.as:92-116`) via `CampaignMapController.sendCampaignArmyMove` (:1514-1517) | not `CampaignOverState`; path cells x20 = pixels | C>S **5124 (0x1404) U_C_CAMPAIGN_SYNCPOS** | `worldmap.PosMoveMsg`: `army_id (#2, INT32)`, `map_id (#1, INT32)`, `routes (#3, RouteMsg, repeated)` with `RouteMsg{x (#1, INT32), y (#2, INT32)}` in pixels. Header `extend1` = 0. Sequence counted (see §5) | **4185** `PosMoveMsg` broadcast to the other members (and **4213** list form); optional **4104** correction to the walker |
| R4 | Lock or unlock an aggressive NPC while it chases the player | `MapSocketOuterManager.sendAlertState(nodeId, lock)` (:31-38); callers `M3/map/campaign/mediator/npcai/NpcAlertMediator.as:66` (true), `NpcAttackAndChaseMediator.as:212,229` (false), `CampaignMapController.__unlockNodeHandler` (:1549-1557, false) | sequence counted | C>S **8196 (0x2004) C_NODE_LOCKSTATE** | `campaign.NodeLockReqMsg`: `node_id (#1, INT32)` = camp data id, `lock (#2, BOOL)` | broadcast **4609** `NodeLockReqMsg` to the members so the NPC stops (`CampaignSocketManger.__lockNpcHandler`, :2051-2064) *(assumption)* |
| R5 | Reveal fog cells | `CampaignMapModel.noteFog` batches 3 cells then `CampaignSocketOutManager.sendUpdateFogData(list, mapId)` (`CM/map/campaign/data/CampaignMapModel.as:433-446`; `CampaignSocketOutManager.as:102-118`) | fog maps only (`!checkFogMap`) | C>S **5126 (0x1406) U_C_CAMPAIGN_FOG_UPDATE** | `CampaignFogDataListReqMsg`: `dataList (#1, CampaignFogDataReqMsg, repeated)`; item `index (#1, INT32)` = row x ceil(Width/110) + col, `fog_byte (#2, INT32)` = new value | persist; broadcast **19** to other members |
| R6 | Preload enemy art for this map | `CampaignSocketOutManager.questCampaignAllEnemy(mapId)` (:42-48) from `PreLoadNextCampaign.mapId` (`CM/map/campaign/preload/PreLoadNextCampaign.as:56-60`), created in `CampaignMapController.enterOver` (:477-480) except pet land and novice maps | none | C>S **5038 (0x13ae) U_C_CAMPAIGN_SYSTEM_ARMY** | `CampaignReqMsg`: `para_int1 (#1, INT32)` = map id | **20** `SystemArmyMsg` |
| R7 | Leave a transfer node area | `TranseferWaitMediator.enterFrame` (`M3/map/campaign/mediator/hero/TranseferWaitMediator.as:62-70`) via `CampaignSocketOutManager.sendTranseferState` (:120-124) | after a 4208 with `is_stand = true`, when the hero walks more than 100 px away | C>S **8301 (0x206d) C_PLAYER_NODE_STATE** | `campaign.PlayerNodeStateMsg`: `map_id (#1, INT32)`, `node_id (#2, INT32)`, `is_stand (#3, BOOL)` = false, `army_id (#4, INT32)` | cancel the pending portal countdown *(assumption)* |
| R8 | Training campaign (tutorial) | `BaseManager.__loginStateHandler` (`CM/yishi/manager/BaseManager.as:1938-1946`), `NewbieSocketOutManager` (`CM/dialog/utils/NewbieSocketOutManager.as:35`) | `newbieProcess < 19000` | C>S **5127 (0x1407) U_C_CAMPAIGN_TRAINING** | `NoviceReqMsgMsg{type}` | 125 for campaign 10002; owned by [../tutorial/README.md](../tutorial/README.md) |

## 4. Server messages (server to client)

### 4.1 Instance creation and members

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **125 (0x007d) U_C_CAMPAIGN_CREATE** | `room.RoomCreatedMsg`: `created_type (#1, INT32)`: 1 create, 2 enter, 3 transfer (no loading screen), 4 invite, -1 already in game (`CM/map/internals/constant/CreateCampaignType.as`); `room (#2, RoomMsg)` with `room_id (#1)`, `campaignId (#2)` = **map id**, `master_id (#3)`, `name (#4)`, `count (#5)`, `capacity (#6)`, `room_state (#7)`, `room_type (#8)`, `is_set_password (#9)`, `masterServerName (#10)`, `masterName (#11)`, `masterScore (#12)`; `is_cross (#3, BOOL)`; `campignId (#4, INT32)` (not read) | `BaseManager.__createCampaignHandler` (`CM/yishi/manager/BaseManager.as:297, 2530-2619`) | instance start, portal to another map (type 3), invite join, reconnect | `room` must be present (a missing room throws at :2592). Sets `RoomInfo` (`id`, `houseOwnerId`, `serverName`, `mapName`, `campaignId`, `capacity`, `roomType`), `CampaignManager.setup(mapId)`, scene switch unless `loginToBattleFlag` |
| **21 (0x0015) U_C_CAMPAIGN_ENTER** | `room.RoomEnterMsg`: `result (#1, INT32)` > 0, `player (#2, RoomPlayerMsg, repeated)` | `CampaignManager.__campaignStartHandler` (`CM/map/campaign/CampaignManager.as:210, 519-532`) | after 125 (all members) and when a member joins | `readMember` per player (position `cur_pos_x/y` in cells, army id, avatar fields). `result <= 0` is ignored |
| **124 (0x007c) U_C_CAMPAIGN_LOGIN_IN** | `CampaignLoginMsg{player_id (#1, INT32), server_name (#2, STRING)}` | `__campaignLoginInHandler` (:1758-1769) | member reconnects | member shown online |
| **123 (0x007b) U_C_CAMPAIGN_LOGIN_OUT** | same | `__campaingLoginOutHandler` (:1771-1782) | member disconnects | member shown offline |
| **131 (0x0083) U_C_CAMPAIGN_ARMY_UPDATE** | `army.ArmyMsg` (army package): `army_id (#1)`, `player_id (#2)`, `nick_name (#3)`, `map_id (#4)`, `cur_pos_x (#5)`, `cur_pos_y (#6)`, `state (#7)`, `type (#8)` (5 = system army), `armyPawn (#9, repeated)`, `simple_hero_info (#10)`, `consortia_id (#11)`, `consortia_name (#12)`, ..., `server_name (#28)` | two listeners: `__updateCampaignArmyHandler` (:1692-1705) and `__campaingArmyInfoHandler` (:1784-1830) | army appears or changes (system armies, other players) | creates or updates `UserArmy`/`SystemArmy`; `SYS_ARMY_UPDATE` |
| **22 (0x0016) U_C_CAMPAIGN_EXIT** | `CampaignExitMsg{result (#1, INT32), player_id (#2, INT32), army_id (#3, INT32), server_name (#4, STRING)}` | `__exitCampaignSceneHandler` (`M3/map/campaign/CampaignSocketManger.as:338, 1937-1975`) | reply to 5025/5120 and to every member when someone leaves | `result > 0` required. Self: `RoomManager.dispose`, `CampaignManager.exit = true`, `exitBack` -> `SwitchPageHelp.returnToSpace()` or the Salão do Jogo (:2029-2044). Other: removes the army and the room member. Cross instances compare `server_name` too |
| **6 (0x0006) U_C_PLAYER_LOGINSTATEE** | `player.LoginStateMsg{player_id (#1), state (#2)}`; state 4 = "副本" (in campaign) | `BaseManager.__loginStateHandler` (:1904-1958) | login | state 4 does nothing by itself: the server must then send 125 (created_type -1 or 2), 21, 127 again to restore the instance *(assumption)* |

### 4.2 Nodes

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **127 (0x007f) U_C_CAMPAIGN_NODE** | `CampaignNodeListMsg{node (#1, CampaignNodeMsg, repeated)}` | `CampaignManager.__campaignDataHandler` (`CM/map/campaign/CampaignManager.as:211, 237-249`), `readNodeInfo` (:251-306) | after 125/21 | replaces the node list |
| **4264 (0x10a8) U_C_CAMPAIGN_NODE_ADD** | `CampaignNodeListMsg` | `__campaignNodeAddHandler` (`M3/map/campaign/CampaignSocketManger.as:329, 1529-1545`) | node spawns (waves, summons) | adds nodes whose `node_id` is new |
| **128 (0x0080) U_C_CAMPAIGN_NODE_UPDATE** | `CampaignNodeUpdateMsg`: `node_id (#1, INT32)` (instance node id), `node_state (#2, INT32)`, `user_id (#3, INT32)` (fighting player), `visitUserIds (#4, INT32, repeated)`, `userIds (#5, repeated, unused)`, `uu_id (#6, STRING)`, `param1 (#7, INT32)`, `sonType (#8, INT32)`, `pos_x (#9)`, `pos_y (#10)` (cells, both needed), `node_name (#11, STRING)`, `currentCount (#12, INT32)`, `param2 (#13, INT32)` (stored as army id), `param3 (#14, unused)` | `__updateCampaignNodeHandler` (:331, 1884-1935) | any node state change: fight start (4), destroyed (8), hidden (9), bonfire (19/20) | updates the node, moves it if a position is given, `UPDATE_CAMPAING_NODE` |
| **4831 (0x12df) U_C_UPDATE_NODE** | `CampaignUpdateNodeListMsg{node (#1, CampaignNodeUpdateMsg, repeated)}` | `__updateNodeHandler` (:407, 1507-1527) | batch moves (shooting, vehicle maps) | looks nodes up by **camp data id**; sets `info.posX/posY` and `state` (note: client bug sets `curPosY = posX`) |
| **4253 (0x109d) U_C_NODEPOS_REFERSH** | `CampaignNodePosRefershListMsg{node (#1, CampaignNodePosRefershMsg, repeated)}`; item `map_id (#1)`, `node_id (#2)`, `pos_x (#3)`, `pos_y (#4)`, `state (#5)` | `__nodePosRefershHandler` (:357, 1139-1161) | node teleports | stops at the first item of another map; moves the node |
| **4122 (0x101a) U_C_NPC_MOVE** | `NPCMoveMsg{id (#1, INT32) node id, pos_x (#2), pos_y (#3) target, cur_pos_x (#4), cur_pos_y (#5)}` | `__npcMoveHandler` (:330, 1846-1882) | patrolling or moving NPC (types 67, 151) | `mapModel.moveNpc` |
| **4124 (0x101c) U_C_ESCORT_NPC_FOLLOW** | `NPCFollowMsg{escort_id (#1), follow_id (#2), cur_posX (#3), cur_posY (#4)}` | `__followNpcHandler` (:345, 1492-1505) | escort NPC starts following an army | sets `followTarget` |
| **4105 (0x1009) U_C_NPC_CHASE_ARMY** | `NPCChaseMsg{node_id (#1), army_id (#2), cur_pos_x (#4), cur_pos_y (#5), server_name (#6)}` | `CampaignMapController.__npcChaseArmyHandler` (`M3/map/campaign/CampaignMapController.as:616, 690-697`) | aggressive NPC targets an army | NPC chases |
| **4609 (0x1201) U_C_NPC_LOCK** | `NodeLockReqMsg{node_id, lock}` | `__lockNpcHandler` (:369, 2051-2064) | after 8196 | NPC path cleared, `restrictMoveCount = 130` |
| **4163 (0x1043) U_C_NPC_CHAT** | `NPCChatMsg{id (#1, INT32) node id, content (#2, STRING)}` | `__npcChatHandler` (:615, 699-713) | scripted NPC speech | chat bubble over the node |
| **20 (0x0014) U_C_CAMPAIGN_SYSTEM_ARMY** | `SystemArmyMsg{heroTemplated (#1, INT32, repeated), soldierTemplated (#2, INT32, repeated)}`; -1 entries are skipped | `PreLoadNextCampaign.__allSystemArmyHandler` (`CM/map/campaign/preload/PreLoadNextCampaign.as:46, 76-100`) | reply to 5038 | preloads avatars and the battle map |

`CampaignNodeMsg` (127, 4264), every field: `node_id (#1, INT32)` instance node id; `camp_data_id (#2, INT32)` template id used by 5125; `node_name (#3, STRING)`; `master_type (#4, INT32)` node type (PosType: 40 start, 41 boss/end, 42 monster, 53 toll, 61 dialog, 62 map portal, 63/171 teleport, 64 AI, 67 moving NPC, 91 gather, 92 chest, 121/131 crossings, 141 tower defence, 151 bomber, 161, 181 treasure hunter, 191..197 steel, 201 movie, 202..207 shooting and garden, 1001/1002 bonfires, 1003 pet boss, 1101/1102 cars; `CM/map/internals/constant/PosType.as`); `son_type (#5, INT32)`; `pre_node_ids (#6, STRING)` and `next_node_ids (#7, STRING)` comma lists (progression); `state (#8, INT32)` (NodeState: 0 none, 1 exist, 2 friendly, 4 fighting, 8 destroyed, 9 hidden, 16/17 alternate art, 19/20 bonfire off/on; `CM/map/internals/constant/NodeState.as`); `refresh_speed (#9, unused)`; `pos_x (#10)`, `pos_y (#11)` cells; `cur_x (#12)`, `cur_y (#13)` current cells; `level (#14)`; `style_type (#15, unused)`; `attack_types (#16)`; `name_color (#17)`; `size_type (#18)`; `toward (#19)` facing; `resource (#20)` render kind; `reset_x (#21)`, `reset_y (#22)` stop point when interacting; `visitUserIds (#23, INT32, repeated)`; `fix_type (#24, unused)`; `fix_x (#25)`, `fix_y (#26)` pixel position; `hero_tempId (#27)` avatar; `handler_range (#28)` interaction radius in cells; `fight_capaity (#29)` displayed power; `param1 (#30, INT32)`, `param2 (#31, INT32)`, `param3 (#32, STRING)`, `param4 (#33, STRING)`, `param5 (#34, STRING, presence checked)`, `param6 (#35, STRING)` mode specific; `currentCount (#36, INT32)` remaining count (demon nodes); `army_id (#37, INT32)`.

### 4.3 Movement and view

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **4185 (0x1059) U_C_ARMYPOS_BROAD** | `worldmap.PosMoveMsg`: `map_id (#1)`, `army_id (#2)`, `routes (#3, RouteMsg)`, `grid_str (#4)`, `userId (#5, repeated)`, `server_name (#6)`, `userStates (#7, RouteStateMsg)`, `army_state (#8)` | `__armyPosBroadHandler` (:351, 1300-1306) | another member walks (relay of 5124) | `movePathsArmy` |
| **4213 (0x1075) U_C_ARMYPOSLIST_BROAD** | `PosMoveListMsg{list (#1, PosMoveMsg, repeated)}` | `__armyPosListBroadHandler` (:352, 1292-1298) | batched moves | `movePathsArmyList` |
| **4104 (0x1008) U_C_ARMY_POS_UPDATE** | `army.ArmyPosUpdatedMsg{army_id (#1), cur_pos_x (#2), cur_pos_y (#3), end_pos_x (#4), end_pos_y (#5), userIds (#6, repeated), server_name (#7)}` | `__updateArmyPosHandler` (:350, 1308-1314) | server places an army (correction, teleport inside the map) | `gotoPosArmy` |
| **4126 (0x101e) U_C_SEND_STANDPOS** | `StandPosMsg{id (#1) army id, pos_x (#2), pos_y (#3), server_name (#4)}` | `__standPosHandler` (:346, 1465-1480) | stop position of an army | sets `curPosX/Y` (also of the own army) |
| **4162 (0x1042) U_C_PLAYER_MOVE** | `PlayerMoveMsg{user_id (#1), map_id (#2), tar_x (#3), tar_y (#4), ismove_camera (#5, BOOL)}` | `CampaignMapController.__playerMoveHandler` (:612, 965-977) | forced walk (scripts, tutorial) | queued `PlayerMoveAction` |
| **142 (0x008e) U_C_CAMERA_MOVE** | `player.PlayerMoveCameraMsg{scene (#1, STRING), target_x (#2), target_y (#3), delay (#4)}` | `__campaignSceneMoveHandler` (:340, 1668-1675) then `CampaignMapController` (:605) | camera pan | queued by the header `extend2` delay |
| **143 (0x008f) U_C_PLAY_MOVIE** | movie payload | `SocketManager` (`CM/yishi/service/managers/SocketManager.as:124`) -> `PlayerMovieClipTransaction` -> `__playNodeMovieHandler` | node movie, teleport effect | queued transaction |
| **4212 (0x1074) U_C_SYN_CAMPAIGN_VIEW** | `worldmap.SynPlayerViewMsg{viewPlayer (#1, ViewPlayerMsg, repeated)}` | `__synCampaignViewHandler` (:393, 608-614) | players entering or leaving the view on crowded maps | `synCampaignView` |
| **4208 (0x1070) U_C_PLAYER_NODE_STATE** | `PlayerNodeStateMsg{map_id, node_id, is_stand, army_id}` | `CampaignMapController.__playerTranseferStateHandler` (:618, 670-688) | the player stands on a transfer node | starts the 100 px watcher (R7) |
| **141 (0x008d) U_C_LOCK_SCREEN** | `LockScreenRspMsg{screen (#1, STRING) scene type or "", frame (#2, INT32) frames}` | `BaseManager.__lockSceneHandler` (`CM/yishi/manager/BaseManager.as:294, 2692-2719`) | cinematic lock | `LOCK_SCENE` for `frame` frames |
| **4371 (0x1113) U_C_TIME_JUDGE** | `TimeJudgeMsg{is_add (#1, BOOL), second_count (#2, INT32), stopTime (#3, STRING "YYYY-MM-DD hh:mm:ss")}` | `__timeJudgeHandler` (:359, 1089-1096) | timed maps | sets the countdown end |
| **4456 (0x1168) U_C_CAMPIAGN_OPEN_MV** | empty | `__campiagnOpenMv` (:360, 1069-1072) | opening animation of timed maps | `showOpenTimeMv` |
| **4199 (0x1067) U_C_LEFT_WEARY** | `HangupInfoMsg{left_weay (#1, INT32), is_startHangup (#2, BOOL), add_weay (#3, INT32)}` | `__hookTimeHandler` (:328, 1632-1638) | hang-up maps | `hookleftWeay` (castle hook feature) |

### 4.4 Fog

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **130 (0x0082) U_C_CAMPAIGN_FOG** | `CampaignFogMsg{row (#1, INT32), col (#2, INT32), forArray (#3, BYTES, repeated) one row of bytes each, map_tempId (#4, INT32)}` | `__campaignFogHandler` (:327, 1600-1630) | after 127 on fog maps | ignored when `map_tempId` differs from the current map; builds `fogData[row][col]` |
| **19 (0x0013) U_C_CAMPAIGN_FOG_UPDATE** | `CampaignFogUpdateMsg{fogUpdate (#1, FogUpdateMsg, repeated)}`; item `index (#1)`, `fog_byte (#2)` | `__updateFogHandler` (:342, 1640-1656) | another member revealed cells | `syscFogNode(index, value, ceil(Width/110))`, keeps the max value (`CampaignMapModel.as:448-466`) |

Fog grid: cell 110 x 86 px (`CampaignMapModel.checkFog`, :412-431). Fog maps are those **not** listed in `WorldBossHelper.checkFogMap` (`CM/yishi/utils/WorldBossHelper.as:64-71`), i.e. mostly team instances.

### 4.5 Accept opcodes without a client listener

9 `U_C_CAMPAIGN_ARRIVE`, 10 `U_C_CAMPAIGN_SYNCPOS`, 14 `U_C_CAMPAIGN_ROOM_ENTER`, 18 `U_C_CAMPAIGN_ROOM_MASTER_CHANGE`, 23 `U_CAMPAIGN_MOVE`, 27 `U_C_CAMPAIGN_ARMY`, 31 `U_C_CAMPAIGN_CALLBACK`, 122 `U_C_CAMPAIGN_CHANGE`: never sent by the original server to this client, or ignored. Do not send them. Send opcode 5123 `U_CAMPAIGN_MOVE` has no sender either.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Sequence check on campaign packets | the client numbers 8196, 8549, 5125, 8255, 8548, 5121, 5033, 5124, 25202, 25203, 9669 with one shared counter passed to `sendProtobuffer`; it closes its own socket if the counter mismatches. The counter value is **not** written to the packet, so the server needs no check | `CM/yishi/comm/ByteSocket.as:150-170`; `M3/map/net/MapSocketOuterManager.as:40-44` |
| Packet header | `short 29099, short length, short checksum, short code, int clientId, int extend1, int extend2`. 5125 puts its 4th argument in `extend1` (always 0 today). Server pushes use `extend2` as a frame delay for queued transactions (126, 134, 137, 142, 143) | `CM/yishi/comm/PackageOut.as:15-29`; `CM/yishi/manager/CoreTransactionManager.as:120-125` |
| Coordinates | node and army positions in cells of 20 px; `RouteMsg` in pixels | `MapSocketOuterManager.as:108-111` |
| Instance map id | `RoomCreatedMsg.room.campaignId` = `MapInfos.Id` | `BaseManager.as:2569,2595` |
| Exit warning | shown unless the map is finished; Types 13 have their own text | `MainToolBar.as:1982-2020` |
| Return scene | `SwitchPageHelp.returnToSpace()` unless in a Salão do Jogo team | `CampaignSocketManger.as:2029-2044` |
| Preload | 5038 sent on every map enter except pet land and novice maps | `CampaignMapController.as:477-480` |

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/MapInfos.xml` | `Id`, `CampaignId`, `Width`/`Height` (path grid and fog size), `MapFileId` (art, `maps/<id>`), `BattleGround`, `MusicPath`, `Type` (1 = campaign map) |
| `raw/xml/tempinfos/Campaigns.xml` | `Types`, `Capacity` (1 solo, 4 team, 10000 open map) |
| `web/public/maps/*.json`, `db: game.campaign_nodes` | editor node layout of the 59 downloaded maps (`docs/world/README.md` §3.4). Real nodes, enemies and links are server data |
| `GameHeroTemp.xml`, `PawnTempInfos.xml` | ids listed in 20 |

## 7. Persistent state (schema `campaign`)

Instances are mostly in memory; persist enough to restore a reconnecting player and to audit runs.

```sql
CREATE TABLE campaign.instance (
  instance_id   bigserial PRIMARY KEY,
  campaign_id   integer  NOT NULL,
  map_id        integer  NOT NULL,
  room_id       integer,
  room_type     smallint NOT NULL DEFAULT 0,
  is_cross      boolean  NOT NULL DEFAULT false,
  owner_player_id integer REFERENCES player.players(player_id) ON DELETE SET NULL,
  state         smallint NOT NULL DEFAULT 0 CHECK (state IN (0, 1, 2, 3)),
  created_at    timestamptz NOT NULL DEFAULT now(),
  finished_at   timestamptz,
  CHECK (finished_at IS NULL OR finished_at >= created_at)
);
CREATE INDEX instance_open ON campaign.instance (state) WHERE finished_at IS NULL;

CREATE TABLE campaign.instance_member (
  instance_id bigint  NOT NULL REFERENCES campaign.instance(instance_id) ON DELETE CASCADE,
  player_id   integer NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  army_id     integer NOT NULL,
  pos_x       integer NOT NULL,
  pos_y       integer NOT NULL,
  has_gains   boolean NOT NULL DEFAULT true,
  online      boolean NOT NULL DEFAULT true,
  joined_at   timestamptz NOT NULL DEFAULT now(),
  left_at     timestamptz,
  PRIMARY KEY (instance_id, player_id)
);
CREATE UNIQUE INDEX instance_member_active ON campaign.instance_member (player_id) WHERE left_at IS NULL;

CREATE TABLE campaign.instance_node (
  instance_id  bigint  NOT NULL REFERENCES campaign.instance(instance_id) ON DELETE CASCADE,
  node_id      integer NOT NULL,
  camp_data_id integer NOT NULL,
  master_type  integer NOT NULL,
  state        smallint NOT NULL,
  pos_x        integer NOT NULL,
  pos_y        integer NOT NULL,
  current_count integer NOT NULL DEFAULT 0,
  fighting_player_id integer,
  PRIMARY KEY (instance_id, node_id)
);
CREATE INDEX instance_node_camp ON campaign.instance_node (instance_id, camp_data_id);

CREATE TABLE campaign.instance_fog (
  instance_id bigint  NOT NULL REFERENCES campaign.instance(instance_id) ON DELETE CASCADE,
  map_id      integer NOT NULL,
  cell_index  integer NOT NULL CHECK (cell_index >= 0),
  fog_value   smallint NOT NULL,
  PRIMARY KEY (instance_id, map_id, cell_index)
);

CREATE TABLE campaign.node_template (
  camp_data_id integer PRIMARY KEY,
  map_id       integer NOT NULL,
  node_name    text    NOT NULL,
  master_type  integer NOT NULL,
  son_type     integer NOT NULL DEFAULT 0,
  pos_x        integer NOT NULL,
  pos_y        integer NOT NULL,
  pre_node_ids text    NOT NULL DEFAULT '',
  next_node_ids text   NOT NULL DEFAULT '',
  handler_range integer NOT NULL DEFAULT 1,
  hero_temp_id integer NOT NULL DEFAULT 0,
  enemy_heroes text    NOT NULL DEFAULT '',
  enemy_soldiers text  NOT NULL DEFAULT '',
  battle_type  integer NOT NULL DEFAULT 6,
  move_to_map_id integer,
  move_to_node_id integer,
  params       jsonb   NOT NULL DEFAULT '{}'::jsonb
);
CREATE INDEX node_template_map ON campaign.node_template (map_id);
```

`campaign.node_template` holds the server node data the client never had (enemies, links, battle types). Seed it from `game.campaign_nodes` and authored content *(assumption: the original data is lost)*.

## 8. Backend implementation notes

| Handler | Opcode | Validation order | Effects |
|---|---|---|---|
| `campaign::map_session::create_instance` (internal) | called by 5039, portals, activities | player not already in an active instance | insert `instance`, members; build nodes from `node_template`; send 125 (`room.campaignId` = map id), 21 to every member, 127, 130 when the map uses fog; mode specific pushes (4282, 4874...) |
| `campaign::map_session::handle_leave` | 5025 (and 5120) | member of an active instance | mark `left_at`; send 22 `{result 1, player_id, army_id}` to the leaver and all members; rooms: also 15 ([rooms.md](rooms.md)); destroy the instance when empty |
| `campaign::map_session::handle_move` | 5124 | member; `map_id` equals the instance map; path cells walkable *(assumption: trust the client)* | store the last cell; relay 4185 to other members |
| `campaign::map_session::handle_node_lock` | 8196 | member; node exists | relay 4609 to members *(assumption)* |
| `campaign::map_session::handle_fog_update` | 5126 | member; fog map | upsert max(fog_value); relay 19 to others |
| `campaign::map_session::handle_system_army` | 5038 | member | reply 20 with the hero and soldier template ids of the map enemies |
| `campaign::map_session::handle_node_state` | 8301 | member | cancel the transfer countdown for `node_id` |
| `campaign::map_session::on_login` | login | player has an active membership | send state 4 in opcode 6, then 125 (created_type -1), 21, 127, 130, mode pushes; send 124 to the other members |
| `campaign::map_session::on_logout` | disconnect | member | `online = false`; send 123 to members; keep the slot for a grace period *(assumption: 5 minutes)* |

- Transactions: membership changes (join, leave) and node state changes are short transactions on the instance tables; pushes go out after commit.
- Concurrency: one actor per instance serializes 5124/5125/5126 and node updates.
- Timers: instance idle timeout (no member online) *(assumption: 10 minutes)*; per-map timers for 4371.

## 9. Open questions and assumptions

1. Original node data (enemies per node, `next_node_ids`, battle types, portal targets) is server-only; content must be authored.
2. Whether the original server validated 5124 paths.
3. Reconnect sequence after login state 4 (125 type -1 assumed).
4. Meaning of `created_type` -1 ("already in game") for the server side.
5. 8196/4609 relay semantics (NPC lock while chasing) are inferred from the handlers.

## 10. Implementation checklist

- [ ] Instance registry and actor per instance
- [ ] 125 encoder with map id in `room.campaignId`
- [ ] 21 `RoomEnterMsg` with full `RoomPlayerMsg` (avatar fields)
- [ ] 127 / 4264 / 128 / 4831 / 4253 node encoders from `node_template`
- [ ] 124 / 123 presence, 131 army updates
- [ ] 5124 -> 4185 relay, 4104 corrections, 4126 stop positions
- [ ] Fog: 130 initial, 5126 -> 19 relay, `instance_fog`
- [ ] 5038 -> 20
- [ ] 8196 -> 4609, 8301, 4208
- [ ] 5025 / 5120 -> 22 (+15 for rooms), instance teardown
- [ ] Reconnect: opcode 6 state 4 then the bootstrap again
- [ ] Tables `instance`, `instance_member`, `instance_node`, `instance_fog`, `node_template`
- [ ] Test: `node server/flowtest.mjs` with 5039 -> 125/21/127, then 5025 -> 22 and the client returns to Reino do Céu
