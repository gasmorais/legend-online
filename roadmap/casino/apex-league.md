# Liga do Pico (apex league, "巅峰联赛")

Path aliases:

| Alias | File |
|---|---|
| APM | `decompiled/core_module/scripts/yishi/manager/ApexManager.as` |
| APS | `decompiled/core_module/scripts/mvc/module/apex/ApexState.as` |
| APBS | `decompiled/core_module/scripts/mvc/module/apex/ApexBattleState.as` |
| APC | `decompiled/core_module/scripts/mvc/controler/ApexController.as` |
| APRC | `decompiled/core_module/scripts/mvc/controler/ApexRoomController.as` |
| AHF | `decompiled/m9/scripts/apex/ApexHallFrame.as` |
| ATI | `decompiled/m9/scripts/apex/team/ApexTeamItem.as` |
| AGF | `decompiled/m9/scripts/apex/guess/ApexGuessFrame.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A weekly cross server team league (teams of up to 4) with 6 divisions ("Bronze", "Prata", "Ouro", "Platina", "Diamante", "Mestre"), 4 league rounds ("1ª rodada da Liga" .. "Última rodada da Liga") and a betting game ("Super adivinhação") on the best teams paid with "Corações de Gelo" (apex coin, shop 1015). Help (`apex.help.hall.content`) summary: sign up as a team, power above 1 million, the captain pays 3,000,000 gold; team power is recorded for matchmaking; teams start at 0 points and gain or lose points per battle by division (Mestre 2100 min, +25/-5; Diamante 1800, +35/-10; Platina 1500, +45/-15; Ouro 1000, +55/-20; Prata 500, +65/-25; Bronze +80/-30); each captain carries a point chest, killing the enemy captain gives 5 points and protecting the chest gives 5; rewards per group and rank after each round; the best Mestre team after the final round gets a title; bets before rounds 2 to 4; Corações de Gelo expire after the final round.

States (`ApexState`, APS): 1 SIGN, 2 GUESS, 3 READY, 4 FIGHT, 5 AWARD, 6 END; stages 1..4 = league rounds.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `apex.ApexHallFrame` (AHF) | "Descrição da Liga do Pico" help, hall | Last winners avatars, sign up, team, fight (enter room), guess, ranking, award list, shop 1015 | Top toolbar `apex` (TopToolBtnInfos 4018 "巅峰联赛", tip "Liga do Pico") -> `sendOpenMainView()` (TTB:1450-1452); state text on the button "Pode se inscrever", "Inscrito\n({0}/4)", "Apostas", "Combater" | 4685, 4684, 4683 |
| `apex.team.ApexTeamView`, `ApexTeamInviteFrame` | "Inscrição na Liga do Pico" | Create, invite (online friends and guild), kick, quit, sign up (captain), team list and search "Insira ID da equipe" | AHF sign button (`openControllerByInfo("apex",8)`) | 191 |
| `apex.guess.ApexGuessFrame`, `ApexGuessDetailFrame` | "Super adivinhação", "Insira o montante da aposta" | Pick a team per group, bet 100..50000 coins; when coins are short the rest is paid in diamonds and only coins are refunded | AHF guess (state 2) | 4681 |
| `apex.rank.ApexRankFrame` | "Ranking" | Groups and teams, "Última atualização: {0}" | AHF or room rank | 4214 |
| `apex.award.ApexAwardFrame`, `ApexAwardListFrame` | award preview, "Obter lista" | Rewards per group and round; bet winners list | AHF, guess frame | 4682 |
| `apex.report.ApexReportView` | result report | "Subiu ao grupo {0}", "Caiu para o grupo {0}", "Não muda", rewards | 4807 | 4807 |
| `ApexRoomController` scene with `apex.room.ApexRoomView` (APRC) | room | Waiting room during the fight phase: turn, next start time, in battle ranking | R3 enter room (room feature `RoomManager`) | 4689, 4688 |

Toolbar visibility: `VersionSwitch.APEX && grades >= 80` (TBH:381-382).

## 3. Routes (client to server)

All routes: C>S 5439 (0x153f) `C_APEX_CLIENT_OP`, body `player.CommonMsg`: `param1` (#1, INT32) op; `param2` (#2, INT32); `param3` (#3, INT32); `param4` (#4, STRING); `param5` (#5, STRING); `param6` (#6, INT64); `param7` (#7, INT64). Senders APM:485-638.

| # | op (`param1`) | Action | UI | Client checks | Other fields | Expected reply |
|---|---|---|---|---|---|---|
| R1 | 1 | Open hall | toolbar | not in battle or campaign (tips "ChatOutputViewII.tip01", "worldboss.helper.WorldBossHelper.tip06", APM:319-333) | none | 4685 (+ 4684, 4683) |
| R2 | 2 | Sign up the team | team item sign (ATI:110-135) | captain else "Apenas o líder pode realizar inscrição"; not signed else "A equipe se inscreveu com sucesso"; confirm "Depois do registo da equipe não pode ser alterada, ..." | none | 185 (and 184 to members) |
| R3 | 3 | Enter the fight room | AHF fight (AHF:266-269) | `model.isOpen` else "A Liga do Pico ainda não começou" | none | room scene messages (room feature), 4689, 4688 |
| R4 | 4 | Ranking | AHF rank, room rank (AHF:301-304) | none | none | 4214 pages |
| R5 | 5 | Open guess | AHF guess (AHF:271-282) | `state == 2` else "Não é horário de adivinhação" | none | 4681 |
| R6 | 6 | Place a bet | AGF (AGF:370-397) | count 100..50000 ("Insira um número de 100 a 50000"); confirm "Deseja gastar {0}Corações de Gelo para realizar aposta?" or "O montante de aposta ultrapassa a quantidade que tem, serão gastos {0} diamantes para complementar..." | `param2` amount, `param4` team uid | 4681 |
| R7 | 7 | Get turn info | not called by the UI | none | none | 4689 (assumption) |
| R8 | 8 | Bet winners list | AGF "Obter lista" (AGF:398-401) | none | none | 4682 pages |
| R9 | 9 | Answer the sign up confirmation | popup of 184 (APM:444-467) | none | `param2` 1 yes, 0 no | 185 |
| R10 | 11 | Create team | team view | none | none | 191 optype 11 |
| R11 | 12 | Kick member | team view | captain | `param2` user id | 191 optype 12 |
| R12 | 13 | Invite | invite item (`ApexTeamInviteItem.as:116`) | none | `param2` user id | 191 optype 13 to the invitee |
| R13 | 14 | Quit team | team item quit, confirm "Deseja sair da equipe atual da Liga do Pico" (ATI:141-155) | none | none | 191 optype 14 |
| R14 | 15 | Join team by id / chat link | team search, chat (`ChatOutputViewII.as:776`) | none | `param2` team id | 191 optype 15 |
| R15 | 16 | All teams | team view | none | none | 191 optype 16 |
| R16 | 18 | Answer an invite | 10 s popup of 191 optype 13 (APM:150-168, 616-638) | accept requires level 80 ("Requer nível 80 de personagem") | `param2` team id, `param3` 1 accept, 0 refuse | 191 optype 15 or 17 |

## 4. Server messages (server to client)

| # | Opcode | Message and fields | Receiver | When |
|---|---|---|---|---|
| S1 | 4684 (0x124c) `U_C_APEX_STATE` | `apex.ApexStateMsg`: `signUpStartTime` (#1), `signUpEndTime` (#2), `betStartTime` (#3), `betEndTime` (#4), `fightStartTime` (#5), `fightEndTime` (#6) STRING "YYYY-MM-DD hh:mm:ss" ("2000-01-01 00:00:00" = no bet phase); `index` (#7, INT32) season; `stage` (#8, INT32) round 1..4; `state` (#9, INT32) 1..6 | `receiveApexState` (APM:243-258): toolbar state; state 4 shows the trace tip "A Liga do Pico atual já se encerrou" (type 57) | login and every state change |
| S2 | 4685 (0x124d) `U_C_APEX_MAIN_VIEW` | `ApexMainViewMsg`: `selfSignUp` (#1, BOOL); `curTeamMemNum` (#2, INT32) | `receiveApexMainView` (APM:305-339): opens the hall | reply to R1 |
| S3 | 185 (0x00b9) `U_C_APEX_SIGN_IN_STATE` | `ApexMainViewMsg` | `updateSignState` (APM:474-483) | sign up result, member changes |
| S4 | 184 (0x00b8) `U_C_APEX_SIGN_IN_CONFIRM` | `player.CommonMsg`: `param4` captain name | `receiveApexSignInConfirm` (APM:444-467): "{0} convida você a participar nesta Liga do Pico, você aceita?" -> R9 | to members when the captain signs up |
| S5 | 191 (0x00bf) `U_C_APEX_TEAM_CLIENT_OP_RESP` | `ApexTeamClientOpRespMsg`: `optype` (#1, INT32) 11..17; `member` (#2, `ApexTeamMemberMsg`: `userId` (#1), `fightPower` (#2), `nickName` (#3), `guildName` (#4), `headPics` (#5), `level` (#6)); `team` (#3, `ApexTeamMsg`: `teamId` (#1), `captainId` (#2), `members` (#3, repeated)); `teams` (#4, repeated) | `receiveTeamOp` (APM:123-231): 11 created, 12 kicked (new team state), 13 invite popup (inviter's guild name; warns when already in a team), 14 left (empty members = team removed), 15 joined, 16 full list, 17 other team update | replies to R10..R16 |
| S6 | 4214 (0x1076) `U_C_APEX_RANK` | `ApexRankListMsg`: `selfTeamUid` (#1, STRING), `updateTime` (#2, STRING), `allRankList` (#3, `ApexRankMsg` repeated: `group` (#1), `teamList` (#2, `ApexRankTeamMsg` repeated: `teamUid` (#1, STRING), `teamName` (#2), `serverName` (#3), `fightCapacity` (#4, INT64), `score` (#5), `rank` (#6), `vipType` (#7), `nextGroup` (#8))), `page` (#4), `totalPage` (#5), `stamp` (#6) | `receiveApexRank` (APM:279-303): paged, opens the rank frame when complete | reply to R4 |
| S7 | 4688 (0x1250) `U_C_APEX_IN_BATTLE_RANK` | `ApexRankListMsg` | `receiveApexInBattleRank` (APM:346-369): room ranking, newer `stamp` replaces | during the fight phase |
| S8 | 4689 (0x1251) `U_C_APEX_BATTLE_STATE` | `player.CommonMsg`: `param1` current turn, `param2` max turns, `param6` next start time (ms) (APBS) | `receiveApexBattleState` (APM:413-420) | fight phase, each turn |
| S9 | 4807 (0x12c7) `U_C_APEX_RESULT` | `ApexResultMsg`: `rewardList` (#1, `ApexRewardMsg` repeated: `itemTempId` (#1), `itemCount` (#2)); `selfScore` (#2); `selfRank` (#3); `currentGroup` (#4); `nextGroup` (#5) | `receiveApexResult` (APM:270-277): report after the current scene | end of each round |
| S10 | 4681 (0x1249) `U_C_APEX_BET_INFO` | `ApexBetMsg`: `selfBetTeamUid` (#1, STRING), `selfBetCount` (#2), `lastBetWinningCount` (#3, INT64), `currentBonusPool` (#4, INT64), `rankList` (#5, `ApexRankMsg`), `guessGroup` (#6), `guessRank` (#7) | `receiveApexBetInfo` (APM:392-411): null `rankList` -> "Adivinhação não aberta" | replies to R5, R6 |
| S11 | 4682 (0x124a) `U_C_APEX_BET_WINNER` | `ApexBetPlayerListMsg`: `page` (#1), `totalpage` (#2), `list` (#3, `ApexBetPlayerMsg` repeated: `nickName` (#1), `serverName` (#2), `vipType` (#3), `order` (#4), `playerUid` (#5)), `stamp` (#4) | `receiveApexBetWinner` (APM:371-390) | reply to R8, paged |
| S12 | 4683 (0x124b) `U_C_APEX_LAST_WINNER` | `ApexLastWinnerMsg`: `list` (#1, `ApexPlayerViewMsg` repeated: `arm` (#1), `cloth` (#2), `wing` (#3), `hat` (#4) STRING, `hideFashion` (#5, BOOL), `fashionArm` (#6), `fashionCloth` (#7), `isDragonTalker` (#8, BOOL), `job` (#9), `nickName` (#10), `serverName` (#11), `playerUid` (#12), `fightCapacity` (#13), `vipType` (#14), `heroTempId` (#15), `teamUid` (#16)) | `receiveApexLastWinner` (APM:422-442): 4 avatars in the space scene | login, after the final |
| S13 | 528 (0x0210) `U_C_FROST_HEART_SHOP` | `player.CommonMsgList`: `list` (#1, `CommonMsg`: `param1` shop goods id, `param2` bought count) | `shopBuyHandler` (APM:93-107) -> `OneCurrentCount` of shop 1015 goods | login, after a purchase |

## 5. Rules and formulas

`raw/xml/tempinfos/ConfigInfos.xml`:

| Config | Value | Meaning |
|---|---|---|
| `apex_sign_in_gold` | 3000000 | gold paid by the captain |
| `apex_open_time` | 4\|18:00,20:00,21:00 | Thursday: ready 18:00, fight 20:00 to 21:00 |
| `apex_group_score` | 0,500,1000,1500,1800,2100 | division minimum points (Bronze..Mestre) |
| `apex_win_score` | 80,65,55,45,35,25 | points per win by division |
| `apex_lost_score` | 30,25,20,15,10,5 | points lost per defeat by division |
| `apex_leader_kill_score` | 5 | killing the enemy captain |
| `apex_master_no1_appell` | 430 | title of the Mestre winner (AppellInfos) |
| `apex_tryout_score`, `apex_league_score` | marked "(无效)" invalid | unused |

- B1. Level 80 (TBH:381, APM:626-634); power above 1 million to sign up (`apex.hall.str2`).
- B2. Team of up to 4; only the captain signs up; the roster is locked after sign up.
- B3. Fight phase: automatic matchmaking per turn between teams of similar recorded power; turns `currentTurn/maxTurn`; win or loss points by division; captain kill and chest protection +5.
- B4. Round end: division recomputed from points (`nextGroup`), rewards `ApexRewardDrop.xml` by group and rank and `ApexRewardSingleDrop.xml`; report 4807.
- B5. Bets: rounds 2..4 during the bet window; 100..50000 coins on one team (guess group and rank); missing coins paid in diamonds; winners share `currentBonusPool`; only coins are refunded.
- B6. Corações de Gelo (currency `apexCoin`, `-4800` in drops) expire after the final round ("Os Corações de Gelo zeram as {0}").

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ApexRewardDrop.xml` | `ApexRewardDropInfo` | `dropId`, `site` (group and rank code), `para2` range, `itemId` (-4800 = Corações de Gelo), `count` |
| `raw/xml/tempinfos/ApexRewardSingleDrop.xml` | `ApexRewardSingleDropInfo` | per battle rewards: `site 1`, `para2` 1 win 10, 2 loss 5 coins |
| `raw/xml/tempinfos/ConfigInfos.xml` | `apex_*` | above |
| Shop 1015 | apex shop goods (`TempleteManager.getApexShopTempInfoList`) | owned by [../shops/README.md](../shops/README.md) |

## 7. Persistent state

```sql
CREATE TABLE casino.apex_season (
  season_id     SERIAL      PRIMARY KEY,
  stage         SMALLINT    NOT NULL DEFAULT 1 CHECK (stage BETWEEN 1 AND 4),
  state         SMALLINT    NOT NULL DEFAULT 1 CHECK (state BETWEEN 1 AND 6),
  sign_start    TIMESTAMPTZ NOT NULL,
  sign_end      TIMESTAMPTZ NOT NULL,
  bet_start     TIMESTAMPTZ,
  bet_end       TIMESTAMPTZ,
  fight_start   TIMESTAMPTZ NOT NULL,
  fight_end     TIMESTAMPTZ NOT NULL,
  bonus_pool    BIGINT      NOT NULL DEFAULT 0
);

CREATE TABLE casino.apex_team (
  team_id      SERIAL   PRIMARY KEY,
  season_id    INTEGER  NOT NULL REFERENCES casino.apex_season(season_id) ON DELETE CASCADE,
  captain_id   INTEGER  NOT NULL REFERENCES player.players(player_id),
  signed_up    BOOLEAN  NOT NULL DEFAULT FALSE,
  team_power   BIGINT   NOT NULL DEFAULT 0,
  score        INTEGER  NOT NULL DEFAULT 0,
  division     SMALLINT NOT NULL DEFAULT 1 CHECK (division BETWEEN 1 AND 6)
);

CREATE TABLE casino.apex_team_member (
  team_id    INTEGER NOT NULL REFERENCES casino.apex_team(team_id) ON DELETE CASCADE,
  player_id  BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  confirmed  BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (team_id, player_id)
);
CREATE UNIQUE INDEX apex_member_one_team ON casino.apex_team_member (player_id);

CREATE TABLE casino.apex_bet (
  season_id  INTEGER NOT NULL REFERENCES casino.apex_season(season_id) ON DELETE CASCADE,
  stage      SMALLINT NOT NULL,
  player_id  BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  team_id    INTEGER NOT NULL REFERENCES casino.apex_team(team_id) ON DELETE CASCADE,
  coins      INTEGER NOT NULL CHECK (coins BETWEEN 100 AND 50000),
  won        BOOLEAN,
  PRIMARY KEY (season_id, stage, player_id)
);

CREATE TABLE casino.apex_match (
  match_id     BIGSERIAL   PRIMARY KEY,
  season_id    INTEGER     NOT NULL REFERENCES casino.apex_season(season_id) ON DELETE CASCADE,
  stage        SMALLINT    NOT NULL,
  turn         SMALLINT    NOT NULL,
  team_a       INTEGER     NOT NULL REFERENCES casino.apex_team(team_id),
  team_b       INTEGER     NOT NULL REFERENCES casino.apex_team(team_id),
  winner       INTEGER,
  played_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- `casino::apex::handle_op` (5439) dispatches on `param1` to `handle_open`, `handle_sign`, `handle_enter_room`, `handle_rank`, `handle_open_guess`, `handle_bet`, `handle_turn`, `handle_bet_winners`, `handle_sign_confirm`, `handle_team_create`, `handle_team_kick`, `handle_team_invite`, `handle_team_quit`, `handle_team_join`, `handle_team_list`, `handle_invite_answer`.
- Sign up: state 1 -> captain -> every member level 80 and power -> captain gold >= 3,000,000; debit, record power, push 184 to members, 185 to all.
- Scheduler (weekly, `apex_open_time`): state transitions with 4684 broadcast; fight phase: every turn match teams in the room, start a team PvP battle (battle type of the room feature, both teams' heroes; captain carries the chest; see [../../docs/battle/server-engine.md](../../docs/battle/server-engine.md)), apply points, push 4688 and 4689; round end: rewards by mail or bag, 4807, divisions; final round: title `apex_master_no1_appell`, 4683.
- Bets: on round end resolve bets, credit coins and split `bonus_pool`.
- Cross server: teams across servers are identified by `teamUid` and `playerUid` strings; single server deployments can use local ids as strings.

## 9. Open questions and assumptions

- Assumption: R7 replies 4689.
- Open: room protocol for the waiting room (room feature, see [../campaign/rooms.md](../campaign/rooms.md)).
- Open: bet payout formula and `guessGroup`/`guessRank` semantics.

## 10. Implementation checklist

- [ ] Screens hall, team, guess, rank, awards, report, room scene
- [ ] Route 5439 ops 1..9, 11..16, 18
- [ ] Messages 4684, 4685, 185, 184, 191, 4214, 4688, 4689, 4807, 4681, 4682, 4683, 528
- [ ] Tables `apex_season`, `apex_team`, `apex_team_member`, `apex_bet`, `apex_match`
- [ ] Weekly scheduler, matchmaking, scoring by division, rewards, title
- [ ] Test: sign up by non captain refused; bet outside window refused; bet below 100 refused

## Screens

- `ApexHelpFrame` (`decompiled/m9/scripts/apex/ApexHelpFrame.as`) extends `SimpleHelpFrame` and shows the Apex league rules help, opened from the help button.
