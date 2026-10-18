# Theseus arena: single arena matches

Module `theseus_arena::single_match`. Prefixes as in [README.md](README.md).

## 1. Overview

In `THESE_PVP_SCENE` the player presses match (op 3). The client shows a "matching" animation (`matchState = 0`) until the server pushes 4318. On `state = 2` the client plays the VS view for 3 s, then the server starts battle 3907 `THESE_PVP_BATTLE` against the opponent (an asynchronous mirror of another player, A: the opponent is "defending" offline, see report `mode`). After the battle the client returns to `THESE_PVP_SCENE` and the buffered 4319 opens the result frame. Each match consumes one of `freeCount + addCount`. More matches: buy with diamonds (op 15) or consume the item "Rolo de Desafio da Arena de Teseu" 7640003 (op 14).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `theseuspvpscene.view.TheseuspvpBottomView` | | stage name and icon, progress to next stage ("Próximo estágio: {0}"), "Restam: {0}" matches, match/cancel buttons, buy button, item use icon (tip "Clique para usar e aumentar o número de vezes"), report and reward buttons with red dots | scene | `selfUserInfo`, `TPL/TheseusPvpTmpls.xml` (`M3/theseuspvpscene/view/TheseuspvpBottomView.as:92-357`) |
| `theseuspvpscene.view.TheseuspvpMatchView` | | VS animation of `matchSelfInfo` vs `matchOtherInfo`, closes after 3 s | `matchState == 2` (`TheseuspvpBottomView.as:232-237`) | `M3/theseuspvpscene/view/TheseuspvpMatchView.as:52-81` |
| `theseuspvpscene.view.TheseusPvpSceneTopView` | | "Até o fim da temporada: {0}" from `stopDate`, help | scene | `M3/theseuspvpscene/view/TheseusPvpSceneTopView.as:53-106` |
| `theseuspvpscene.view.TheseusPvpLeftView` | | 6 stage icons, tips "Pontos de Graduação: {0}" | scene | `M3/theseuspvpscene/view/TheseusPvpLeftView.as:120-143` |
| `theseuspvpscene.view.TheseuspvpSceneRightView` | | buttons shop (1027), ranking (`SORT`), hall (`GLORY`), glory rewards (`PRIVATE`) | scene | `M3/theseuspvpscene/view/TheseuspvpSceneRightView.as:42-74` |
| `theseuspvp.TheseusPvpResultFrame` | | win/lose, "Rank: {0}" old and new, points delta with "(vitórias x{0}, extra +{1})", stage change, progress, "Prêmio:" items | 4319 via `BATTLE_RESULT` | `TheseusPvpFightResultMsg` (`M3/theseuspvp/TheseusPvpResultFrame.as:160-250`) |
| `theseuspvp.TheseusPvpBuyTimeFrame` | Mais Combinações | choose how many 7640003 items to use ("Adições:", "Possui: {0} x {1}") | item icon (`BUY_TIME`) | bag count of 7640003 (`M3/theseuspvp/TheseusPvpBuyTimeFrame.as:146-193`) |

## 3. Routes (client to server)

Opcode 9712 `C_THESEUS_PVP_CLIENT_OP`, `PlayerOpMsg` (see [season.md](season.md)).

| # | Action | UI control | Client sender | Client checks | Request | Responses (in order) |
|---|---|---|---|---|---|---|
| M1 | Match | `_matchBtn` | `TheseuspvpBottomView.matchHandler` (`:325-341`) | now < `stopDate` else `theseuspvp.inCounting`; `freeCount + addCount > 0` else `theseuspvp.fightNeedGood` "Desafios insuficientes" | `{op:3}` | 4318 `state 0` (matching), later 4318 `state 2` with both players, then the battle start sequence (battle 3907), after the battle 4312 and 4319 |
| M2 | Cancel match | `_cancelBtn` | `cancelHandler` (`:343-346`) | none | `{op:4}` | 4318 `state 1` |
| M3 | Buy one match | `_buyBtn` | `buyClickHandler` -> `confirmChoose` (`:284-318`) | price for purchase `buyCount + 1` from `theseus_pvp_buy_count_points`; none -> `theseuspvp.buyMax` "As compras de hoje atingiram o limite"; confirmation `theseuspvp.buyAlert` "Deseja gastar {0} diamantes para obter mais 1 vez para emparelhar?..." | `{op:15}` | 4312 (`buyCount`, `addCount`), diamond update |
| M4 | Use challenge items | Buy Time frame confirm | `TheseusPvpBuyTimeFrame._sloveClickHandler` (`:153-157`) | 1 <= n <= bag count of 7640003 | `{op:14, id:0, count:n}` | 4312 (`addCount`), bag update |
| M5 | Leave | toolbar exit | see [season.md](season.md) E2 | | `{op:2}` | |

## 4. Server messages (server to client)

### 4318 (0x10DE) `U_C_THESEUS_PVP_MATCH`, `TheseusPvpMatchMsg`

Receiver `__matchInfosHandler` (`TPM:388-417`): `state` (#1, INT32) -> `model.matchState`: 0 matching (spinner, toolbar state 3), 1 idle (match button), 2 matched (VS view). `players` (#2, repeated `TheseusPvpMatchPlayerMsg`: `integral` #1, `pvpId` #2, `nickName` #3, `serverName` #4, `job` #5, `fightCapacity` #6); the row whose `nickName + "_" + serverName` equals the own name and server is self, the other is the opponent. Notification `theseuspvpMatchEvent`.

### 4319 (0x10DF) `U_C_THESEUS_PVP_FIGHT_RESULT`, `TheseusPvpFightResultMsg`

Receiver `__resultInfosHandler` sets `matchState = 1` and buffers until `THESE_PVP_SCENE` (`TPM:419-443`), then opens `BATTLE_RESULT`. Fields: `isWin` (#1, BOOL), `rank` (#2, INT32), `integral` (#3, INT32), `pvpId` (#4, INT32), `lastRank` (#5), `lastIntegral` (#6), `lastPvpId` (#7), `keepWin` (#8, INT32, streak length), `keepWinIntegral` (#9, INT32, streak bonus included in the delta), `rewardInfo` (#10, STRING "itemId,count|itemId,count", per battle drops).

### Battle

Battle type 3907: P-PVP, no hero bar, no team strip, sealed skill locked (`docs/battle/rules.md`); exit scene `THESE_PVP_SCENE` (`CM/battle/handler/BattleResultHandler.as:306-308`).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| P1 | Daily free matches `theseus_pvp_day_free_count` = 5 | config; `TheseuspvpBottomView.as:203` |
| P2 | Purchases `theseus_pvp_buy_count_points` = 1,20\|2,30\|3,50\|4,50\|5,100: n-th purchase costs that many diamonds, max 5 a day; purchased and item matches are usable only the same day ("as vezes compradas só podem ser usadas no mesmo dia") | config; LANG `theseuspvp.buyAlert`, `theseuspvp.MaxAdd` |
| P3 | Item 7640003 "Rolo de Desafio da Arena de Teseu": +1 match each (A: 1 per item; MP uses 7640004 "Bilhete de Desafio Interservidores"); daily cap "até {0} adições por dia" (A: server value) | `TheseusPvpBuyTimeFrame.as:148`; LANG `theseuspvp.MaxAdd` |
| P4 | Opponent search: candidates whose points are inside the current stage `MatchingSection` (e.g. Prata I 0..500, Hall 7750..99999); not the same opponent again within `theseus_pvp_matching_cd` minutes by MainType (1:60, 2:30, 3:30, 4:20, 5:15, 6:10) | `TPL/TheseusPvpTmpls.xml`; config |
| P5 | Points: `TPL/TheseusPvpIntegralTmpls.xml` row by own `PvpId`, `Mode` and `Section` (A: Section = opponent points minus own points). Mode 0 (attacker, the player who pressed match): win +Victory (100 when far below, down to 40 when far above), loss 0 (A: Defeat column = points lost, 0 for attackers). Mode 1 (defender, the matched opponent): win +Victory, loss -Defeat (30..90). The defender's change is what the absence report 4317 shows | templates; report `mode` 0/1 (`M3/theseuspvp/item/TheseusPvpReportItem.as:112`) |
| P6 | Win streak bonus `WinningStreak` = 3,10\|4,20\|...\|10,80: at streak n add the listed points (A: streaks above 10 keep 80) -> `keepWinIntegral` | `TPL/TheseusPvpTmpls.xml` |
| P7 | Stage = highest template with `NeedIntegral <= points` (Prata I 0, Prata II 200, Prata III 500, ..., Lenda III 8750, Hall 10000). (A) Points never below 0 | templates |
| P8 | Data note: Section "-299,200" in `TheseusPvpIntegralTmpls.xml` overlaps; read it as -299..-200 like the MP file | template data |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `TPL/TheseusPvpTmpls.xml` | stage | `Id`, `Name`, `MainType`, `SonType`, `NeedIntegral`, `WinningStreak`, `MatchingSection`, `OpenShop` |
| `TPL/TheseusPvpIntegralTmpls.xml` (352) | points table | `PvpId`, `Section`, `Mode`, `Victory`, `Defeat` |
| `TPL/ConfigInfos.xml` | `theseus_pvp_day_free_count`, `theseus_pvp_buy_count_points`, `theseus_pvp_matching_cd` | |
| `TPL/ItemTempInfos.xml` | 7640003 | |

## 7. Persistent state

```sql
CREATE TABLE theseus_arena.match (
  match_id        bigserial PRIMARY KEY,
  mode            smallint NOT NULL,                   -- 1 single, 2 MP
  season_id       integer NOT NULL,
  attacker_id     integer NOT NULL REFERENCES player.players(player_id),
  defender_id     integer NOT NULL REFERENCES player.players(player_id),
  attacker_won    boolean NOT NULL,
  attacker_delta  integer NOT NULL,
  defender_delta  integer NOT NULL,
  streak_bonus    integer NOT NULL DEFAULT 0,
  battle_id       text,
  fought_at       timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX ON theseus_arena.match (mode, season_id, attacker_id, fought_at DESC);
CREATE INDEX ON theseus_arena.match (mode, season_id, defender_id, fought_at DESC);
```

Counters live in `theseus_arena.player_state` ([season.md](season.md)). Matchmaking queue is in memory.

## 8. Backend implementation notes

- `theseus_arena::single_match::handle_match` (op 3): validate season running, counts > 0, not already queued; queue the player, send 4318 `state 0`; search P4 among `player_state` rows (offline mirrors allowed); on hit: consume one match (free first, then added), send 4318 `state 2` with both players, wait about 3 s, start battle 3907 (player hero and army vs the opponent snapshot).
- `handle_cancel_match` (op 4): dequeue, 4318 `state 1`.
- `handle_buy_match` (op 15): P2 price by `bought_today + 1`, debit diamonds, increment `added_today` and `bought_today`, send 4312.
- `handle_add_match` (op 14): validate `count` <= bag count and daily cap, consume items, add, send 4312.
- On battle end: P5/P6/P7 for both sides, insert `match`, set defender `red_report`, compute rank, task counters ([rewards.md](rewards.md)); send 4312 then 4319 (buffered by the client until the scene is back).

## 9. Open questions and assumptions

- (A) Section sign convention; whether attackers lose points (Defeat = 0 in Mode 0 suggests not).
- (A) Item daily cap and per item value.
- (A) Fallback when no opponent is found (timeout then 4318 `state 1`).

## 10. Implementation checklist

- [ ] Ops 3, 4, 14, 15
- [ ] 4318 states 0/1/2, 4319 result with `rewardInfo`
- [ ] Battle 3907 against an offline snapshot
- [ ] Points P5, streak P6, stage P7, cooldown P4
- [ ] Table `match`
- [ ] Tests: no counts, buy beyond 5, cancel while matched, streak 3 bonus, Section boundaries
