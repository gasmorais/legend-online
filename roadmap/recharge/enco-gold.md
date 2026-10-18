# Encouragement gold ("Ouro da Incentivação", 鼓励金)

Path aliases:

| Alias | File |
|---|---|
| EGM | `decompiled/core_module/scripts/managers/EncoGoldManager.as` |
| EGMOD | `decompiled/core_module/scripts/mvc/module/encoGold/EncoGoldModel.as` |
| EGF | `decompiled/m11/scripts/encoGold/EncoGoldFrame.as` |
| EGMI | `decompiled/m11/scripts/encoGold/view/EncoGoldMsgItemView.as` |
| EGMV | `decompiled/m11/scripts/encoGold/view/EncoGoldMsgView.as` |
| EGDI | `decompiled/m11/scripts/encoGold/view/EncoGoldDayItemView.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A consumption rebate event over a list of days. Each event day is either a gain day (type 1, optionally doubled) or a discount day (type 2). On a gain day, the first diamond consumption of the day earns encouragement gold equal to a random percentage of the amount consumed. On a discount day, the first consumption larger than the accumulated encouragement gold is discounted by that gold, once; otherwise the gold is lost. Rule text (`encoGold.encoGoldTips04`): "Durante o evento, dentro do dia do ouro da incentivação, ao consumir pela primeira vez diamantes (por dia), o sistema irá presentear um certo valor percentual do ouro da incentivação. No dia de oferta em dobro, obtendo o ouro da incentivação, também poderá dobrá-lo. Durante o dia do desconto, o primeiro consumo de recarga que fizer, obterá desconto de ouro da incentivação, apenas haverá desconto 1 vez, basta efetuar o consumo de valor superior à quantidade de ouro da incentivação. Só assim é que será descontado, caso contrário irá invalidar-se."

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `encoGold.EncoGoldFrame` (EGF) | "Ouro da Incentivação" (EGF:309) | Countdown "Tempo restante do evento: {0}" to `stopTime` (EGF:185-213); gold bar "{take}/{max}" or "0/{max}(descontados)" after the discount (EGF:215-233); "Reembolso do Ouro da Incentivação: {0}%-{1}%" (EGF:234); minimum consumption digits `limitConsumePoint` (EGF:235); rules "Regras do Ouro da Incentivação" (EGF:160-161); day strip with previous / next (EGF:240-305) | top toolbar "encoGold" (`TopToolsBar.as:1356-1357`) visible when hero level >= 6 and 421 open (TBH:357-358) | requests data on open (EGF:98) |
| `EncoGoldDayItemView` (EGDI) | day icon | type 1 gain (frame 3), type 1 double (frame 2), type 2 discount (frame 1) (EGDI:41-60) | EGF strip | |
| `EncoGoldMsgItemView` (EGMI) | "Consumir {0}" day line | Per day: consumed diamonds; status text: past day not taken "Passou o tempo do evento"; today not taken "Ainda não obteve ouro da incentivação" (gain) or "Ouro de incentivo não descontado" (discount); future "Ainda não chegou o tempo do evento"; taken "obter" / "descontado" with tip "Ouro da incentivação obtido: {0}" or "Ouro da incentivação descontado: {0}" (EGMI:61-120) | EGMV list | |

## 3. Routes (client to server)

### E1. Request event data
- UI: EGF constructor (EGF:98).
- Sender: `EncoGoldManager.sendSeverInfo` (EGM:53-57).
- Route: send 9643 (0x25ab) `C_ENCOGOLD_REQ`, empty body (`SocketSendManager.send`, no protobuf).
- Expected response: 422 `U_C_ENCOGOLDINFO`.

## 4. Server messages (server to client)

### S1. 421 (0x01a5) `U_C_ENCOGOLD_OPENSTATE`
- Message `simple.PropertyMsg`: `param7` (#7, BOOL) open.
- Receiver: `EncoGoldManager.__receiveOpenInfo` (EGM:61, 65-72) -> `ENCO_GOLD_OPENSTATE_UPDTAE` (toolbar, `TopToolsBar.as:466, 597`).
- When: login, event start, event end.

### S2. 422 (0x01a6) `U_C_ENCOGOLDINFO`
- Message `sumpassion.EncoGoldListMsg`: `openTime` (#1, STRING); `stopTime` (#2, STRING); `totalTakePoint` (#3, INT32) gold accumulated; `totalBackPoint` (#4, INT32) gold already discounted; `limitConsumePoint` (#5, INT32) minimum consumption shown in the header; `limitBackPer` (#6, INT32) minimum percent; `maxBackPer` (#7, INT32) maximum percent; `maxBackPoint` (#8, INT32) gold cap; `dayMsg` (#9, `EncoDayMsg`, repeated).
- `EncoDayMsg`: `dayStr` (#1, STRING "YYYY-MM-DD"); `encoType` (#2, INT32) 1 gain, 2 discount; `isDouble` (#3, BOOL); `isTaked` (#4, BOOL) gain obtained or discount applied that day; `takePoint` (#5, INT32) gold obtained or discounted that day; `ConsumPoint` (#6, INT32) diamonds consumed that day.
- Receiver: `EncoGoldManager.__receiveInfo` (EGM:62, 74-120): days sorted by date, `currentDay` = index of today, `ENCO_GOLD_INFO_UP_DATA`.
- When: reply to E1; push after each change while the frame might be open (assumption).

## 5. Rules and formulas

- Gain day (type 1), first consumption of the day with `amount >= limitConsumePoint` (assumption on the minimum): `gold = round(amount * rand(limitBackPer, maxBackPer) / 100)`, doubled when `isDouble`, then `gold = min(gold, maxBackPoint - totalTakePoint)`; `totalTakePoint += gold`; day `isTaked = true`, `takePoint = gold`.
- Discount day (type 2), first consumption of the day: if `amount > totalTakePoint` and `totalBackPoint == 0`, refund `totalTakePoint` (assumption: as diamonds, i.e. the price is reduced) and set `totalBackPoint = totalTakePoint`, day `isTaked = true`, `takePoint = totalTakePoint`; otherwise the discount is lost for that day ("caso contrário irá invalidar-se").
- Only one discount per event ("apenas haverá desconto 1 vez").
- "Consumption" means diamonds (not bound) spent, as reported by `currency::spending::on_consumption` ([../currency/spending.md](../currency/spending.md)). The rule text mentions "consumo de recarga"; the client data only shows consumption (assumption).
- Days outside the list do nothing.

## 6. Templates

None.

## 7. Persistent state

```sql
CREATE TABLE recharge.enco_gold_events (
  id                  SERIAL      PRIMARY KEY,
  starts_at           TIMESTAMPTZ NOT NULL,
  ends_at             TIMESTAMPTZ NOT NULL,
  min_consume         INTEGER     NOT NULL DEFAULT 0,
  min_percent         SMALLINT    NOT NULL CHECK (min_percent BETWEEN 0 AND 100),
  max_percent         SMALLINT    NOT NULL CHECK (max_percent BETWEEN 0 AND 100),
  max_gold            INTEGER     NOT NULL CHECK (max_gold > 0),
  CHECK (ends_at > starts_at AND max_percent >= min_percent)
);

CREATE TABLE recharge.enco_gold_days (
  event_id    INTEGER  NOT NULL REFERENCES recharge.enco_gold_events(id) ON DELETE CASCADE,
  day         DATE     NOT NULL,
  day_type    SMALLINT NOT NULL CHECK (day_type IN (1, 2)),
  is_double   BOOLEAN  NOT NULL DEFAULT false,
  PRIMARY KEY (event_id, day)
);

CREATE TABLE recharge.enco_gold_players (
  player_id      BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  event_id       INTEGER NOT NULL REFERENCES recharge.enco_gold_events(id) ON DELETE CASCADE,
  total_gold     INTEGER NOT NULL DEFAULT 0 CHECK (total_gold >= 0),
  total_used     INTEGER NOT NULL DEFAULT 0 CHECK (total_used >= 0),
  PRIMARY KEY (player_id, event_id)
);

CREATE TABLE recharge.enco_gold_player_days (
  player_id   BIGINT  NOT NULL,
  event_id    INTEGER NOT NULL,
  day         DATE    NOT NULL,
  consumed    INTEGER NOT NULL DEFAULT 0 CHECK (consumed >= 0),
  taken       BOOLEAN NOT NULL DEFAULT false,
  amount      INTEGER NOT NULL DEFAULT 0 CHECK (amount >= 0),
  PRIMARY KEY (player_id, event_id, day),
  FOREIGN KEY (player_id, event_id) REFERENCES recharge.enco_gold_players(player_id, event_id) ON DELETE CASCADE
);
```

## 8. Backend implementation notes

- `recharge::enco_gold::handle_info` (9643): current event or the last one ended less than a day ago; build 422 from the tables (zero rows for days without activity).
- `recharge::enco_gold::on_consume(tx, player_id, diamonds)` (called by `currency::spending::on_consumption`): lock the player rows; add `consumed` for today; if today is an event day and not yet `taken`, apply the gain or discount rule; a discount refunds through `currency::spending::grant(-400, n, "recharge.enco_gold.discount")` with `counts_as_consumption = false`; after commit push 3 when refunded and 422 if the player is online.
- Scheduler: at start and end push 421 to online players.

## 9. Open questions and assumptions

- Assumption: refunds are plain diamonds.
- Assumption: `limitConsumePoint` is the minimum consumption that triggers a gain.
- Open: whether the trigger is consumption or recharge on discount days ("consumo de recarga").
- Gap: percent range, cap and day calendar are server configuration.

## 10. Implementation checklist

- [ ] Screen: header bar, percent range, minimum, countdown, day strip and per day lines
- [ ] Route E1 9643
- [ ] Server message S1 421
- [ ] Server message S2 422
- [ ] Table `recharge.enco_gold_events`
- [ ] Table `recharge.enco_gold_days`
- [ ] Table `recharge.enco_gold_players`
- [ ] Table `recharge.enco_gold_player_days`
- [ ] Rule: first consumption per gain day, random percent, double days, cap
- [ ] Rule: one discount per event, lost when the consumption is too small
- [ ] Test: two consumptions on a gain day earn once
- [ ] Test: discount applied once and shown as "(descontados)"
