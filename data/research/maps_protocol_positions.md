# Map positions in the protocol (protobuf): opcodes, AS3 consumers and units

Survey of the `writeTag` writers in `decompiled/*/scripts/com/road/yishi/proto/**` and of the handlers. `CSM` = `decompiled/m3/scripts/map/campaign/CampaignSocketManger.as`, `OCC` = `decompiled/m3/scripts/map/outercity/OuterCityController.as`.
(*) = class present only in AS3, missing from `protocol/proto.json` (which lacks 254 of the 1708 proto classes and does not store submessage types).

## Units
- **20 px cell (×20 = px):** every `pos_x/pos_y`, `cur_pos_x/y`, `cur_x/y`, `end_pos_x/y`, `reset_x/y`, `tar_x/y`, `target_x/y`, `BossMsg`/`BoxMsg` x/y, `PosMsg` x/y, vehicle `Position` x/y. A* on a 20 px grid (`decompiled/core_module/scripts/map/internals/findPath/AcorrsLineGrid.as:271`).
- **Pixels:** `RouteMsg.x/y` (`PosMoveMsg.routes`, campaign and outer city) and `CampaignNodeMsg.fix_x/fix_y`.
- **1000 px block file name** (`floor(px/1000)_floor(py/1000)`, `MapDataUtils.as:31-35`): `PosMoveMsg.grid_str`, `PhysicUpdateReqMsg.req_grid`, `OutercityReqMsg.files/position`.

## Campaign entry and army position
| message | opcode | consumer | unit |
|---|---|---|---|
| `RoomEnterMsg.player[]` → `RoomPlayerMsg.cur_pos_x/y` (start position of each member = **spawn**) | U_C_CAMPAIGN_ENTER 21 | `decompiled/core_module/scripts/map/campaign/CampaignManager.as:210,519,636-637`; view `CampaignWalkLayer.as:515-516` (×20) | cell |
| `ArmyMsg.map_id/cur_pos_x/cur_pos_y` | U_C_CAMPAIGN_ARMY_UPDATE 131 | CSM:332,335,1692,1784-1811 | cell |
| `CrossArmyListMsg.armyList[]` | U_C_CROSS_ARMY_UPDATE 4494 | CSM:368,1707 | cell |
| `StandPosMsg.id/pos_x/pos_y` (standing position; revive/teleport) | U_C_SEND_STANDPOS 4126 | CSM:346,1465-1477; `CampaignWalkLayer.as:110-111`; space `SpaceSocketManager.as:94,273-274` | cell |
| `PlayerMoveMsg.map_id/tar_x/tar_y` (forced move) | U_C_PLAYER_MOVE 4162 | `CampaignMapController.as:612,973`; `PlayerMoveAction.as:43-47` | cell |
| `PlayerMoveCameraMsg.target_x/y` | U_C_CAMERA_MOVE 142 | CSM:340,1668; `SceneMoveAction.as:56-58` | cell |
| `PlayerNodeStateMsg.map_id/node_id/is_stand` | U_C_PLAYER_NODE_STATE 4208 | `CampaignMapController.as:618,673-678` | n/a |

## Movement and paths
- `PosMoveMsg.routes[]` (RouteMsg x,y, **px**): sent via U_C_CAMPAIGN_SYNCPOS 5124 (`decompiled/m3/scripts/map/net/MapSocketOuterManager.as:100,109-110`); received via U_C_ARMYPOS_BROAD 4185 (CSM:351→1300) and U_C_ARMYPOSLIST_BROAD 4213 (CSM:352→1292); consumers divide by 20 (`CampaignWalkLayer.as:167-261`, `CampaignMapModel.as:1419-1420`). Outer city: sent via C_MOVE_POS 8254 (`OuterCitySocketOutManager.as:101`), received via U_C_BROAD_POS 4167 (OCC:820,871,887-892).
- `ArmyPosUpdatedMsg.cur_pos/end_pos`: U_C_ARMY_POS_UPDATE 4104 (CSM:350→1308; A* to end×20 in `CampaignWalkLayer.as:339,350`).
- `SpacePlayerMoveMsg.players[].path[]` (PosMsg*): U_C_PLAYER_SPACE_SYNC_POS 4594 (`SpaceSocketManager.as:90,169-183`; `decompiled/m3/scripts/stage3drender/WalkLayer.as:198,204`); sent via C_PLAYER_SPACE_MOVE 8690.
- `VehicleMoveMsg.path[]`: CSM:3034-3035 (×20).
- `ArmyPositionMsg.pos_x/pos_y/map_id`: U_C_ARMYPOS_SEND 4241, U_C_ARMY_POSATION 4237 (OCC:828,832,1177,1209-1210); request C_ARMYPOS_REQUEST 8328.
- `OutercityRspMsg*` (return home): U_C_ARMY_RETURNHOME 98 (OCC:824,1144,1167-1170).

## Campaign nodes
- `CampaignNodeListMsg.node[]` (`CampaignNodeMsg*`: node_id, master_type, son_type, pre/next_node_ids, state, pos_x/y, cur_x/y, size_type, toward, reset_x/y, fix_type, fix_x/y, handler_range, army_id): U_C_CAMPAIGN_NODE 127 (`CampaignManager.as:211,237-283`) and U_C_CAMPAIGN_NODE_ADD 4264 (CSM:329,1529-1590).
  `pos` → cell (`CampaignMainBuidingLayer.as:292-293,350-351`, `MapPhysics.as:52`); `cur` → cell (`NpcLayer.as:166-167`); `fix` → px (`CampaignMainBuidingLayer.as:285-288`; CSM:1155 does `fixX = posX*20`); `reset` → cell (`CampaignArmyViewHelper.as:227-237`). Chest nodes have master_type 92.
- `CampaignNodeUpdateMsg*`: U_C_CAMPAIGN_NODE_UPDATE 128 (CSM:331,1884,1919-1924) and U_C_UPDATE_NODE 4831 (CSM:407,1508; decompilation bug at CSM:1521 `curPosY = posX`).
- `CampaignNodePosRefershMsg*`: U_C_NODEPOS_REFERSH 4253 (CSM:357,1139-1159).
- `NPCMoveMsg*`: U_C_NPC_MOVE 4122 (CSM:330,1846; `NpcLayer.as:236-239`); `NPCChaseMsg*` U_C_NPC_CHASE_ARMY 4105; `NPCFollowMsg*` U_C_ESCORT_NPC_FOLLOW 4124 (CSM:345,1492-1504).
- Client→server: `CampaignReqMsg.paraInt1 = nodeId` in U_C_CAMPAIGN_ARRIVE 5125 (`MapSocketOuterManager.as:55-61`).

## Outer city: castles, wild lands, grid
- `BaseCastleMsg.pos_x/pos_y/map_id`: own castle at login U_C_LOAD_CASTLE 4153 (`LoginInitDataAccept.as:101`); on-screen castles U_C_PHYSIC_LIST_UPDATE 4129 (`PhysicListUpdateMsg*`, OCC:826,898,918-943); update U_C_MAPDATA_SYNC 140 (`SocketManager.as:121-122,181-196`).
- `WildLandMsg*.pos_x/pos_y/size`: same opcodes (OCC:947-976).
- `ArmyUpdatedGridMsg*`: U_C_ARMY_UPDATE_GRID 169 (OCC:821,1030).
- `CastleReqMsg`: move castle U_C_BUILDING_TRANSCASTLE 5176 (`SocketSendManager.as:128-136`); received as 105 (`PlayerManager.as:156,1850-1857`).
- `CastleDefenseRspMsg*`: U_C_CASTLE_DEFENSE 118 (OCC:825,1096-1103). `MapPhysicAttackMsg*`: U_C_ARMY_ATTACK 5160.

## Bosses, chests and boxes
- `MapBossMsg*.bosslist[]` (`BossMsg*` bossName, grade, type, x, y): U_C_MAPBOSS_DATAS 4938 (fog 4939), `OuterCityManager.as:74-75,111`; camera ×20 in `OuterCityBossInfoView.as:233`.
- `MapBoxMsg*.boxlist[]` (army.`BoxMsg` boxId, mapId, x, y, type): U_C_MAPBOSS_BOX 4940 (`OuterCityManager.as:76,180-181`; `OuterCityBossBoxView.as:31-32`).
- `BossInviteMsg.pos_x/pos_y`: U_C_CAMPAIGN_BOSS_ARMY_INVITE 132 (CSM:344,2015-2024).
- Battle chest: `BattleReportMsg.pos_x/pos_y` (U_BATTLE_REPORT 4103, CSM:367,1008,1028-1031).

## Other grids (not traced in depth)
PlanesWarGridMsg*, PlanesWarRspMsg pos_x/pos_y, PlanesWarPlayerInfoMsg walkPath, PlanesResourceMsg*, DungeonGridMsg, DungeonMsg pos_x/pos_y, FantasyMatrixNodeMsg, MinosNodeMsg*, ArchaeologyNodeMsg, SeekNodeMsg*, LandMineMsg/SapperMsg, SecretWarMoveMsg, CrisisPlayerInfo, DitchNpcInfoMsg.bornPoint, SkyTrialPortalMsg*, VehicleNpcNodeMsg (cur/rest/path), PlayerVehicleMsg, SimpleArmyMsg, RoomPlayerMsg, TeamPlayerInfoMsg.
