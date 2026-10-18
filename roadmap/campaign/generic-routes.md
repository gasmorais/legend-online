# Generic campaign routes 5125, 5120, 10008 (and 5025)

Module `generic-routes` of [campaign](README.md). Many features run on the campaign map engine (guild boss maps, Teseu boxes, world boss, mazes, farm, wedding, dungeon turn, dusk area...). They do not have their own "attack" or "leave" opcodes: they reuse the campaign arrive route **5125**, the campaign leave route (**5025** in practice; **5120** exists but is dead), and the battle skill route **10008**. This module is the contract between the campaign router and those features.

## 1. Overview

| Route | Real use in this client | Owner of the handler |
|---|---|---|
| 5125 U_C_CAMPAIGN_ARRIVE | every node interaction on every campaign map | campaign router, delegating by map id to the owning feature |
| 5120 U_C_CAMPAIGN_EXIT | **no live sender** (dead code) | campaign router: same as 5025 |
| 5025 U_C_CAMPAIGN_ROOM_EXIT | leaving any campaign map, room or activity map from the main bar | campaign router (rooms and instances) |
| 10008 U_B_HERO_ORDER | skill use in every battle | battle engine ([../battle/README.md](../battle/README.md)); listed here because campaign battles depend on it |

Other roadmap modules that already rely on this contract: [../guild/boss.md](../guild/boss.md) (5125 on map 7701), [../theseus/box.md](../theseus/box.md) (5125 and 5120 on 40101..43000), [../tutorial/guided-steps.md](../tutorial/guided-steps.md) (5125 on nodes 1000206/1000208/1000211, 5025), [../avenger/battle.md](../avenger/battle.md) (10008).

## 2. Screens

No screen of its own. Triggers:

- 5125: walking onto a node (`CampaignArmyViewHelper`), NPC catches the player (`NpcAttackAndChaseMediator`, `NpcAttackIIMediator`, `GvgChaseNpcMediator`), server request 387, dungeon turn fight, house UI, boss invitation frame, tutorial actions. See [node-combat.md](node-combat.md) §3 A1.
- 5025: main bar back button and every activity HUD "Sair" (`CM/ui/maintoolbar/MainToolBar.as:1735-1980, 2134-2149`), room "Sair" (`M9/room/view/pve/RoomRightView.as:866-869`), `RoomControl` (`CM/mvc/controler/RoomControl.as:89`), team frame, room timer (`CM/mediator/RoomTimeMediator.as:149`, msg "kill self").
- 10008: battle skill bar (`CM/battle/view/ui/SkillItemListController.as:700-715`), extra skill view (`CM/battle/view/ui/AddOtherSkillView.as:309-320`).

## 3. Routes (client to server)

### 3.1 5125 U_C_CAMPAIGN_ARRIVE

| Item | Value |
|---|---|
| Sender | `MapSocketOuterManager.sendCampaignArrive(armyId, campDataId, flag = true, ext = 0)` (`M3/map/net/MapSocketOuterManager.as:55-62`); wrapper `CampaignMapController.sendCampaignArrive` (`M3/map/campaign/CampaignMapController.as:1519-1522`) |
| Route | C>S **5125 (0x1405) U_C_CAMPAIGN_ARRIVE** ("直接攻击", `CM/yishi/datas/consant/ProtocolTypeTable.as:1004`) |
| Header | `extend1` = `ext` (always 0 in this client), `extend2` = 0 |
| Request | `campaign.CampaignReqMsg`: `para_int1 (#1, INT32)` = camp data id of the node (or the boss template id from the boss invitation, [node-combat.md](node-combat.md) A2); `para_bool1 (#7, BOOL)` = true, false only for a refused boss invitation. Unused: `para_int2 (#2)`, `para_int3 (#3)`, `para_int4 (#4)`, `para_int5 (#5)`, `para_string1 (#6)`, `server_name (#8)`, `isCross (#9)` |
| Client checks | army exists; node not destroyed (8) or hidden (9) for the 387 path; per map rules in [node-combat.md](node-combat.md) §5; 700 ms anti flood on direct clicks |
| Responses | battle 157 (+ battle sequence), dialog 29 or 138, teleport 143, new map 125 (`created_type 3`), tip 126, node updates 128 broadcast |

### 3.2 5120 U_C_CAMPAIGN_EXIT

| Item | Value |
|---|---|
| Sender | `CampaignSocketOutManager.sendExitCampaignScene(armyId)` (`CM/map/campaign/CampaignSocketOutManager.as:84-90`) |
| Live callers | **none**. The only caller is `CampaignMapController.exitSubmitBack` (`M3/map/campaign/CampaignMapController.as:1023-1029`), which nothing references (also absent from `build/as3/gen` call sites) |
| Request | `room.RoomExitMsg{msg (#1, STRING) = ""}` |
| Server behavior | accept it and behave exactly like 5025 so a future client or a test tool works |

### 3.3 5025 U_C_CAMPAIGN_ROOM_EXIT (the real leave route)

| Item | Value |
|---|---|
| Sender | `CampaignSocketOutManager.sendReturnCampaignRoom(armyId, killSelf = false)` (`CM/map/campaign/CampaignSocketOutManager.as:68-82`) |
| Request | `room.RoomExitMsg{msg (#1, STRING)}` = "" or "kill self" (room timer expiry). The army id is not serialized |
| Client checks | not `CampaignManager.CampaignOverState`; confirmation alert when the map is unfinished; monopoly (`sendLeaveCampaign` when the game is over), market (cannot leave while selling), sacrifice and garden maps leave directly (`MainToolBar.as:1755-1795`) |
| Responses | in a map: **22** `CampaignExitMsg` to the leaver and the members; in a room scene: **15** `RoomExitRspMsg` ([rooms.md](rooms.md)); both when leaving a team instance that belongs to a room *(assumption)* |

### 3.4 10008 U_B_HERO_ORDER

| Item | Value |
|---|---|
| Sender | `SocketSendManager.gameCommand(battleId, heroId, skillId)` (`CM/yishi/service/managers/SocketSendManager.as:208-216`); callers `SkillItemListController.as:706,711`, `AddOtherSkillView.as:315,320` |
| Route | C>S **10008 (0x2718) U_B_HERO_ORDER** |
| Request | `battle.UseSkillMsg`: `battle_id (#1, STRING)`, `hero_id (#2, INT32)` (living id), `skill_id (#3, INT32)` |
| Client checks | battle running, skill ready; with `newbieProcess < 19000` the client first sends 10022 `B_PAUSE_FINISHED` and 10008 400 ms later (`SkillItemListController.as:700-712`) |
| Response | **75 (0x004b) U_B_HERO_ORDER** `battle.HeroOrderMsg{battle_id (#1, STRING), hero_index_id (#2, INT32), skill_id (#3, INT32), result (#4, INT32), cast_time (#5, INT32), qte_time (#6, INT32), targetIndexs (#7, INT32, repeated)}`; receiver `SkillItemListController.__skillUseServerBack` (:243, 842-1010): `result 0` accepted; other values re-enable the bar after 1000 ms (:966-1002). Then the attack sequence 153 |
| Siblings (other features) | 10516 child skills, 10522 war soul skills (`SocketSendManager.as:218-235`) |

Engine rules for 10008 are documented in `docs/battle/server-engine.md` §7 (checks: battle active, own hero, alive, no pending request, known skill on the bar with UseWay 1, SP, cooldown).

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When |
|---|---|---|---|
| 22 U_C_CAMPAIGN_EXIT | `CampaignExitMsg{result (#1, INT32) > 0, player_id (#2, INT32), army_id (#3, INT32), server_name (#4, STRING)}` | `CampaignSocketManger.__exitCampaignSceneHandler` (`M3/map/campaign/CampaignSocketManger.as:1937-1975`) | answer to 5025/5120 on a map and broadcast to the other members |
| 15 U_C_CAMPAIGN_ROOM_EXIT | `RoomExitRspMsg{player_id (#1), exit_type (#2), param1 (#3)}` | `RoomManager.__returnRoomHandler` (`CM/managers/RoomManager.as:467-490`) | answer to 5025 in a room scene |
| 75 U_B_HERO_ORDER | `HeroOrderMsg` | skill bar controllers | answer to 10008 |
| 157, 29, 138, 143, 125, 126, 128 | see [node-combat.md](node-combat.md) and [map-session.md](map-session.md) | | answers to 5125 |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Which feature owns a 5125 | the map id of the sender's current instance. Ranges used by the client to switch behavior (`CM/yishi/utils/WorldBossHelper.as`): 10001..10005 novice, 5000..5100 world boss, 8000..8430 mazes, 4202 dungeon turn and Molong, 9996 Bloody, 4101 Templo das Chamas, 4701 Fogo e Gelo, 4901 dusk area, 5401 SvS, 5101 quiz, 5201 monopoly, 7701 Terra dos Sonhos, 7501 guild secret land, 4301..4303 wedding, 5501..5505 farm, 5601..5605 house, 5701 steel, 5703 Caça Fantástica, 5801 market, 6011/6021/6031 prison, 8501 gods evening, 9995 sacrifice, 9997 Formação Mágica, 20001..25000 pet land, 31001..39999 Zona Proibida, 40101..43000 Teseu boxes, 2291..2294 Grupo FB | `docs/world/README.md` §3.2 |
| Arrive id | camp data id (`CampaignNodeMsg.camp_data_id`) | `CM/map/campaign/CampaignManager.as:264` |
| Packet counter | 5125 is in the client side sequence list; no field on the wire | `CM/yishi/comm/ByteSocket.as:150-170` |
| Leave while finished | the client never sends 5025 after `CampaignOverState` (set by 137) | `MainToolBar.as:1736-1739` |

## 6. Templates

None of their own. Node data: `campaign.node_template` ([map-session.md](map-session.md)); skills: `SkillTempInfos.xml` (battle feature).

## 7. Persistent state

None of their own. Uses `campaign.instance`, `campaign.instance_member`, `campaign.instance_node` ([map-session.md](map-session.md)).

## 8. Backend implementation notes

```
campaign::generic::handle_arrive (5125)
  1. find the player's active instance; none -> 126 tip, stop
  2. owner = feature_for_map(instance.map_id)      // table above
  3. owner != campaign -> owner::handle_arrive(player, instance, para_int1, para_bool1)
                          e.g. guild::boss::handle_dream_attack (7701), theseus::box::handle_floor_fight
  4. else campaign::node_combat::handle_arrive

campaign::generic::handle_leave (5025, 5120)
  1. player in a room scene (room state 0..2, no instance) -> campaign::rooms::handle_leave -> 15
  2. player in an instance -> owner::on_leave hook (optional) then campaign::map_session::handle_leave -> 22
  3. neither -> reply 22 {result 1} anyway so the client returns to the Reino do Céu *(assumption)*

battle::handle_order (10008)  // battle feature; campaign battles only provide the battle id
```

- Feature hooks: `on_arrive(player, instance, camp_data_id, flag) -> Outcome` and `on_leave(player, instance)`. The campaign router owns the instance; features own their node semantics.
- The router must be idempotent for duplicated 5125 (the client sends 5125 again when the walk ends near the same node).

## 9. Open questions and assumptions

1. 5120 was probably the exit of an older client; nothing shows its original response other than 22 *(assumption)*.
2. `extend1` of 5125 is always 0; its purpose in older clients is unknown.
3. Whether 5025 in a team instance should also send 15 (room) or only 22 (map).

## 10. Implementation checklist

- [ ] `feature_for_map(map_id)` registry with hooks
- [ ] 5125 router -> campaign node handler or feature hook
- [ ] 5120 alias of 5025
- [ ] 5025 router: room leave (15) vs instance leave (22)
- [ ] 10008 handled by the battle engine for campaign battles (no special case)
- [ ] Test: `node server/flowtest.mjs` 5125 on a monster node -> 157; 5120 -> 22; 5025 in a room -> 15
