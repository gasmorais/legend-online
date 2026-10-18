# General compensation ("Compensação Geral", 全民返利)

Path aliases:

| Alias | File |
|---|---|
| WRM | `decompiled/core_module/scripts/managers/WholeRebateManager.as` |
| WRMOD | `decompiled/core_module/scripts/mvc/module/wholerebate/WholeRebateModel.as` |
| WRF | `decompiled/m11/scripts/wholerebate/WholeRebateFrame.as` |
| CV | `decompiled/m11/scripts/wholerebate/ChargeView.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

During the event each player gets one daily draw of a rebate percent. After drawing, every diamond recharged that day gives extra diamonds equal to `percent`% of the recharge, until the daily rebate pool (`total`) is used up. The draw resets at 00:00.

Rules shown to the player (`wholerebate.wholerebateframe.rule`): "1) Durante o tempo de evento, os jogadores obtêm uma oportunidade diária de sortear uma compensação de diamantes. A oportunidade é resetada às o horas. 2) Após obter a compensação de diamantes, além dos diamantes carregados nesse dia pode também obter diamantes extra de compensação. O número de recargas é ilimitado. 3) O número de diamantes que podem ser obtidos como compensação é limitado. Se ultrapassar o limite não será mais recompensado."

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `wholerebate.WholeRebateFrame` (WRF) | "Compensação Geral" (WRF:57) | Period "{0} a {1}", rules, draw button or the charge view | top toolbar "wholerebate" (`TopToolsBar.as:1432-1433`) visible while `model.isOpen` (TBH:367-368) | closes when the event closes (WRF:69-76); `percent > 0` shows CV, else the draw button (WRF:78-88) |
| `wholerebate.ChargeView` (CV) | rebate panel | Percent digits, rebate diamonds left, diamonds to recharge to use them all, progress `total - left / total`, recharge button | WRF | `percent`, `leftDiamond`, `needCharge`, `progress` (CV:99-111); recharge button opens the page (CV:93-97) |

## 3. Routes (client to server)

### W1. Draw today's rebate percent
- UI: WRF draw button `_getRebateIconBtnClickHandler` (WRF:91-94), visible only while `percent == 0`.
- Sender: `WholeRebateManager.sendWholeRebateOperate` (WRM:86-90).
- Route: send 9645 (0x25ad) `C_CCCACTIVE_CLIENTOP` with header `extend1` = 28 (`new PackageOut(9645, 0, 28)`) and an empty body.
- Expected responses: 4865 `U_C_MONEY_RETURN_INFO` (draw result, ignored by the client), then 4866 `U_C_MONEY_RETURN_STATE` with `param1` = drawn percent.

## 4. Server messages (server to client)

### S1. 4866 (0x1302) `U_C_MONEY_RETURN_STATE`
- Message `simple.PropertyMsg`: `param1` (#1, INT32) today's percent (0 = not drawn); `param2` (#2, INT32) rebate diamonds still obtainable today; `param3` (#3, INT32) daily rebate cap; `param4` (#4, STRING) event start "YYYY-MM-DD hh:mm:ss"; `param5` (#5, STRING) event end; `param7` (#7, BOOL) event open.
- Receiver: `WholeRebateManager.__moneyReturnStateHandler` (WRM:52, 56-77): `needCharge = ceil(left / (percent / 100))`, `progress = 100 * (total - left) / total`; dispatches `WHOLE_REBATE_SHOW` (toolbar and frame).
- When: login, event start and end, after W1, after each credited recharge, at 00:00 (percent back to 0, left back to the cap).

### S2. 4865 (0x1301) `U_C_MONEY_RETURN_INFO`
- Message `cccactive.MoneyReturnMsg`: `op` (#1, INT32); `percent` (#2, INT32); `left` (#3, INT32).
- Receiver: `WholeRebateManager.__moneyReturnReturnInfoHandler` (WRM:53, 79-84) reads and discards it.
- When: reply to W1 (assumption: `op` 1 = draw ok, `percent` drawn, `left` pool); may be omitted.

## 5. Rules and formulas

- One draw per player per server day while the event is open; a second draw the same day is refused.
- Percent distribution: server configuration (gap; no client data). Proposed weighted table, e.g. 5, 10, 15, 20, 30, 50.
- On each credited recharge of `d` diamonds after drawing: `extra = min(floor(d * percent / 100), left)`; grant `extra` as diamonds (assumption: plain diamonds, "diamantes extra de compensação"); `left -= extra`.
- Recharges before drawing on the same day do not earn (assumption; the rule text says "Após obter a compensação").
- `total` (cap) is per day (assumption from the reset at 0h).

## 6. Templates

None.

## 7. Persistent state

```sql
CREATE TABLE recharge.whole_rebate_events (
  id           SERIAL      PRIMARY KEY,
  starts_at    TIMESTAMPTZ NOT NULL,
  ends_at      TIMESTAMPTZ NOT NULL,
  daily_cap    INTEGER     NOT NULL CHECK (daily_cap > 0),
  percent_table JSONB      NOT NULL,          -- [{percent, weight}]
  CHECK (ends_at > starts_at)
);

CREATE TABLE recharge.whole_rebate_days (
  player_id    BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  event_id     INTEGER NOT NULL REFERENCES recharge.whole_rebate_events(id) ON DELETE CASCADE,
  day          DATE    NOT NULL,
  percent      SMALLINT NOT NULL CHECK (percent BETWEEN 1 AND 100),
  rebate_left  INTEGER NOT NULL CHECK (rebate_left >= 0),
  rebate_paid  INTEGER NOT NULL DEFAULT 0 CHECK (rebate_paid >= 0),
  PRIMARY KEY (player_id, event_id, day)
);
```

## 8. Backend implementation notes

- `cccactive::dispatch` extend1 28 -> `recharge::whole_rebate::handle_draw`: require open event; insert today's row with a weighted percent and `rebate_left = daily_cap` (primary key prevents double draws); reply 4865 then 4866.
- `recharge::whole_rebate::on_recharge(tx, player_id, diamonds)`: if today's row exists and `rebate_left > 0`, compute `extra`, `currency::spending::grant(-400, extra, "recharge.whole_rebate")`, update the row; after commit push 3 and 4866.
- Scheduler: at start, end and 00:00 push 4866 to online players.

## 9. Open questions and assumptions

- Gap: percent table and daily cap values.
- Assumption: extra diamonds are plain diamonds.
- Assumption: only recharges after the draw count.

## 10. Implementation checklist

- [ ] Screen: draw button vs charge view, progress and needed recharge
- [ ] Route W1 9645 extend1 28
- [ ] Server message S1 4866
- [ ] Server message S2 4865
- [ ] Table `recharge.whole_rebate_events`
- [ ] Table `recharge.whole_rebate_days`
- [ ] Rule: one draw per day, reset at 00:00
- [ ] Rule: extra = recharge x percent capped by the pool
- [ ] Test: second draw same day refused
- [ ] Test: recharge after cap gives no extra
