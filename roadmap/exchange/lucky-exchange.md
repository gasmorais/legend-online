# Troca da Sorte (lucky exchange)

Path aliases:

| Alias | File |
|---|---|
| LEM | `decompiled/core_module/scripts/yishi/manager/LuckyExchangeManager.as` |
| LEC | `decompiled/core_module/scripts/mvc/controler/LuckyExchangeControler.as` |
| LEF | `decompiled/m11/scripts/luckyexchange/LuckyExchangeFrame.as` |
| LEB | `decompiled/m11/scripts/luckyexchange/LuckyExchangeLeftButton.as` |
| LER | `decompiled/m11/scripts/luckyexchange/LuckyExchangeRightView.as` |
| LBI | `decompiled/m11/scripts/luckyexchange/LuckyexchangeBagItem.as` |

## 1. Overview

The server runs one or more "lucky exchange" events, each defined by a server side template (no XML file): a name, a consumed item and amount, a luck value and a time window. The player trades the consumed item for rewards. Each trade adds luck; when the luck bar is full ("Após atingir o valor da sorte, você precisará sortear +1 vez para então obter Prêmios raros") the next trade gives the rare prizes. Rewards are grouped by draw rule: sure, one random, chance per item, one random.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `luckyexchange.LuckyExchangeFrame` (`LEF`) | "Troca da Sorte" (`luckyexchange.LuckyExchangeFrame.titleText`) | Left list of active events, 9 per page with pager (`LEF:58`, `:194-232`); right detail view for the selected event (`LEF:156-164`) | top toolbar `luckyexchange` -> `LuckyExchangeControler` (`LEC:21-31`) | events with `start_time <= now <= end_time` (`LEF:109-125`) |
| `LuckyExchangeLeftButton` (`LEB`) | event name | Selectable button showing `name` (`LEB:29-37`) | frame | `LuckExchangeTempMsg` |
| `LuckyExchangeRightView` (`LER`) | detail | Consumed item icon and "Números obtidos: {0}" (bag count), luck bar `current/luck_value` with full bar effects (`LER:259-272`), "Número de trocas:" input, "Trocar" button, remaining time ("funny.FunnyRightView.active.remainTime" or "feedback.FeedBackItem.outDate", `LER:309-334`), reward groups (`LER:159-217`), flying icon animation for new items (`LER:336-405`) | frame | template + `current_luck_value` |
| `LuckyexchangeBagItem` (`LBI`) | reward group | Group 0 rare items (no title, highlight effect); group 1 "Obterá definitivamente os seguintes itens"; 2 "Obterá aleatoriamente um dos seguintes itens"; 3 "Tem chance de obter os itens abaixo"; 4 "Obterá aleatoriamente um dos seguintes itens"; groups after the first are prefixed with "e" (`LBI:53-76`); 9 icons per row with counts (`LBI:78-109`) | right view | `dropItems` filtered by `rare` and `drop_type` (`LEM:113-143`) |

## 3. Routes (client to server)

### R1 Trade (C_LUCK_EXCHANGE)

- UI: "Trocar" -> `LuckyExchangeRightView.__exchangeClickHandler` (`LER:247-257`) -> `LuckyExchangeManager.OperateLuckyExchange(id, count)` (`LEM:165-172`).
- Client checks:
  - anti spam 500 ms: "Clique excessivo, tente novamente" (`LER:249-253`);
  - count input clamp (`LER:274-300`): `num` = bag count of `consume_item_id` in bag type 1 (`LER:302-307`); if `num > 0`: count <= `num`, and count <= `luck_value - current_luck_value`, except when the bar is full (`current == luck_value`) where count = 1; if `num == 0`: count = 1 (the request is still sent; the server must reject);
  - no check of `consume_item_count` (the clamp assumes 1 item per trade), no time window check at click time.
- Route: C>S 9610 (0x258a) `C_LUCK_EXCHANGE`; `LuckExchangeOpMsg` (package `active`): `exchange_id` (#1, STRING) event id, `exchange_count` (#2, INT32) number of trades.
- Expected replies in order: 115 `U_C_BAG_MOVE_UPDATE` (consumed and granted items; granted items flagged new trigger the flying icons), 364 `U_C_LUCK_EXCHANGE_DATA_MSG` (S2).

## 4. Server messages (server to client)

### S1 363 (0x016b) U_C_LUCK_EXCHANGE_TEMP_MSG

- `LuckExchangeTempListMsg` (package `active`): `luckExchange` (#1, repeated `LuckExchangeTempMsg`).
- `LuckExchangeTempMsg`: `id` (#1, STRING) event id; `name` (#2, STRING) pt-BR name; `consume_item_id` (#3, INT32) consumed template; `consume_item_count` (#4, INT32) consumed per trade; `luck_value` (#5, INT32) luck needed; `start_time` (#6, STRING `YYYY-MM-DD hh:mm:ss`); `end_time` (#7, STRING); `dropItems` (#8, repeated `LuckExchangeItemTempMsg`).
- `LuckExchangeItemTempMsg`: `item_id` (#1, INT32) template; `item_count` (#2, INT32); `rare` (#3, BOOL) rare prize; `drop_type` (#4, INT32) 1 sure, 2 one random, 3 chance per item, 4 one random (`LEM:20-26` constants `SURE`, `RANDOM2`, `PERCENT`, `RANDOM`).
- Receiver `LuckyExchangeManager.__luckyTempHandler` (`LEM:59-66`) stores the list and dispatches `LUCKY_TEMP_CHANGE` (no frame listens; the toolbar uses `showData`, `LEM:77-102`).
- When: push at login and whenever the event list changes (start, end, edit). Include events that start later so the toolbar can appear on time (the client filters by time).

### S2 364 (0x016c) U_C_LUCK_EXCHANGE_DATA_MSG

- `LuckExchangeInfoListMsg` (package `active`): `luckExchangeInfo` (#1, repeated `LuckExchangeInfoMsg`: `exchange_id` (#1, STRING), `current_luck_value` (#2, INT32)).
- Receiver `LuckyExchangeManager.__luckyDataHandler` (`LEM:68-75`) -> `LUCKY_INFO_CHANGE` -> `LER.__refreshHandler` repaints the bar. `getLuckyValueById` iterates `_dataList` without a null check (`LEM:145-158`): the server must send 364 at login before the player can open the frame, otherwise the client throws.
- When: push at login (all active events) and reply to R1 (at least the traded event).

## 5. Rules and formulas

- X1 Toolbar: level 6 and at least one event with `start_time <= now <= end_time` (`TopBtnCheckShowHelper.as:309-310`, `LEM:77-102`). Server rejects trades outside the window or below level 6 (assumption).
- X2 Cost per trade: `consume_item_count` of `consume_item_id` from the main bag. Total cost `count * consume_item_count`; reject when missing.
- X3 Luck: each normal trade adds 1 to `current_luck_value` up to `luck_value` (inferred from the client clamp `count <= luck_value - current`, `LER:283-293`). When `current == luck_value`, the next trade (count forced to 1) gives the rare prizes and resets luck to 0 (assumption based on "você precisará sortear +1 vez para então obter Prêmios raros").
- X4 Normal trade rewards (assumption, per trade): all items of `drop_type 1`; one item of `drop_type 2`; each item of `drop_type 3` with its own server side chance; one item of `drop_type 4`. Rare items (`rare = true`) are given only by the full bar trade (all rare items, assumption) and should use a `drop_type` outside 1..4 so the client does not list them twice (`LEM:113-143` lists a rare item in both groups otherwise).
- X5 Progress persists per player and event until the event ends.

## 6. Templates

No client template; events come from the server (S1). Server configuration proposed in `exchange.lucky_event` and `exchange.lucky_drop`.

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS exchange;

CREATE TABLE exchange.lucky_event (
  exchange_id         TEXT         PRIMARY KEY,
  name                TEXT         NOT NULL,
  consume_item_id     INTEGER      NOT NULL,
  consume_item_count  INTEGER      NOT NULL CHECK (consume_item_count > 0),
  luck_value          INTEGER      NOT NULL CHECK (luck_value > 0),
  min_level           SMALLINT     NOT NULL DEFAULT 6,
  starts_at           TIMESTAMPTZ  NOT NULL,
  ends_at             TIMESTAMPTZ  NOT NULL,
  CHECK (ends_at > starts_at)
);

CREATE TABLE exchange.lucky_drop (
  exchange_id   TEXT      NOT NULL REFERENCES exchange.lucky_event(exchange_id) ON DELETE CASCADE,
  seq           SMALLINT  NOT NULL,
  item_id       INTEGER   NOT NULL,
  item_count    INTEGER   NOT NULL CHECK (item_count > 0),
  rare          BOOLEAN   NOT NULL DEFAULT false,
  drop_type     SMALLINT  NOT NULL CHECK (drop_type BETWEEN 0 AND 4),
  weight        INTEGER   NOT NULL DEFAULT 1 CHECK (weight >= 0),
  chance_ppm    INTEGER   NOT NULL DEFAULT 0 CHECK (chance_ppm BETWEEN 0 AND 1000000),
  PRIMARY KEY (exchange_id, seq)
);

CREATE TABLE exchange.lucky_progress (
  player_id      INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  exchange_id    TEXT     NOT NULL REFERENCES exchange.lucky_event(exchange_id) ON DELETE CASCADE,
  luck           INTEGER  NOT NULL DEFAULT 0 CHECK (luck >= 0),
  total_trades   INTEGER  NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, exchange_id)
);
```

## 8. Backend implementation notes

- `exchange::lucky::handle_trade` (9610). Validation order: event exists (silently ignore otherwise, no error receiver) -> now inside the window -> level >= 6 -> `exchange_count >= 1` -> if `luck == luck_value` then force `count = 1` and rare mode, else `count = min(count, luck_value - luck)` -> bag holds `count * consume_item_count` of `consume_item_id` -> bag space for the worst case reward set (else mail overflow, assumption). Transaction: lock `exchange.lucky_progress` row, consume items, roll rewards per trade, grant, update `luck` and `total_trades`. Reply 115, then 364.
- `exchange::lucky::push_templates` at login and on calendar changes (363); `exchange::lucky::push_progress` at login (364 for all events visible to the player, zero when no row).
- Rolls use a server RNG; log every grant for audit (generic item log of the inventory module).

## 9. Open questions and assumptions

- Assumption: +1 luck per trade, full bar trade gives all rare items and resets luck.
- Assumption: draw semantics of `drop_type` 2 and 4 (same pt-BR title); chance values of `drop_type 3` are server data.
- Open: original event list and rewards (server data, not in the client).

## 10. Implementation checklist

- [ ] Screens: LuckyExchangeFrame list and detail
- [ ] Route 9610 `C_LUCK_EXCHANGE`
- [ ] Server messages 363 and 364 (login order: 363, 364)
- [ ] Tables `exchange.lucky_event`, `exchange.lucky_drop`, `exchange.lucky_progress`
- [ ] Rules X1..X5
- [ ] Test: toolbar icon appears only inside the window at level 6
- [ ] Test: count clamp vs server validation (missing items rejected)
- [ ] Test: full bar trade grants rare prizes and resets luck
