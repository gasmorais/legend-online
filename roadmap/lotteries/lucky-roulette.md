# Roleta da Sorte (internal lottery, "幸运轮盘")

Path aliases:

| Alias | File |
|---|---|
| LM | `decompiled/core_module/scripts/managers/LotteryManager.as` |
| LMOD | `decompiled/core_module/scripts/mvc/module/lottery/LotteryModel.as` |
| LINF | `decompiled/core_module/scripts/mvc/module/lottery/LotteryInfo.as` |
| LC | `decompiled/core_module/scripts/mvc/controler/LotteryController.as` |
| LF | `decompiled/m11/scripts/lottery/LotteryFrame.as` |
| LTC | `decompiled/m11/scripts/lottery/LotteryTurnControl.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A timed event wheel. During the event every `onceNeedPoint` diamonds the player spends (consumption, not recharge) grant one draw chance, capped by `dayMaxCount` chances gained per day. A draw spins a 16 slot wheel and gives the item the wheel stops on. A scrolling panel shows the recent winners of the server. The frame closes itself when the event closes.

Server names: opcodes 8748 `C_LOTTERY_REWARD` ("内部抽奖抽奖", internal lottery draw) and 8750 `C_LOTTERY_REQUEST` ("内部抽奖客户端请求抽奖信息") (`decompiled/core_module/scripts/yishi/datas/consant/ProtocolTypeTable.as:1296-1297`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `lottery.LotteryFrame` (LF), 868x502 | "Roleta da Sorte" (`lottery.LotteryFrame.titleText`, LF:100) | Wheel of up to 16 `LotteryBoxItem` (slots 0..5 top row, 6..8 right, 9..13 bottom, 14..15 left, LF:191-237); draw button; progress bar to the next chance; remaining chances; countdown days/hours/minutes/seconds; rules; winners panel | Top toolbar button `lottery` (TopToolBtnInfos 2026 "幸运轮盘", tip "Roleta da Sorte") via `FrameControllerManager.openControllerByInfo("lottery")` (TTB:1170-1173) -> `LotteryController.frameClassName = "lottery.LotteryFrame"` (LC:29) | `leftCount` (chances), `payedPoint` (diamonds spent in the event), `onceNeedPoint - payedPoint % onceNeedPoint` (diamonds still needed for the next chance, LF:145-148), "Você já atingiu o limite da quantidade de sorteios do dia" when `dayAddCount >= dayMaxCount` (LF:149-162), rules "1.Durante o evento consumindo acumuladamente {0} diamantes, poderá obter uma chance de sorteio<br/>2. Durante o evento, poderá apenas obter {1} chances de sorteio" with `onceNeedPoint`, `dayMaxCount` (LF:144), countdown from `leftMillis` (LF:178-189) |

Toolbar visibility: `thane.grades >= 10 && lotteryModel.info.isOpen` (TBH:265-266). The toolbar repaints on `LOTTERY_STATE` (TTB:409).

## 3. Routes (client to server)

### R1. Open the frame (load info)
- UI: `LotteryFrame` constructor (LF:85).
- Sender: `LotteryManager.requestInfo()` (LM:108-112).
- Client checks: none (the toolbar button only opens when `isOpen`).
- Route: C>S 8750 (0x222e) `C_LOTTERY_REQUEST`, empty body (`sendProtobuffer(pkg, null)`).
- Expected response, in order: 4636 `U_C_LOTTERY` (S2), 4641 `U_C_LOTTERY_ITEMS` (S3), 4639 `U_C_LOTTERY_NOTICE` (S4). The frame initializes on the first 4636 (LF:169-176) and builds the wheel on 4641 (LF:342-345).

### R2. Draw
- UI: draw button `_btn` (LF:356-371).
- Sender: `LotteryManager.senLotteryRolette()` (LM:114-118).
- Client checks: `leftCount > 0` else tip "Quantidade de chances de sorteio insuficientes" (LF:358-362); wheel not empty (LF:363-366). Disables the close button and the draw button until the animation ends.
- Route: C>S 8748 (0x222c) `C_LOTTERY_REWARD`, empty body.
- Expected response: 4642 `U_C_LOTTERY_RESULT` (S5), then bag update 115 and, if needed, 4639 with the new winner line. On failure the server must still answer 4642 with `param1 = 0` so the client re-enables its buttons (LF:322-326).

## 4. Server messages (server to client)

All messages except S3 and S5 use `LotteryMsg` (package `lottery`): `payedPoint` (#1, INT32) diamonds spent during the event; `totalCount` (#2, INT32) total chances gained (stored, not shown); `leftCount` (#3, INT32) unused chances; `dayMaxCount` (#4, INT32) max chances gained per day; `onceNeedPoint` (#5, INT32) diamonds per chance; `leftMillis` (#6, INT64) milliseconds until the event ends; `isOpen` (#7, BOOL); `property1` (#8, STRING) unused; `property2` (#9, STRING) unused; `property3` (#10, STRING, repeated) winner lines; `property4` (#11, STRING, repeated) unused; `dayAddCount` (#13, INT32) chances gained today.

### S1. 4637 (0x121d) `U_C_LOTTERY_STATE`
- `LotteryMsg`, only `isOpen` read.
- Receiver: `LotteryManager.__lotteryState` (LM:79-86): sets `info.isOpen`, dispatches `LOTTERY_STATE`; the toolbar refreshes (TTB:409) and an open frame disposes itself when closed (LF:277-283).
- When: push at login and when the event opens or closes (assumption: the original pushed it at login, the client never asks).

### S2. 4636 (0x121c) `U_C_LOTTERY`
- `LotteryMsg`: reads `dayMaxCount`, `leftCount`, `leftMillis` (converted to seconds), `onceNeedPoint`, `payedPoint`, `totalCount`, `dayAddCount` (LM:56-69).
- Receiver: `LotteryManager.__lotteryInfoHandler` -> `LOTTERY_INFO` -> `LotteryFrame.__infoHandler` (LF:169-176, first time `initData`, always refreshes `leftCount`).
- When: reply to R1; push when a diamond spend grants a new chance while the frame may be open (assumption).

### S3. 4641 (0x1221) `U_C_LOTTERY_ITEMS`
- `VipRouletteMsg` (package `vip`): only `leftItem` (#4, `VipItemInfoMsg`, repeated: `temp_id` (#1, INT32), `count` (#2, INT32)) read; other fields `left_count` (#1), `need_vipItem` (#2), `openIndex` (#3, repeated), `takeItem` (#5, repeated), `is_start` (#6), `op_type` (#7) unused here.
- Receiver: `LotteryManager.__lotteryDropListHandler` (LM:88-95) -> `DROP_LIST` -> `refreshGoodsList` (LF:191-237): at most the first 16 entries are placed on the wheel.
- When: reply to R1.

### S4. 4639 (0x121f) `U_C_LOTTERY_NOTICE`
- `LotteryMsg`, only `property3` read: chat formatted winner lines (channel 21, parsed by `ChatFormat.getContentCellData`, LF:373-402).
- Receiver: `LotteryManager.__lotteryNoticeHandler` (LM:71-77) -> `UPDATE_SHOW_INFO` -> `__refreshShowInfo` (skipped while the wheel spins).
- When: reply to R1 and push after every draw that adds a line (assumption: last N wins of the server).

### S5. 4642 (0x1222) `U_C_LOTTERY_RESULT`
- `PropertyMsg` (package `simple`): `param1` (#1, INT32) won item template id (0 = no result); `param2` (#2, INT32) remaining `leftCount`; `param3` (#3, INT32) won item count.
- Receiver: `LotteryManager.__lotteryResultHandler` (LM:97-106) -> `LotteryFrame.__resultHandler` (LF:318-340): finds the wheel slot with the same `templateId` and `count` and spins to it (`LotteryTurnControl.turnPlate`). At the end (`lottery_effct_complete`, LF:285-316) it plays the new item effect, writes "Obteu {0} x {1}" in the system chat (channel 3) and as a tip.
- When: reply to R2. `param1 = 0` ends the spin immediately without animation.

## 5. Rules and formulas

- B1. Unlock: level 10 and the event open (TBH:265-266).
- B2. Chance accrual: during the event every cumulative `onceNeedPoint` diamonds spent gives one chance (`describe` text). Progress `payedPoint % onceNeedPoint` (LF:145-148). Chances gained per day cannot exceed `dayMaxCount`; `dayAddCount` counts today's gains and resets at 00:00.
- B3. Draw: costs one chance. The result must be one of the wheel entries (same template id and count), otherwise the wheel does not stop on it.
- B4. The wheel holds at most 16 entries.
- B5. Winner lines are server formatted chat strings (assumption: same format as other broadcast lines, for example `"<player>" ganhou <item>`).
- Values for `onceNeedPoint`, `dayMaxCount`, the reward pool and weights are server event data; no client template.

## 6. Templates

None on the client. Item names come from `raw/xml/tempinfos/ItemTempInfos.xml`. The event configuration (period, price per chance, daily cap, 16 rewards with weights) is server data.

## 7. Persistent state

```sql
CREATE TABLE lotteries.roulette_event (
  event_id          SERIAL      PRIMARY KEY,
  starts_at         TIMESTAMPTZ NOT NULL,
  ends_at           TIMESTAMPTZ NOT NULL,
  diamonds_per_draw INTEGER     NOT NULL CHECK (diamonds_per_draw > 0),
  daily_draw_cap    INTEGER     NOT NULL CHECK (daily_draw_cap > 0),
  CHECK (ends_at > starts_at)
);

CREATE TABLE lotteries.roulette_reward (
  event_id     INTEGER  NOT NULL REFERENCES lotteries.roulette_event(event_id) ON DELETE CASCADE,
  slot         SMALLINT NOT NULL CHECK (slot BETWEEN 0 AND 15),
  item_id      INTEGER  NOT NULL,
  item_count   INTEGER  NOT NULL CHECK (item_count > 0),
  weight       INTEGER  NOT NULL CHECK (weight >= 0),
  broadcast    BOOLEAN  NOT NULL DEFAULT FALSE,
  PRIMARY KEY (event_id, slot)
);

CREATE TABLE lotteries.roulette_player (
  event_id         INTEGER  NOT NULL REFERENCES lotteries.roulette_event(event_id) ON DELETE CASCADE,
  player_id        INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  diamonds_spent   INTEGER  NOT NULL DEFAULT 0,
  draws_total      INTEGER  NOT NULL DEFAULT 0,
  draws_left       INTEGER  NOT NULL DEFAULT 0 CHECK (draws_left >= 0),
  draws_gained_day INTEGER  NOT NULL DEFAULT 0,
  gain_day         DATE     NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE lotteries.roulette_winner_log (
  log_id     BIGSERIAL   PRIMARY KEY,
  event_id   INTEGER     NOT NULL REFERENCES lotteries.roulette_event(event_id) ON DELETE CASCADE,
  player_id  INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  item_id    INTEGER     NOT NULL,
  item_count INTEGER     NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX roulette_winner_log_event_idx ON lotteries.roulette_winner_log (event_id, created_at DESC);
```

## 8. Backend implementation notes

- `lotteries::roulette::handle_request` (8750): find the active event; send 4636 from `roulette_player` (lazy daily reset of `draws_gained_day` when `gain_day < today`), 4641 with the 16 rewards ordered by `slot`, 4639 with the last 10 formatted winner lines (assumption on the count).
- `lotteries::roulette::handle_draw` (8748): validation order: event open -> `draws_left > 0` -> bag space. Transaction: decrement `draws_left`, weighted roll, grant the item, insert the winner log when `broadcast`. Reply 4642 (`param1` item, `param2` new `draws_left`, `param3` count), then 115 bag update; push 4639 to every online player with the frame open (assumption: to all online players at level 10+).
- Hook in the currency module: every diamond spend while an event is active adds to `diamonds_spent`; for each crossed multiple of `diamonds_per_draw` add one draw unless `draws_gained_day >= daily_draw_cap`; push 4636 to the player.
- Schedules: at `starts_at` and `ends_at` push 4637 to online players; at 00:00 nothing to push (lazy reset).
- On failure reply 4642 with `param1 = 0` and the current `draws_left`.

## 9. Open questions and assumptions

- Assumption: chances come from diamond consumption (text says "consumindo"), bound diamonds excluded.
- Assumption: 4637 is pushed at login; the client has no request for it.
- Assumption: winner list size and format; the client renders whatever chat markup it receives.
- Open: whether unused chances survive the end of the event (the frame closes when `isOpen` becomes false, so they are lost).
- The strings `lottery.LotteryFrame.mutipBtn.tipData` "Clique para sortear 10 vezes" and `alertFrame.content` exist but no x10 button is wired in this client.

## 10. Implementation checklist

- [ ] Screen `LotteryFrame` reachable from the toolbar (level 10, `isOpen`)
- [ ] Route 8750 -> 4636, 4641, 4639
- [ ] Route 8748 -> 4642, 115, 4639 broadcast
- [ ] Push 4637 at login and on event start or end
- [ ] Tables `roulette_event`, `roulette_reward`, `roulette_player`, `roulette_winner_log`
- [ ] Rule B2 diamond spend hook with daily cap
- [ ] Rule B3 result always a wheel entry
- [ ] Test: draw with 0 chances refused (4642 `param1 = 0`)
- [ ] Test: daily cap stops accrual and shows "limite" text
- [ ] Test: frame closes when 4637 `isOpen = false`
