# Snow battle ("Batalha da Neve", 7th anniversary)

Module `artillery::snow_battle`. Citation prefixes: see [README.md](README.md).

## 1. Overview

Seasonal free-for-all snowball fight run inside the normal campaign map scene (`CAMPAIGN_MAP_SCENE`), campaign id `snow_vehicle_campaign_id = 3002`. Players queue from the 7th anniversary "Bandeira de Batalha" tab, up to `snow_vehicle_match_max = 8` per match (cross-server: every target carries a `serverName`). Each player becomes a snow vehicle (template 3202 "Homem de Gelo"); monsters (3201), a boss (3204) and towers (3205) are on the map. Rewards are "Pontos de Guerreiro" (item template `snow_vehicle_reward_template = -15000`), capped per day at `snow_vehicle_daily_reward_max = 600` (shared with [auto-chess](../auto-chess/README.md)).

Reachability in this build: `SevenYearSnowView` is never instantiated. The battle flag tab creates the style `SevenYearBattleFlagView.selfchessView` as `SevenYearSelfChessView` in the `_snowView` slot (`M11/sevenyear/view/SevenYearBattleFlagView.as:24-25,45-46`), so the anniversary UI starts auto-chess, not the snow battle. The only live entry is the space NPC dialog option 106, gated by the New Year module dates (`ConfigManager.info.NEW_YEAR_MODULE`, `NEW_YEAR_BEGIN_DATE`, `NEW_YEAR_END_DATE`), which sends 9587 without a body (`M3/map/space/view/frame/DialogOptionItem.as:698-708`). Treat the whole module as optional.

The client code is the campaign "active vehicle" layer (`M3/map/campaign/**ActiveVehicle*`, `M3/map/campaign/view/ui/snowball/**`), enabled when `mapId == ConfigInfoManager.getActiveVehicleCampaignId()` (`CM/yishi/utils/WorldBossHelper.as:481-484`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data |
|---|---|---|---|---|
| `sevenyear.view.battleflag.SevenYearSnowView` | (card) | Start/stop matchmaking, "n/8" counter, today's points "x/600" ("Hoje ainda pode recebe"), time to event end | 7th anniversary main frame, battle flag tab ([hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md)) | 200, `SevenYearModel.snowScore` (4987) |
| Campaign scene with `ActiveVehicle*` UI | | Map, own snow vehicle, skills bar (`ActiveVehicleBottomViewII`), team/rank (`SnowBallRankView`), top timer (`SnowTopView`), right view with "Voltar" | 125 with campaign 3002 | 4513, 4518, 183, 4474, 4520-4522 |
| `map.campaign.view.ui.snowball.SnowballReportFrame` (360x470) | Resolução da Batalha da Neve de inverno | End report | 201 | rank, damage, picks, eliminations, today's reward |
| `ActiveVehicleAccountFrame` (462x485) | Resultado da campanha do inverno | Legacy result frame | | |

## 3. Routes (client to server)

| # | Action | Sender | Client checks | Route and request | Response |
|---|---|---|---|---|---|
| S1 | Start matchmaking | "Começar emparelhamento" -> `SevenYearSnowView.__startSnowBallHandler` (`M11/sevenyear/view/battleflag/SevenYearSnowView.as:153-163`) -> `CampaignSocketOutManager.sendEnterSnowBallVehicle(1)` (`CM/map/campaign/CampaignSocketOutManager.as:174-180`) | 5 s throttle | C to S 9587 (0x2573) `C_JOIN_ACTIVE_VEHICLE`, `campaign.CampaignReqMsg` {`para_int1` (#1, INT32) = 1 join} | 200 to all queued players with `curNum`; when full, 125 (campaign 3002) |
| S2 | Stop matchmaking | "Parar emparelhamento" (`SevenYearSnowView.as:165-168`), also on view dispose while queued (`:180-187`) | none | 9587 `CampaignReqMsg` {`para_int1` = 0 cancel} | 200 with `curNum = 0` to the leaver (A) |
| S3 | NPC entry (live path) | space NPC dialog option 106 (`M3/map/space/view/frame/DialogOptionItem.as:698-708`) -> `sendEnterActiveVehicle` (`CampaignSocketOutManager.as:168-172`) | New Year module enabled and inside its dates, else "consortia.data.ConsortiaDemonInfo.unopenTip"; `SwitchPageHelp.checkScene()` | 9587 with empty body | treat as join (A) |
| S4 | Move | `PlayerWalkMediator` (`M3/map/campaign/mediator/hero/PlayerWalkMediator.as:98`) -> `sendSnowBallActiveVehicleArmyMove(userId, path, serverName)` (`CampaignSocketOutManager.as:249-278`) | active vehicle model exists, self | C to S 25218 (0x6282) `CR_SNOW_VEHICLE_MOVE`, `vehicle.VehicleMoveMsg` {`playerId` (#1), `path` (#3, Position, repeated), `serverName` (#4, STRING)} | 4519 broadcast |
| S5 | Cast skill | `ActiveVehicleCastAction` (`M3/map/campaign/action/ActiveVehicleCastAction.as:443`), `ActiveVehicleJumpCastAction` (`:145`) -> `sendSnowBallCastSkill` (`CampaignSocketOutManager.as:204-217`) | cooldown, uses, alive ("Você já morreu" `snowball.dieTip`) | C to S 25216 (0x6280) `CR_SNOW_VEHICLE_ATTACK`, `VehicleAttackReqMsg` {`skill_id` (#1), `suffererId` (#4, repeated), `effectX` (#5), `effectY` (#6), `suffererServerName` (#7, STRING, repeated, parallel to `suffererId`), `suffererNpcIdArray` (#8, INT32, repeated), `attack_server_name` (#9, STRING)} | 4520, 4522, 4521, 183 |
| S6 | Pick up | `ActiveVehiclePickupAction` (`M3/map/campaign/action/ActiveVehiclePickupAction.as:131`) -> `sendSnowBallActiveVehiclePickup(nodeId, serverName)` (`CampaignSocketOutManager.as:289-297`) | alive | C to S 25217 (0x6281) `CR_SNOW_VEHICLE_PICK`, `VehiclePickPropMsg` {`propNodeId` (#1), `serverName` (#3)} | 4474 node disposed, 4521 skill |
| S7 | Leave | "Voltar" confirm "Deseja sair da campanha do evento de inverno?" (`M3/map/campaign/view/ui/activevehicle/ActiveVehicleRightView.as:182-212`); bottom exit warns "Se sair da campanha não poderá receber pontos de guerreiro. Deseja sair?" (`ActiveVehicleBottomViewII.as:310`) | confirm | C to S 8610 (0x21a2) `C_VEHICLE_LEAVE_CAMPAIGN`, empty (`CampaignSocketOutManager.as:182-186`) | 4523; client returns to space after 500 ms |

The snow routes use their own sequence counter `_sendSnowByteCount` (`CampaignSocketOutManager.as:215,276,295`).

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Effect |
|---|---|---|---|---|
| 200 (0x00c8) `U_C_SNOW_VEHICLE_SYNC_NUM` | `vehicle.SnowVehicleSimpleInfoMsg` {`matchOrCancel` (#1, INT32), `curNum` (#2, INT32) players in queue, `userId` (#3), `groupId` (#4, STRING), `serverName` (#5)} | `SevenYearManager.__snowVehicleInfoHandler` (`CM/managers/SevenYearManager.as:76,88-95`) | each queue change | `snowTeamNum`; Start/Stop buttons and "n/8" |
| 125 `U_C_CAMPAIGN_CREATE` | `room.RoomCreatedMsg` with `room.campaignId = 3002` | `BaseManager.__createCampaignHandler` (`CM/yishi/manager/BaseManager.as:2530-2620`) | match formed | campaign scene; `CampaignManager` creates `ActiveVehicleModel` (`CM/map/campaign/CampaignManager.as:184`) |
| 4513 `U_C_VEHICLE_JOIN` | `PlayerVehicleListMsg` (uses `playerId`, `serverName`, `templateId`, `defaultSkills` (#23, STRING), `hp`, `maxHp` (#22), `isHoldKey` (#24), `buffState`, `team`, `x`, `y`, `rebornTime`; NPC rows: no `playerId`, `npcNodeId` (#16)) | `CampaignSocketManger.__activeVehicleJoinHandler` (`M3/map/campaign/CampaignSocketManger.as:397,2774-2859`) | enter, join, transform, revive | armies updated |
| 183 (0x00b7) `U_C_SNOW_ARM_LIST` | `PlayerVehicleListMsg` (same fields) | `__playersHpHandler` (`CampaignSocketManger.as:410,506-590`) | HP/buff sync after hits | HP bars, buffs |
| 4518 `U_C_VEHICLE_DETAILE` | `VehicleCampaignDetailMsg`: `campaignStartTime` (#13), `scroeList` with `playerId`, `server_name`, `nick_name`, `order`, `enterSeq`, `pickSkillCount` | `__activeCampaignInfoHandler` (`:399,2861-2897`) | score changes | rank list "ActiveFlushRank" sorted by `enterSeq` |
| 4519 `U_C_VEHICLE_MOVE` | `VehicleMoveMsg` | `__activeCampaignMoveHandler` (`:401,2972-2995`) | moves | paths |
| 4520, 4521, 4522, 4524, 4474 | as in [battle-scene.md](battle-scene.md) | `CampaignSocketManger.as:375-381` | combat | |
| 4523 `U_C_VEHICLE_EXIT` | `VehicleExitMsg` | `__activeVehicleExitHandler` (`:398,2899-2927`) | leave | self: exit campaign |
| 201 (0x00c9) `U_C_SNOW_VEHICLE_END_REWARD` | `vehicle.SnowVehicleEndRewardMsg` {`myRank` (#1, INT32), `isOnHook` (#2, BOOL) AFK flag, `pickSkillNum` (#3), `damage` (#4), `eliminateNum` (#5) snowmen pushed, `todayReward` (#6) points granted today} | `__activeCampaignEndHandler` (`:411,2929-2970`) | personal end (eliminated or match over) | exit campaign, then `SnowballReportFrame` (`M3/map/campaign/helper/CampaignFrameHelper.as:18-38`) |
| 4514 `U_C_VEHICLE_END` | listened by the same handler (`:400`) but parsed as `SnowVehicleEndRewardMsg` | same | do not send for 3002; use 201 (A) | |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Event window | `snow_vehicle_open_time` = `2020-03-26 00:00:00|2020-04-25 23:59:59` (the 7th anniversary event runs `seven_year_start_date`..`seven_year_stop_date` 2020-05-11..2020-06-08; dates must be reconfigured) | `TPL/ConfigInfos.xml` |
| Players per match | 8 (`snow_vehicle_match_max`) | `SevenYearSnowView.as:87` |
| Player template | 3202 Homem de Gelo (HP 30, speed 5, skills 2010 "Grande bola de neve" 2 dmg, 2011 dodge) | `snow_vehicle_template_id`, `TPL/VehicleObjectTempInfos.xml` |
| Monster / boss / tower | 3201 Monstro de Gelo, 3204 boss (HP 1000, skill 3013), 3205 tower (HP 2000, skill 3014) | ConfigInfos `snow_vehisnow_vehicle_monster_temp_id` (sic), `snow_vehicle_boss`, `snow_vehicle_tower` |
| Snow skills | 2001 Bola de Neve (1 dmg, CD 0.4 s), 2002-2006 picked skills, 2007 Acelerar, 2008 Recuperar, 2009 Escudo, 2012 transform (buff 105 -> template 3202, damage +1, speed halved) | `TPL/VehicleSkillTempInfos.xml`, `TPL/VehicleBuffTempInfos.xml` |
| Score | 1 point per 10 damage (floor); last hit on a player 10 points; each skill picked 10 points | `snowball.helpTxt` |
| Rewards | all in "Pontos de Guerreiro" (item -15000), daily cap 600; leaving = no reward | `snowball.helpTxt` items 4-6 |
| Rank reward | `snow_vehicle_order_reward` = rank,count: 1:80, 2:70, 3:60, 4:50, 5:40, 6:30, 7:20, 8:5 | ConfigInfos |
| Elimination reward | `snow_vehicle_kill_reward` = id,snowmen,count: 1:10, 2:40, 3:60, 4:80, 5:100, 6:120, 7:140 (by number of snowmen pushed) | ConfigInfos |
| Damage reward | `snow_vehicle_damage_reward` = damage,count: 1:1, 10:10, 20:20 ... 100:100 (threshold steps) | ConfigInfos |
| Pick reward | `snow_vehicle_pick_skill_reward` = picks,count: 1:10 ... 12:120 | ConfigInfos |

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `TPL/ConfigInfos.xml` | `snow_vehicle_*` keys listed above | |
| `TPL/VehicleObjectTempInfos.xml` | Type 11 rows 3201-3205, 5 | stats, skills |
| `TPL/VehicleSkillTempInfos.xml` | 2001-2012, 3013, 3014 | |
| `TPL/VehicleBuffTempInfos.xml` | 104, 105, 2003-2009 | |

## 7. Persistent state

```sql
CREATE TABLE artillery.snow_daily_points (
  player_id    BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day          DATE NOT NULL,
  points       INTEGER NOT NULL DEFAULT 0 CHECK (points >= 0),
  PRIMARY KEY (player_id, day)
);

CREATE TABLE artillery.snow_match_results (
  match_id       BIGINT NOT NULL,
  player_id      BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  server_name    TEXT NOT NULL,
  final_rank     SMALLINT NOT NULL,
  damage         INTEGER NOT NULL DEFAULT 0,
  eliminations   INTEGER NOT NULL DEFAULT 0,
  picks          INTEGER NOT NULL DEFAULT 0,
  on_hook        BOOLEAN NOT NULL DEFAULT false,
  points_granted INTEGER NOT NULL DEFAULT 0,
  finished_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (match_id, player_id)
);
```

The daily cap must be shared with the auto-chess "Pontos de Guerreiro" (same counter `SevenYearUserMsg.snowScore`, A). Keep one counter table in [hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md) if both modes are enabled.

## 8. Backend implementation notes

- `artillery::snow_battle::handle_join` (9587): `para_int1 = 1` join, `0` leave queue; check event window; broadcast 200 to the queue; at 8 create the match (cross-server matchmaker if available), send 125 with campaign 3002 to each player, then 4513 roster, 4474 nodes, 4518.
- `handle_move` (25218), `handle_attack` (25216), `handle_pick` (25217): same engine as [battle-scene.md](battle-scene.md) with players identified by `(playerId, serverName)`; HP updates via 183.
- `handle_leave` (8610): mark as quit (no rewards), 4523.
- End of a player: compute rewards from the four config tables, clamp to the remaining daily cap, grant item -15000 count, update `snow_daily_points`, send 201, push 4987 user info (anniversary event) so `snowScore` refreshes.
- AFK detection sets `isOnHook` and blocks rewards (A).

## 9. Open questions and assumptions

- (A) How the rank, damage, elimination and pick reward tables combine (sum, then cap).
- (A) Elimination rule ("推雪人", pushing snowmen) and when a player's match ends (single life vs time limit). `SnowTopView` uses `activeVehicleModel.overTime`.
- (A) `isOnHook` detection threshold.
- `SevenYearSnowView.snowStart.alert` ("Precisa ter uma Bandeira de Guerra...") is not used by the client code; `SevenYearModel.hasFlag` always returns true.

## 10. Implementation checklist

- [ ] Event switch and window.
- [ ] 9587 join/leave queue with 200 broadcast.
- [ ] Match creation, 125 (3002), roster 4513, nodes 4474, scores 4518.
- [ ] 25218 move, 25216 attack, 25217 pick with server names; 183 HP sync.
- [ ] 8610 leave without reward.
- [ ] End report 201 with rewards and daily cap.
- [ ] Tables `snow_daily_points`, `snow_match_results`.
- [ ] Tests: cap reached mid-match, leave before end, cross-server target ids.
