# Node interaction, battles, results and cards

Module `node-combat` of [campaign](README.md). What happens when an army reaches a node on a campaign map: the arrive route 5125, server dialogs, reinforcement and boss teams, battle start and end, drop chests, the campaign result grade, the card draw and the finish. The map lifecycle is in [map-session.md](map-session.md); the contract for other features is in [generic-routes.md](generic-routes.md).

## 1. Overview

- The hero walks toward a node. When it is inside `handler_range` (`CampaignMapModel.getHandlerNode`), `CampaignArmyViewHelper.selfArmyToEnd` stops it at `reset_x/reset_y` and calls `sendMessage` (`M3/map/campaign/helper/hero/CampaignArmyViewHelper.as:51-91, 121-186`).
  - Type 92 (local chest) is collected client side.
  - A node in state 4 (fighting) sends **8255** reinforce in team maps, or **5125** in a list of PvP and activity maps.
  - Any other node sends **5125 U_C_CAMPAIGN_ARRIVE** with `para_int1 = camp_data_id` after a 50 ms delay (:188-222).
- The server decides what the node does and answers with one of:
  - a battle (**157** ...), node state 4 (128) and later 8 or 9;
  - a dialog (**29** `CampaignConfirmMsg`, answer **5033**; or **138** plot dialog, answer **5032**);
  - a teleport (**143** movie, or **125** with `created_type 3` for another map);
  - a tip (**126**).
- When the boss node dies the server sends **137** (result grade, `CampaignResultView`), then **135** (card draw, `ChestFrame`). The player flips a card (**5122** -> **26**); the frame then sends **5180** (finish or "again") and the server answers **134** (campaign over) and returns the player to the room or the Reino do Céu.

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Map nodes (`M3/map/campaign/view/layer/*`) | `node_name` | Interactable nodes | 127 | state art, name color, chat bubbles (4163), boss HP (4183) |
| `IconAlertHelper` alert, `SubmitResourcesFrame`, `TrailDialogView`, `PetLandDialogFrame`, `MineralDialogFrame`, `MarryWeddingDialogFrame`, `NewbieVillageDialogFrame`, `SacrificeRoomDialogFrame`, `ConsortiaBossDialogFrame`, `GodsEveningDialogFrame`, `HookAlertFrame` | `CampaignConfirmMsg.title` | Server dialog on a node | 29 | `body`, optional item icon (`item_tempId`, `item_count`) |
| `DialogAction` / dialog frames (`CM/yishi/actions/map/DialogAction.as`) | NPC dialog | Story dialog | 138 | `PlotMsg` lines (tutorial feature) |
| `PrepareBattleFrame1` (`M3/map/campaign/view/frame/PrepareBattleFrame1.as`) | boss invitation | "{nick} invites you to fight {boss}" with countdown | 132 | boss name, level, template, remaining time, position |
| `PrepareBattleFrame2` | boss team | members already fighting the boss | 133 | boss info, `fightPlayer` list, remaining time |
| `NpcInfoFrame` (`M3/map/campaign/view/frame/NpcInfoFrame.as`) | NPC army info | Info of a system army node | click on an NPC | army detail after 5121 |
| `CampaignResultView` (`CM/map/internals/view/displaye/CampaignResultView.as`) | result movie "campaign.Resultmc" | Grade of the run | 137 | boss time vs "(Tempo da Batalha do Chefão ≤ {0} Seg)" (`StandSecond`), deaths "(Número de Mortes≤ {0} S)", appraisal frames, team/friend/prop/other bonuses, total EXP, VIP EXP, pet EXP, final grade D..SSS (:100-160) |
| `ChestFrame` (`CM/map/internals/battle/ChestFrame.as`) | card draw | Flip one card | 135 | `card_count` cards, free and paid, 11 s auto pick, buttons "Sair"/"Desafiar novamente" or "Confirmar" (:270-345) |
| Drop chest node and `BattleFallGoodsView` (`M3/map/campaign/view/fall/BattleFallGoodsView.as`) | "battle.handler.BattleResultHandler.name" | Loot dropped by a map battle | 4103 with items | item list; take all or one item |

## 3. Routes (client to server)

| # | Action | Sender (file:line) | Client checks | Route | Request | Server response |
|---|---|---|---|---|---|---|
| A1 | Reach a node | `CampaignMapController.sendCampaignArrive(armyId, campDataId, ext=0)` (`M3/map/campaign/CampaignMapController.as:1519-1522`) -> `MapSocketOuterManager.sendCampaignArrive` (`M3/map/net/MapSocketOuterManager.as:55-62`). Callers: `CampaignArmyViewHelper` (:134-220, via `sendMessage` and `delayCall`), `PlayerArriveMediator.as:64`, `NpcAttackIIMediator.as:117`, `NpcAttackAndChaseMediator.as:221`, `GvgChaseNpcMediator.as:143`, `HouseUIView.as:645`, `CampaignSocketManger.as:3123` (387), `DungeoTurnManager.fight` (`CM/managers/DungeoTurnManager.as:197-204`), tutorial (`M8/mediators/NewbieBaseActionMediator.as:1126-1128`) | 700 ms anti flood in `launchFight` (:93-119); node not hidden; special cases in §5 | C>S **5125 (0x1405) U_C_CAMPAIGN_ARRIVE** | `CampaignReqMsg`: `para_int1 (#1, INT32)` = **camp data id** of the node (`CampaignNode.nodeId`), `para_bool1 (#7, BOOL)` = true. Header `extend1` = 0 | battle, dialog 29/138, teleport 143 or 125 (type 3), or tip 126; node updates 128 to everyone |
| A2 | Answer a boss invitation | `PrepareBattleFrame1.__onAcceptHandler` / `__onRejectHandler` (`M3/map/campaign/view/frame/PrepareBattleFrame1.as:116-127`) | none | C>S **5125** | `para_int1` = boss `templateId` from 132, `para_bool1` = true (accept) or **false** (reject) | accept: join the boss battle; reject: nothing *(assumption)* |
| A3 | Reinforce a node already in combat (team maps) | `MapSocketOuterManager.sendReinforce(campDataId)` (`M3/map/net/MapSocketOuterManager.as:64-70`) from `CampaignArmyViewHelper.sendMessage` (:121-186) | node state 4, `Capacity > 1`, map not in the 5125 list | C>S **8255 (0x203f) C_PLAYER_REINFORCE** | `CampaignNodeMsg` with only `camp_data_id (#2, INT32)` set | add the player to the running battle (reinforcement, battle feature) *(assumption)* |
| A4 | Ask the army of a system NPC | `NpcInfoFrame.getArmyInfo` (`M3/map/campaign/view/frame/NpcInfoFrame.as:43-46`) -> `MapSocketOuterManager.sendSelectCampaignArmy(2, physicId)` (:72-80) | frame open | C>S **5121 (0x1401) U_C_CAMPAIGN_ARMY** | `CampaignReqMsg`: `para_int1` = 2, `para_int2` = node `PhysicInfo.id` (instance node id). The 3rd argument (army id) is computed but not sent | 131 `ArmyMsg` of that system army (`type 5`), which fires `GET_SYS_ARMY_INFO` *(assumption)* |
| A5 | Answer a server dialog (29) | `CampaignMapController.__callServerSccess` and `hookAlertBack` (`M3/map/campaign/CampaignMapController.as:941-963`) -> `MapSocketOuterManager.sendFrameCallBack` (:82-90). Gods evening variant `sendFrameCallBackGodsEvening` (:173-182) | one dialog at a time (`_preFrameIsClose`) | C>S **5033 (0x13a9) U_C_CAMPAIGN_CONFIRM** | `CampaignReqMsg`: `para_int1 (#1)` = `map_id` from 29, `para_int2 (#2)` = `node_id` from 29, `para_bool1 (#7)` = accepted; gods evening adds `para_int5 (#5)` | executes the node action (teleport, submit, start, enter house...). Empty body dialogs with type < 4 are auto answered with false (:772-776) |
| A6 | Finish a scripted dialog (138), gather node, mineral confirm | `BaseManager.__sessionOverHandler` (`CM/yishi/manager/BaseManager.as:2237-2246`) parsing "nodeId:", "mapId:", "command:" from the dialog param; `CollectionAction.as:466` (cmd 2); `CampaignMapController.__mineralConfirmCall` (:954-958, cmd 2) | none | C>S **5032 (0x13a8) U_C_CAMPAIGN_CALLBACK** | `campaign.CallBackReqMsg`: `map_id (#1, INT32)`, `node_id (#2, INT32)`, `cmd (#3, INT32)` | continue the node script (battle, reward, next dialog) |
| A7 | Flip a card | `ChestFrame.__clickHandler` (`CM/map/internals/battle/ChestFrame.as:355-366`), auto pick after 11 s `autoChest` (:410-433) | one card per player (`BaseManager.isSelect`) | C>S **5122 (0x1402) U_C_CAMPAIGN_TAKE_CARD** | `CampaignReqMsg`: `para_int1 (#1)` = army id, `para_bool1 (#7)` = paid card (`isPay`), `para_int2 (#2)` = card index (0-based) | **26** to every member of the instance |
| A8 | Close the card frame or retry | `ChestFrame.dispose` (:435-480) sends `sendCampaignFinish(1)`; "Desafiar novamente" `campaignAgain` (:197-206) sends `sendCampaignFinish(2)`; `OpenChestTransaction.gotoChest` (`CM/map/internals/transaction/OpenChestTransaction.as:61-80`) sends 1 when the card was already taken | none; retry checks Energy (warning `disclist02`) | C>S **5180 (0x143c) U_C_CAMPAIGN_FINISH** | `CampaignReqMsg`: `para_int1 (#1)` = 1 finish, 2 restart the same campaign | 1: **134** then return; 2: a new instance of the same campaign (**125**) *(assumption)* |
| A9 | Take a map drop chest | `BattleFallGoodsView._reciveClick` (take all) and `sendGetSimpleGoods(templateId)` (`M3/map/campaign/view/fall/BattleFallGoodsView.as:122-133, 262-275`); maze hang-up variant `HangUpMediator.as:236` | bag space for stackables | C>S **5129 (0x1409) U_C_DROPITEM_TAKE** | `CampaignReqMsg`: `para_string1 (#6, STRING)` = `sign_id` from the battle report, `para_int1 (#1)` = item template id (0 = all), `para_int2 (#2)` = 0 | grant items (inventory pushes); on failure **4268** with the remaining items |
| A10 | Report the combo count after a campaign battle | `SocketSendManager.sendBattleCount` (`CM/yishi/service/managers/SocketSendManager.as:110-116`) from `BattleResultHandler` (`docs/battle/rules.md` battleType 6) | `maxBatterCount > 2` | C>S **8282 (0x205a) C_BATTER_COUNT** | `campaign.BatterLastInfoMsg{count (#1, INT32)}` | none; feeds `CampaignReportMsg.batter` *(assumption)* |

## 4. Server messages (server to client)

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **129 (0x0081) U_C_NODE_SUCCESS** | `CampaignNodeSuccMsg{node_id (#1, INT32)}` | `__attackNodeHandler` (`M3/map/campaign/CampaignSocketManger.as:341, 1658-1666`) | node defeated by the player | `currentDieNodeId` (death animation) |
| **387 (0x0183) U_C_CAMPAIGN_ARRIVE_REQUEST** | `CampaignNodeArriveRequestMsg{node_id (#1, INT32)}` (camp data id) | `__CampaignBattleRequestHandler` (:405, 3110-3125) | server asks the client to trigger a node (e.g. an NPC caught the player) | sends 5125 for that node unless its state is 8 or 9 |
| **29 (0x001d) U_C_CAMPAIGN_CONFIRM** | `CampaignConfirmMsg{title (#1, STRING), body (#2, STRING), map_id (#3, INT32), node_id (#4, INT32) camp data id, item_tempId (#5, INT32), item_count (#6, INT32), type (#7, INT32)}` | `CampaignMapController.__confirmFrameHandler` (`M3/map/campaign/CampaignMapController.as:613, 750-910`) | node with a dialog | type 0 icon alert -> 5033; 2 submit resources; 3 and 10 trail dialog; 4 pet land; 5 mineral; 6 mineral confirm -> 5032 cmd 2; 11/12 wedding; 13 newbie village; 14 wedding exit (body from the client); 15 sacrifice; 16 guild boss; 18 gods evening; 19 **dungeon turn** board (opens 9006 op 0, no 5033, [dungeon-turn.md](dungeon-turn.md)); other types `HookAlertFrame` -> 5033 |
| **138 (0x008a) U_C_GAME_PLOT** | `gameplot.PlotMsg{loop (#1, BOOL), scene_type (#2, INT32), info (#3, PlotInfoMsg, repeated)}` (tutorial feature) | `BaseManager.__gamePlotHandler` (`CM/yishi/manager/BaseManager.as:298, 2211-2224`) -> `DialogAction` | story dialogs | dialog; its `param` carries "nodeId:", "mapId:", "command:" for 5032 |
| **132 (0x0084) U_C_CAMPAIGN_BOSS_ARMY_INVITE** | `BossInviteMsg{nick_name (#1, STRING) inviter, boss_nick (#2, STRING), level (#3, INT32), template_id (#4, INT32), left_fight_time (#5, INT32) s, pos_x (#6), pos_y (#7)}` | `__campaignBossArmyInviteHandler` (:344, 2015-2027) | a member engaged a boss that allows helpers | `PrepareBattleFrame1` |
| **133 (0x0085) U_C_CAMPAIGN_BOSS_ARMY_LIST** | `army.BossArmyListMsg{left_fight_time (#1), boss_name (#2), level (#3), boss_template_id (#4), fightPlayer (#5, FightPlayerMsg, repeated)}`; `FightPlayerMsg{player_id (#1), nick_name (#2), pic (#3)}` | `__campaignBossArmyListHandler` (:343, 1991-2013) | team gathering for the boss | `PrepareBattleFrame2` |
| **4183 (0x1057) U_C_MULTI_HPSYNC** | `MultiCampaignHpSyncMsg{proxyId (#1, STRING), mapId (#2), nodeId (#3) camp data id, nodeHp (#4), nodeTotalHp (#5), playerHp (#6, MultiPlayerHpSyncMsg, repeated)}`; `MultiPlayerHpSyncMsg{armyId (#1), curHp (#2, INT64), totalHp (#3, INT64)}` | `__multiHpsyncHandler` (:349, 1316-1336) | team instances: node HP and member HP persist between battles | node and army HP bars |
| 157, 156, 153, 154, 4103 | battle | battle feature | after 5125/8255 | battle scene; return to `CAMPAIGN_MAP_SCENE` (`BattleManager.preScene`) |
| **4103** (in campaign) | `battle.BattleReportMsg{battle_result (#1), strategy_bonus (#2), gp_bonus (#3), pos_x (#4), pos_y (#5), sign_id (#6, STRING), baseItem (#7, BaseItemMsg, repeated), battle_scene (#8), fail_count (#9), gold_bonus (#10), pet_gp_bonus (#11), param1 (#12), param2 (#13)}` | `__battleInfoResultHandler` (`M3/map/campaign/CampaignSocketManger.as:979-1042`) | battle end on a campaign map | when `baseItem` is not empty, spawns a local chest node (type 92, sonType 2201) at the player position with `sign_id` |
| **4268 (0x10ac) U_C_TAKEDROP_FAIL** | `BattleReportMsg` (`sign_id`, `baseItem` left) | `CampaignMapController.__resetFallHandler` (:614, 715-748) | 5129 could not give everything (bag full) | chest node back to state 1 with the remaining items |
| **4382 (0x111e) U_C_PLAY_GETMOIVE** | `simple.FightOverMoiveMsg{gp (#1), gold (#2), strategy (#3)}` | `CampaignMapController.__playGetMovieHandler` (`M3/map/campaign/CampaignMapController.as:610, 992-1021`) | after a map battle | floating EXP/gold/strategy numbers over the hero |
| **137 (0x0089) U_C_CAMPAIGN_REPORT** | `CampaignReportMsg{failed_count (#1), failed_appraisal (#2) frame 1..7, endBossTime (#3) ms, endBossAppraisal (#4) frame, total_appraisal (#5) grade 1..7, batter (#6), teamJoin (#7), friendJoin (#8), vipJoin (#9) VIP EXP, propJoin (#10), otherJoin (#11), total_gp (#12), pet_gp (#13)}` | `__campaignResultHandler` (:333, 1832-1838) -> `CampaignResultTransaction` (`CM/map/internals/transaction/CampaignResultTransaction.as`) -> `CampaignResultView` (`CM/map/internals/view/displaye/CampaignResultView.as:52-160`) | boss killed (end of a graded campaign) | sets `CampaignOverState`; plays the result movie with the grade D/C/B/A/S/SS/SSS (`total_appraisal` 1..7, :134-160) |
| **135 (0x0087) U_C_CAMPAIGN_CARDS** | `item.CampaignCardsMsg{scene_type (#1, STRING), card_count (#2, INT32), pay_card_count (#3, INT32), price (#4, INT32), dropItems (#5, item.ItemInfoMsg, repeated)}` | `BaseManager.__campaignCardsHandler` (`CM/yishi/manager/BaseManager.as:305, 1985-2001`) -> `OpenChestTransaction` (`CM/map/internals/transaction/OpenChestTransaction.as`) -> `ChestFrame` | after 137 | if the player already picked (`isSelect`) sends 5180 directly; else shows `card_count` cards; `scene_type "SINGLE_CAMPAIGN_MAP_SCENE"` selects the solo buttons (`ChestFrame.as:315-327`). In battleType 16 it is buffered for `BATTLE_SCENE` |
| **26 (0x001a) U_C_CAMPAIGN_TAKE_CARD** | `CampaignTakeCardsMsg{player_id (#1), name (#2, STRING), pay (#3, BOOL), index (#4, INT32), template_id (#5), count (#6), bind (#7, BOOL), random_skill_1..5 (#8..#12, INT32)}` | `BaseManager.__campaingTakeCardHandler` (:306, 2003-2012) -> `ChestFrame.__updateCardHandler` (:368-410) | each card flip, to every member | flips the card with the item; own flip sets `isSelect`, enables "Confirmar", closes after 8 s |
| **134 (0x0086) U_C_CAMPAIGN_FINISH** | empty | `__campaignFinishInfoHandler` (:334, 1840-1844) -> `CampaignOverTransaction` (`CM/map/internals/transaction/CampaignOverTransaction.as`) | after 5180 (1), or when the instance ends | `exit = true`; `Capacity == 1`: dispose room, `returnToSpace`; Salão do Jogo team: back to it; else `PVE_ROOM_SCENE` (back to the room) |
| **126 (0x007e) U_C_MSG** | `CampaignNotifyMsg{id (#1, INT32), scene (#2, STRING), map_id (#3, INT32), body (#4, STRING), delay (#5, INT32)}` | `BaseManager.__msgHandler` (:299, 2070-2085) -> `SessionTransaction` -> `MessageAction` -> `ServerFrameManager.createFrame` (`CM/yishi/manager/ServerFrameManager.as`) | any tip or error, all features | `id 2`: floating tip with `body`; `id 0`: nothing; `id 1`: throws (do not use). Buffered until `scene` is current (`""` = now) |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Arrive id | 5125 `para_int1` is the camp data id (`CampaignNode.nodeId = camp_data_id`), not `node_id` | `CM/map/campaign/CampaignManager.as:264` |
| Node in combat (state 4) | consortia secret land: nothing; PvP maps, dusk area 4901, ice and fire 4701, pet boss floor with a team, guild dream land, gods evening (not `param2 == 2`): 5125; pet land: tip; `Capacity <= 1`: nothing; else 8255 | `CampaignArmyViewHelper.as:121-186` |
| Special pickups | node type 99999 (steel props) and 207 (garden bed) are handled locally | `CampaignArmyViewHelper.as:188-222` |
| Dialog auto refusal | 29 with empty `body` and `type < 4` is answered immediately with `para_bool1 = false` | `CampaignMapController.as:772-776` |
| Grade scale | 1 D, 2 C, 3 B, 4 A, 5 S, 6 SS, 7 SSS (`room.InstanceItem.gradeText` "--\|D\|C\|B\|A\|S\|SS\|SSS") | `CampaignResultView.as:134-160`; `index/language.json` |
| Grade inputs | boss kill time against `Campaigns.StandSecond`, death count (target 0), team/friend/prop/other bonuses. The formula is server side *(assumption: average of the time and death appraisals, see [stars-and-sweep.md](stars-and-sweep.md))* | `CampaignResultView.as:100-118`; strings "campaign.Resultmc.*" |
| Card draw | `card_count` cards; the first flip is free, others cost `price` *(assumption from `pay_card_count`/`price`)*; auto free pick after 11 s | `ChestFrame.as:273-300, 410-433` |
| Card frame exits | solo: "Sair" (+ "Desafiar novamente" when level >= 30, map != 4401 and not hero difficulty); team: "Confirmar" | `ChestFrame.as:315-327` |
| Gains | members with `isNoGet` (room checkbox "Utilizar a quantidade de ganhos diária" off) or no Energy get no rewards *(assumption: no 135 for them)* | [rooms.md](rooms.md) |
| Combo report | 8282 when the battle combo > 2 | `docs/battle/rules.md` row 6 |

## 6. Templates

| File | Use |
|---|---|
| `Campaigns.xml` | `StandSecond` (boss time target), `BaseGp`, `Item` (drop showcase, real drops are server side), `CardPayment` (always 0) |
| `GameHeroTemp.xml`, `PawnTempInfos.xml`, `HeroAis.xml` | enemies of each node (server node data) |
| `AreaMapDropInfos.xml`, `CommonDropTempInfo` sets | card and drop pools *(assumption: server side drop tables, see `docs/mechanics/world_progression.md` §8)* |
| `ItemTempInfos` | card items |

## 7. Persistent state (schema `campaign`)

```sql
CREATE TABLE campaign.run (
  run_id        bigserial PRIMARY KEY,
  instance_id   bigint   NOT NULL REFERENCES campaign.instance(instance_id) ON DELETE CASCADE,
  player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  campaign_id   integer  NOT NULL,
  has_gains     boolean  NOT NULL,
  failed_count  integer  NOT NULL DEFAULT 0 CHECK (failed_count >= 0),
  boss_kill_ms  integer,
  max_combo     integer  NOT NULL DEFAULT 0,
  grade         smallint CHECK (grade BETWEEN 1 AND 7),
  total_gp      integer  NOT NULL DEFAULT 0,
  started_at    timestamptz NOT NULL DEFAULT now(),
  finished_at   timestamptz
);
CREATE INDEX run_player ON campaign.run (player_id, started_at DESC);

CREATE TABLE campaign.card_draw (
  run_id      bigint   NOT NULL REFERENCES campaign.run(run_id) ON DELETE CASCADE,
  card_index  smallint NOT NULL CHECK (card_index >= 0),
  item_template_id integer NOT NULL,
  item_count  integer  NOT NULL CHECK (item_count > 0),
  is_bound    boolean  NOT NULL DEFAULT true,
  picked_by_player_id BIGINT REFERENCES player.players(player_id),
  paid        boolean  NOT NULL DEFAULT false,
  picked_at   timestamptz,
  PRIMARY KEY (run_id, card_index)
);

CREATE TABLE campaign.map_drop (
  sign_id     text     PRIMARY KEY,
  instance_id bigint   NOT NULL REFERENCES campaign.instance(instance_id) ON DELETE CASCADE,
  player_id   BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  items       jsonb    NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

| Handler | Opcode | Validation order | Effects |
|---|---|---|---|
| `campaign::node_combat::handle_arrive` | 5125 | (1) member of the instance (or of a map owned by another feature: dispatch, see [generic-routes.md](generic-routes.md)); (2) node with that camp data id exists and is not 8/9; (3) node `pre_node_ids` satisfied *(assumption)*; (4) player not in battle | by node kind: monster/boss -> start battle (128 state 4 to all, 157 to the player); dialog -> 29 or 138; portal (62/171) -> 125 `created_type 3` on the target map; teleport (63) -> 143 + 4104; locked or invalid -> 126 tip |
| `campaign::node_combat::handle_reinforce` | 8255 | node state 4 and team instance | add the player to the node battle (battle feature reinforcement) |
| `campaign::node_combat::handle_army_info` | 5121 | `para_int1 == 2`, node exists | reply 131 with the system army |
| `campaign::node_combat::handle_confirm` | 5033 | a dialog is pending for (`map_id`, `node_id`) | accepted: run the node action; refused: nothing |
| `campaign::node_combat::handle_callback` | 5032 | pending script step | run `cmd` (2 = finish gathering, mineral confirm, dialog end) |
| `campaign::node_combat::on_battle_end` | battle report | battle belongs to a node | win: node state 8 (128), 129 to the winner, `failed_count` unchanged; spawn drops (4103 `baseItem`, `sign_id`, store `map_drop`); if the node is the end node (41): compute grade, store `run`, send 137 then 135 to each member with gains. Loss: `failed_count + 1`, node back to 1 |
| `campaign::node_combat::handle_take_card` | 5122 | 135 was sent to this player; card not taken; paid card: enough diamonds | assign the item from the pre-rolled `card_draw`, grant it, broadcast 26 |
| `campaign::node_combat::handle_finish` | 5180 | run ended | `para_int1 == 1`: send 134, then team members go back to the room scene (client side) and solo players to the Reino do Céu; `== 2`: create a new instance of the same campaign (Energy rules of [selection.md](selection.md)) |
| `campaign::node_combat::handle_take_drop` | 5129 | `sign_id` belongs to the player | grant all or one template; on bag full send 4268 with the rest |
| `campaign::node_combat::handle_batter_count` | 8282 | in a campaign run | `max_combo = max(max_combo, count)` |

- Battle config per node (`docs/battle/server-engine.md` §9.2): `battle_type` 6 for solo and normal team nodes, 3846 `ROOM_BOSS_BATTLE` for team bosses *(assumption)*, 3848 for cross-server instances *(assumption)*; `map` = `MapInfos.BattleGround` of the instance map; enemy heroes and soldiers from `campaign.node_template`; members as allies for team battles.
- Pushes to other members: 128 on every node state change, 26 on every card, 4183 HP sync after team battles, 22 on leave.
- Use 126 `{id 2, scene "", body}` for every refusal so the player sees a reason.

## 9. Open questions and assumptions

1. The grade formula is server side; inputs are known from `CampaignReportMsg`.
2. Card pricing (`pay_card_count`, `price`) and how many paid flips are allowed.
3. 5121 `para_int1 = 2` meaning (only value used).
4. 5125 `para_bool1 = false` from the boss invitation reject: refusal semantics.
5. Battle types for team bosses and cross instances.

## 10. Implementation checklist

- [ ] 5125 dispatcher by map owner, then node kind
- [ ] Battle start from node data; 128 state 4 broadcast
- [ ] Battle end: 129, 128 state 8, 4103 drops + `map_drop`, 4382 floating gains
- [ ] Dialogs: 29 encoder with types, 5033 handler; 138 / 5032 bridge with the tutorial feature
- [ ] 8255 reinforcement, 132/133 boss team, 4183 HP sync
- [ ] 5121 -> 131
- [ ] Result: grade computation, 137 encoder
- [ ] Cards: 135 encoder (pre-rolled pool), 5122 -> 26 broadcast
- [ ] 5180 -> 134 (or restart)
- [ ] 5129 / 4268
- [ ] 8282 combo
- [ ] 126 helper used by all handlers
- [ ] Tables `run`, `card_draw`, `map_drop`
- [ ] Test: kill a boss node -> 137 grade S -> 135 -> 5122 -> 26 -> 5180 -> 134 and the client returns to the room
