# Theseus arena: season, user state and entry

Module `theseus_arena::season`. Prefixes as in [README.md](README.md).

## 1. Overview

Each mode has a season (`seasonId`, `startDate`, `stopDate`, `closeDate`) and per player state (`TheseusPvpUserMsg` / `TheseusMultiPvpUserMsg`: points, stage, rank, streak, counts, red dots, like and special reward info). The hub items count down to the next season ("Até a próxima temporada") or to the end ("Até o fim da temporada"), and refuse entry between `stopDate` and the next start ("A temporada terminou e está sendo calculada..."). Entering the single arena sends op 1 and switches to `THESE_PVP_SCENE` immediately; leaving sends op 2. If the player's points changed while away (defended as an offline opponent), the server sends an absence report shown when the scene is active.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `godpvpenter.item.TheseusPvpEnterItem` | Arena de Teseu | hub tile: stage name, countdown, red dot | `godpvpenter.GodPvpEnterFrame` | `seasonTimeInfo`, `selfUserInfo.pvpId` (stage name from `TPL/TheseusPvpTmpls.xml`), `redReport || redReward` (`M11/godpvpenter/item/TheseusPvpEnterItem.as:86-150`) |
| `godpvpenter.item.TheseusDoublePvpEnterItem` | Arena MP Teseu | hub tile for MP, buttons join (room list) and create room | hub | MP season and user (`M11/godpvpenter/item/TheseusDoublePvpEnterItem.as:96-160`) |
| `theseuspvp.TheseuspvpBackReportFrame` | | "Na sua ausência, ocorreram as seguintes alterações aos seus pontos de classificação:" with old/new rank, points and stage | 4317 (buffered for `THESE_PVP_SCENE`) via controller `theseuspvp` openType `BACK_REPORT` | `TheseusPvpLeaveReportMsg` (`M3/theseuspvp/TheseuspvpBackReportFrame.as`; `TPM:367-386`) |
| `theseusdoublepvp.TheseuspvpDoubleBackReportFrame` | | same for MP | 580 (buffered for `THESE_Double_PVP_SCENE`), openType `BACK_REPORTDOUBLE` | `TPM:604-623` |

Scene `theseuspvpscene.TheseusPvpScene` (`THESE_PVP_SCENE`, `M3/theseuspvpscene/TheseusPvpScene.as:26-153`): top (season countdown, help), left (6 stage icons with "Pontos de Graduação: {0}"), bottom (match), right (shop, ranking, hall, glory). Details in [single-match.md](single-match.md).

## 3. Routes (client to server)

Single: **C to S 9712 (0x25F0) `C_THESEUS_PVP_CLIENT_OP`**; MP: **C to S 9736 (0x2608) `C_THESEUS_DOUBLEPVP_CLIENT_OP`**. Body `player.PlayerOpMsg`; the client sets `op` (#1, INT32), `id` (#5, INT32) and `count` (#4, INT32) only (`TPM:445-463`). Other `PlayerOpMsg` fields: `type` (#2), `payType` (#3), `index` (#6), `userId` (#7), `templateId` (#8), `campaignId` (#9), `nodeId` (#10), `chapterId` (#11), `uuid` (#12), `value1` (#13), `value2` (#14), `param1` (#15), `param2` (#16), `flag1` (#17), `flag2` (#18), `pos` (#19), `ids` (#20, repeated), unused here.

Op table (`TPM:65-121`): 1 OPEN, 2 LEAVE, 3 MATCH, 4 CANCEL_MATCH, 5 VIEW_REPORT, 6 VIEW_SHOW, 7 GET_REWARD, 8 LIKE, 9 UNLOCK_SPECIAL_REWARD, 10 GET_SPECIAL_REWARD, 11 ONEKEY_GET_SPECIAL_REWARD, 12 VIEW_RANK, 13 VIEW_REWARD, 14 ADD_MATCH_COUNT, 15 BUY_MATCH_COUNT.

| # | Action | UI control | Client sender | Client checks | Request | Responses |
|---|---|---|---|---|---|---|
| E1 | Enter single arena | hub tile click | `TheseusPvpEnterItem.clickHandler` (`TheseusPvpEnterItem.as:175-195`) | dragon talker -> `theseuspvp.enter.dragonTip`; royalty level < `getPvpLv(1)` -> `poseidon.shop.openLv` "Abre com Realeza Nv. {0}"; season not running -> `theseuspvp.inCounting` | 9712 `{op:1}`, then client sets scene `THESE_PVP_SCENE` | 4312 (user), 4320 (season) if changed, 4317 if an absence report is pending |
| E2 | Leave single arena | main toolbar exit in `THESE_PVP_SCENE`, confirm `theseuspvp.return` "Sair da Arena de Teseu?" | `MainToolBar.exitTheseusPvpGame` (`CM/ui/maintoolbar/MainToolBar.as:1919-1931`) | sets `matchState = 1` | 9712 `{op:2}` then return to space | none required; server cancels any pending match |
| E3 | Open MP (create room) | hub "create" | `TheseusDoublePvpEnterItem.clickHandler` -> `TheseusRoomListControler.sendCreateRoom` then `doSomething1(1)` (`TheseusDoublePvpEnterItem.as:218-238`) | same as E1 | 5023 (see [multi-rooms.md](multi-rooms.md)) and 9736 `{op:1}` | 12 (room type 16), 575, 583 |
| E4 | Open MP room list | hub "join" | `joinHandler` -> controller `theseusroomlist` (`:174-193`) | same as E1 | see [multi-rooms.md](multi-rooms.md) | |

## 4. Server messages (server to client)

Receivers registered once in `TheseusPvpManager.setup` (`TPM:206-226`).

| Opcode | Hex | Name | Body | Receiver | Effect |
|---|---|---|---|---|---|
| 4320 | 0x10E0 | `U_C_THESEUS_PVP_SEASON` | `TheseusPvpSeasonMsg` | `__timeInfosHandler` (`TPM:228-239`) | `seasonTimeInfo`; notification `thesepvpUpdateEnterTime` (hub refresh) |
| 583 | 0x0247 | `U_C_THESEUS_PVPDOUBLE_SEASON` | `TheseusMultiPvpSeasonMsg` | `__timeInfosdoubleHandler` (`TPM:465-476`) | same for MP |
| 4312 | 0x10D8 | `U_C_THESEUS_PVP_USER` | `TheseusPvpUserMsg` | `__userInfosHandler` (`TPM:241-262`) | `selfUserInfo`; notification `theseuspvpUserInfoEvent` |
| 575 | 0x023F | `U_C_THESEUS_PVPDOUBLE_USER` | `TheseusMultiPvpUserMsg` | `__userInfosDoubleHandler` (`TPM:478-499`) | same for MP |
| 4317 | 0x10DD | `U_C_THESEUS_PVP_LEAVE_REPORT` | `TheseusPvpLeaveReportMsg` | `__leaveReportInfosHandler`, buffered until `THESE_PVP_SCENE` (`TPM:367-386`) | opens `BACK_REPORT` |
| 580 | 0x0244 | `U_C_THESEUS_PVPDOUBLE_LEAVE_REPORT` | `TheseusMultiPvpLeaveReportMsg` | `TPM:604-623`, buffered until `THESE_Double_PVP_SCENE` | opens `BACK_REPORTDOUBLE` |

Season message fields (both): `seasonId` (#1, INT32), `startDate` (#2, STRING "YYYY-MM-DD hh:mm:ss", season start), `stopDate` (#3, STRING, fights stop; scene countdown and match refusal use it), `closeDate` (#4, STRING, entry close, hub "Até o fim da temporada" countdown).

User message fields (both): `op` (#1, INT32, echo of the request op, A), `integral` (#2, INT32, points), `pvpId` (#3, INT32, current stage template id), `rank` (#4, INT32, ladder rank), `keepWin` (#5, INT32, current win streak), `freeCount` (#6, INT32, free matches left today), `likeInfo` (#7, STRING, "a,b,c": 1 = already liked hall slot 1..3 this season), `specialInfo` (#8, STRING, "gear,x|gear,x" glory gears already claimed), `openPaySpecial` (#9, BOOL, advanced lane unlocked), `redReport` (#10, BOOL, unseen reports), `redReward` (#11, BOOL, claimable rewards), `maxPvpId` (#12, INT32, best stage this season), `addCount` (#13, INT32, extra matches added today by item or purchase), `buyCount` (#14, INT32, purchases made today).

Leave report fields (both): `rank` (#1), `integral` (#2), `pvpId` (#3) (new values), `lastRank` (#4), `lastIntegral` (#5), `lastPvpId` (#6) (values when the player left).

When: 4320/583 and 4312/575 at login (the hub needs them before any request, A) and on change; 4312/575 after every op that changes counts, points, rewards or likes; 4317/580 on entering the scene when points changed while away.

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| S1 | Season start: week `theseus_pvp_open_config` = 1, day 1 of every month at 00:00:00; lasts `theseus_pvp_open_days` = 21 days; fights stop at 22:00:00 of the last day; entry closes 7 days later at 23:00:00 (A from "赛季开始时间,赛季结束时间,擂台入口关闭时间(N天后的时间关闭)") | `TPL/ConfigInfos.xml` |
| S2 | Entry gate: royalty level >= min `RoyaltyLevel` of `TPL/RoyaltyTemplates.xml` rows with `OpenPvp = 1` (6) | `CM/yishi/datas/templates/cate/RoyaltyTempCate.as:106-108,234-238` |
| S3 | Dragon talker state forbids entry | `TheseusPvpEnterItem.as:177-181` |
| S4 | New season: points reset (A: to the first stage), counts reset daily at 00:00 (A) | |

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `TPL/TheseusPvpTmpls.xml` (16) / `TPL/TheseusMultiPvpTmpls.xml` (16) | stages | `Id` (pvpId: single 11..61, MP 1..16), `Name`, `Icon`, `MainType` 1..6, `SonType`, `NeedIntegral`, `WinningStreak`, `OpenShop` (single), `MatchingSection` |
| `TPL/RoyaltyTemplates.xml` | royalty levels | `RoyaltyLevel`, `OpenPvp` |
| `TPL/ConfigInfos.xml` | season keys | see README |

## 7. Persistent state

Schema `theseus_arena`. `mode` is 1 single, 2 MP throughout.

```sql
CREATE TABLE theseus_arena.season (
  mode            smallint NOT NULL CHECK (mode IN (1, 2)),
  season_id       integer NOT NULL,
  starts_at       timestamptz NOT NULL,
  stops_at        timestamptz NOT NULL,
  closes_at       timestamptz NOT NULL,
  settled         boolean NOT NULL DEFAULT false,
  PRIMARY KEY (mode, season_id)
);

CREATE TABLE theseus_arena.player_state (
  mode            smallint NOT NULL,
  season_id       integer NOT NULL,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  server_id       integer NOT NULL,
  points          integer NOT NULL DEFAULT 0,
  stage_id        integer NOT NULL,                    -- pvpId
  best_stage_id   integer NOT NULL,                    -- maxPvpId
  win_streak      smallint NOT NULL DEFAULT 0,
  free_left       smallint NOT NULL,
  added_today     smallint NOT NULL DEFAULT 0,         -- addCount
  bought_today    smallint NOT NULL DEFAULT 0,         -- buyCount
  counters_day    date NOT NULL,
  paid_lane_open  boolean NOT NULL DEFAULT false,      -- openPaySpecial
  red_report      boolean NOT NULL DEFAULT false,
  last_seen_points integer,                            -- for the absence report
  last_seen_rank  integer,
  last_seen_stage integer,
  PRIMARY KEY (mode, season_id, player_id),
  FOREIGN KEY (mode, season_id) REFERENCES theseus_arena.season(mode, season_id)
);
CREATE INDEX ON theseus_arena.player_state (mode, season_id, points DESC);
```

## 8. Backend implementation notes

- `theseus_arena::season::handle_open` (9712/9736 op 1): validate S2, S3 and season window; create `player_state` if missing (stage = first template, free = `theseus_pvp_day_free_count`); daily reset of counters when `counters_day` < today; send 4312/575; if `last_seen_*` differs from current, send 4317/580 and update `last_seen_*`.
- `theseus_arena::season::handle_leave` (9712 op 2): cancel matchmaking, store `last_seen_*`.
- Scheduler: create seasons from S1; push 4320/583 to online players at every boundary; settle at `stops_at` (rank rewards, hall snapshot, see [rewards.md](rewards.md) and [ranking.md](ranking.md)).

## 9. Open questions and assumptions

- (A) Meaning of `op` in the user message; exact S1 interpretation of the third time value.
- (A) Whether points carry over between seasons.

## 10. Implementation checklist

- [ ] Tables `season`, `player_state`
- [ ] 4320/583 and 4312/575 at login
- [ ] Op 1 and op 2 for both opcodes
- [ ] 4317/580 absence report
- [ ] Season scheduler and daily counter reset
- [ ] Tests: entry gate royalty < 6, dragon talker, season gap
