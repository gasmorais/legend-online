# Roleta de Recarga (charge lottery, "充值抽奖轮盘")

Path aliases:

| Alias | File |
|---|---|
| CLM | `decompiled/core_module/scripts/yishi/manager/ChargeLotteryManager.as` |
| CLF | `decompiled/m11/scripts/chargelottery/ChargeLotteryFrame.as` |
| CLI | `decompiled/m11/scripts/chargelottery/ChargeLotteryItem.as` |
| TC2 | `decompiled/core_module/scripts/yishi/utils/TurnControlII.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A timed event wheel fed by recharges. Every `oneNeedPoint` diamonds recharged during the event give one draw, up to `dayMaxCount` draws gained per day. The wheel has 22 normal slots; 2 of them (positions 6 and 17 of the ring) are "rare chance" slots. Landing on a rare chance slot sets `isRare`: the next draw is made on an inner ring of 8 rare prizes and costs nothing extra. A "draw all" button spends every remaining draw at once. A log panel shows server wide results.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `chargelottery.ChargeLotteryFrame` (CLF), 900x566 | "Roleta de Recarga" (`ui.toptoolbar.TopToolsBar.tipData_chargelottery`, CLF:129) | Outer ring of 22 `ChargeLotteryItem` built from `normalArr` (CLM:87-131); inner ring of 8 from `rareArr` (CLM:133-147); buttons draw and draw all; "Número restante:" `leftCount`; "Necessário recarregar:" `leftNeedPoint`; rules; countdown to `stopTime`; log panel | Top toolbar `chargelottery` (TopToolBtnInfos 2017 "充值抽奖轮盘") -> `openControllerByInfo("chargelottery")` (TTB:1326-1328) | rules "1.Durante o evento recarregando acumuladamente {0} diamantes, poderá obter uma chance de sorteio2. Durante o evento, poderá por dia aumentar, no máximo, {1} chances de sorteio" (`oneNeedPoint`, `dayMaxCount`, CLF:337); countdown "remainTime" or "Evento encerrado" (CLF:488-517); logs on channel 103 (CLF:384-411) |

Toolbar visibility: `thane.grades >= 11 && openChargeLottery` (TBH:333-334).

## 3. Routes (client to server)

All routes: C>S 9645 (0x25ad) `C_CCCACTIVE_CLIENTOP`, header `extend1 = 24`, body `cccactive.ChargePointLotteryMsg` with `op` (#1, INT32) and `isOneKey` (#12, BOOL). Sender `ChargeLotteryManager.OperateChargeReq(op, isOneKey = false)` (CLM:149-156).

### R1. Open (op 1)
- UI: frame constructor (CLF:114).
- Expected response: 432 with `op 1` (S2) carrying the full state.

### R2. Draw once (op 2)
- UI: draw button (CLF:435-451).
- Client checks: `leftCount > 0 || isRare`, else alert "Insuficiente, favpre recarregar" with a recharge link (CLF:438-442, 474-486); `openChargeLottery` true. Disables both buttons and the close button.
- Fields: `op 2`, `isOneKey false`.
- Expected response: 432 `op 2` (S2) with one `resultPos`; bag update 115; 432 `op 3` with logs (assumption).

### R3. Draw all (op 2, one key)
- UI: draw all button (CLF:453-472).
- Client checks: `leftCount > 0`; `openChargeLottery`; not allowed while `isRare` (CLF:465-468).
- Fields: `op 2`, `isOneKey true`.
- Expected response: 432 `op 2` with every `resultPos`; the client shows the list without animation (CLF:275-279).

## 4. Server messages (server to client)

### S1. 433 (0x01b1) `U_C_CHARGELOTTERY_STATE`
- `PropertyMsg` (package `simple`): `param7` (#7, BOOL) open.
- Receiver: `ChargeLotteryManager.__openStateHandler` (CLM:73-80) -> `REFRESH_TOPTOOLS`.
- When: login and event start or end.

### S2. 432 (0x01b0) `U_C_CHARGELOTTERYINFO`
- `cccactive.ChargePointLotteryMsg`: `op` (#1, INT32) 1 full state, 2 draw result, 3 logs; `chargePoint` (#2, INT32) diamonds recharged during the event (not shown); `oneNeedPoint` (#3, INT32) diamonds per draw; `leftNeedPoint` (#4, INT32) diamonds still to recharge for the next draw; `leftCount` (#5, INT32) draws available; `dayMaxCount` (#6, INT32) daily gain cap; `dayAddCount` (#7, INT32) draws gained today; `openTime` (#8, STRING); `stopTime` (#9, STRING) "YYYY-MM-DD hh:mm:ss"; `reward` (#10, `LotteryItemMsg`, repeated); `logs` (#11, STRING, repeated) chat formatted lines; `isOneKey` (#12, BOOL); `isRare` (#13, BOOL) next draw uses the rare ring; `resultPos` (#14, INT32, repeated) positions won.
- `LotteryItemMsg`: `templateId` (#1, INT32); `count` (#2, INT32); `templateType` (#3, INT32) 0 normal prize, 1 rare chance slot, 2 rare prize; `pos` (#4, INT32) slot id matched by `resultPos`.
- Receiver: `ChargeLotteryManager.__chargelotteryHandler` (CLM:46-71). `op 1` replaces the whole message; `op 2` copies `leftNeedPoint`, `leftCount`, `dayAddCount`, `isOneKey`, `isRare`, `resultPos`; `op 3` copies `logs`. Then `CHARGELOTTERY_RESULT_UPDATE` -> `CLF.__chargeResultHandler` (CLF:249-285): `op 1` builds the rings; `op 2` with one `resultPos` spins to the matching slot, otherwise shows the summary; `op 3` refreshes the log.
- Summary text after a draw: "Você obteve:" + "name*count," for each position (CLF:287-329); when no item was won (rare chance slot only) "Parabéns, você obteve 1 chance para sortear itens raros." Sent to system chat (channel 3) and as a tip.
- Layout constraint: `op 1` must contain exactly 20 `templateType 0` entries, 2 `templateType 1` entries (placed at ring indexes 6 and 17) and 8 `templateType 2` entries (CLM:87-147, CLF:199-240).
- When: reply to R1 (`op 1`), R2 and R3 (`op 2`); `op 3` push with the latest logs after draws and probably on open (assumption).

## 5. Rules and formulas

- B1. Unlock: level 11 and event open.
- B2. Draw accrual: `floor(rechargedDuringEvent / oneNeedPoint)` capped per day by `dayMaxCount`; `leftNeedPoint = oneNeedPoint - chargePoint % oneNeedPoint`.
- B3. Normal draw: consumes 1 draw, picks one of the 22 outer slots by weight. If the slot is a rare chance slot (`templateType 1`) no item is given and `isRare` becomes true.
- B4. Rare draw: while `isRare`, the draw button works with `leftCount = 0`, consumes no draw (assumption from the client check), picks one of the 8 rare prizes, then `isRare = false`.
- B5. Draw all: consumes every `leftCount` draw; rare chance hits inside a draw all are converted immediately into rare draws (assumption) because the client blocks draw all while `isRare`.
- B6. Logs are server formatted (channel 103).

## 6. Templates

None. Prize table, weights and the per draw recharge amount are server event data.

## 7. Persistent state

```sql
CREATE TABLE lotteries.charge_event (
  event_id          SERIAL      PRIMARY KEY,
  starts_at         TIMESTAMPTZ NOT NULL,
  ends_at           TIMESTAMPTZ NOT NULL,
  diamonds_per_draw INTEGER     NOT NULL CHECK (diamonds_per_draw > 0),
  daily_draw_cap    INTEGER     NOT NULL CHECK (daily_draw_cap > 0)
);

CREATE TABLE lotteries.charge_reward (
  event_id    INTEGER  NOT NULL REFERENCES lotteries.charge_event(event_id) ON DELETE CASCADE,
  pos         SMALLINT NOT NULL,
  kind        SMALLINT NOT NULL CHECK (kind IN (0, 1, 2)),
  item_id     INTEGER  NOT NULL DEFAULT 0,
  item_count  INTEGER  NOT NULL DEFAULT 0,
  weight      INTEGER  NOT NULL CHECK (weight >= 0),
  PRIMARY KEY (event_id, pos)
);

CREATE TABLE lotteries.charge_player (
  event_id          INTEGER NOT NULL REFERENCES lotteries.charge_event(event_id) ON DELETE CASCADE,
  player_id         BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  diamonds_charged  INTEGER NOT NULL DEFAULT 0,
  draws_left        INTEGER NOT NULL DEFAULT 0 CHECK (draws_left >= 0),
  draws_gained_day  INTEGER NOT NULL DEFAULT 0,
  gain_day          DATE    NOT NULL DEFAULT CURRENT_DATE,
  rare_pending      BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE lotteries.charge_log (
  log_id      BIGSERIAL   PRIMARY KEY,
  event_id    INTEGER     NOT NULL REFERENCES lotteries.charge_event(event_id) ON DELETE CASCADE,
  player_id   BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  pos         SMALLINT    NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX charge_log_event_idx ON lotteries.charge_log (event_id, created_at DESC);
```

## 8. Backend implementation notes

- `extend1 = 24` -> `lotteries::charge::handle_op` on `op`:
  - 1 `lotteries::charge::handle_open`: lazy daily reset; reply 432 `op 1` with the 30 rewards and state, then 432 `op 3` with the last logs.
  - 2 `lotteries::charge::handle_draw`: event open -> `rare_pending` or `draws_left > 0` (draw all: `draws_left > 0` and not `rare_pending`) -> bag space. Transaction: roll, grant, update `draws_left` and `rare_pending`, log. Reply 432 `op 2` (`resultPos`, `leftCount`, `leftNeedPoint`, `dayAddCount`, `isRare`, `isOneKey`), 115, then 432 `op 3` to players with the frame open.
- Recharge hook (recharge feature): add to `diamonds_charged`, grant draws per B2, push 432 `op 2` with empty `resultPos` is not safe (the client would show the summary); push 432 `op 1` instead (assumption).
- Push 433 at login and on event start or end.

## 9. Open questions and assumptions

- Assumption: rare draws do not consume `leftCount`.
- Assumption: draw all resolves rare chance hits immediately.
- Open: log line format and size.

## 10. Implementation checklist

- [ ] Screen `ChargeLotteryFrame` (level 11, open)
- [ ] Route 9645/24 op 1 -> 432 op 1 (+ op 3)
- [ ] Route 9645/24 op 2 single and one key -> 432 op 2, 115
- [ ] Push 433; push 432 op 1 after a recharge
- [ ] Tables `charge_event`, `charge_reward`, `charge_player`, `charge_log`
- [ ] Rule B3/B4 rare chain
- [ ] Test: 22 + 8 layout with kinds 0/1/2 and positions 6 and 17
- [ ] Test: draw all refused while `isRare`
