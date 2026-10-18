# Campaigns and rooms ("Campanhas e salas")

Feature slug `campaign`, domain world. Client packages `selectcampaign`, `singlecampaign`, `pveroomlist`, `room`, `duskarea` plus the campaign map engine (`map.campaign.*`, M3 and CM). Protobuf packages `campaign`, `room`, `tollgate`, `dungeon`, `dungeonturn`.

What the player gets:

- **Solo campaigns** ("Campanha", hotkey Z): 7 chapters ("Pasto Livre" to "Porta da Decisão"), 83 campaigns in Normal and "Herói" difficulty. Each run is graded D to SSS; the grade unlocks the next campaign, the hero difficulty and the chapter SSS reward.
- **Team instances** ("Salão de Campanhas", "Portal dos Heróis" NPC): rooms of up to 4 players that pick a multiplayer instance, get ready and start together. Cross-server matchmaking fills empty slots.
- **The campaign map**: a walkable instance with nodes (monsters, bosses, portals, dialogs, chests). Walking onto a node sends the generic arrive route 5125; the server starts a battle, a dialog or a teleport. After the boss, a result screen and a card draw.
- **Activity modes hosted on the same engine**: "Roleta da Masmorra" (dungeon turn board game), "Terra do Crepúsculo" (dusk area, 2 team war field), sweep ("Modo Bot") of cleared campaigns.

All traffic is socket based. No HTTP route. PostgreSQL schema: `campaign`. Rust handlers: `campaign::<module>::handle_<action>`.

Conventions used in every module:

- Paths are relative to `decompiled/`. `CM` = `core_module/scripts`, `M3`, `M4`, `M5`, `M9`, `M13` = `mN/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Field tags were checked against the AS3 `writeTo`/`readFrom` when `protocol/proto.json` is ambiguous (it merges messages that share a short name, see [tollgate.md](tollgate.md) and [rooms.md](rooms.md)).
- *(assumption)* marks anything the client does not prove.

## Entry points

| Entry | Condition (client) | Opens | Module |
|---|---|---|---|
| Main bar "Campanha" button, hotkey Z (`CM/ui/maintoolbar/MainToolBar.as:532,1360-1364`; `CM/yishi/keyboard/KeyBoardRegister.as:666`) | none on the button; `SwitchPageHelp.gotoSingleCampaign` requires `newbieProcess > 23000` and no sweep running (`CM/yishi/SwitchPageHelp.as:889-910`) | `SelectCampaignFrame` | [selection.md](selection.md) |
| Quest links and daily guide (`SwitchPageHelp.gotoCampaignById`, `CM/yishi/SwitchPageHelp.as:1067-1136`; `CM/managers/DayGuideManager.as:474`) | Capacity 1: `MinLevel`; Capacity > 1: level 20, then walks to NPC node 2 | selection frame on the quest campaign, or the room hall | [selection.md](selection.md), [room-list.md](room-list.md) |
| NPC "Tina, Portal dos Heróis" in Reino do Céu, dialog option type 2 (`M3/map/space/helper/hero/SpaceArmyViewHelper.as:181-190`; option level check `M3/map/space/view/frame/DialogOptionItem.as:344`) | option `minLevel` from `MapNodeInfos.Param3` (20) | `PVERoomListFrame` "Salão de Campanhas" | [room-list.md](room-list.md) |
| Castle and top bar shortcuts (`M4/castle/CastleSceneView.as:121`; `CM/ui/toptoolbar/TopToolsBar.as:1391`) | none | room hall | [room-list.md](room-list.md) |
| Room invitation popup, chat room link | invitee level 20 for room type 0 | joins a room | [rooms.md](rooms.md) |
| "Campo de Batalha" list (world boss feature, `M13/worldboss/pvp/WarFightItem.as:105-117`) | daily war field count | map 4901 "Terra do crepúsculo" | [dusk-area.md](dusk-area.md) |
| Selection frame "Modo Bot" button | level 20, campaign already cleared, 20 Energy per run | sweep frames (mopup feature) | [stars-and-sweep.md](stars-and-sweep.md) |

## Modules

| Module | Content |
|---|---|
| [selection.md](selection.md) | Campaign selection frame: lands, chapters, areas, difficulties, grade display, chapter rewards, start of a solo campaign (5039 with `para_int1 = 1`), 9536, 4192 |
| [single-campaign.md](single-campaign.md) | Solo trail view (`SingleCampaignMapView`): 4 enemy cards per campaign, 8666 fight, 4282 progress |
| [map-session.md](map-session.md) | Campaign instance lifecycle: 125 create, 21 members, 127 nodes, node updates, movement, fog, NPC moves, exit (5025, 22), reconnect, preload 5038 |
| [node-combat.md](node-combat.md) | Node interaction: arrive 5125, reinforce, server dialogs 29/5033, callbacks 5032, battle start and end, result 137, finish 134/5180, cards 135/5122/26, drop chests, generic tips 126 |
| [generic-routes.md](generic-routes.md) | Contract of the shared routes 5125, 5120 (dead in this client) and 10008, plus the real exit 5025, for the features that run on the campaign engine |
| [room-list.md](room-list.md) | "Salão de Campanhas": room list 5026/13/4270, search 8465/4370, create 5023, join 5024, waiting players 11, chat room link 8780/4913 |
| [rooms.md](rooms.md) | Room scene: 12 create, members 120, slots 17/5029, edit 32/5034, password 8344, ready 5036/24, state 5037/25, kick 5031/28, owner 5030/121, invite 5028/16/8286/9557/8353, leave 5025/15, start 5039 |
| [cross-match.md](cross-match.md) | Cross-server PvE matchmaking: 5039 `isCross`, 4994/25157, 4995/25156, kick vote 4984/25152 |
| [stars-and-sweep.md](stars-and-sweep.md) | Grades D..SSS (4151 rank list), unlock rules, chapter SSS rewards, campaign sweep protocol 8528/4425 |
| [dungeon-turn.md](dungeon-turn.md) | "Roleta da Masmorra" (campaign 4202): board, dice, fights, boxes (9006/4874) |
| [dusk-area.md](dusk-area.md) | "Terra do crepúsculo" war field (map 4901): entry 8599/4493/8332, score 4252, ranking 8337/4255, report 4254, attacks 8334 |
| [tollgate.md](tollgate.md) | "Chegada dos Deuses" tollgate protocol (8752..8755, 4645..4647) and the parts reused by Solo Pass |
| [dungeon.md](dungeon.md) | Underground palace exploration protocol (4931, 4932): messages only, no client consumer in this build |

## Shared identifiers (read this before implementing)

| Name | Meaning | Source |
|---|---|---|
| `CampaignId` | `Campaigns.xml` row. Used by 5039 `para_int2`, 5034 `campaign_id`, rooms (`RoomMsg.campaignId` in 12/13/4270/32), 4151 `campaign_id`, sweep | `CM/mvc/module/room/RoomInfo.as:66-74` |
| map id | `MapInfos.Id`. A campaign has 1..n maps (`MapInfos.CampaignId`). **125 `RoomCreatedMsg.room.campaignId` carries the map id**, not the campaign id: the client calls `CampaignManager.setup(room.campaignId)` and resolves the template through `MapInfos` (`CM/yishi/manager/BaseManager.as:2569,2595`; `CM/map/campaign/data/CampaignMapModel.as:267-273`). Example: campaign 1001 runs on map 1021, hero campaign 11101 on map 11111 | `raw/xml/tempinfos/MapInfos.xml` |
| node id | `CampaignNodeMsg.node_id`: instance node id, stored as `PhysicInfo.id`; looked up by `getMapNodesById` (128, 4264, 4122, 4124, 4253) | `CM/map/campaign/data/CampaignMapModel.as:815-825` |
| camp data id | `CampaignNodeMsg.camp_data_id`: node template id, stored as `CampaignNode.nodeId`; looked up by `getMapNodeByNodeId` (5125 `para_int1`, 8255, 387, 4831, 29, 8196, 4609, 4183) | `CM/map/campaign/data/CampaignMapModel.as:840-850` |
| army id | player army (`ArmyManager.army.id`), sent in 5121, 5124, 5025 is called with it but not serialized | `CM/map/campaign/CampaignSocketOutManager.as:68-82` |

## Protobuf coverage

The registry assigns 158 messages to this feature. Only some belong to campaign gameplay; the rest live in the `campaign` or `room` package but are used by other systems.

| Messages | Module or owner |
|---|---|
| `CampaignReqMsg`, `RankListRspMsg`, `RankMsg`, `SingleHeroReqMsg`, `SingleHeroCountMsg` | [selection.md](selection.md), [stars-and-sweep.md](stars-and-sweep.md) |
| `CampaignNodeMsg`, `CampaignNodeListMsg`, `CampaignNodeUpdateMsg`, `CampaignUpdateNodeListMsg`, `CampaignNodePosRefershListMsg`, `CampaignNodePosRefershMsg`, `CampaignLoginMsg`, `CampaignExitMsg`, `CampaignFogMsg`, `CampaignFogUpdateMsg`, `FogUpdateMsg`, `CampaignFogDataListReqMsg`, `CampaignFogDataReqMsg`, `StandPosMsg`, `NPCMoveMsg`, `NPCFollowMsg`, `NPCChaseMsg`, `NPCChatMsg`, `NodeLockReqMsg`, `PlayerMoveMsg`, `PlayerNodeStateMsg`, `TimeJudgeMsg`, `HangupInfoMsg`, `SystemArmyMsg`, `LockScreenRspMsg`, `CampaignNpcMoveListMsg`, `CampaignNpcMoveMsg` | [map-session.md](map-session.md) |
| `CampaignNodeSuccMsg`, `CampaignNodeArriveRequestMsg`, `CampaignConfirmMsg`, `CallBackReqMsg`, `BossInviteMsg`, `CampaignReportMsg`, `CampaignTakeCardsMsg`, `CampaignNotifyMsg`, `MultiCampaignHpSyncMsg`, `MultiPlayerHpSyncMsg`, `BatterLastInfoMsg`, `HurtOrderMsg`, `WinConditionsMsg`, `TaskCampaignReqMsg` | [node-combat.md](node-combat.md) |
| room package: `RoomReqMsg`, `RoomMsg`, `RoomListRspMsg`, `RoomCreatedMsg`, `RoomEnterMsg`, `RoomExitMsg`, `RoomExitRspMsg`, `RoomPlayerListMsg`, `RoomPlayerMsg`, `RoomEditMsg`, `EditRoomRspMsg`, `KillPlayerRspMsg`, `ChangeMasterRspMsg`, `PlaceStateRspMsg`, `PlayerReady`, `PlayerReadyRspMsg`, `RoomStateRspMsg`, `RoomInviteMsg`, `MatchStateMsg`; plus `CaptainSpeakMsg` | [room-list.md](room-list.md), [rooms.md](rooms.md), [cross-match.md](cross-match.md) |
| `CampaignSweepReq`, `CampaignSweepRsp`, `SweepResult`, `ItemTemplate` | [stars-and-sweep.md](stars-and-sweep.md) |
| `WarFightInfoMsg`, `WarReportListMsg`, `WarReportMsg`, `WarFieldAttackMsg`, `WarMovieMsg`, `WarFightFlagEndTimeMsg`, `WarEnergyListMsg`, `WarEnergyMsg` | [dusk-area.md](dusk-area.md) |
| dungeonturn package (4) | [dungeon-turn.md](dungeon-turn.md) |
| tollgate package (5, plus the shadowed `tollgate.ChallengeMsg` and `tollgate.RankInfoMsg`) | [tollgate.md](tollgate.md) |
| dungeon package (5) | [dungeon.md](dungeon.md) |
| `WorldBossInfoLoadMsg`, `WorldBossInfoStateMsg`, `WorldBossLiveMsg`, `WorldBossReportMsg`, `WorldBossStateMsg`, `WorldBossWoundRewardListMsg`, `WorldBossWoundRewardMsg`, `WorldBossBufferMsg`, `OprateReplacemntMsg`, `ReplacementMsg` | [../world-boss/README.md](../world-boss/README.md) |
| `MountAvatarMsg`, `MountEditMsg`, `MountInfoMsg`, `MountKingInfoMsg`, `MountKingListMsg`, `MountShopItemMsg`, `MountShopMsg`, `AvatarInfoMsg` | [../mounts/README.md](../mounts/README.md) |
| `TowerInfoMsg`, `TowerInfoReqMsg`, `TowerListMsg`, `EnterTowerInfoMsg`, `KingTowerInfoMsg`, `TowerDiedMsg` | [../mazes/README.md](../mazes/README.md) (Labirinto floors) |
| `HangupAttackMsg`, `HangupStateListMsg`, `HangupStateMsg`, `PlayerHangupStateListMsg`, `PlayerHangupStateMsg`, `QuickHangupMsg` | [../castle/README.md](../castle/README.md) (hook / idle map PvP) |
| `CampaignNodeInfoMsg`, `NodeMsg`, `RollDiceMsg`, `TriggerEventMsg`, `TempMsg` | [../casino/README.md](../casino/README.md) (monopoly) |
| `PassInfoMsg`, `QuickPassInfoMsg`, `QuickPassRankMsg`, `RankInfoMsg` (campaign) | [../trials/README.md](../trials/README.md) (rapid through) |
| `BoxInfoMsg`, `DragonCampaingnDataMsg`, `RollInfoMsg`, `RandomBuffMsg`, `RandomBossBuffefMsg` | Molong and random boss activity maps *(assumption: [../trials/README.md](../trials/README.md) and [../cross-server/README.md](../cross-server/README.md))* |
| `SpacePlayerMsg`, `SpacePlayerMoveMsg`, `SpacePlayerArmyInfoReqMsg`, `PosMsg` | [../sky-realm/README.md](../sky-realm/README.md) |
| `AltarCampaignReportMsg`, `AltarCampaignSkillMsg`, `ArriveAltarReqMsg` | [../guild/README.md](../guild/README.md) (altar, 8549) |
| `CarInfo`, `TramcarInfoMsg` | mineral map *(assumption: [../mines/README.md](../mines/README.md))* |
| `MonsterAccessoryHammerMsg` | [../monsters/README.md](../monsters/README.md) |
| `CampaignBufferMsg`, `BufferInfoMsg` | [../hero/README.md](../hero/README.md) (player buffs) |
| `PlanesWarAllPlayerMsg`, `PlanesWarPlayerInfoMsg` | [../planes/README.md](../planes/README.md) |
| `VehicleBuffListMsg`, `VehicleBuffStateMsg`, `VehicleSkillListMsg`, `SnowVehicleSkillListMsg`, `SmallMapFogListMsg` | [../artillery/README.md](../artillery/README.md) |
| `TeamRoomListMsg`, `TeamRoomMsg`, `TeamPlayerMsg` | [../team/README.md](../team/README.md) (Grupo FB) |
| `ItemTemplate` (also used by sweep), `SweepResult` | [stars-and-sweep.md](stars-and-sweep.md) |

## Dependencies

- [../battle/README.md](../battle/README.md): battle start 157 and the battle sequence (156, 153, 154, 4103), skill route 10008/75, `BattleReportMsg`. Campaign battleTypes: 6 `CAMPAIGN_BATTLE`, 11 `BATTLE_MULTIPLAYER`, 3846 `ROOM_BOSS_BATTLE`, 3848 `CROSS_MULTI_CAMPAIGN`, 3878 `DUNGEON_TURN` (`CM/yishi/datas/battle/BattleType.as:16,26,124,126,182`).
- [../hero/README.md](../hero/README.md): Energy ("weary") fields of player info opcode 3, daily counters (`multiCopyCount`, `dungeoRestNum`, `warFieldCount`...), extra fields 260, level and job transfer state.
- [../army/README.md](../army/README.md): army id, formation (`teammanager`, 8278/4186), `ArmyMsg`.
- [../inventory/README.md](../inventory/README.md): item grants for cards, drops, chapter rewards; Energy potions 2030500..2030503; `item.ItemInfoMsg`.
- [../sky-realm/README.md](../sky-realm/README.md): return to Reino do Céu (8688/4595/4606) after a campaign or room.
- [../tutorial/README.md](../tutorial/README.md): training campaign 10002 (5127), node arrivals scripted by the tutorial.
- [../mopup/README.md](../mopup/README.md): sweep frames (`mopup` module) on top of 8528/4425.
- [../friends/README.md](../friends/README.md), [../guild/README.md](../guild/README.md): invite lists (friends, guild members).
- [../chat/README.md](../chat/README.md): quick invite 8353, room links 8780.
- [../world-boss/README.md](../world-boss/README.md): war field list that enters the dusk area.
- [../trials/README.md](../trials/README.md): Solo Pass reuses the tollgate routes 8753/8755.
- [../mail/README.md](../mail/README.md): chapter rewards and offline grants *(assumption)*.

## Implementation order

1. Templates loaders: `Campaigns`, `MapInfos`, `SingleCampaignDatas`, `DistrictDrop`, `DistrictSSSDrop`, `ConfigInfos` keys.
2. [map-session.md](map-session.md) and [generic-routes.md](generic-routes.md): instance registry, 125/21/127, movement, exit 5025/22. Without them nothing else runs.
3. [node-combat.md](node-combat.md): 5125, battle 6, result 137, finish 134, cards 135/5122/26.
4. [selection.md](selection.md) + [stars-and-sweep.md](stars-and-sweep.md) (4151 at login): solo progression end to end.
5. [single-campaign.md](single-campaign.md).
6. [room-list.md](room-list.md) then [rooms.md](rooms.md): team instances.
7. [cross-match.md](cross-match.md).
8. [dungeon-turn.md](dungeon-turn.md), [dusk-area.md](dusk-area.md).
9. Sweep protocol in [stars-and-sweep.md](stars-and-sweep.md).
10. [tollgate.md](tollgate.md) and [dungeon.md](dungeon.md) only if a consumer appears (no client screen uses them in this build, except Solo Pass for 8753/8755).
