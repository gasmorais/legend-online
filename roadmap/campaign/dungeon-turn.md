# Dungeon turn ("Roleta da Masmorra")

Module `dungeon-turn` of [campaign](README.md). A team board game played inside campaign 4202 "Roleta da Masmorra": the room owner rolls a die, the team token walks around a 14 cell board, colored cells start a battle, and energy bars upgrade the reward chests. Protobuf package `dungeonturn`; opcodes 9006 (request) and 4874 (response and push).

## 1. Overview

- **Template.** `Campaigns.xml` row 4202: `Types 13`, `SonTypes 307` (`CampaignTemplate.isDungeoTurn`, `CM/yishi/datas/templates/CampaignTemplate.as:238-245`), `LandId 0`, `DungeonId 3` (activity chapter), `AreaId 307`, `Capacity 4`, `EnterNumb 1`, `MinLevel 80`, `MaxLevel 100`, `NeedTransfer true`, `StandSecond 600`, `Item` "2060901,2060902,2060911,2060912". Map 4202.
- **Entry.** A normal PvE room selects 4202 in the instance frame ("Apenas pode obter ganhos uma vez por semana na roleta da masmorra.") and starts with 5039 ([rooms.md](rooms.md)). Gains are weekly (`playerInfo.dungeoRestNum` / `dungeoTurnMaxNum`; warning "Você já participou da Roleta da Masmorra todas as vezes disponíveis para esta semana...").
- **Opening the board.** On the map, the start node sends a server dialog **29** with `type 19` (`TrailDialogView`); confirming calls `CampaignMapController.showFrame` -> `DungeoTurnManager.openTurn()` -> **9006** `op 0` (`M3/map/campaign/CampaignMapController.as:892-910, 912-915`). The server answers **4874** `op 0` with the board.
- **Turn.** Only the room owner can roll (`DungeonTurnFrame._refreshControlButton`, `M3/map/campaign/view/frame/dungeonturn/DungeonTurnFrame.as:304-324`): random roll (`rollNum 0`) or a chosen number when `selectCount > 0` (dice control). The server answers **4874** `op 1` to every member with the roll and the new position; clients animate the walk.
- **Fight.** When the token stops on a fight cell, **every client** calls `DungeoTurnManager.fight()` after 700 ms, which sends **5125** for that cell's node (`M3/map/campaign/view/frame/dungeonturn/TurnItemView.as:126-155`; `CM/managers/DungeoTurnManager.as:197-226`). The server runs one team battle (battleType 3878 `DUNGEON_TURN`) and then pushes **4874** `op 5` with the updated board.
- **End.** Beating the boss cell (13) or losing all HP ends the run. The server pushes **4874** `op 2` with the reward string; the reward frame opens when the players are back in the room. Claiming sends **9006** `op 3`; the answer is **4874** `op 3`. **4874** `op 4` refreshes the reward state at any time (room button "Ganhos").

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `DungeonTurnFrame` (`M3/map/campaign/view/frame/dungeonturn/DungeonTurnFrame.as`) | none; help "Descrição da Roleta da Masmorra" | Board | 4874 op 0, op 1 (members), op 5 when closed (`DungeoTurnManager.as:126-129, 135-138, 190-193`) | 14 cells (`TurnItemView`), dice (`DiceView`), roll button, dice control button with `selectCount` (:213), three progress bars "{n}/100" red, blue, green (:208-235), normal and boss box icons with counts ("{0} Baús de Prata da Masmorra", "{0} Baús de Ouro da Masmorra", big variants), member list with HP% ("Percentagem de vida restante: {0}%", `HeroItem`) |
| `TurnItemView` + `TurnItem` (`.../TurnItemView.as`, `.../TurnItem.as`) | none | Board cells | frame | cell 0 start, 4 and 8 "again" art, 12 "restart" art, 13 boss, other 9 cells from `posStatusMsg[0..8]`: energy color (`type`), "x{count}", buff icon for `additionType` 4 ("Se derrotar o chefão obterá uma oportunidade de avançar.") or 5 ("Se derrotar o chefão a vida será recuperada."), grey and not fightable when `status != 0` (:57-96) |
| `DiceControlView` (`.../DiceControlView.as`) | "Escolha o número" | Pick the die value | dice control button (owner, `selectCount > 0`) | 1..6 picker; confirm sends 9006 op 1 with the value (:65-71) |
| `RewardFrame` (`.../RewardFrame.as`) | "Ganhos obtidos" | Claim the chests | 4874 op 2 (deferred to `PVE_ROOM_SCENE`), room button (`RoomRightView._dungeoTurnGetHandler`, `M9/room/view/pve/RoomRightView.as:505-508`) | boss and normal box art (level 1/2) and counts; claim button enabled when `!hasGeted && hasReward && bossBoxNum != 0` (:97-105) |
| Room "Ganhos" button (`RoomRightView`, :191-192, 446-460) | tip "Obtém ganhos depois de completar a campanha." | Shortcut to the reward frame | room scene with 4202 selected | "({left}/{max})" weekly entries; disabled when `dungeoHasReward` is false |

## 3. Routes (client to server)

All requests use C>S **9006 (0x232e) C_DUNGEON_TURN_OP** with `dungeonturn.DungeonTurnOpMsg`; sender `DungeoTurnManager.sendDungeoTurnOperate(op, value)` (`CM/managers/DungeoTurnManager.as:228-239`), which sets `op (#1, ENUM)` and, for op 1 only, `rollNum (#3, INT32)`.

| op | Name (`DungeonTurnOp.as`) | UI control and caller | Client checks | Fields | Expected response |
|---|---|---|---|---|---|
| 0 | OPEN_TURN | dialog type 19 confirm -> `CampaignMapController.showFrame` (`M3/map/campaign/CampaignMapController.as:912-915`) -> `openTurn` (`DungeoTurnManager.as:241-244`) | none | `op 0` | **4874** op 0 with `dungeonTurnInfoMsg` to the requester (and op 1 style board to members *(assumption)*) |
| 1 | ROLL | roll button `DungeonTurnFrame._shakeIconButtonClickHandler` (:443-447, `rollNum 0`); dice control confirm `DiceControlView._selectIconButtonClickHandler` (:65-71, chosen value) -> `rollDice` (`DungeoTurnManager.as:246-251`) | owner only; not rolling; not fighting; control needs `selectCount > 0` | `op 1`, `rollNum (#3, INT32)` 0 = random, 1..6 = chosen | **4874** op 1 to all members: `rollNum` = rolled value, `dungeonTurnInfoMsg` with the new `curPos` and `selectCount`; op 1 **without** `dungeonTurnInfoMsg` means "no move" (enables dispose) |
| 2 | SHOW_REWARD | `getRewardInfo` (`DungeoTurnManager.as:253-256`), **no caller** | | `op 2` | 4874 op 2 |
| 3 | GET_REWARD | `RewardFrame._getRewardClickHandler` (:124-127) -> `obtainReward` (`DungeoTurnManager.as:258-261`) | button enabled rule above | `op 3` | grant boxes, **4874** op 3 `{hasGetReward true}`, `reward` omitted (closes the frame via `DUNGEO_GET_REWARD`) |
| fight | (5125) | `TurnItemView.goToNext` -> `DungeoTurnManager.fight` (`CM/managers/DungeoTurnManager.as:197-226`) | cell fightable; sent by every member | C>S **5125 (0x1405) U_C_CAMPAIGN_ARRIVE** `CampaignReqMsg{para_int1 = node id, para_bool1 true}`; node id = `beginNodeId (4202101) + i` for board cells 1, 2, 3, 5, 6, 7, 9, 10, 11 (i = 0..8), `endNodeId 4202110` on cell 13 (`CM/mvc/module/DungeoTurnModel.as:34-36`) | one battle 3878 for the team; after it **4874** op 5 |

## 4. Server messages (server to client)

**4874 (0x130a) U_C_DUNGEON_TURN_OP**, message `dungeonturn.DungeonTurnOpMsg`: `op (#1, ENUM DungeonTurnOp)`, `errorId (#2, ENUM ErrorId)` 0 SUCCESS, 1 FAILED, 2 HAS_GET (`CM/com/road/yishi/proto/dungeonturn/ErrorId.as`), `rollNum (#3, INT32)`, `reward (#4, STRING)` "templateId,count|...", `hasGetReward (#5, BOOL)`, `dungeonTurnInfoMsg (#6, DungeonTurnInfoMsg)`. `hasReward` read by the client is not a field: it is the protobuf presence of `reward` (#4) (`CM/com/road/yishi/proto/dungeonturn/DungeonTurnOpMsg.as:104-107`). Send `reward` (possibly "") when a reward exists, omit it otherwise.

Two receivers:
- `CampaignSocketManger.__dungeonTurnOpHandler` (`M3/map/campaign/CampaignSocketManger.as:409, 595-606`), buffered for `CAMPAIGN_MAP_SCENE`, calls `DungeoTurnManager.dungeoTurnop` (`CM/managers/DungeoTurnManager.as:104-195`) for ops 0, 1, 2, 5;
- `DungeoTurnManager._dungeoTurnopHandler` (`CM/managers/DungeoTurnManager.as:55-87`), always active, handles ops 3 and 4.

| op | Name | When | Client effect |
|---|---|---|---|
| 0 | OPEN_TURN | reply to 9006 op 0 | loads colors, cells, position, boxes, players, `selectCount`; opens the board if closed |
| 1 | ROLL | each roll, to all members | members (not the owner) open the board if closed; stores `rollNum`; `DUNGEO_TURN_ROLL` animates; without `dungeonTurnInfoMsg`: stop rolling |
| 2 | SHOW_REWARD | run ended | `reward` (its presence = `hasReward`), `hasGetReward`; reward frame queued for `PVE_ROOM_SCENE` |
| 3 | GET_REWARD | reply to 9006 op 3 | `hasGeted`, `hasReward` (presence of `reward`); `DUNGEO_GET_REWARD` closes the frame and disables the room button |
| 4 | UPDATE_REWARD | push (login, room entry *(assumption)*) | `reward`, `hasGetReward`; `playerInfo.dungeoHasReward = reward != ""` |
| 5 | UPDATE_TURN | after each board battle | board refresh, `DUNGEO_FINISH_FIGHT` (roll enabled again), level-up animations of the boxes |

`DungeonTurnInfoMsg`: `blue (#1, INT32)`, `red (#2, INT32)`, `green (#3, INT32)` energy bars 0..100; `bossBox (#4, INT32)` gold box count; `normalBox (#5, INT32)` silver box count; `selectCount (#6, INT32)` dice controls left; `curPos (#7, INT32)` board cell 0..13; `playerInfo (#8, PlayerInfoMsg, repeated)`; `posStatusMsg (#9, PosStatusMsg, repeated)` exactly 9 entries for cells 1, 2, 3, 5, 6, 7, 9, 10, 11.
`dungeonturn.PlayerInfoMsg`: `userId (#1, INT32)`, `nickName (#2, STRING)`, `hpPercent (#3, INT32)`, `headId (#4, INT32)`.
`PosStatusMsg`: `pos (#1, INT32)`, `type (#2, INT32)` energy color frame, `count (#3, INT32)` energy amount shown "x{count}", `additionType (#4, INT32)` 0 none / 4 extra roll / 5 heal, `additionPara (#5, INT32)`, `status (#6, INT32)` 0 alive / 1 beaten.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Board | 14 cells: 0 start, 4 and 8 "again", 12 "restart", 13 boss, 9 fight cells | `TurnItemView.as:57-96` |
| Cell to node id | fight cells i = 0..8 -> 4202101 + i; boss -> 4202110 | `DungeoTurnModel.as:34-36`; `DungeoTurnManager.getNodeId` (:206-226) |
| Who rolls | room owner only, not while rolling or fighting | `DungeonTurnFrame.as:304-324` |
| Dice control | `selectCount` uses left; picker 1..6 | `DiceControlView.as`; `DungeonTurnFrame.as:213, 315-322` |
| Energy | winning a cell adds its `count` to the bar of its `type`; each bar caps at 100 | help text `dungeoturn.helpFrame.helpContent`; `DungeonTurnFrame.as:208-216` |
| Bars | red >= 100: normal (silver) boxes doubled; green >= 100: normal box quality 2; blue >= 100: boss (gold) box quality 2 | `DungeoTurnModel.calcBox` (`CM/mvc/module/DungeoTurnModel.as:173-200`); bar tips `dungeoturn.Dungeonturn.*Tipdata` |
| Rewards | each won fight: 1 silver box; boss: gold boxes. Items 2060901 silver, 2060902 big silver, 2060911 gold, 2060912 big gold | help text; `DungeoTurnModel.calcReward` (:119-166) |
| Cell buffs | `additionType 4`: extra roll after the win ("Avanço"); 5: surviving members recover 50% HP ("recuperação") | help text; `TurnItem.as:62-96` |
| Loss | all players at 0 HP -> run lost | help text |
| Weekly gains | one rewarded run per week (`dungeoRestNum`, `dungeoTurnMaxNum` player fields) | `room.instanceRight.todayAlertText.dungeoturn`; `RoomRightView.as:446-452` |
| Entry | level 80..100, job transfer required, 1 to 4 players | `Campaigns.xml` 4202 |
| Battle | 3878 `DUNGEON_TURN`; the client has an empty special case | `CM/yishi/datas/battle/BattleType.as:182`; `docs/battle/rules.md` row 3878 |

## 6. Templates

| File | Use |
|---|---|
| `Campaigns.xml` row 4202 | entry rules, showcase items |
| `MapInfos.xml` 4202 | map |
| `ItemTempInfos` 2060901, 2060902, 2060911, 2060912 | reward chests (contents server side) |
| board content (cell colors, energy counts, buffs, enemies of nodes 4202101..4202110) | server data, not in the client *(assumption: author in `campaign.node_template` and a board table)* |

## 7. Persistent state (schema `campaign`)

```sql
CREATE TABLE campaign.dungeon_turn_run (
  instance_id   bigint   PRIMARY KEY REFERENCES campaign.instance(instance_id) ON DELETE CASCADE,
  owner_player_id integer NOT NULL REFERENCES player.players(player_id),
  cur_pos       smallint NOT NULL DEFAULT 0 CHECK (cur_pos BETWEEN 0 AND 13),
  red           smallint NOT NULL DEFAULT 0 CHECK (red BETWEEN 0 AND 100),
  green         smallint NOT NULL DEFAULT 0 CHECK (green BETWEEN 0 AND 100),
  blue          smallint NOT NULL DEFAULT 0 CHECK (blue BETWEEN 0 AND 100),
  normal_boxes  smallint NOT NULL DEFAULT 0 CHECK (normal_boxes >= 0),
  boss_boxes    smallint NOT NULL DEFAULT 0 CHECK (boss_boxes >= 0),
  select_count  smallint NOT NULL DEFAULT 0 CHECK (select_count >= 0),
  fighting      boolean  NOT NULL DEFAULT false,
  ended         boolean  NOT NULL DEFAULT false
);

CREATE TABLE campaign.dungeon_turn_cell (
  instance_id   bigint   NOT NULL REFERENCES campaign.dungeon_turn_run(instance_id) ON DELETE CASCADE,
  slot          smallint NOT NULL CHECK (slot BETWEEN 0 AND 8),
  energy_type   smallint NOT NULL,
  energy_count  smallint NOT NULL,
  addition_type smallint NOT NULL DEFAULT 0 CHECK (addition_type IN (0, 4, 5)),
  addition_para integer  NOT NULL DEFAULT 0,
  beaten        boolean  NOT NULL DEFAULT false,
  PRIMARY KEY (instance_id, slot)
);

CREATE TABLE campaign.dungeon_turn_member_hp (
  instance_id bigint  NOT NULL REFERENCES campaign.dungeon_turn_run(instance_id) ON DELETE CASCADE,
  player_id   integer NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  hp_percent  smallint NOT NULL DEFAULT 100 CHECK (hp_percent BETWEEN 0 AND 100),
  PRIMARY KEY (instance_id, player_id)
);

CREATE TABLE campaign.dungeon_turn_reward (
  player_id   integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  week_start  date     NOT NULL,
  reward      text     NOT NULL,
  claimed     boolean  NOT NULL DEFAULT false,
  created_at  timestamptz NOT NULL DEFAULT now(),
  claimed_at  timestamptz,
  PRIMARY KEY (player_id, week_start)
);
```

## 8. Backend implementation notes

| Handler | Opcode | Validation order | Effects |
|---|---|---|---|
| `campaign::dungeon_turn::handle_open` | 9006 op 0 | member of a 4202 instance | create the run if missing (roll 9 cells); reply 4874 op 0 with the board |
| `campaign::dungeon_turn::handle_roll` | 9006 op 1 | (1) room owner; (2) not fighting, not ended; (3) `rollNum` 0 or (1..6 and `select_count > 0`) | value = random 1..6 or `rollNum` (`select_count - 1`); move `cur_pos` (wrap after 13 *(assumption)*; cell 12 "restart" sends back to 0 *(assumption)*; cells 4/8 "again" give a free roll *(assumption)*); push 4874 op 1 with `rollNum` and board to all members |
| `campaign::dungeon_turn::handle_fight` | 5125 with node 4202101..4202110 | run exists; `cur_pos` cell is fightable; first request wins, duplicates from other members are ignored | `fighting = true`; start battle 3878 with all members against the cell enemies; HP from `dungeon_turn_member_hp` |
| `campaign::dungeon_turn::on_battle_end` | battle report | | win: mark the cell beaten, add energy, +1 silver box, apply `additionType` (extra roll: `select_count`? *(assumption)*, heal 50%); boss win: gold boxes, end; loss: HP to 0, end if all dead; push 4874 op 5; at end push 4874 op 2 with the reward string to members with weekly gains |
| `campaign::dungeon_turn::handle_claim` | 9006 op 3 | reward exists, not claimed (else `errorId 2`) | grant boxes per `calcBox` rules (doubling, quality); mark claimed; reply 4874 op 3 `{hasGetReward true}` with `reward` omitted (so `hasReward` is false) |
| `campaign::dungeon_turn::push_reward_state` | 4874 op 4 | login and room entry | `{reward (when any), hasGetReward}` |

- Box contents: `reward` string uses 2060901/2060902 for normal boxes and 2060911/2060912 for boss boxes with counts (`DungeoTurnModel.calcReward`).
- Weekly counter: `campaign.daily_entry` mode `dungeon_turn` with a weekly `period_start` ([rooms.md](rooms.md)).

## 9. Open questions and assumptions

1. Meaning of cells 4, 8 ("again") and 12 ("restart").
2. Energy color mapping of `PosStatusMsg.type` to red/green/blue.
3. Battle composition per cell and boss.
4. Whether an empty `reward` string with presence set was used to mean "reward claimed".
5. What `selectCount` starts at and how it is earned.

## 10. Implementation checklist

- [ ] Screens check: `DungeonTurnFrame`, `TurnItemView`, `DiceControlView`, `RewardFrame`, room "Ganhos" button
- [ ] Dialog 29 `type 19` on the 4202 start node
- [ ] 9006 ops 0, 1, 3 (2 optional)
- [ ] 4874 ops 0..5 encoder, two client receivers
- [ ] 5125 fight dedupe and battle 3878
- [ ] Box rules (red doubles, green/blue quality)
- [ ] Weekly gains counter
- [ ] Tables `dungeon_turn_run`, `dungeon_turn_cell`, `dungeon_turn_member_hp`, `dungeon_turn_reward`
- [ ] Test: owner rolls 3 from 0 -> all members receive op 1, token stops on cell 3 (slot 2), each client sends 5125 for 4202103, one battle starts, op 5 follows
