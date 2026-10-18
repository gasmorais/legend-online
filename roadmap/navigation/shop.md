# Navigation shop ("Loja de Navegação")

Feature [navigation](README.md), module `shop`. Aliases in [README.md](README.md). Common request/response format in [hub.md](hub.md).

## 1. Overview

- Six random offers drawn from `NavigationShopTempInfos.xml` (weight `Random`), paid with "Moedas de Navegação" (`Currency`) and sometimes diamonds (`Diamond`, bound first).
- Each offer can be bought once per refresh; at most `navigation_shop_buy_num = 6` purchases per day.
- Offers refresh for free when the refresh timer `shopRefreshCD` has elapsed, or immediately for `navigation_shop_refresh_point = 10` diamonds.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SHOP/NavigationShopFrame.as` (550 x 540) | "Loja de Navegação" (`:244-248`) | 6 offer cells, daily counter, coin balance, refresh timer, free/paid refresh buttons (`:57-227`) | `NavigationFrame` shop button -> controller `shop` openType 9001 (`NAV/NavigationFrame.as:200-204`, `decompiled/core_module/scripts/mvc/controler/ShopControler.as:143`) | `shopList`, `dayBuyShopNum` ("6 - n / 6", `:165-170`), `currency`, `shopRefreshCD` countdown (`:171-187`) |
| `SHOP/NavigationShopGoodsItem.as` | "Deseja consumir {0} moedas de navegação para comprar {1} x{2}?" / with diamonds "Deseja gastar {0} Moeda(s) de Navegação e {3} Diamante(s) para comprar {2} x{1}? (Diamantes vinculados são usados primeiro)" | Offer cell; buy button disabled when `buy == true` (`:153-190`) | shop frame | item, count, coin price, diamond price |

## 3. Routes (client to server)

### R1. Buy offer (op 14)

- UI: buy button (`SHOP/NavigationShopGoodsItem.as:117-151`).
- Client checks: `dayBuyShopNum < 6` else "Limite de compras diárias atingiu o limite"; confirmation; `currency >= Currency` else "Moedas de navegação, não é possível comprar"; `allPoint >= Diamond` else recharge.
- Request: `op = 14`, `param1 = ""`, `param2 = ""`, `param3 = slot index` (`MountShopInfo.index`).
- Expected: 341 `{op: 14}`, 342 with the row `buy = true`, `dayBuyShopNum + 1`, `currency` reduced; bag 115; player info 3 when diamonds were spent.

### R2. Free refresh (op 15, free)

- UI: free refresh button, visible only when the timer elapsed (`SHOP/NavigationShopFrame.as:145-158`).
- Request: `op = 15`, `param1 = ""`, `param2 = ""`, `param3 = 0`, `param4 = 0`.
- Expected: 341 `{op: 15}`, 342 with 6 new rows and a new `shopRefreshCD`.

### R3. Paid refresh (op 15, paid)

- UI: quick refresh button, visible while the timer runs (`SHOP/NavigationShopFrame.as:115-143`).
- Client checks: confirmation "Deseja consumir {0} diamantes para atualizar item?" (10) with bound option; `allPoint` or `point >= 10` else recharge.
- Request: `op = 15`, `param3 = 1` (paid), `param4 = useBound ? 0 : 1`.
- Expected: 341 `{op: 15}`, 342 with 6 new rows (timer unchanged, assumption), player info 3.

## 4. Server messages (server to client)

342 fields `buyData` (#8, `NavigationBuyDataMsg`, repeated: `shopId` (#1, INT32) template `ShopId`, `index` (#2, INT32) slot 0..5, `buy` (#3, BOOL) bought), `dayBuyShopNum` (#3), `shopRefreshCD` (#5, INT64 epoch ms), `currency` (#2). Stored by `NM:103-150`; rows sorted by `index`. Event `NAVIGATION_DATA_CHANGE` refreshes the shop (`SHOP/NavigationShopFrame.as:160-163`). The 341 op 13 SHOP_MAIN has no client sender (server only).

## 5. Rules and formulas

- 6 slots; offers picked by weight `Random` (100 for common rows, 20 for rare rows); 66 templates, 24 distinct items (assumption: without duplicates in one refresh).
- Daily purchase cap 6 (reset with the daily reset in [hub.md](hub.md)).
- Paid refresh 10 diamonds; free refresh period `navigation_shop_refresh_cd` (getter `CFG:337-340`) is absent from this `ConfigInfos.xml` (open question; suggested 2 h).

## 6. Templates

`raw/xml/tempinfos/NavigationShopTempInfos.xml` (`nagivationShopTemplateCate.getTemplateByShopId`): `ShopId` (1..66), `ItemId`, `Count`, `Random` weight, `Currency` coin price (60..800), `Diamond` extra diamond price (0..200).

## 7. Persistent state

```sql
CREATE TABLE navigation.shop_offer (
  player_id    INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  slot         SMALLINT NOT NULL CHECK (slot BETWEEN 0 AND 5),
  shop_id      INTEGER  NOT NULL,
  bought       BOOLEAN  NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, slot)
);
```

Counters `shop_buys_today` and `shop_refresh_at` are in `navigation.player_state` ([hub.md](hub.md)).

## 8. Backend implementation notes

- `navigation::shop::handle_buy` (op 14): slot exists, not bought, `shop_buys_today < 6`, coins and diamonds enough -> transaction: deduct coins and diamonds (bound first), grant `ItemId x Count`, `bought = true`, `shop_buys_today + 1`.
- `navigation::shop::handle_refresh` (op 15): `param3 = 0` requires `now >= shop_refresh_at`, then `shop_refresh_at = now + period`; `param3 = 1` charges 10 diamonds per `param4`. Regenerate 6 rows.
- First access: generate offers lazily when no rows exist.

## 9. Open questions and assumptions

- Free refresh period (config key missing).
- Whether a paid refresh resets the free timer.
- Duplicate offers allowed or not.

## 10. Implementation checklist

- [ ] Screen: `NavigationShopFrame`, `NavigationShopGoodsItem`
- [ ] Route R1 op 14 buy
- [ ] Route R2 op 15 free refresh
- [ ] Route R3 op 15 paid refresh
- [ ] Server message 342 shop fields
- [ ] Table `navigation.shop_offer`
- [ ] Template loader `NavigationShopTempInfos.xml`
- [ ] Test: purchase cap 6 per day and bought flag
