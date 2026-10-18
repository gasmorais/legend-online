# Month card daily packs ("天天大礼包")

Path aliases:

| Alias | File |
|---|---|
| MCM | `decompiled/core_module/scripts/managers/MonthCardManager.as` |
| MCMOD | `decompiled/core_module/scripts/mvc/module/monthcard/MonthCardModel.as` |
| MCG | `decompiled/core_module/scripts/mvc/module/monthcard/MonthCardGiftInfo.as` |
| MCF | `decompiled/m11/scripts/monthcard/MonthCardFrame.as` |
| MCI | `decompiled/m11/scripts/monthcard/MonthCardGiftItem.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A timed activity (top toolbar template 2051 "天天大礼包", "daily big pack") selling up to three packs for diamonds. A bought pack can be collected once per calendar day for `lastDay` days. Unclaimed days are mailed at 00:00. Each pack can be bought once per event.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `monthcard.MonthCardFrame` (MCF) | (art title), period `openTime - stopTime` (MCF:115) | Three `MonthCardGiftItem` cards and four help lines | top toolbar "monthcard" (TTB:1438-1439); visible when `VersionSwitch.MONTH_CARD` and `model.isOpen` (TBH:371-372); toolbar effect when the activity just opened or a reward is collectable (TTB:956-965) | help: "1) Durante o tempo do evento, é possível comprar pacotes clicando em Participar Já.", "2) Durante o tempo de retirar pacotes, você pode receber os itens correspondentes.", "3) Cada pacote apenas pode ser comprado uma vez por evento.", "4) Quando um pacote não é retirado no próprio dia, às 0 horas, quando os pacotes são renovados, o pacote será enviado por email." (MCF:67-81) |
| `MonthCardGiftItem` (MCI) | pack name `giftName`, picture `PathManager.getMonthCardIconPath(giftPic)` | Not bought: "Pode ser retirado durante {0} dias. Custo: {1} diamantes" and join button; bought: "Ainda pode ser retirado durante: {0} dias" and collect button enabled when collectable (MCI:151-187) | MCF | daily items (MCI:197-223) |

## 3. Routes (client to server)

All routes: send 9645 (0x25ad) `C_CCCACTIVE_CLIENTOP` with header `extend1` = 29 (`new PackageOut(9645, 0, 29)`, MCM:119) and body `cccactive.MonthCardMsg`: `op` (#1, INT32), `type` (#2, INT32) pack type. Sender `MonthCardManager.sendMonthRequest(op, type = 0)` (MCM:117-124).

### M1. Load (op 1)
- UI: MCF constructor (MCF:42).
- Route: 9645 / 29, `op` 1, `type` 0.
- Expected response: 175 `U_C_MONTH_CARD`.

### M2. Buy a pack (op 2)
- UI: MCI join button (MCI:104-116) if not bought; confirm "Deseja gastar {0} diamantes para comprar o pacote?" (MCI:110-115).
- Client checks: `judgePointEnoughToShowPay(needPoint, false)`: diamonds only (MCI:118-129).
- Route: 9645 / 29, `op` 2, `type` = pack type.
- Expected response: 3 (`point`), 175 with `leftDay` set for that pack.

### M3. Collect today's items (op 3)
- UI: MCI collect button (MCI:131-138) when `canGetReward`.
- Route: 9645 / 29, `op` 3, `type` = pack type.
- Expected response: bag updates, 175 with `collectTime` = now and `leftDay` decreased.

## 4. Server messages (server to client)

### S1. 175 (0x00af) `U_C_MONTH_CARD`
- Message `MonthCardMsg` (cccactive): `op` (#1, INT32) unused by the client; `type` (#2, INT32) unused; `isOpen` (#3, BOOL) activity open; `openTime` (#4, STRING) and `stopTime` (#5, STRING) shown as the period; `gifts` (#6, `MonthCardGiftMsg`, repeated).
- `MonthCardGiftMsg`: `type` (#1, INT32) pack id (sort key); `giftName` (#2, STRING); `giftPic` (#3, STRING) icon name; `needPoint` (#5, INT32) diamond price; `lastDay` (#6, INT32) days of collection; `items` (#7, `GiftItemInfoMsg`, repeated: `templateId` (#1, INT32), `templateCount` (#2, INT32)) daily content; `leftDay` (#8, INT32) remaining collection days, -1 when not bought; `collectTime` (#9, STRING) last collection time.
- Receiver: `MonthCardManager.__updateMonthCardMsg` (MCM:59, 62-115): `openChange` = was closed and now open; replaces the gift list sorted by `type`; notifies `MONTH_INFO_CHANGE`.
- Client rules: `hasBuy = leftDay >= 0` (MCG:33-36); `canGetReward` = bought, `leftDay > 0`, `collectTime` not empty and not today (MCG:38-57).
- When: reply to 9645 / 29, login, activity start and end, 00:00 rollover.

## 5. Rules and formulas

- Purchase once per pack per event; price `needPoint` diamonds, bound not allowed.
- On purchase: `leftDay = lastDay`, `collectTime` = "2000-01-01 00:00:00" so the first collection is allowed the same day (the client requires a non empty value).
- Collect at most once per calendar day: grant `items`, `collectTime = now`, `leftDay -= 1`.
- Rollover 00:00: for every bought pack with `leftDay > 0` that was not collected on the day that just ended, mail that day's items and decrement `leftDay` (help line 4).
- Toolbar visible while `isOpen`; packs bought before `stopTime` keep their remaining days after the activity closes (assumption: collection continues by mail).

## 6. Templates

None: packs are server data sent in 175. `PathManager.getMonthCardIconPath(giftPic)` resolves the image.

## 7. Persistent state

```sql
CREATE TABLE vip.month_card_events (
  id           SERIAL      PRIMARY KEY,
  starts_at    TIMESTAMPTZ NOT NULL,
  ends_at      TIMESTAMPTZ NOT NULL,
  CHECK (ends_at > starts_at)
);

CREATE TABLE vip.month_card_packs (
  event_id     INTEGER  NOT NULL REFERENCES vip.month_card_events(id) ON DELETE CASCADE,
  pack_type    INTEGER  NOT NULL,
  name         TEXT     NOT NULL,
  picture      TEXT     NOT NULL,
  price        INTEGER  NOT NULL CHECK (price > 0),
  days         INTEGER  NOT NULL CHECK (days > 0),
  items        JSONB    NOT NULL,                 -- [{item_id, count}]
  PRIMARY KEY (event_id, pack_type)
);

CREATE TABLE vip.month_card_purchases (
  player_id      BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  event_id       INTEGER     NOT NULL,
  pack_type      INTEGER     NOT NULL,
  days_left      INTEGER     NOT NULL CHECK (days_left >= 0),
  last_collected_at TIMESTAMPTZ,
  bought_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, event_id, pack_type),
  FOREIGN KEY (event_id, pack_type) REFERENCES vip.month_card_packs(event_id, pack_type)
);
CREATE INDEX month_card_open_idx ON vip.month_card_purchases (days_left) WHERE days_left > 0;
```

## 8. Backend implementation notes

- `cccactive::dispatch` extend1 29 -> `vip::month_card::handle(op)`.
- `handle_load` (op 1): build 175 for the current event (or the last one while the player still has days left).
- `handle_buy` (op 2): lock purchase row; refuse if it exists; spend diamonds (`pay_type 1`, no bound, reason "vip.month_card"); insert with `days_left = days`; reply 3 and 175.
- `handle_collect` (op 3): lock; require `days_left > 0` and `last_collected_at` not today; grant items (mail overflow); update; reply bag pushes and 175.
- Midnight job: for rows with `days_left > 0` and not collected yesterday, mail yesterday's items and decrement; push 175 to online owners. Activity start/end: push 175 (and toolbar refresh).

## 9. Open questions and assumptions

- Assumption: `collectTime` initial value "2000-01-01 00:00:00".
- Assumption: collection continues after the activity end until `days_left` is 0.
- Open: whether the purchase day counts as day 1 when bought late in the day (chosen: yes).

## 10. Implementation checklist

- [ ] Screen: three cards, bought and not bought states
- [ ] Screen: toolbar effect when collectable
- [ ] Route M1 op 1
- [ ] Route M2 op 2
- [ ] Route M3 op 3
- [ ] Server message S1 175
- [ ] Table `vip.month_card_events`
- [ ] Table `vip.month_card_packs`
- [ ] Table `vip.month_card_purchases`
- [ ] Rule: once per pack per event, diamonds only
- [ ] Rule: one collection per day
- [ ] Rule: midnight mail of uncollected day
- [ ] Test: collecting twice the same day is refused
- [ ] Test: skipped day arrives by mail and `leftDay` decreases
