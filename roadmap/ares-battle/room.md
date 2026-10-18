# Ares battle: fight room, turns and matches

Module `ares_battle::room`. Prefixes as in [README.md](README.md).

## 1. Overview

During the fight window a signed player presses "start" in the Start frame. The server places the player in a one seat campaign room of type 9 and the client switches to scene `ARESLORDS_ROOM`. The room is a waiting area: the server drives a turn loop (`currentTurn` of `maxTurnCount`, countdown `leftTime` seconds), and at every turn it pairs waiting players and starts battle type 3859 `CROSS_ARESLORDS_BATTLE`. After each battle the client returns to the room (`BattleManager.preScene = "ARESLORDS_ROOM"`, `CM/managers/RoomManager.as:89-92`) and receives a fresh 370. The room shows the group ranking (left), the turn and countdown (top), the score, remaining turns and the current skill set with a reroll button (right).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| scene `mvc.controler.AresLordsRoomController` (`ARESLORDS_ROOM`) | | hosts `areslordsroom.AresLordsRoomView`; if `RoomManager.exit` is set it returns to space after 1.2 s | `BaseManager.__createRoomHandler` when `RoomMsg.roomType == 9` (`CM/yishi/manager/BaseManager.as:2636-2677`; `CM/mvc/controler/AresLordsRoomController.as:42-52`; `CM/yishi/scene/SceneCreate.as:75-76`) | |
| `areslords.room.AresLordsRoomView` | | composes the 4 panels, refreshes on `INFO_UPDATE` (370) and `SKILL_INFO` (372) | scene | `AresLordsModel.roomInfo` (`M9/areslords/room/AresLordsRoomView.as:34-133`) |
| `areslords.room.AresLordsRoomBackView` | | background and the single player seat (`PLAYER_COUNT = 1`) with the own avatar from room member data | room view | `RoomInfo` players from 120 (`M9/areslords/room/AresLordsRoomBackView.as:20,119-159`) |
| `areslords.room.AresLordsRoomTopView` | | edition image (`season`), round (`warIndex`), turn "{n}/{max}", per second countdown from `leftTime`; when `currentTurn >= maxTurnCount` shows the "finished" title | room view | `M9/areslords/room/AresLordsRoomTopView.as:77-105` |
| `areslords.room.AresLordsRoomLeftView` | | ranking of one group per tab (prev/next), "O meu rank:" "{0} {1}º lugar" or "Sem rank", "Pontos:" | room view | `rankList` filtered by `teamType`, sorted by `rankOrder` (`M9/areslords/room/AresLordsRoomLeftView.as:149-238`) |
| `areslords.room.AresLordsRoomRightView` (224 wide) | | score, remaining turns `maxTurnCount - currentTurn`, skill icons with counts, "Chances grátis: {0}/3" or "Consumir {0} diamantes para alterar", buttons "Todas as habilidades" and change | room view | `skillInfo` (`M9/areslords/room/AresLordsRoomRightView.as:141-225`) |
| `areslords.AresLordsSkillFrame` | | catalog of every skill of MasterType 301, 3 per row | controller `areslords` openType 4 from "Todas as habilidades" | `TPL/SkillTempInfos.xml` (`M9/areslords/AresLordsSkillFrame.as:70-99`) |

## 3. Routes (client to server)

Request opcode 9615 `C_ARES_CLIENT_OP`, body `AresLordsListMsg` (fields in [signup.md](signup.md) section 3).

| # | Action | UI control | Client sender | Client checks | Request | Responses (in order) |
|---|---|---|---|---|---|---|
| R1 | Enter the room | Start frame `_startBtn` | `AresLordsStartFrame.__startBtnClickHandler` (`M9/areslords/AresLordsStartFrame.as:237-247`) -> `AresLordsManager.requestEnterRoom` (`CM/yishi/manager/AresLordsManager.as:95-111`) | 3000 ms click throttle; `isOpen` else tip `areslords.Error.str01` "Batalha de Ares ainda não começou"; `isSign` else `areslords.Error.str02` "Não se inscreveu da Batalha de Ares" | `{op:5}` | 12 `U_C_CAMPAIGN_ROOM_CREATE` (`RoomMsg` with `roomType = 9`, `capacity = 1`), 120 `U_C_CAMPAIGN_ROOM_MEMBER` (own `RoomPlayerMsg`), 370 `U_C_ARESINFO`, 372 `U_C_ARES_SKILL_INFO` |
| R2 | Reroll skills | right panel change button | `AresLordsRoomRightView.__changeBtnClickHandler` -> `conformChange` -> `AresLordsManager.requestRefreshSkill` (`M9/areslords/room/AresLordsRoomRightView.as:179-225`; `AresLordsManager.as:113-119`) | 3000 ms throttle (reset when 372 arrives); if `freeCount == 0`: diamonds `playerInfo.point >= Ares_Skill` (20) else recharge prompt, then confirmation `areslords.Dialog.changeSkill` "Deseja consumir {0} diamantes para alterar habilidades?"; with free count no confirmation | `{op:3}` | 372 with the new set and `freeCount`; diamond update push of the player resource module |
| R3 | Show all skills | "Todas as habilidades" | `__allSkillBtnClickHandler` (`:174-177`) | none | none (openType 4, templates) | none |
| R4 | Leave the room | main toolbar exit button in `ARESLORDS_ROOM` | `MainToolBar` exit switch (`CM/ui/maintoolbar/MainToolBar.as:1634-1638`) -> `exitAreslordsRoom` (`:1956-1962`) -> `CampaignSocketOutManager.sendReturnCampaignRoom` (`CM/map/campaign/CampaignSocketOutManager.as:68-82`) | confirmation `ui.maintoolbar.MainToolBar.exitAresLordsRoom` "Deseja sair da Batalha de Ares?"; client clears the room ranking and skills | C to S 5025 (0x13A1) `U_C_CAMPAIGN_ROOM_EXIT`, `RoomExitMsg` `msg` (#1, STRING) = "" | 15 `U_C_CAMPAIGN_ROOM_EXIT` `RoomExitRspMsg` with own `playerId` (client sets `RoomManager.exit` and returns to space, `CM/managers/RoomManager.as:467-494`) |

## 4. Server messages (server to client)

### 370 (0x0172) `U_C_ARESINFO`, `AresLordsListMsg`

Receiver `AresLordsManager.__aresLordsMainInfoHandler` (`AresLordsManager.as:170-177`) -> `resovleRoomInfo` (`:336-363`), then event `INFO_UPDATE` (room refresh). Fields read: the base fields of 371 plus `season`, `warIndex`, `currentTurn`, `maxTurnCount`, `totalScore`, `teamType`, `order` (copied unconditionally, so always send them), `leftTime` (#9, seconds until the next turn starts, drives the top countdown), `info` (ranking rows, all groups; the left panel filters by group).

When: after R1, at the start of every turn (new `currentTurn`, `leftTime`), after every battle result (new score, ranking), and when the last turn ends (`currentTurn = maxTurnCount`, top view shows the end title).

### 372 (0x0174) `U_C_ARES_SKILL_INFO`, `AresSkillListMsg`

Receiver `__aresLordsSkillInfoHandler` (`:199-206`) -> `resovleSkillInfo` (`:365-384`), event `SKILL_INFO`.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `info` | 1 | `AresSkillInfoMsg`, repeated | `skillTempId` (#1, INT32, skill of MasterType 301), `skillCount` (#2, INT32, uses available in battle) |
| `freeCount` | 2 | INT32 | free rerolls left (client text "/3") |

When: after R1 and after every R2; after a battle when counts were consumed (A).

### Room messages owned by [campaign](../campaign/README.md)

- 12 `U_C_CAMPAIGN_ROOM_CREATE`, `room.RoomMsg`: `roomId` (#1), `campaignId` (#2), `masterId` (#3), `name` (#4), `count` (#5), `capacity` (#6), `roomState` (#7), `roomType` (#8, must be 9), `isSetPassword` (#9), `masterServerName` (#10), `masterName` (#11), `masterScore` (#12). Receiver `BaseManager.__createRoomHandler` (`BaseManager.as:295,2636-2677`).
- 120 `U_C_CAMPAIGN_ROOM_MEMBER`, `RoomPlayerListMsg` (`state` #1, `roomPlayer` #2 repeated `RoomPlayerMsg`, avatar and hero fields); receiver `RoomManager.__roomMemberHandler` (`CM/managers/RoomManager.as:184-196`).
- 15 `U_C_CAMPAIGN_ROOM_EXIT`, `RoomExitRspMsg` (`playerId` #1, `exitType` #2, `param1` #3).

### Battle

Standard battle start sequence of the battle engine with `battle_type = 3859`. `BattleModel.isAresLords()` (`CM/yishi/datas/BattleModel.as:1050-1053`) makes the skill bar show the hero `trialProps` (the Ares skills with counts) instead of normal skills (`CM/battle/view/ui/SkillItemListView.as:96-130`). After the result the client returns to `ARESLORDS_ROOM` (preScene).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| R1 | Room entry only while `isOpen` and `isSign`; server repeats both checks | `AresLordsManager.as:97-106` |
| R2 | Room is a campaign room of `roomType` 9, capacity 1 | `BaseManager.as:2674-2677`; `AresLordsRoomBackView.as:20` |
| R3 | Turn loop: `maxTurnCount` turns inside `Ares_Time` (20:00 to 21:00); `leftTime` counts down to the next pairing. (A) Turn length = window / `maxTurnCount`; players in battle at turn start skip that pairing | `AresLordsRoomTopView.as:77-105`; config |
| R4 | Pairing (A): players present in the room, same or nearest group, then nearest score; odd player gets a bye (no battle, no score) | not in the client |
| R5 | Skill set: random skills from MasterType 301 (12 skills 41302001..41302012, e.g. "Refúgio de Marte" immune 1 turn, "Refluxo de Vida" heal 50%) each with `skillCount` uses, shown as trial props in battle | `TPL/SkillTempInfos.xml`; `SkillItemListView.as:96` |
| R6 | Reroll: 3 free per fight day ("Chances grátis: {0}/3"); afterwards `Ares_Skill` = 20 diamonds each | `areslords.Room.Right.str01/02`; `ConfigInfoManager.as:512-515` |
| R7 | Score per battle: win adds, loss subtracts (`AresLordsInfoMsg.addScore`, `descScore`, `result`). (A) Values are server side, no config key in the client | proto only |
| R8 | Leaving the room does not cancel the signup (A); re-entering sends op 5 again | |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `TPL/SkillTempInfos.xml` MasterType 301 | Ares battle skills | `TemplateId`, `TemplateName`, `Icons`, `Description`, `UseWay`, `BufferIds` (battle effect) |
| `TPL/ConfigInfos.xml` | `Ares_Skill` 20, `Ares_Time` | |

## 7. Persistent state

Schema `ares_battle`. Room membership and turn state are in memory (A); persisted only what survives a restart.

```sql
CREATE TABLE ares_battle.skill_set (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id),
  edition_id      integer NOT NULL,
  round_no        smallint NOT NULL,
  free_rerolls    smallint NOT NULL DEFAULT 3 CHECK (free_rerolls BETWEEN 0 AND 3),
  skills          jsonb NOT NULL,                      -- [{skill_template_id, count}]
  updated_at      timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE ares_battle.match (
  match_id        bigserial PRIMARY KEY,
  edition_id      integer NOT NULL,
  round_no        smallint NOT NULL,
  turn_no         smallint NOT NULL,
  attacker_id     integer NOT NULL REFERENCES player.players(player_id),
  defender_id     integer REFERENCES player.players(player_id),   -- null = bye
  winner_id       integer REFERENCES player.players(player_id),
  attacker_score_delta integer NOT NULL DEFAULT 0,
  defender_score_delta integer NOT NULL DEFAULT 0,
  battle_id       text,
  fought_at       timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX ON ares_battle.match (edition_id, round_no, turn_no);
CREATE INDEX ON ares_battle.match (attacker_id);
CREATE INDEX ON ares_battle.match (defender_id);
```

## 8. Backend implementation notes

- `ares_battle::room::handle_enter_room` (9615 op 5): validate open window, signup row, player not already in a room or battle; create (or reuse) the player's room with `roomType 9`; send 12, 120, 370, 372 in this order (12 switches the scene; 370/372 arriving before the scene exists are kept in the model and rendered on scene creation).
- `ares_battle::room::handle_refresh_skill` (9615 op 3): validate in room and not in battle; if `free_rerolls > 0` decrement, else debit 20 diamonds (transaction); draw a new random set from MasterType 301; persist `skill_set`; send 372 and the diamond update.
- Exit uses the shared room handler for 5025: remove the player from the Ares pool, send 15.
- Turn scheduler (one per fight window, cross server): at each turn start increment `current_turn`, push 370 with `leftTime` to all room members; pair and start battles of type 3859 (map: A, the PvP arena map of the trial modes), each hero carries the Ares skill set as `trialProps`; on result update scores ([ranking.md](ranking.md)), insert `match`, push 370 to both players. When `current_turn == max_turns` push the final 370 and close.
- Battle config: `battle_type 3859`, two player heroes with their real formation and soldiers (A), automatic mode not forced.

## 9. Open questions and assumptions

- (A) Pairing algorithm, turn length, bye handling.
- (A) Initial number of skills and counts per set; whether used counts persist between battles of the same day.
- (A) Whether 372 is pushed after every battle.
- Map id of battle 3859 is not visible in the client.

## 10. Implementation checklist

- [ ] Scene `ARESLORDS_ROOM` entry via 12 `roomType 9`
- [ ] 9615 op 5 with checks, 12 + 120 + 370 + 372
- [ ] 9615 op 3 reroll (free then diamonds) -> 372
- [ ] 5025 exit -> 15
- [ ] Turn scheduler with 370 pushes and `leftTime`
- [ ] Pairing and battle 3859 with trial props
- [ ] Tables `skill_set`, `match`
- [ ] Tests: enter refused when closed or not signed; reroll free count; diamond shortage; final turn view
