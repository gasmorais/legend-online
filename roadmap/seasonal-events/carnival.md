# Carnival ("Folia", 节日嘉年华)

Feature `seasonal-events`, module `carnival`. Client package `carnvial` (sic, `M11/carnvial/*`), shared code `CM/yishi/manager/CarnivalManager.as` (`CAM`), `CM/mvc/module/carnival/CarnivalModel.as`, `CM/mvc/module/carnival/CarnivalTaskInfo.as`. Proto package `carnival`. The three mini games are the air garden games ([air-garden.md](air-garden.md)).

Conventions: see [README.md](README.md).

---

## 1. Overview

A holiday event (window `CarnivalStartDate`..`CarnivalStopDate`, for example `2024-12-24 12:00:00`..`2025-01-06 23:59:59`) with one frame and eight tabs ("carnival.tab.names"): "Pontos de Folia" | "Recarga Premiada" | "Virada da Sorte" | "Pacotes Especiais" | "Tesouro da Sorte" | "Missão Diária" | "Joguinho" | "Prêmio Online".

- "Pontos de Folia" (carnival points, currency -20000) are earned by recharge, "Tesouro da Sorte" and daily tasks; 25 point milestones give rewards.
- "Recarga Premiada": one wheel spin per 100 diamonds recharged.
- "Virada da Sorte": same digit draw as Christmas (up to 4 draws unlocked by accumulated recharge).
- "Pacotes Especiais": 4 daily packs.
- "Tesouro da Sorte": spend 1 "Moeda da Folia" (208600) for an item plus carnival points.
- "Missão Diária": 8 daily tasks, 5 points each.
- "Joguinho": 3 mini games (match pairs, memory cards, five cards), 3 rewarded plays each per day when the target score is reached.
- "Prêmio Online": 6 rewards by online minutes today.

The theme (images under `images/carnival/<CarnivalTabControl>/`) is selected by config `CarnivalTabControl` (101) (`CarnivalModel.as:45`, `CarnvialMainFrame.as:187-191`).

---

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `carnvial.CarnvialMainFrame` (`M11/carnvial/CarnvialMainFrame.as`) | "Data: {0}--{1}" (`carnival.active.time`) from `CarnivalStartDate`/`CarnivalStopDate` | Tab frame | Tool bar `carnival` (TopToolBtnInfo 4025, `CM/ui/toptoolbar/TopToolsBar.as:1509-1510`), visible when `CarnivalManager.isOpen` (`TopBtnCheckShowHelper.as:417-418`) | Tabs below; a lock layer blocks input during animations (`CarnivalLockOper`) |
| `view.CarnvialYearPage` | "Pontos de Folia" | Point milestones | Tab 1 | `score`, next target, 25 boxes (`CarnivalPointExchange` Type 1) claimed from `scoreRewardInfo` |
| `view.CarnivalRechargePage` | "Recarga Premiada" | Wheel | Tab 2 | `totalCharge` ("Recarregado:"), spins "Sorteios: {0}" = `lotteryCount`, outer ring (LuckDraw MT1 SonType 1, 14), inner ring (SonType 2, 8), win chat line "Parabéns! Você obteve: {0}x{1}!" |
| `view.CarnivalLuckPage` + `item.CarnivalTurnItem` | "Virada da Sorte" | Digit draw | Tab 3 | `luckCount` "Sorteios Restantes", `luckNum` digits, "Ganho Acumulado:", "1ª..4ª vez" log |
| `view.CarnivalDiscountPage` + `item.CarnivalGiftBox` | "Pacotes Especiais" | Daily packs | Tab 4 | `dayCharge` "Recarregue hoje:", daily reset "Reseta todo dia às 00:00", remaining per pack ("carnival.gift.free/noCondition/needPoint") |
| `view.CarnivalBaoPage` | "Tesouro da Sorte" | Coin draw | Tab 5 | Coin count, left pool (MT3 SonType 1), right pool (MT3 SonType 2 carnival points), result "Parabéns! Você obteve: {0}, {1}!" |
| `view.CarnivalDayTaskPage` + `item.CarnivalTaskItem` | "Missão Diária" | Tasks | Tab 6 | "{Title}({data}/{Para1})", "Pontos: +{0}", claim |
| `view.CarnivalGamePage` + `item.CarnivalGameItem` | "Joguinho" | Mini game list | Tab 7 | 3 games, "Ganhos disponíveis atuais: {0}" = `PlayCount - played` from `gameInfo`, rewards |
| `view.CarnivalOnlinePage` + `item.CarnivalOnLineBox` | "Prêmio Online" | Online boxes | Tab 8 | "Total online hoje:" = `dayOnline + minutes since frame opened` (`CarnivalOnlinePage.as:110-130`), 6 boxes (Type 3) |
| Air garden game frames | see [air-garden.md](air-garden.md) | The mini game itself | 381 push after op 9 | Target score "samll.game.score" from `CarnivalPlayGroundTemplates.Target` |

---

## 3. Routes (client to server)

Single route: **9019 (0x233b) `C_CARNIVAL_OP`**, body `player.PlayerOpMsg`, sender `CarnivalManager.opRequest(op, id = 0)` (`CAM:137-143`). Only `op (#1, INT32)` and `id (#5, INT32)` are set (full `PlayerOpMsg` field list in [christmas.md](christmas.md) section 3).

| op | Name (`CAM:24-32`) | UI control | Client sender (file:line) | Client checks | id | Expected response |
|---|---|---|---|---|---|---|
| 1 | OP_OPEN | Frame opens | `CarnvialMainFrame()` (`CarnvialMainFrame.as:86-93`) | none | 0 | 4304, 4305 |
| 2 | OP_SCORE_REWARD | milestone box | `CarnivalYearBigBox.clickHandler` (`item/CarnivalYearBigBox.as:156-161`), `CarnivalYearSmallBox.clickHandler` (`item/CarnivalYearSmallBox.as:79-84`) | box active when `Target <= score` and id not in `scoreRewardInfo` | PointExchange Type 1 id | 4304 with `scoreRewardInfo` extended |
| 3 | OP_CHARGE_LOTTERY | "Recarga Premiada" spin | `CarnivalRechargePage.clickHandler` (`view/CarnivalRechargePage.as:219-224`) | button enabled when `lotteryCount > 0` (`:276`) | 0 | 4304 with `opType 3`, `result` = won LuckDraw id (MT1), `lotteryCount - 1`; the page stops the light on that id (`:226-271`) |
| 4 | OP_LUCK_LOTTERY | "Virada da Sorte" turn | `CarnivalTurnItem.clickHandler` (`item/CarnivalTurnItem.as:354-361`) | enabled when `luckCount > 0` | 0 | 4304 `opType 4`, new `luckNum`, `luckCount` |
| 5 | OP_BUY_GIFT | pack button | `CarnivalGiftBox.clickHandler/sendBuy` (`item/CarnivalGiftBox.as:96-127`) | `Price > 0`: diamonds >= Price else recharge alert, confirm "Gastar {0} diamantes para comprar o pacote {1}?"; button enabled when `Target <= dayCharge` and bought < daily limit (`:201-280`) | PointExchange Type 2 id | 4304 with `giftBuyInfo`; bag and wallet pushes |
| 6 | OP_LUCK_TREASURE | "Tesouro da Sorte" start | `CarnivalBaoPage.clickHandler` (`view/CarnivalBaoPage.as:99-104`) | the page enables the button when coin count >= `CarnivalLuckyDraw[1]` *(read at `:72-77`)* | 0 | 4304 with `result` = "itemRowId,pointRowId" (two LuckDraw MT3 ids, SonType 1 and 2) and new `score`; 4305 (task type 3) |
| 7 | OP_TASK_REWARD | task claim | `CarnivalTaskItem.clickHandler` (`item/CarnivalTaskItem.as:74-79`) | `Para1 <= data` and not rewarded | DailyChallenge id | 4305 (`isReward`), 4304 (`score + Points`) |
| 8 | OP_ONLINE_REWARD | online box | `CarnivalOnLineBox.clickHandler` (`item/CarnivalOnLineBox.as:72-77`) | `Target <= online minutes`, id not in `onlineRewardInfo` | PointExchange Type 3 id | 4304 with `onlineRewardInfo` extended |
| 9 | OP_GAME | game "start" | `CarnivalGameItem.startHandler` (`item/CarnivalGameItem.as:81-88`) | none | PlayGround `Type` (1 match pairs, 2 memory, 3 five cards) | **381** `U_C_AIR_GARDEN_GAME_OPEN` `CommonMsg{param1 = type}` opens the game frame (`CM/managers/AirGardenManager.as` `__gameStartBackHandler`), then the game protocol of [air-garden.md](air-garden.md); 4304 with `gameInfo` after a rewarded play |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Client receiver | When | Client reaction |
|---|---|---|---|---|---|
| 4304 (0x10d0) | U_C_CARNIVAL_DATA | `carnival.CarnivalMsg` | `CarnivalManager.__activeInfoHandler` (`CAM:69, 95-114`) | Response to every op; push on recharge, online tick *(optional)*, daily reset | Copies fields, fires `carn.EVENT_UPDATE` with `data = opType`; pages refresh, animation pages use `opType` |
| 4305 (0x10d1) | U_C_CARNIVAL_TASK_DATA | `carnival.CarnivalTaskListMsg` | `__taskInfoHandler` (`CAM:70, 116-135`) | Response to ops 1, 6, 7; push when a task counter changes | Merges by `taskId`, fires `carn.EVENT_UPDATE` |
| 4590 (0x11ee) | U_C_TOP_TOOL_BTN | `simple.PropertyMsg` | `__topBtnHandler` (`CAM:71, 74-93`) | Window start and end; `param1 = 4025` | `isOpen = param7`; when false disposes the open carnival frame; fires `REFRESH_TOPTOOLS` |
| 381 | U_C_AIR_GARDEN_GAME_OPEN | `CommonMsg` | `AirGardenManager.__gameStartBackHandler` | After op 9 | Opens the mini game frame (see [air-garden.md](air-garden.md)) |

`CarnivalMsg` fields: `opType` (#1, INT32) echoed op; `score` (#2, INT32) carnival points; `scoreRewardInfo` (#3, STRING) claimed milestone ids "id,id"; `totalCharge` (#4, INT32) recharge in the event; `lotteryCount` (#5, INT32) "Recarga Premiada" spins left; `dayCharge` (#6, INT32) today's recharge; `giftBuyInfo` (#7, STRING) "id,count\|id,count" today; `dayOnline` (#8, INT32) minutes online today at send time; `onlineDate` (#9, STRING) not read; `onlineRewardInfo` (#10, STRING) claimed online box ids "id,id"; `luckCount` (#11, INT32) digit draws left; `luckNum` (#12, INT32) revealed digits; `gameInfo` (#13, STRING) "type,playedRewarded\|..." today; `result` (#14, STRING) last draw result.

`CarnivalTaskMsg`: `taskId` (#1, INT32) DailyChallenge id; `data` (#2, INT32) progress; `isReward` (#3, BOOL) claimed. `CarnivalTaskListMsg`: `tasks` (#1, CarnivalTaskMsg, repeated).

No error code; refusals return a tip *(assumption)* and the unchanged 4304.

---

## 5. Rules and formulas

Config (`ConfigInfos.xml`):

| Key | Value | Meaning |
|---|---|---|
| `CarnivalStartDate`, `CarnivalStopDate` | 2024-12-24 12:00:00, 2025-01-06 23:59:59 | Window |
| `CarnivalTabControl` | 101 | Theme folder |
| `CarnivalRebate` | 100,500,4000,20000 | Accumulated recharge thresholds for "Virada da Sorte" draws |
| `CarnivalPayLuckyDraw` | 100 | Diamonds recharged per "Recarga Premiada" spin |
| `CarnivalLuckyDraw` | 208600,1 | "Tesouro da Sorte" cost item and count |
| `CarnivalDailControl` | 00:00:00 | Reset time of daily tasks, packs, online boxes and games |
| `CarnivalPayCount` | 100,15 | Carnival points per recharge: 15 per 100 diamonds (help text says 5: the config wins) |
| `carnival_buy_gift_limit` | 2001,1\|2002,5\|2003,3\|2004,2 | Daily limit per pack id |

- **Recharge hook**: `totalCharge += n`, `dayCharge += n`, `lotteryCount += floor` of new 100-diamond blocks (carry the remainder), `score += floor(n / 100) * 15`, digit draws unlocked by `CarnivalRebate`.
- **Recarga Premiada**: weighted roll over all LuckDraw MT1 rows (both rings) *(assumption: one roll over 22 rows; the UI lights the ring that contains the id)*.
- **Virada da Sorte**: identical to Christmas (LuckDraw MT2 SonType k = digit k, diamonds), see [christmas.md](christmas.md) section 5.
- **Tesouro da Sorte**: consume 1 x 208600, roll one MT3 SonType 1 item and one MT3 SonType 2 row (`-20000` x 1/2/4/6/10, weights 50/30/15/3/2), add points to `score`; increments task type 3.
- **Packs** (PointExchange Type 2): 2001 free, 2002 200 diamonds, 2003 500 diamonds needs `dayCharge >= 500`, 2004 1500 diamonds needs `dayCharge >= 2500`; limits above.
- **Online boxes** (Type 3): 10/20/40/60/100/140 minutes today.
- **Milestones** (Type 1): 25 targets 100..10000 points, claim once each.
- **Daily tasks**: `CarnivalDailyChallengeTemplates` `TaskType` 3 Tesouro da Sorte (5), 7 Yggdrasil energize a friend (1), 8 archaeology or astronomy digs (5), 9 Einherjar arena (2), 10 game hall (1), 11 multiplayer campaign "Portal dos Heróis" (1), 12 world boss (1), 13 battlefield (1). +5 points each. Hooks come from those features.
- **Mini games**: `PlayCount` 3 rewarded plays per type per day; a play is rewarded when the final score >= `Target` (500, 500, 1000); reward `Item1..4` x `ItemNum1..4`.
- Frame closes when 4590 says closed (`CAM:84-90`).

---

## 6. Templates

| File | Records | Fields |
|---|---|---|
| `CarnivalPointExchangeTemplates.xml` | 35 | `Id`, `Type` 1 milestones, 2 packs, 3 online boxes; `Sort` display order (pack number); `Target` points, recharge or minutes; `Price` diamonds; `Item1..4`, `ItemNum1..4` |
| `CarnivalLuckDrawTemplates.xml` | 84 | `Id`, `MasterType` 1 recharge wheel (SonType 1 outer, 2 inner), 2 digit draw (SonType = digit), 3 treasure (SonType 1 item, 2 points); `Item`, `ItemNum`, `Random` weight |
| `CarnivalDailyChallengeTemplates.xml` | 8 | `Id`, `TaskType`, `Title`, `Description` (pt-BR), `Para1` goal, `Points` |
| `CarnivalPlayGroundTemplates.xml` | 3 | `Id`, `Type` game, `Target` score, `PlayCount`, `Item1..4`, `ItemNum1..4` |
| `TopToolBtnInfos.xml` | | `carnival` 4025 |

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.carnival_players (
  window_id         integer NOT NULL REFERENCES seasonal_events.event_windows(window_id),
  player_id         bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  score             integer NOT NULL DEFAULT 0,
  total_charge      integer NOT NULL DEFAULT 0,
  charge_remainder  integer NOT NULL DEFAULT 0,
  wheel_spins       integer NOT NULL DEFAULT 0 CHECK (wheel_spins >= 0),
  lucky_draws_done  smallint NOT NULL DEFAULT 0 CHECK (lucky_draws_done BETWEEN 0 AND 4),
  lucky_number      integer NOT NULL DEFAULT 0,
  day_date          date    NOT NULL DEFAULT current_date,
  day_charge        integer NOT NULL DEFAULT 0,
  day_online_min    integer NOT NULL DEFAULT 0,
  PRIMARY KEY (window_id, player_id)
);

CREATE TABLE seasonal_events.carnival_claims (
  window_id    integer NOT NULL,
  player_id    bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id  integer NOT NULL,
  day_date     date    NOT NULL DEFAULT '1970-01-01',
  count        smallint NOT NULL DEFAULT 1,
  PRIMARY KEY (window_id, player_id, template_id, day_date)
);
-- milestones use day_date = '1970-01-01' (once per window); packs and online boxes use the real day

CREATE TABLE seasonal_events.carnival_tasks (
  window_id  integer NOT NULL,
  player_id  bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day_date   date    NOT NULL,
  task_id    integer NOT NULL,
  progress   integer NOT NULL DEFAULT 0,
  rewarded   boolean NOT NULL DEFAULT false,
  PRIMARY KEY (window_id, player_id, day_date, task_id)
);

CREATE TABLE seasonal_events.carnival_games (
  window_id  integer  NOT NULL,
  player_id  bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day_date   date     NOT NULL,
  game_type  smallint NOT NULL CHECK (game_type BETWEEN 1 AND 3),
  rewarded_plays smallint NOT NULL DEFAULT 0,
  PRIMARY KEY (window_id, player_id, day_date, game_type)
);
```

---

## 8. Backend implementation notes

| Handler | op | Validation | Transaction and pushes |
|---|---|---|---|
| `seasonal_events::carnival::handle_open` | 1 | window open | roll daily state if `day_date` changed; 4304, 4305 |
| `seasonal_events::carnival::handle_score_reward` | 2 | Type 1 → `score >= Target` → not claimed → bag space | tx; 4304 |
| `seasonal_events::carnival::handle_charge_lottery` | 3 | `wheel_spins > 0` | tx: decrement, roll, grant; 4304 `opType 3` |
| `seasonal_events::carnival::handle_luck_lottery` | 4 | draws unlocked > draws done | tx: roll digit, credit diamonds; 4304 `opType 4` |
| `seasonal_events::carnival::handle_buy_gift` | 5 | Type 2 → daily limit → `day_charge >= Target` → diamonds | tx; 4304 |
| `seasonal_events::carnival::handle_luck_treasure` | 6 | 208600 >= 1 | tx: consume, two rolls, grant item and points, task type 3; 4304, 4305 |
| `seasonal_events::carnival::handle_task_reward` | 7 | progress >= Para1 → not rewarded | tx: score += Points; 4305, 4304 |
| `seasonal_events::carnival::handle_online_reward` | 8 | Type 3 → online minutes >= Target → not claimed today | tx; 4304 |
| `seasonal_events::carnival::handle_game` | 9 | type 1..3 | open a mini game session tagged `carnival` in the air garden game service; 381 |
| `seasonal_events::carnival::on_game_finished` | callback from the mini game service | session tagged carnival → score >= Target → rewarded plays < PlayCount | tx: grant, increment; 4304 |

- Hooks: recharge, online time, and the 8 task sources (Yggdrasil, archaeology, Einherjar arena, game hall, multiplayer campaign, world boss, battlefield).
- Schedule: daily reset at `CarnivalDailControl`; 4590 broadcast at window start and end.
- No battle.

---

## 9. Open questions and assumptions

- *(assumption)* "Recarga Premiada" rolls over both rings together; the client only displays the result id.
- *(assumption)* Mini game rewards are granted once the game session ends (the carnival protocol has no "finish" op; the mini game protocol does).
- The help text says 5 points per 100 diamonds; config `CarnivalPayCount` says 15. Use config.
- `onlineDate` is never read.

---

## 10. Implementation checklist

**Screens:**
- [ ] Tool bar button 4025, main frame with 8 tabs and theme images

**Routes (9019):**
- [ ] op 1 open, op 2 milestone, op 3 wheel, op 4 digit draw, op 5 pack, op 6 treasure, op 7 task, op 8 online, op 9 game

**Server messages:**
- [ ] 4304 with `opType` echo and `result` formats
- [ ] 4305 task list
- [ ] 4590 (param1 4025)
- [ ] 381 game open

**Tables:**
- [ ] `carnival_players`, `carnival_claims`, `carnival_tasks`, `carnival_games`

**Rules:**
- [ ] Recharge hook (points, spins, draws)
- [ ] Daily reset
- [ ] Task hooks from 7 features

**Tests:**
- [ ] Pack 2004 refused when today's recharge < 2500
- [ ] Wheel refused with 0 spins; spins carry remainders correctly
- [ ] Mini game below target gives nothing and does not consume a rewarded play
