# Glory supremacy matches, schedule and rewards

Module `glory_supremacy::matches`. Citation prefixes: see [README.md](README.md).

## 1. Overview

Matches run on consecutive Saturdays from the anniversary start. Registered team members open the sign tab and press "Entrar" to join their team's room (`roomType = 15`, scene `GLORY_GAME_SCENE`). At the scheduled time the server pairs teams for the current turn and starts team battles (type 3891). Between turns the room shows the stage, turn, score (qualifier) or wins (other stages) and the next match time. The calendar tab lists every pairing with scores.

Stages: 1 "Eleição Marinha" qualifier (15 turns, points), 2 group stage (16 teams, groups, 3 turns, wins/losses), 3 quarter-finals, 4 semi-finals, 5 final (best of three: "Vitória decisiva" / "Melhor de três"), 6 ended.

## 2. Screens

| Class | pt-BR | Purpose | Data |
|---|---|---|---|
| `gloryGame.SevenYearGloryGameScheduleView` + `ScheduleData1` (qualifier) / `ScheduleData2` (groups, knockouts) | Calendário, "Equipe {0}", "{0}°lugar", "{1}°lugar Grupo {0}", "Vencedor n°{0}", "Vencedor" | Bracket and results (`M11/sevenyear/view/gloryGame/SevenYearGloryGameScheduleView.as:60-100`) | 4992 `allSchedule` |
| `mvc.controler.GloryGameRoomController` (scene `GLORY_GAME_SCENE`) with `gloryGame.GloryGameRoomView` | room exit hint "No momento você está na sala da Supremacia da Glória. Deseja sair?" | Room: `GloryGameRoomBackView` (slots and `placesState`), `GloryGameRoomPlayerView` (members), `GloryGameRoomTopView` (stage and "turn/total"), `GloryGameRoomRightView` (score in stage 1, wins later) (`M9/gloryGame/*.as`) | 12, 120, 17, 4993 |

`GloryGameRoomController.enter` returns to space with `isOpenPveRoomList` if `RoomManager.exit` is set (`CM/mvc/controler/GloryGameRoomController.as:20-33`).

## 3. Routes (client to server)

| Action | Sender | Client checks | Request | Response |
|---|---|---|---|---|
| Enter room | sign view "Entrar" -> `GGM.sendEnterRoom` (`M11/sevenyear/view/gloryGame/SevenYearGloryGameSignView.as:280-283`, `GGM:374-380`) | none client-side; "No momento não há tempo de partida" (`SevenYearGloryGame.enter.timeHint`) is the expected server refusal text | 9694 `PropertyMsg` {`param1` = 3 ROOM_ENTER} | 12 `RoomMsg` (`room_type = 15`), 120 members, 17 slots, 4993 |
| Leave room | MainToolBar exit in `GLORY_GAME_SCENE` -> confirm -> `exitGloryGame` (`CM/ui/maintoolbar/MainToolBar.as:1725-1729,1806-1813`) | confirm | 5025 (0x13a1) `U_C_CAMPAIGN_ROOM_EXIT` `RoomExitMsg{msg = ""}` (`CM/map/campaign/CampaignSocketOutManager.as:68-81`) and 9694 {`param1` = 6 ROOM_OUT} (`GGM:348-351,399-405`) | 15 exit, scene leaves |
| Open calendar data | `GGM.sendOpenBet` (shared with [forecast.md](forecast.md)) | none | 9694 {`param1` = 4} | 4992 |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Effect |
|---|---|---|---|---|
| 4993 (0x1381) `U_C_GLORY_ROOM_UPDATE` (the CSV also names 0x1381 `U_C_GUARD_SCUFFLE_OP_RSP`: shared opcode) | `simple.PropertyMsg` {`param1` (#1, INT32) turn, `param2` (#2, INT32) round/stage, `param3` (#3, INT32) team score (stage 1), `param4` (#4, STRING) group number as text, `param5` (#5, STRING) wins as text, `param7` (#7, BOOL) extra time flag} | `GGM.receiveRoomUpdate` (`GGM:62,135-150`) | on entering the room, after each turn, on stage change | room top/right views |
| 4992 (0x1380) `U_C_GLORY_OPEN_BET_VIEW` (also `U_C_GUARD_SCUFFLE_RSP` in the CSV) | `Glory.GloryBetMsg` {`playerBet` (#1, PlayerBetMsg, repeated), `allSchedule` (#2, GloryScheduleMsg, repeated), `round` (#3, INT32)} | `GGM.receiveBetInfo` (`GGM:61,152-182`) | reply to op 4 | schedules and team names map; bets in [forecast.md](forecast.md) |
| 12, 120, 17, 15 | generic room messages | `BaseManager`, `RoomManager` | room life | see [../artillery/trial-lobby.md](../artillery/trial-lobby.md) |
| 157 ... 4103 | battle 3891 | battle pipeline | each match | team PvP battle; the result handler has no special case, it returns to `SwitchPageHelp.returnScene` (A: the room) |

`GloryScheduleMsg`: `scheduleUid` (#1, STRING), `teamUid1` (#2, STRING), `teamName1` (#3), `serverName1` (#4), `score1` (#5, INT32), `teamUid2` (#6), `teamName2` (#7), `serverName2` (#8), `score2` (#9, INT32), `round` (#10, INT32 stage), `group` (#11, INT32 group or turn).

## 5. Rules and formulas

Schedule (`GGM:230-299`): `saturday(r)` = the first Saturday on or after the event begin (`SevenYearModel.beginTime`), plus `(r-1)` weeks, at 20:00 (72,000,000 ms after midnight); the sign-in limit variant is 19:55 (71,700,000 ms).

| Stage | Match time |
|---|---|
| 1 qualifier | `saturday(1) + group * 3 min` (one turn every 3 min, 15 turns) |
| 2 groups | `saturday(2) + turn * 3 min` |
| 3 quarter-finals, 4 semi-finals | `saturday(r) + (group-1) * 9 min`, or `+ turn * 3 min` per game of the best of three |
| 5 final | `saturday(4) + 30 min (+ turn * 3 min)` (same evening as the semi-finals) |

| Rule | Value | Source |
|---|---|---|
| Qualifier | 15 turns, points; top 16 teams advance | `sign.rule` items 1-2; `GloryGameConst.TRYOUT_TOTAL_TURN` |
| Groups | top 2 of each group advance; rank by wins, then fewer losses, then head to head; three-way tie: two tie-break matches by qualifier rank | `sign.rule` items 3-4 |
| Knockouts | best of three | `sign.rule` item 5; `OUT_TOTAL_TURN = OUT2_TOTAL_TURN = FINAL_TOTAL_TURN = 3` |
| Rewards (Pontos de Guerreiro, item -15000) | champion 100000, runner-up 80000, 3rd-4th 60000, 5th-8th 40000, 9th-16th 20000, other participants 10000 | `TPL/GloryRewardDrop.xml` sites 6..1; tip `SevenYearGloryGame.award.str` |

Groups count (A): 16 teams in 8 groups of 2 cannot produce "top 2 per group" plus quarter-finals of 8 teams; the consistent reading is 4 groups of 4 (3 turns = round robin), top 2 of each -> 8 teams -> quarter-finals.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `TPL/GloryRewardDrop.xml` | reward by placement band | `site` 1..6 (1 participant .. 6 champion), `itemId` -15000, `count` |

## 7. Persistent state

```sql
CREATE TABLE glory_supremacy.matches (
  schedule_uid  UUID PRIMARY KEY,
  season_id     INTEGER NOT NULL REFERENCES glory_supremacy.seasons(season_id) ON DELETE CASCADE,
  stage         SMALLINT NOT NULL CHECK (stage BETWEEN 1 AND 5),
  group_no      SMALLINT NOT NULL,
  turn          SMALLINT NOT NULL,
  team_uid_1    UUID NOT NULL REFERENCES glory_supremacy.teams(team_uid),
  team_uid_2    UUID REFERENCES glory_supremacy.teams(team_uid),
  score_1       INTEGER NOT NULL DEFAULT 0,
  score_2       INTEGER NOT NULL DEFAULT 0,
  scheduled_at  TIMESTAMPTZ NOT NULL,
  played_at     TIMESTAMPTZ
);
CREATE INDEX glory_matches_season_stage_idx ON glory_supremacy.matches (season_id, stage, group_no);

CREATE TABLE glory_supremacy.team_standings (
  team_uid      UUID NOT NULL REFERENCES glory_supremacy.teams(team_uid) ON DELETE CASCADE,
  stage         SMALLINT NOT NULL,
  group_no      SMALLINT NOT NULL DEFAULT 0,
  points        INTEGER NOT NULL DEFAULT 0,
  wins          SMALLINT NOT NULL DEFAULT 0,
  losses        SMALLINT NOT NULL DEFAULT 0,
  final_rank    SMALLINT,
  PRIMARY KEY (team_uid, stage)
);

CREATE TABLE glory_supremacy.rewards (
  season_id     INTEGER NOT NULL REFERENCES glory_supremacy.seasons(season_id) ON DELETE CASCADE,
  player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  band          SMALLINT NOT NULL CHECK (band BETWEEN 1 AND 6),
  amount        INTEGER NOT NULL,
  granted_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (season_id, player_id)
);
```

## 8. Backend implementation notes

- Season scheduler drives `(stage, phase, turn)`: SIGN_IN -> READY (rooms open) -> FIGHT per turn -> REWARD -> next stage; broadcasts 4991/4993 to registered players.
- `glory_supremacy::matches::handle_enter_room` (op 3): registered member, room phase READY or FIGHT, else refuse with `SevenYearGloryGame.enter.timeHint` tip; create or join the team room (`room_type = 15`); send 12, 120, 17, 4993.
- `handle_leave_room` (op 6, plus 5025): remove from room; the team still fights with the present members (A).
- Turn start: pair teams (qualifier: by current points, Swiss style A; groups: round robin; knockouts: bracket); create `matches` rows; run battle 3891 between the two teams' members present in their rooms (team without members present loses, A); write scores; push 4993 to both rooms.
- Stage end: compute standings and qualifiers; final ranks; grant rewards through `add_war_points` or directly item -15000 (A: the cap of 600 does not apply, amounts are 10000+); insert `rewards`.

## 9. Open questions and assumptions

- (A) Group structure (4x4), qualifier pairing, point values per qualifier win.
- (A) Whether the 600 daily cap applies to glory rewards.
- (A) Team battle composition (members' armies side by side) for type 3891.
- Opcodes 4992/4993 are shared with "guard scuffle" in `protocol/opcodes.csv`; routing must be per feature context.

## 10. Implementation checklist

- [ ] Season state machine and Saturday schedule.
- [ ] Op 3 enter room (type 15) and op 6 / 5025 leave.
- [ ] 4993 room updates.
- [ ] Pairing per stage and battle 3891.
- [ ] Standings, tie-breaks, bracket progression.
- [ ] 4992 schedules.
- [ ] Rewards by band from `GloryRewardDrop`.
- [ ] Tables `matches`, `team_standings`, `rewards`.
- [ ] Tests: absent team, tie in group, best of three ending 2-0, schedule computation across event start.
