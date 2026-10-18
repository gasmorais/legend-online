# Guild chess ("Duelo Tático", consortiachess)

Module: `guild::chess`. Protobuf packages `com.road.yishi.proto.consortiaplay` (board, data) and `com.road.yishi.proto.player` (`PlayerOpMsg`). Client manager `managers.ChessPvpManager`; views `decompiled/m3/scripts/consortiachess/**`.

The full game design (rules, board numbering, piece movement vectors, revive, promotion, screens and HUD layout, assets) is already documented in **[docs/battle/chess-modes.md](../../docs/battle/chess-modes.md) Part A** and is not repeated here. This file lists every opcode, the server responsibilities and persistent state, and the implementation checklist.

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `CC/` = `decompiled/m3/scripts/consortiachess/`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`. "(A)" marks an assumption.

## Overview

Guild versus guild real-time chess on an 8x8 board. The leader signs the guild up (100000 guild Fortuna) and assigns each member a piece (16 pawns, 2 rooks, 2 knights, 2 bishops, 1 queen, 1 king; 24 members). Guilds play in four leagues (0 Bronze, 1 Prata, 2 Ouro, 3 Diamante): one round per week, ranking matches Monday to Friday, promotion match on Saturday (chess-modes.md A.1). Each match runs 19:00 to 20:00 (`chess_pvp_times` = `19:00:00|20:00:00`). Pieces march in real time; when both teams stand on one square the server runs a battle (battleType 3910); the winner occupies the square, the loser returns to respawn (max 3 revives). Most occupied squares at the end wins; losing the king (or having none) ends the match as a loss.

**Switch: `VersionSwitch.CHESS_PVP = false`** (`CM/yishi/datas/VersionSwitch.as:246`, never reassigned). The guild activity entry (id -2) and the shop tab are hidden in this BR build; listeners 561 to 566 stay registered (`CM/managers/ChessPvpManager.as:67-76`, called from `CM/yishi/lunch/Yishi.as:555`). Treat the whole module as optional, behind a server feature flag. Reward templates `ChessPvpRankDrop` and `ChessPvpFightDrop` are referenced by the client (`CM/yishi/manager/TempleteManager.as:1420-1421`) but absent from `raw/xml/tempinfos/`.

Entry: `ConsortiaViewHelper.initChesspvp` (`CM/mvc/module/consortia/ConsortiaViewHelper.as:110-126`) prompt = `beginTime` when signed up, else "Não se inscreveu" (`chesspvp.in.noJoin`); click `gotoChessPvp` (:128-136): `SwitchPageHelp.checkScene()`, then `openControllerByInfo("chesspvp")` and `setLockPreFrame("consortia","15",5,"consortiachess.ChesspvpInFrame")`. Controller `CM/mvc/controler/ConsortiaChessController.as:34-97`.

## Screens

| Class (openType) | pt-BR title | Purpose | Opened from | Data |
|---|---|---|---|---|
| `consortiachess.ChesspvpInFrame` (default) | Duelo Tático | Lobby: signup, next match card, lineup, rank/record/shop buttons | activity entry -2 | 561 |
| `consortiachess.ChesspvpBattleFrame` (1) | Duelo Tático | Board, scoreboard, square panel, guild chat (channel 5) | 564 | 564, 565 |
| `consortiachess.ChesspvpUpRoleFrame` (2) | Promover o Peão | Pawn promotion (no close button) | own pawn idle on last rank | none |
| `consortiachess.ChessPvpResultFrame` (3) | (none) | Match result | 566 | 566 |
| `consortiachess.ChesspvpRankFrame` (4) | Ranking | League ranking, 4 tabs, 8 per page | lobby rank button | 562 |
| `consortiachess.ChesspvpRecordFrame` (5) | Registro da Partida | This week / last week records | lobby record button | 563 |
| `consortiachess.ChesspvpRewardFrame` (6) | Prêmio | Daily and weekly rewards per league | lobby | templates only |
| Shop (`"shop",2,{chesspvp:true}`) | | "Pontos Táticos" shop 1030 (economy) | lobby shop button (`CC/ui/ChesspvpInLeftUI.as:136-139`) | economy module |

Layouts: chess-modes.md A.7.

## Actions

### C to S 9730 (0x2602) `C_CHESS_PVP_CLIENT_OP`, `player.PlayerOpMsg`

Sender `ChessPvpManager.operFun(op, userId=0, type=0)` (`CM/managers/ChessPvpManager.as:320-328`), always sets `op` (#1, INT32), `userId` (#7, INT32), `type` (#2, INT32). Op constants `CM/mvc/module/chesspvp/ChessPvpOp.as:12-24`.

| # | Action | UI control / sender | Client checks | Fields | Responses |
|---|---|---|---|---|---|
| C1 | Open lobby | `ChesspvpInFrame` constructor (`CC/ChesspvpInFrame.as:40`) | `checkScene` | `op=1` OPEN | 561 `op=1` (client clears board model, `ChessPvpManager.as:118-121`) |
| C2 | Close lobby | `ChesspvpInFrame.dispose` (`CC/ChesspvpInFrame.as:96`) | none | `op=2` CLOSE | none |
| C3 | Sign up | "Inscrever" -> `ChesspvpInLeftUI.jionHandler` -> `__alertResponse` (`CC/ui/ChesspvpInLeftUI.as:141-157`) | confirm "Deseja gastar {0} pontos de fortuna da guilda para fazer a inscrição?" with `chess_pvp_sign_offer` = 100000 (:78-82); visible while `!isSignUp`; no rank check client-side | `op=3` SIGN | 561 `op=3` with `group.isSignUp=true` to all online members viewing the lobby (A) |
| C4 | Assign piece | `ChesspvpRoleComMenu` option (`CC/item/ChesspvpRoleComMenu.as:85`) | menu only when own `dutyId == 1` (`CC/ui/ChesspvpInRightUI.as:134-140`); quotas 16/2/2/2/1/1 (`CC/ui/ChesspvpRoleNumUI.as:35-48`) | `op=4` EDIT, `userId` member, `type` chessType 0 (remove) .. 6 | 561 `op=4` with `userList` |
| C5 | Enter match | "Entrar na batalha" -> `ChesspvpInLeftGroupUI.clickHandler` (`CC/ui/ChesspvpInLeftGroupUI.as:113-116`) | enabled only when `group.state == 1` | `op=5` FIGHT | 564 board snapshot |
| C6 | View ranking | `ChesspvpRankFrame` constructor (`CC/ChesspvpRankFrame.as:55`) | none | `op=6` VIEW_RANK | 562 |
| C7 | View records | `ChesspvpRecordFrame` constructor (`CC/ChesspvpRecordFrame.as:36`) | none | `op=7` VIEW_RECORD | 563 |

### C to S 25232 (0x6290) `CR_CHESS_PVP_CLIENT_OP`, `consortiaplay.ChessPvpBoardOpMsg`

Sender `ChessPvpManager.operChess(op, boardUid, userId, serverName, targetPos=-1, chessType=-1)` (`ChessPvpManager.as:330-341`). Fields: `op` (#1, INT32), `boardUid` (#2, STRING), `userId` (#3, INT32), `serverName` (#4, STRING), `targePos` (#5, INT32, sic), `chessType` (#6, INT32). Ops `ChessPvpOp.as:26-30`.

| # | Action | Sender | Client checks | Fields | Responses |
|---|---|---|---|---|---|
| C8 | Leave board | board close -> `CC/ChesspvpBattleFrame.as:75` | none | `op=1` ROLE_LEAVE | none (A: 565 to others if the piece state changes) |
| C9 | March | "Marchar" -> `CC/ui/ChesspvpBattleNodeUI.as:172-195` | own piece idle, geometric path exists (`getPaths`), else "O local do alvo não pode ser alcançado"; no blocking check | `op=2` ROLE_MOVE, `targePos` 1..64 | 565 to all board players (`state=1`, `targetPos`, `moveTotalTime`, `movePassTime`); on arrival with enemies: battle 3910 for the involved players, 565 for the rest; after battle 564 to the fighters on return |
| C10 | Promote pawn | `CC/ui/ChesspvpRoleUpUI.as:100-113` | own pawn idle on pos 1-8 (White) or 57-64 (Black) | `op=3` ROLE_CHANGE, `targePos=-1`, `chessType` 2..5 | 565 with new `chessType` |

Errors: none of the messages has a result code. Reject silently and resend the authoritative 561 or 565 (A).

## Server messages

All S to C, receivers in `CM/managers/ChessPvpManager.as`. Field tables with tags: chess-modes.md A.6 (verified against `protocol/proto.json`).

| Opcode | Name | Message | Receiver | When | Client effect |
|---|---|---|---|---|---|
| 561 (0x0231) | `U_C_CHESS_PVP_DATA` | `ChessPvpMsg` {`op` #1, `group` #2 `ChessPvpGroupMsg`, `userList` #3 repeated `ChessPvpUserMsg` {`userId` #1, `chessType` #2}} | `__pvpMatchDataHandler` :95-129 | response to 9730 op 1, 3, 4; push when pairing changes `group.state` | `selfGroupInfo`, `chessTypeDic`; event `EVENT_OP_FUN [op]` |
| 562 (0x0232) | `U_C_CHESS_PVP_RANK` | `ChessPvpRankListMsg` {`groups` #1 repeated `ChessPvpGroupRankMsg` {`group` #1, `ranks` #2 repeated `ChessPvpRankMsg` {`rank` #1, `name` #2, `serverName` #3, `score` #4, `fightPower` #5 INT64}}, `rankTime` #2} | `__rankHandler` :131-157 | response to op 6 | rank frame |
| 563 (0x0233) | `U_C_CHESS_PVP_RECORD` | `ChessPvpRecordListMsg` {`currWeek` #1, `lastWeek` #2 repeated `ChessPvpRecordMsg`} | `__recordHandler` :159-198 | response to op 7 | record frame, sorted by date desc |
| 564 (0x0234) | `U_C_CHESS_PVP_BOARD_DATA` | `ChessPvpBoardMsg` {`boardUid` #1, `currTime` #2, `endTime` #3, `teams` #4, `boxes` #5 (all 64), `roles` #6} | `__pvpBattleDataHandler` :200-213 | response to op 5; after each 3910 battle for the fighters | opens `ChesspvpBattleFrame` |
| 565 (0x0235) | `U_C_CHESS_PVP_BOARD_UPDATE` | `ChessPvpBoardUpdateMsg` {`teams` #1, `boxes` #2, `roles` #3}, partial, merged by key | `__pvpBattleUpdateHandler` :309-318 | push to every player on the board on any change | board redraw |
| 566 (0x0236) | `U_C_CHESS_PVP_BOARD_RESULT` | `ChessPvpBoardResultMsg` {`result` #1 0 loss / 1 win / 2 draw, `teams` #2} | `__pvpBattleResultHandler` :78-93 | push at `endTime` or king death, per team | result frame, or deferred until the frame opens |

`ChessPvpGroupMsg`: `op` #1, `currTime` #2 STRING, `beginTime` #3 STRING, `endTime` #4 STRING, `group` #5 league 0..3, `score` #6, `state` #7 (0 not paired "Ainda Não Emparelhado", 1 paired, 2 no opponent "Vazio"), `rivalName` #8, `rivalServerName` #9, `rivalScore` #10, `isSignUp` #11 BOOL, `rank` #12.
`ChessPvpTeamMsg`: `team` #1 (1 White, 2 Black), `name` #2, `serverName` #3, `score` #4, `group` #5, `addScore` #6.
`ChessPvpBoxMsg`: `pos` #1 (1..64), `buffId` #2, `team` #3 (occupier), `blackList` #4 / `whiteList` #5 repeated roleIds on the square.
`ChessPvpRoleMsg`: `roleId` #1, `userId` #2, `serverName` #3, `nickName` #4, `team` #5, `currPos` #6, `targetPos` #7, `chessType` #8, `movePassTime` #9 ms, `reiverTime` #10 revives used, `reiverCd` #11 ms, `state` #12 (0 stand, 1 move, 2 fight, 3 dead), `firstMove` #13 BOOL (true = has moved), `waitCd` #14 ms, `moveTotalTime` #15 ms.

Battle opcodes for 3910: the generic pipeline (157, 10007, 156, 153..., 154, 4103), see `docs/battle/README.md` section 1. Exit to `chesspvp` (`CM/battle/handler/BattleResultHandler.as:510-513`; `docs/battle/rules.md:1435`).

## Rules and formulas

| # | Rule | Source |
|---|---|---|
| H1 | Signup cost `chess_pvp_sign_offer` = 100000 guild Fortuna; the leader signs up (help); server must enforce chairman (client does not) | `CC/ui/ChesspvpInLeftUI.as:78-82`; `TPL/ConfigInfos.xml` |
| H2 | Only `dutyId == 1` can assign pieces; quotas per chessType 1..6 = 16, 2, 2, 2, 1, 1 | `CC/ui/ChesspvpInRightUI.as:134-140`; `CC/ui/ChesspvpRoleNumUI.as:35-48` |
| H3 | Schedule: one round per week, Mon-Fri ranking matches, Saturday promotion match; match 19:00-20:00 daily; opponents set at midnight ("Informações adversárias serão atualizadas à meia-noite no dia da partida") | chess-modes.md A.1; `chess_pvp_times` |
| H4 | Leagues 0..3; weekly promotion: top 6 of Bronze, top 4 of Prata, top 3 of Ouro ("As 6 melhores guildas ao final de cada semana têm a oportunidade de subir de nível.") | LANG `chesspvp.rank.des0..3` |
| H5 | Board: 64 squares from the server, pos 1..64 row-major from White's top-left; team 1 White, team 2 Black | chess-modes.md A.3 |
| H6 | Movement vectors per piece (pawn first double step, etc.); the server validates blocking and captures | `CC/util/ChesspvpConst.as:26-162`; chess-modes.md A.4 |
| H7 | Revives: max 3 per piece (`REIVER_TIME`), `reiverCd` countdown while dead | `CC/item/ChesspvpMoveCdItem.as:23`; `CC/item/ChesspvpRiverCdItem.as:41-65` |
| H8 | Promotion on last rank to 5, 4, 3 or 2 | `CC/ui/ChesspvpRoleUpUI.as:64-113` |
| H9 | Fight: square with both `blackList` and `whiteList` non-empty -> battleType 3910 (team battle with reinforcement); winner occupies (`box.team`), loser to respawn | chess-modes.md A.4 |
| H10 | End: at `endTime` or king death (no king = loss). Winner = most occupied squares. `addScore` per team shown on scoreboard and result | chess-modes.md A.1, A.4 |
| H11 | Rewards: daily `ChessPvpFightDrop` by `para2` (1 participation, 2 win, 3 loss, 4 draw), weekly `ChessPvpRankDrop`, `site = group + 1`; currency item -23000 "Pontos Táticos" | `CC/ui/ChesspvpRdGroupUI.as:73-105` |
| H12 | Square buffs `buffId` 10-12, 20-22, 30-32 have icons only; effects are server-defined | `CC/board/ChesspvpBoxItem.as:98-113` |

## Templates

| File | Status | Fields used by client |
|---|---|---|
| `ChessPvpRankDrop` (`ChessPvpRankDropCate`, `TempleteManager.as:1420`) | missing in `raw/xml/tempinfos/`; must be authored | drop rows with `site` (league+1), `itemId`, `count` (same shape as `CommonDropTempInfo`) |
| `ChessPvpFightDrop` (`ChessPvpFightDropCate`, `TempleteManager.as:1421`) | missing; must be authored | `site`, `para2` 1..4, `itemId`, `count` |
| `TPL/ConfigInfos.xml` | present | `chess_pvp_times`, `chess_pvp_sign_offer` |

## Persistent state

```sql
CREATE TABLE guild.chess_week (
  id          serial PRIMARY KEY,
  week_start  date NOT NULL UNIQUE,
  rank_time   timestamptz,                               -- ChessPvpRankListMsg.rankTime
  settled_at  timestamptz
);

CREATE TABLE guild.chess_entry (                          -- guild in a week
  week_id     integer NOT NULL REFERENCES guild.chess_week(id),
  guild_id    integer  NOT NULL,
  league      smallint NOT NULL CHECK (league BETWEEN 0 AND 3),
  score       integer NOT NULL DEFAULT 0,
  rank        integer,
  signed_by   integer  NOT NULL,
  signed_at   timestamptz NOT NULL DEFAULT now(),
  wealth_paid integer NOT NULL,
  PRIMARY KEY (week_id, guild_id)
);
CREATE INDEX chess_entry_rank_idx ON guild.chess_entry (week_id, league, score DESC);

CREATE TABLE guild.chess_league (                         -- persistent league per guild
  guild_id integer PRIMARY KEY,
  league   smallint NOT NULL DEFAULT 0 CHECK (league BETWEEN 0 AND 3)
);

CREATE TABLE guild.chess_lineup (
  week_id    integer NOT NULL,
  guild_id   integer  NOT NULL,
  user_id    integer  NOT NULL,
  chess_type smallint NOT NULL CHECK (chess_type BETWEEN 1 AND 6),
  PRIMARY KEY (week_id, guild_id, user_id),
  FOREIGN KEY (week_id, guild_id) REFERENCES guild.chess_entry(week_id, guild_id)
);

CREATE TABLE guild.chess_match (
  id           bigserial PRIMARY KEY,
  board_uid    text NOT NULL UNIQUE,
  week_id      integer NOT NULL,
  match_date   date NOT NULL,
  is_promotion boolean NOT NULL DEFAULT false,
  white_guild_id integer NOT NULL,
  black_guild_id integer,                                  -- null = no opponent (state 2)
  begin_at     timestamptz NOT NULL,
  end_at       timestamptz NOT NULL,
  result       smallint CHECK (result IN (0, 1, 2)),     -- from White's view
  white_add_score integer, black_add_score integer,
  UNIQUE (match_date, white_guild_id)
);

CREATE TABLE guild.chess_record (                         -- 563 rows per guild
  id          bigserial PRIMARY KEY,
  guild_id    integer NOT NULL,
  match_id    bigint NOT NULL REFERENCES guild.chess_match(id),
  record_date timestamptz NOT NULL,
  result      smallint NOT NULL,
  add_score   integer NOT NULL,
  rival_guild_id integer,
  rival_add_score integer
);
CREATE INDEX chess_record_guild_idx ON guild.chess_record (guild_id, record_date DESC);
```

Live board state (64 boxes, roles, timers, revives) lives in memory per `board_uid` for the one-hour match; persist only the result and records (A).

## Backend implementation notes

| Request | Handler |
|---|---|
| 9730 op 1 | `guild::chess::handle_open` |
| 9730 op 2 | `guild::chess::handle_close` |
| 9730 op 3 | `guild::chess::handle_sign` |
| 9730 op 4 | `guild::chess::handle_edit_lineup` |
| 9730 op 5 | `guild::chess::handle_enter_board` |
| 9730 op 6 | `guild::chess::handle_view_rank` |
| 9730 op 7 | `guild::chess::handle_view_record` |
| 25232 op 1 | `guild::chess::handle_role_leave` |
| 25232 op 2 | `guild::chess::handle_role_move` |
| 25232 op 3 | `guild::chess::handle_role_change` |

Validation: feature flag on -> in a guild -> (sign) chairman, not signed this week, guild wealth >= 100000 -> (edit) chairman, member of the guild, quota not exceeded -> (enter) match exists, now in 19:00-20:00, user has a piece -> (board ops) `boardUid` matches, `userId` is the session user, piece state allows it, path legal (server-side chess rules incl. blocking), promotion square.

Transactions: sign (debit guild wealth + insert entry); lineup edit (upsert/delete row); match settlement (result, scores, records, rewards mail). Board moves are in-memory under a per-board actor.

Schedules: Monday 00:00 new week (league promotion from last week); daily 00:00 pairing within league (push 561 to online members of signed guilds); 19:00 boards created; 20:00 end, 566 to all participants, settlement; Saturday promotion matches; Sunday weekly rank rewards.

Pushes: 561 to online members of the guild after sign/lineup/pairing; 565 to every player connected to the board; 566 to all board players.

Battle config for battleType 3910 (engine shape: `docs/battle/server-engine.md` section 9.2): `battle_type` 3910; `map` (A) generic PvP map; attacker side = the team that arrived; units = the formations of all players of both teams on that square (team battle with reinforcement, A: each player's own heroes and soldiers, `use_way` reinforcement); square `buffId` applied as a battle buff (A); `count_down` 180 (A); report without items. Afterwards: loser `state=3` with `reiverCd`, winner occupies the square, 565 broadcast, 564 to the fighters when they return.

Cross-area dependencies: core (guild, duties, wealth), battle engine (3910), economy (Pontos Táticos -23000, shop 1030), mail (rewards), guild chat channel 5 (board chat reuses it).

## Open questions

1. Feature is disabled client-side; confirm whether to implement now.
2. Reward templates are missing; author them or obtain the originals.
3. March speed, revive cooldown, `waitCd` values and start positions are server-only (chess-modes.md Part C row 3).
4. Square buff effects (ids 10-32).
5. Exact battle composition for 3910 (who fights when several pieces share a square).
6. Pairing rule inside a league and promotion match pairing.

## Implementation checklist

Client (present, flag off):
- [ ] Activity entry -2 and lobby (C1, C2)
- [ ] Signup (C3), lineup editor (C4)
- [ ] Enter match (C5), board, scoreboard, square panel, chat
- [ ] March (C9), promotion (C10), leave (C8)
- [ ] Result frame (566), rank (C6), record (C7), reward frame

Backend:
- [ ] Feature flag `guild_chess_enabled`
- [ ] `guild::chess::handle_open` / `handle_close` -> 561
- [ ] `guild::chess::handle_sign` -> 561
- [ ] `guild::chess::handle_edit_lineup` -> 561
- [ ] `guild::chess::handle_enter_board` -> 564
- [ ] `guild::chess::handle_view_rank` -> 562
- [ ] `guild::chess::handle_view_record` -> 563
- [ ] `guild::chess::handle_role_leave`, `handle_role_move`, `handle_role_change` -> 565
- [ ] Board actor: 64 squares, roles, timers, revives, server chess rules, fight detection
- [ ] Battle rule 3910 and post-battle board update
- [ ] Match end -> 566, settlement, records, rewards
- [ ] Weekly scheduler (pairing, promotion, rank rewards)
- [ ] Tables `chess_week`, `chess_entry`, `chess_league`, `chess_lineup`, `chess_match`, `chess_record`
- [ ] Author `ChessPvpRankDrop` and `ChessPvpFightDrop`
