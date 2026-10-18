# Daily sign in ("Check-in diário")

Area: daily-activity, module `daily-sign-in`. Covers `dayguide.SignDayFrame`, `SignView`, `SignDayView`, `SignRewardItemView` (m11), the sign data in `DayGuideManager` (`mvc.module.dayGuide.DaySignInfoData`), the controller `DayGuideController` (open type 1), the template `SignDrop`, and the legacy monthly sign bitset in `PlayerMsg`.

Conventions: see [README.md](README.md).

## 1. Overview

A 10 day sign in card. Each calendar day the player presses "Check-in" once; signed days are ticked. Reaching 2, 5, 8 and 10 signed days in the current cycle unlocks a reward block (items and bound diamonds). The cycle resets on a server date ("Próximo atualização: {0}") and a countdown shows the days left in the cycle. The frame opens automatically at login when today is not signed yet. VIP level 2 and above have "Check-in automático" (VIP privilege type 3).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `dayguide.SignDayFrame` (`decompiled/m11/scripts/dayguide/SignDayFrame.as:35`), 596 x 581 | "Check-in diário" (`signDay.view.SignDayFrame.title`, `:71`) | Hosts `SignView`; on construction sends 8518 (`:38`) and refreshes info tips 25 and 26 | `FrameControllerManager` key `dayguide` with open type 1 (`DayGuideController.frameClassName` `decompiled/core_module/scripts/mvc/controler/DayGuideController.as:57`); blocked during mop up ("mopup.MopupManager.mopupTipData01", `:34`) | `DayGuideManager.daySignInfo` |
| `dayguide.SignView` (`decompiled/m11/scripts/dayguide/SignView.as:62`) | "Total" signed count, "Contagem regressiva de check-in acumulado: {0} dia(s)", "Próximo atualização: {0}", sign button, VIP gift button, client download button (only with `CLIENT_DOWNLAND`) | 10 day cells in 2 rows of 5 (`:80`), 4 reward blocks at signed counts 2, 5, 8, 10 (`SIGN_DAY_INDEX` `:56`) | frame | `signTimes`, `signCycle`, `todayIndex`, `resetDate`, `rewardTag` |
| `dayguide.SignDayView` (`decompiled/m11/scripts/dayguide/SignDayView.as:23`) | day number | Cell: past day frame 4, today frame 1 (signed today frame 2), tick when the day flag is 1 (`setData` `:42`) | view | `signArr[i]`, `todayIndex` |
| `dayguide.SignRewardItemView` (`decompiled/m11/scripts/dayguide/SignRewardItemView.as:29`) | signed count label, items, "claimed" stamp | Reward block of `SignDrop` rows with `Times == n`; greyed and stamped when `n <= rewardTag` (`updateView` `:69`) | view | `SignDrop`, `rewardTag` |

Entry points:

| Entry | Condition | Source |
|---|---|---|
| Login auto open | after the login load, hero level >= 25 and none of mail check, marriage heart question or version broadcast pending: when `signArr[todayIndex - 1] != 1` opens `dayguide` 1, else opens activity points | `decompiled/core_module/scripts/yishi/lunch/Yishi.as:587-:618` |
| Queue bar item type 10 "Check-in diário" | level >= 6 (`decompiled/core_module/scripts/ui/queuebar/QueueBar.as:919`) | `decompiled/core_module/scripts/ui/queuebar/QueueBar.as:341`, label `decompiled/core_module/scripts/ui/queuebar/view/QueueItem.as:454` |
| Task trace bar daily button | none | `TaskTraceBar.dailyActivityBtnClickHandle` `decompiled/core_module/scripts/ui/tasktracebar/TaskTraceBar.as:112` |

## 3. Routes (client to server)

### G1. Sign in today

- UI: sign button (`SignView.__signHandler` `decompiled/m11/scripts/dayguide/SignView.as:172`), enabled when `signArr[todayIndex - 1] != 1` (`:220-:221`).
- Client checks: none besides the enabled state.
- Sender: `DayGuideController.sendSign` `decompiled/core_module/scripts/mvc/controler/DayGuideController.as:66`.
- Route: C>S 8266 (0x204a) `C_PLAYER_SIGN_CMD`, no body.
- Expected response: S>C 4177 with today's flag set to 1 (and `rewardTag` raised when a reward block is reached); bag and diamond updates for reward blocks (assumption: rewards are granted automatically when the signed count reaches `Times`).

### G2. Refresh daily counters on open

- UI: `SignDayFrame` constructor (`decompiled/m11/scripts/dayguide/SignDayFrame.as:38`).
- Route: C>S 8518 (0x2146) `C_CLICKDATALIST`, no body (`DayGuideSocketOutManager.sendDailyCount` `decompiled/core_module/scripts/managers/DayGuideSocketOutManager.as:37`).
- Expected response: S>C 4412 `ClickDatasRspMsg`. Documented in [legacy-day-guide.md](legacy-day-guide.md) S4; the sign frame itself does not use it.

### G3. VIP gift and client download buttons

- VIP gift button: opens `vip` (gift frame when `IsTakeGift` and VIP active) (`SignView.__gifHandler` `:183`); see [../vip/README.md](../vip/README.md).
- Client download: browser download of the desktop launcher (`:232`), no game route.

## 4. Server messages (server to client)

### S1. 4177 (0x1051) `U_C_PLAYER_SIGN`

- Message `player.DaySignInfoMsg`: `signTimes (#1, STRING)` comma separated day flags of the cycle, "1" signed, "0" not, index 0 = cycle day 1; `signCycle (#2, INT32)` cycle length in days; `resetDate (#3, STRING)` text shown as next reset date; `rewardTag (#4, INT32)` highest reward block count already granted (0, 2, 5, 8 or 10); `op (#5, INT32)` not read by the client; `todayIndex (#6, INT32)` 1 based day of the cycle for today.
- Receiver: `DayGuideManager.__signHandler` `decompiled/core_module/scripts/managers/DayGuideManager.as:336`: merges only the fields present (`has*`), then notification `DAY_SIGN_INFO` refreshes `SignView` (`decompiled/m11/scripts/dayguide/SignView.as:195`).
- When: login (mandatory: for heroes of level >= 25 the login flow reads `daySignInfo.signArr` and throws if the message never arrived, `decompiled/core_module/scripts/yishi/lunch/Yishi.as:607`), after G1, at the cycle reset.
- Counting: "Total" = number of "1" in `signTimes` (`DaySignInfoData.signCount` `decompiled/core_module/scripts/mvc/module/dayGuide/DaySignInfoData.as:23`). Countdown = `signCycle - todayIndex`.

### S2. 3 (0x0003) `U_C_PLAYER_INFO` sign fields (legacy)

- `PlayerMsg`: `signDate (#44, STRING)`, `signTimes (#45, INT32)`, `signSite (#46, INT32)` copied into `PlayerInfo` (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:649-:653`). `signSite` is a monthly bitset: day `d` of a month with `n` days is signed when bit `n - d` is set (`DayGuideCatecory.hasSigned` `decompiled/core_module/scripts/mvc/module/dayGuide/DayGuideCatecory.as:532`). Only the unreachable calendar view `DateItemView` reads it. Send 0 or the real bitset; no screen depends on it.

## 5. Rules and formulas

- One sign per server day; the button is disabled once today's flag is 1.
- Cycle length: the UI shows exactly 10 cells and reward blocks at 2, 5, 8, 10, so `signCycle` must be 10 and `signTimes` must have 10 entries (the current prototype in `server/flows.json` sends 30, which only shows the first 10).
- Missed days stay "0" (frame 4, no tick). No make up sign in this frame (the paid make up exists only in [super-sign-in-card.md](super-sign-in-card.md)).
- Reward blocks (`raw/xml/tempinfos/SignDrop.xml`): 2 days `DropId` 17001: "Bolsa de Ouro" 2030102 x1, "Pedra de Refinação de Moda" 2131521 x5, "Pedra dos Deuses" 212018 x2, "Ágata da Vida Nv.2" 2240602 x1; 5 days 17002: bound diamonds -500 x20, 2131521 x8, 212018 x5, 2240602 x2, 2030102 x2; 8 days 17003: 212018 x8, 2240602 x3, 2030102 x3, -500 x50, 2131521 x10; 10 days 17004: -500 x100, 2131521 x12, 212018 x10, "Ágata da Vida Nv.3" 2240603 x1, 2030102 x5.
- A block is shown as claimed when `Times <= rewardTag`; the server sets `rewardTag` to the block it just granted.
- VIP privilege 3 "Check-in automático" (VIP level >= 2): assumption: the server signs automatically at the first login of the day.
- Cycle reset: when `todayIndex` would exceed `signCycle`, start a new cycle (`signTimes` all "0", `rewardTag` 0, `todayIndex` 1, new `resetDate`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/SignDrop.xml` (19 rows, `signDropTemplateCate`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1166`; cate `decompiled/core_module/scripts/yishi/datas/templates/cate/SignDropTemplateCate.as:37`) | `SignDropTemplate` | `DropId`, `Times` signed count (2, 5, 8, 10), `TemplateId` item (negative = currency), `Data` count, `ValidDate` (0) |

## 7. Persistent state

```sql
CREATE TABLE daily_activity.sign_cycle (
    player_id     BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    cycle_start   date        NOT NULL,
    cycle_length  smallint    NOT NULL DEFAULT 10 CHECK (cycle_length > 0),
    signed_mask   integer     NOT NULL DEFAULT 0,
    reward_tag    smallint    NOT NULL DEFAULT 0 CHECK (reward_tag IN (0, 2, 5, 8, 10)),
    last_sign_on  date
);

CREATE TABLE daily_activity.sign_log (
    player_id   BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    signed_on   date        NOT NULL,
    signed_at   timestamptz NOT NULL DEFAULT now(),
    auto_signed boolean     NOT NULL DEFAULT false,
    PRIMARY KEY (player_id, signed_on)
);
```

`todayIndex = (today - cycle_start) + 1`; bit `i` of `signed_mask` = cycle day `i + 1`.

## 8. Backend implementation notes

- `daily_activity::daily_sign_in::push_state(player)`: rolls the cycle when needed, builds 4177 with all fields. Send during the login load (8224) before the client finishes `loginInitDataAcceptComplete`.
- `daily_activity::daily_sign_in::handle_sign` (8266): validate today not signed; in one transaction set the bit, insert `sign_log`, compute `signed = popcount(mask)`, for every `Times` in (2, 5, 8, 10) with `reward_tag < Times <= signed` grant the `SignDrop` rows and raise `reward_tag`; push bag and currency updates, then 4177. Also call `activity_points::record(player, 1, 1)` only if daily login is tied to signing (assumption: it is tied to login instead).
- Auto sign for VIP >= 2 on the first login of the day, before pushing 4177 (assumption).
- Schedule: none required; the state is recomputed lazily from the date.

## 9. Open questions and assumptions

- Reward delivery: no claim route exists, so rewards are assumed to be granted on the sign that reaches the threshold.
- `resetDate` format is free text in the UI; the original value format is unknown (use "YYYY-MM-DD").
- `op` (#5) meaning is unknown.
- Whether VIP auto sign marks the day or only grants the reward is unknown.

## 10. Implementation checklist

- [ ] 4177 pushed at login (required for the client login flow)
- [ ] Table `daily_activity.sign_cycle`, `sign_log`
- [ ] Route 8266 sign with reward block grants
- [ ] Cycle of 10 days with reset
- [ ] VIP auto sign (privilege 3)
- [ ] Queue item 10 and login auto open verified
- [ ] Test: double sign refused, thresholds 2/5/8/10 granted once, cycle rollover
