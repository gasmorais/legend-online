# Caça Fantástica (unreal shooting)

Feature [final-defense](README.md), module `unreal-shooting`.

Path aliases:

| Alias | Path |
|---|---|
| `USC` | `decompiled/core_module/scripts/mvc/controler/UnrealShootingController.as` |
| `USM` | `decompiled/core_module/scripts/map/campaign/data/UnrealShootingModel.as` |
| `USL` | `decompiled/m9/scripts/unrealshooting/` |
| `USH` | `decompiled/m3/scripts/map/campaign/view/ui/unrealshooting/` |
| `BM` | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| `MSO` | `decompiled/m3/scripts/map/net/MapSocketOuterManager.as` |

## 1. Overview

Help text (`unrealshooting.UnrealShootingFrame.helpContent`), summarized: a cross server 4v4 real time arena; opens twice a day; one participation per day; during the 4 minute matchmaking preparation window the player enters the preparation room; players are matched by combat power; fewer than 8 players in the room means no match; in the room each player picks a character whose attributes scale with his own; 8 players are split randomly into 2 teams (1 blue, 2 red); killing enemies and monsters and defending the tower gives points and "cristais fantásticos" (only usable in the match, exchanged for buffs); victory: destroy the enemy tower, else more points, else more tower life, else draw; rewards by points ranking.

- Schedule `unrealshooting_time` = `16:00,16:15|21:00,21:15`; preparation window from start - 5 min to start - 1 min (`USM:75-117`).
- Characters: `VehicleObjectTempInfos` Type 12 (`USM:10`): "Tifa", "Cloud", "Serah Farron", "Zack", "Ashe", "Tribal", each with 3 skills `NormalSkill`, `+1`, `+2` (`USL/room/UnrealShootingRoomBottomView.as:112-136`).
- Map: campaign map 5703 (`decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as:320-327`), using the campaign map scene and the vehicle real time protocol (skills, buffs, props).
- Buffs: `unreal_buffer` = `570303,1200|570304,1600|570305,1600|570306,1200|570307,2400` (buff template id, crystal cost).
- Weekly ranking ("Ranking da Caça Fantástica") with rewards `UnrealWeekRewards` ("Cristal de Ressonância" 6260002, "Pedra de Avanço de Brasões" 6260003) by order bracket, plus temporary mount and title.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `USL/UnrealShootingFrame.as`, `UnrealShootingView.as` | "Caça Fantástica" | Lobby: open and preparation times, join, ranking, help | top toolbar `unrealshooting` (controller default type) | times from `USM`, join enabled during preparation (`shineUnrealShootingBtn`) (`UnrealShootingView.as:221-283`) |
| `USL/room/UnrealShootingRoomView.as` and Top/Left/Right/Bottom views | "ID", "Nome", "Personagem" | Preparation room scene `UNREAL_SHOOTING_ROOM`: character list, members list, countdown, confirm | 4829 `param1 = 1` (`USC:162-203`) | `playerList`, `leftTime`, `isLocked` |
| `decompiled/m3/scripts/map/campaign/mediator/unrealshooting/*.as`, `USH/UnrealShootingTopBar.as`, `BottomBar`, `BufferBar`, `BufferBuyView`, `SortTopView`, `MiniMapView`, `DownTimeView` | "Vida Azul:{0}", "Vida Vermelha:{0}", "Nº de cristais fantásticos possuídos:", "Minha Formação:", "Meus pontos:" | In match HUD on map 5703: skills, target selection, buff shop, live ranking, minimap | campaign map scene | `rankDetailList`, `teamScoreBlue/Red`, `selfPoint`, `selfScore` |
| `USH/UnrealShootingGameOverFrame.as`, `UnrealShootingGameOverItem.as` | "Ranking de Pontos da Caça Fantástica": "Rank", "Nome", "Servidor", "Pontos", "Poder de Combate", "Jogadores Derrotados", "Offline" | Final report | 4834 -> controller type 2 (`BM:721-805`) | report list, rewards |
| `USL/ranklists/UnrealShootingRankListFrame.as`, `UnrealShootingRankView.as`, `UnrealShootingRewardView.as` | "Ranking da Caça Fantástica", "Lugares {0}-{1}:", "Abaixo do {0}º lugar:", "Montaria Temporária", "Título Temporário", "{0} pontos atingidos:" | Weekly ranking (10 per page) and reward brackets | lobby rank button (controller type 1); sends op 5 (`UnrealShootingRankView.as:61`) | `finalOrderList`, `myRankInfo` |

## 3. Routes (client to server)

### 9662 (0x25be) `C_UNREAL_SHOOTING_OP`

Protobuf `PropertyMsg` of package `simple` (`decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as`; `protocol/proto.json` keys this name to `army.PropertyMsg`, which is a different message): `param1` (#1, INT32), `param2` (#2, INT32), `param3` (#3, INT32), `param4..param6` (#4..#6, STRING), `param7..param9` (#7..#9, BOOL), `param10`, `param11` (#10, #11, INT32), `param12` (#12, STRING). Only `param1` (op) and `param2` are used. Senders `USC:340-389`.

| op | Constant | UI | Client checks | Expected reply |
|---|---|---|---|---|
| 1 | `C_ENTER` | lobby "Participar" (`UnrealShootingView.as:221-234`) | `shineUnrealShootingBtn` (preparation phase) else "Não é tempo de preparação para emparelhamento." | 4829 `param1 = 1` -> room scene; server refuses when already played today ("Já participou da Caça Fantástica hoje. Volte amanhã.", `MAX_ENTERCOUNT = 1`) |
| 2 | `C_SELECT_TEMPLATE` | never sent (selection is client side, `USL/room/UnrealShootingRoomLeftView.as:101-118`) | - | - |
| 3 | `C_CONFIRM_TEMPLATE` | room confirm button (`UnrealShootingRoomBottomView.as:97`) or automatically at 5 s left (`UnrealShootingRoomTopView.as:103-108`); `param2` = vehicle template id | not `isLocked` | 4829 with the member `param1 = 1` (locked) |
| 4 | `C_BUY_BUFF` | buff shop (`USH/UnrealShootingBufferBuyItem.as:110-140`); `param2` = buff template id | `selfPoint >= cost` else "Cristais fantásticos insuficientes. Não é possível trocar."; confirm "Confirma que deseja trocar {0} cristais fantásticos por {1}" | 4828 (crystals), buff sync through the vehicle buff push (owner [artillery](../artillery/README.md)) |
| 5 | `C_WEEK_ORDER` | ranking frame (`UnrealShootingRankView.as:61`) | - | 4835 |
| 6 | `C_LEAVE_MATCH` | HUD exit in the room (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1969`) | - | 4829 `param1 = 3` -> back to space |

### 25202 (0x6272) `CR_UNREAL_ATTACK`

- Sender `MSO.sendCastSkillUnrealShooting` (`MSO:222-235`) from `decompiled/m3/scripts/map/campaign/action/UnrealShootingCastAction.as:451` and `UnrealShootingJumpCastAction.as:145`.
- Message `VehicleAttackReqMsg` (package `vehicle`): `skill_id` (#1, INT32); `attack_type` (#2, INT32) unused; `sufferer_npc_id` (#3, INT32) unused; `suffererId` (#4, INT32, repeated) target player ids; `effectX` (#5), `effectY` (#6) (INT32) skill target point; `suffererServerName` (#7, STRING, repeated) target servers; `suffererNpcIdArray` (#8, INT32, repeated) target npc/tower node ids; `attack_server_name` (#9, STRING) attacker server.
- Server: validate skill cooldown and range; apply damage; update scores, kills, crystals; broadcast results (vehicle protocol pushes) and 4830.

### 25203 (0x6273) `CR_UNREAL_PICK`

- Sender `MSO.sendPickupUnrealShooting` (`MSO:237-244`) from `decompiled/m3/scripts/map/campaign/action/UnrealShootingPickupAction.as:132`.
- Message `VehiclePickPropMsg`: `propNodeId` (#1, INT32) prop node; `playerId` (#2) unused; `serverName` (#3, STRING).
- Server: prop exists and near; grant crystals or effect; remove node (campaign node update).

## 4. Server messages (server to client)

All use `UnrealShootingMsg` (package `unrealshooting`): `gameState` (#1, INT32); `leftTime` (#2, INT32) seconds; `score` (#3, INT32); `week_score` (#4, INT32); `enterCount` (#5, INT32); `list` (#6, MESSAGE `UnrealShootingPlayerMsg`, repeated); `param1` (#7, INT32); `param2` (#8, INT32); `param3` (#9, STRING); `param4` (#10, STRING); `server_name` (#11, STRING); `user_id` (#12, INT32).
`UnrealShootingPlayerMsg`: `serverName` (#1, STRING); `userId` (#2, INT32); `nickName` (#3, STRING); `score` (#4, INT32); `rank` (#5, INT32); `uuid` (#6, STRING); `fightPower` (#7, INT32); `template_id` (#8, INT32) chosen character; `killNum` (#9, INT32); `param1` (#10, INT32) per opcode; `team` (#11, INT32) 1 blue, 2 red; `item_count` (#12, INT32) crystals; `is_on_hook` (#13, BOOL) offline.

| Opcode | Name | Fields read | Receiver | When |
|---|---|---|---|---|
| 4836 (0x12e4) | `U_C_UNREAL_ACTIVE_STATE` | `gameState` 0 closed, 1 matching (button shown and shining, toolbar state 2), 2 playing (shown), 3 show; `enterCount` | `USC.__unrealActiveStateHandler` (`USC:129-160`) | login and every phase change, broadcast |
| 4829 (0x12dd) | `U_C_UNREAL_MAIN_INFO` | `leftTime`; `param1` 1 enter room scene, 3 return to space; `list` room members (`userId`, `nickName`, `serverName`, `rank`, `template_id`, `param1` 1 = confirmed/locked) | `USC.__unrealMainInfoHandler` (`USC:162-203`) | reply to op 1, 3, 6; room changes |
| 4828 (0x12dc) | `U_C_UNREAL_SHOOTING_INFO` | `param1` own crystals, `score`, `leftTime`, `list` (`score`, `killNum`, `team`, `item_count`) | `USC.__unrealShootingInfoHandler` (`USC:205-235`) | match start and after buff purchase |
| 4830 (0x12de) | `U_C_UPDATE_UNREAL_SCORE` | `list` (`score`, `killNum`, `team`, `item_count`); team totals computed client side | `USC.__updateUnrealScoreHandler` (`USC:237-275`) | after every scoring event |
| 4833 (0x12e1) | `U_C_VEHICLE_UNREAL_SYNC_SKILL` | `VehicleSkillListMsg` `skillId`, `state`, `curSum` (vehicle package) | `decompiled/m3/scripts/map/campaign/CampaignSocketManger.as:2360-2366` | skill cooldown/charges sync |
| 4834 (0x12e2) | `U_C_UNREAL_REPORT` | `gameState` -1 abnormal end (return to space); `list` full result (`rank`, `score`, `fightPower`, `template_id`, `killNum`, `param1`, `team`, `item_count`, `is_on_hook`); `param3` rewards `"...|..."` | `BM.__unrealShootingReportHandler` (`BM:721-805`), buffered until the return scene | match end |
| 4835 (0x12e3) | `U_C_UNREAL_WEEK_ORDER` | own row: `user_id`, `param4` nick, `param3` server, `param1` rank, `param2` fight power, `score`; `list` (`uuid`, `userId`, `rank`, `nickName`, `serverName`, `score`, `fightPower`) | `USC.__weekOrderHandler` (`USC:277-307`) | reply to op 5 |

## 5. Rules and formulas

- Daily entries: 1 (`MAX_ENTERCOUNT`).
- Minimum 8 players per match; 2 teams of 4; teams assigned randomly; matching by combat power.
- Victory order: tower destroyed > team points > tower life > draw.
- Buff costs from `unreal_buffer`; crystals reset per match.
- Weekly rewards (`UnrealWeekRewards.xml`, `Order` brackets 0, 1, 2, 3, 10, 50, 100): 6260002 x 70/60/55/50/40/30/25 and 6260003 x 140/120/110/100/... by rank bracket; extra "3000 pontos atingidos" reward line (`UnrealShootingRewardView.as:87-90`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/VehicleObjectTempInfos.xml` | Type 12 rows 570310, 570311, 570320, 570321, 570330, 570331 | `TemplateName`, `NormalSkill`, `Avatar`, `Speed` |
| `raw/xml/tempinfos/VehicleSkillTempInfos.xml`, `VehicleBuffTempInfos.xml` | skills 5707xx..5712xx, buffs 570303..570307 | skill and buff definitions (owner [artillery](../artillery/README.md)) |
| `raw/xml/tempinfos/UnrealWeekRewards.xml` | 14 rows | `TemplateId`, `Count`, `Order` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `unrealshooting_time`, `unreal_buffer` | schedule, buffs |

## 7. Persistent state

```sql
CREATE TABLE final_defense.unreal_player (
  player_id            BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  day                  DATE        NOT NULL,
  enter_count          SMALLINT    NOT NULL DEFAULT 0 CHECK (enter_count BETWEEN 0 AND 1),
  week_start           DATE        NOT NULL,
  week_score           INTEGER     NOT NULL DEFAULT 0 CHECK (week_score >= 0)
);
CREATE INDEX unreal_week_score_idx ON final_defense.unreal_player (week_start, week_score DESC);

CREATE TABLE final_defense.unreal_match (
  match_id             BIGSERIAL   PRIMARY KEY,
  started_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  ended_at             TIMESTAMPTZ,
  winner_team          SMALLINT    CHECK (winner_team IN (0, 1, 2))
);

CREATE TABLE final_defense.unreal_match_player (
  match_id             BIGINT      NOT NULL REFERENCES final_defense.unreal_match(match_id) ON DELETE CASCADE,
  server_name          TEXT        NOT NULL,
  user_id              INTEGER     NOT NULL,
  team                 SMALLINT    NOT NULL CHECK (team IN (1, 2)),
  vehicle_template_id  INTEGER     NOT NULL,
  score                INTEGER     NOT NULL DEFAULT 0,
  kills                INTEGER     NOT NULL DEFAULT 0,
  rank                 SMALLINT,
  PRIMARY KEY (match_id, server_name, user_id)
);
```

Cross server players are keyed by `(server_name, user_id)`; local players also map to `player.players`.

## 8. Backend implementation notes

- Scheduler: phase transitions per `unrealshooting_time` broadcast 4836 to all online players (state 1 at start - 5 min, state 2 at start, 0 at end).
- `final_defense::unreal_shooting::handle_op` (9662): op 1 queue the player into a preparation room (8 per room by power), consume the daily entry when the match starts (assumption); op 3 lock character; op 4 buy buff; op 5 weekly ranking; op 6 leave room.
- Match start (room full and countdown over): create `unreal_match`, assign teams, move players to campaign map 5703 with their vehicle character (vehicle stats derived from the hero, "atributos ... influenciados pelos atributos pessoais"), push 4828.
- `final_defense::unreal_shooting::handle_attack` (25202) and `handle_pick` (25203) run on the real time map loop shared with [artillery](../artillery/README.md) and [campaign](../campaign/README.md) (positions, buffs 4833 etc.).
- End: compute winner, push 4834 to every participant, mail rewards by points rank, add to `week_score`.
- Weekly job: rank `week_score`, mail `UnrealWeekRewards` brackets, temporary mount and title, reset.

## 9. Open questions and assumptions

- The real time map rules (tower HP, monsters, crystal drops, points per kill) are not in client templates.
- Cross server topology (the `CR_` opcodes go to a cross server); a single server implementation can treat `server_name` as constant.
- Match reward table (4834 `param3`) and whether the entry is consumed on join or on match start.

## 10. Implementation checklist

- [ ] Screen: lobby, room scene, in match HUD, game over, ranking
- [ ] Route 9662 op 1 enter
- [ ] Route 9662 op 3 confirm character
- [ ] Route 9662 op 4 buy buff
- [ ] Route 9662 op 5 weekly ranking
- [ ] Route 9662 op 6 leave
- [ ] Route 25202 attack
- [ ] Route 25203 pick
- [ ] Server messages 4836, 4829, 4828, 4830, 4833, 4834, 4835
- [ ] Tables `final_defense.unreal_player`, `unreal_match`, `unreal_match_player`
- [ ] Scheduler for phases
- [ ] Weekly reward job
- [ ] Test: second entry on the same day refused

## Screens

- `UnrealShootingRoomController` (`decompiled/core_module/scripts/mvc/controler/UnrealShootingRoomController.as`) is the MVC controller of the unreal shooting room scene; it owns the scene setup and the daily entry used by this mode.
