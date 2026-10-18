# Mercado hub and Loja Misteriosa (mystery shop)

Path aliases:

| Alias | File |
|---|---|
| SMF | `decompiled/m7/scripts/auction/SupermarketFrame.as` |
| ASV | `decompiled/m7/scripts/auction/view/supermarket/AuctionShopView.as` |
| MSV | `decompiled/m7/scripts/auction/view/supermarket/MysteryShopView.as` |
| MSM | `decompiled/core_module/scripts/managers/MysteryShopManager.as` |
| MSO | `decompiled/core_module/scripts/mvc/module/auction/MysteryShopModel.as` |
| MSC | `decompiled/core_module/scripts/mvc/controler/MysteryShopControler.as` |
| MSF | `decompiled/m7/scripts/auction/view/mysteryshop/MysteryShopFrame.as` |
| BGI | `decompiled/m7/scripts/auction/view/mysteryshop/BuyGoodsItem.as` |
| EGI | `decompiled/m7/scripts/auction/view/mysteryshop/ExchangeGoodsItem.as` |
| NBF | `decompiled/core_module/scripts/yishi/view/frame/NumBuyFrame.as` |
| SGR | `decompiled/core_module/scripts/yishi/resolve/ShopGoodsInfoResolve.as` |

## 1. Overview

- **Mercado** (`auction.SupermarketFrame`, title "Mercado", castle string `castle.view.CastleBuildingView.command24`): hub with two cards, "Leilão" ("Aqui é mercado de leilões, onde Líderes de todos os cantos se reunem para comprar e vender todos os tipos de item.") and "Loja Misteriosa" ("Uma Loja coberta com um ar misterioso, onde itens raros são vendidos e em períodos determinados, novos itens aparecem."). Opening it also loads the mystery offers when they are stale (`SMF:77-94`).
- **Loja Misteriosa** (`auction.view.mysteryshop.MysteryShopFrame`, "Loja Misteriosa"): tab 1 shows 6 personal random offers (shop rows of `ShopType 5`), refreshed automatically every 4 hours or on demand for 10 diamonds; every offer is bought once. Tab 2 is an exchange of mystery points ("pontos", earned by refreshing and buying) plus diamonds for `ShopType 7` rows. A daily purchase limit applies to both tabs ("O número de compras sofre um reset todos os dias às 5 da manhã"). A left panel lists up to 8 rare items (`IsHot`) and lucky purchase events.

Help (`auction.view.mysteryshop.helpContent`, pt-BR summary): rare items, mounts, materials and jewels; automatic refresh every 4 hours or with diamonds; refreshing or buying gives points that can be traded with a few diamonds for valuable items; daily limit of purchases and exchanges, reset at 5:00.

Data gap: this build's `raw/xml/tempinfos/ShopTempInfos.xml` has no row with `ShopType 5` or `7` (1183 rows; types counted with a script). Without data the shop shows empty slots. The mystery shop also has no reachable entry in this build (see [README.md](README.md)).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `auction.SupermarketFrame` (`SMF`) | "Mercado" | Two cards with hover mask; `show(1)` highlights the auction card, else the mystery card (`SMF:77-94`) | `SupermarketController` (`decompiled/core_module/scripts/mvc/controler/SupermarketController.as:39-42`); never opened in this build | |
| `AuctionShopView` (`ASV`) | "Leilão" card | Enter button -> `openControllerByInfo("auction")` (`ASV:86-89`) | hub | text |
| `MysteryShopView` (`MSV`) | "Loja Misteriosa" card | Enter button; level 26 ("Função ativada no Nv. 26") and daily buys left ("Limite de compras atingida") (`MSV:91-109`) | hub | |
| `MysteryShopFrame` (`MSF`) | "Loja Misteriosa" | Tab 1: 6 `BuyGoodsItem` (2 columns x 3 rows, `MSF:349-367`), countdown to the next automatic refresh, "Atualizar agora" button (tip "Atualizar agora necessita consumir {0} diamantes"), "Compras restantes de hoje： x / max" (`MSF:337-342`). Tab 2: 6 `ExchangeGoodsItem` per page with pager (`MSF:389-407`, `MSC:65-96`). Left: 8 rare items "Lista de possíveis itens da Loja Misteriosa" (`MSF:369-387`, `MSC:49-63`), lucky events (`MSF:307-335`), mystery points (`MSF:344-347`) | `MysteryShopControler.showFrame` (`MSC:26-31`) | `MysteryShopModel` |
| `BuyGoodsItem` (`BGI`) | offer card | Icon, name, price in diamonds (`Point`) or bound diamonds (`GiftToken`), buy or "bought" button (`BGI:230-272`) | tab 1 | `BuyGoodsInfo {index, itemId, isCanBuy}` + `ShopGoodsInfo` |
| `ExchangeGoodsItem` (`EGI`) | exchange card | Icon, name, diamond price, point price `Score` (`EGI:194-231`) | tab 2 | `ShopGoodsInfo` (ShopType 7) |
| `NumBuyFrame` (`NBF`) | quantity buy | Quantity limited by points / `Score` and diamonds / price (`NBF:269-284`); buy via the generic shop cart (`NBF:176-197`) | `EGI` buy button (`EGI:112-140`) | |

Also using this module: the hero frame "Troca de itens" view (`decompiled/m5/scripts/armyII/viewII/information/ItemExchangeView.as:59-71`) sends R1 with `isButton = false` at level 26 or more when the offers are stale. This is the only path the shipped client actually exercises.

## 3. Routes (client to server)

### R1 Load or refresh offers (C_SHOPITEM_FRESH)

- UI: hub open (`SMF:82-85`), frame open when the cache is stale (`MSF:211-216`), countdown end (`MSF:634-638`, `MSF:480-487`), hero "Troca de itens" view; paid refresh "Atualizar agora" (`MSF:506-544`).
- Sender: `MysteryShopManager.sendRefreshGoodsList(isButton, useBind = true)` (`MSM:146-157`).
- Client checks for the paid refresh (`MSF:506-632`): first time of the day a confirmation with "Não alertar mais" and a bound diamond option (`MSF:575-610`); balance `point` (+ `giftToken` when bound diamonds are allowed) >= `ShopFresh_NeedDiamond` (10) else recharge; daily buys left > 0 else "Limite de compras atingida"; if an unbought offer is rare (`Rands <= 100`, `MSO:227-246`) confirm "Itens raros ainda não comprados, certeza ao atualizar?" (`MSF:546-573`).
- Route: C>S 8483 (0x2123) `C_SHOPITEM_FRESH`; `ShopFreshReqMsg` (package `mall`): `isButton` (#1, BOOL) false = load or automatic refresh, true = paid refresh; `pay_type` (#2, INT32) 0 = bound diamonds may be used first, 1 = diamonds only.
- Expected response: 4384 `U_C_SHOPITEM_FRESH` (S1); after a paid refresh also 3 (diamonds) and the points change (assumption: carried by S2 `score` on the next purchase; no other receiver exists).

### R2 Buy an offer (C_SHOPITEM_BUY)

- UI: offer "Comprar" -> confirm "Comprar {0} consumirá {1} diamantes" (bound diamond checkbox variant for `GiftToken` prices) -> `buyGoodsHandlerBack` (`BGI:109-151`) -> `MysteryShopManager.sendBuyGoodsItem(itemId, index, useBind)` (`MSM:132-144`). The button switches to "bought" optimistically.
- Client checks: `buyCount < maxBuyCount` else "Limite de compras atingida" (`BGI:113-118`). No balance check.
- Route: C>S 8482 (0x2122) `C_SHOPITEM_BUY`; `ShopItemBuyMsg` (package `mall`): `item_id` (#1, INT32) shop row `Id` of `ShopType 5`, `index` (#2, INT32) slot 0..5, `pay_type` (#3, INT32) 2 = bound diamonds allowed, 1 = diamonds only.
- Expected replies: 4383 `U_C_SHOPITEM_BUY` (S2), 115 (item), 3 (diamonds); 4470 to everyone when the item is rare (assumption).

### R3 Exchange with points (generic shop cart)

- UI: exchange card "Trocar" (`EGI:112-140`): buys left > 0, `consumePoints >= Score` else "Ponto insuficiente"; opens `NumBuyFrame`; confirm -> `ShopManager.buyOne(Id, count, self, PayType, false)` (`NBF:194-197`, `decompiled/core_module/scripts/managers/ShopManager.as:1205-1220`).
- Route: C>S 8970 (0x230a) `C_SHOPCAR_BUY` with `ShopCarListMsg` (owned by [../shops/README.md](../shops/README.md)): `receiveUserId` (#2) self, `discountTempId` (#3) 0, `carItemInfo` (#4) one `CarItemInfoMsg {shopId (#1) = row Id, counts (#2), payType (#3) = row PayType, isDiscountShop (#4) false}`.
- Expected replies: 4783 `U_C_SHOPCAR_RESULT` (shops module), 115, 3, and S2 or a 4383 push carrying the new `score` and `buy_count` (assumption: the client only learns points through 4383).

## 4. Server messages (server to client)

### S1 4384 (0x1120) U_C_SHOPITEM_FRESH

- `ShopFreshRspMsg` (package `mall`): `itemId` (#1, INT32, repeated) six shop row ids in slot order; `fresh_lastdate` (#2, STRING `YYYY-MM-DD hh:mm:ss`) last refresh time; `isCanBuy` (#3, INT32, repeated) per slot 0 = buyable, 1 = bought; `buy_count` (#4, INT32) purchases today; `max_buy_count` (#5, INT32) daily limit.
- Receiver `MysteryShopManager.__refreshGoodsListHandler` (`MSM:82-105`) -> `MYSTERY_GOODS_LIST_REFRESH` -> `MSF.__refreshFrameView` (`MSF:473-478`). The countdown is `14400 - (now - fresh_lastdate)` seconds (`MSO:210-225`); 0 triggers another R1.
- When: response to R1.

### S2 4383 (0x111f) U_C_SHOPITEM_BUY

- `ShopItemBuyRspMsg` (package `mall`): `result` (#1, INT32), `buy_count` (#2, INT32) purchases today, `score` (#3, INT32) mystery points balance.
- Receiver `MysteryShopManager.__refreshGoodsHandler` (`MSM:70-80`) -> `BGI.__buyReturnHandler` (`BGI:153-167`): result 1 or 12 keep the slot as bought; any other result restores the buy button, then `shopingResult` shows (`BGI:169-228`): 2 "Usuário a presentear inexistente", 3 "Mercadoria inexistente", 5 "Erro de parâmetros", 6 "Limite de quantidade ultrapassada", 7 "Restrição de nível mínimo VIP", 8 "Módulo de mercadoria inexistente", 9 "Restrição de nível da Guilda", 10 "Restrição de nível do Líder", 11 "Falha na dedução", 12 "Compra sucedida, mochila cheia, item foi enviado no email", 15 "Você já possui essa Montaria, não é possível comprar", 19 to 23 VIP and coupon messages; 1 and 4 show nothing.
- When: response to R2; also after R3 to update points (assumption).

### S3 4470 (0x1176) U_C_MYSTERYEVENT_LIST

- `MysteryEventListMsg` (package `mall`): `eventInfo` (#1, repeated `MysteryEventInfoMsg`: `id` (#1, INT32), `user_id` (#2, INT32), `remark` (#3, STRING chat markup), `create_time` (#4, STRING), `is_exist` (#5, BOOL)).
- Receiver `MysteryShopManager.__refreshLuckyPlayerListHandler` (`MSM:107-130`); the frame renders the list only when it opens (`MSF:224`, `:307-335`).
- When: at login and when a rare purchase happens (assumption).

### Other sources

- 4202 (0x106a) `U_C_DATARESET`: `DataResetMsg.buy_count` (#11) resets `buyCount` at the daily reset (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:290`, `:1899-1901`).

## 5. Rules and formulas

- M1 Level 26 (`MSV:95-100`, `ItemExchangeView.as:64`).
- M2 Six slots (`MSO:27`), each from `ShopType 5` rows (`SGR:188-191`, stored as `_mysteryShopTemplateDic`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2615`, lookup by row `Id` `:1807-1817`). Rarity: `Rands <= 100` is rare (`MSO:239`); assumption: the server rolls rows by weight `Rands`.
- M3 Automatic refresh: client countdown 4 h (`AUTO_REFRESH_INTERVAL = 14400`, `MSO:23`). Config `ShopFresh_Times = 11:59:59|23:59:59` ("【神秘商店】自动刷新时间") disagrees; assumption: the server refreshes when 4 h passed since `fresh_lastdate` (matches the client and the help text).
- M4 Paid refresh: `ShopFresh_NeedDiamond = 10` diamonds (`MSO:35-37`), at most `ShopFresh_DayCount = 10` per day (config; the pt-BR key `auction.view.mysteryshop.RefreshCountView.tipText` "Vezes restantes de atualização de hoje:" exists but no view uses it).
- M5 Purchase limit: `max_buy_count` per day, shared by tab 1 and tab 2 (client checks both, `BGI:113`, `EGI:120`). Reset at 05:00 (help). Value not in config; assumption 10.
- M6 Price: `Point` (diamonds) or `GiftToken` (bound diamonds) of the row; the row with `GiftToken` accepts bound diamonds first when `pay_type = 2`.
- M7 Mystery points: earned by paid refresh and purchases (help); spent as `Score` in tab 2. Amount per action unknown (assumption: refresh +10, purchase + price).
- M8 Exchange tab rows: `ShopType 7` (`SGR:196-199`, `_mysteryExchangeShopTemplateDic`), sorted by `Sort` (`MSC:65-79`), 6 per page.
- M9 Rare preview: rows of `ShopType 5` with `IsHot = true`, first 8 (`MSC:49-63`).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ShopTempInfos.xml` | `ShopTempInfo` with `ShopType 5` (offers) and `7` (exchange); none shipped | `Id`, `ItemId`, `Point`, `GiftToken`, `Score`, `PayType`, `Rands`, `IsHot`, `ValidDate`, `Sort`, `VIP0Count..VIP6Count` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `ShopFresh_NeedDiamond` 10, `ShopFresh_Times` `11:59:59|23:59:59`, `ShopFresh_DayCount` 10 | |

## 7. Persistent state

```sql
CREATE TABLE auction.mystery_state (
  player_id          BIGINT      PRIMARY KEY REFERENCES player.players(player_id),
  last_refresh_at    TIMESTAMPTZ  NOT NULL,
  paid_refresh_day   DATE         NOT NULL,
  paid_refresh_count SMALLINT     NOT NULL DEFAULT 0 CHECK (paid_refresh_count >= 0),
  buy_day            DATE         NOT NULL,
  buy_count          SMALLINT     NOT NULL DEFAULT 0 CHECK (buy_count >= 0),
  points             INTEGER      NOT NULL DEFAULT 0 CHECK (points >= 0)
);

CREATE TABLE auction.mystery_slot (
  player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  slot_index   SMALLINT  NOT NULL CHECK (slot_index BETWEEN 0 AND 5),
  shop_id      INTEGER   NOT NULL,
  bought       BOOLEAN   NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, slot_index)
);

CREATE TABLE auction.mystery_event (
  event_id     BIGSERIAL    PRIMARY KEY,
  player_id    BIGINT      NOT NULL REFERENCES player.players(player_id),
  remark       TEXT         NOT NULL,
  created_at   TIMESTAMPTZ  NOT NULL DEFAULT now()
);
CREATE INDEX mystery_event_recent_idx ON auction.mystery_event (created_at DESC);
```

## 8. Backend implementation notes

- `auction::mystery::handle_refresh` (8483): level >= 26. `isButton = false`: if `now - last_refresh_at >= 4 h` reroll the 6 slots and set `last_refresh_at = now`; reply 4384. `isButton = true`: paid refresh count < 10 today, buys left > 0, diamonds (bound first when `pay_type = 0`) >= 10; transaction: debit, reroll, `last_refresh_at = now`, add points; reply 4384, then 3.
- `auction::mystery::handle_buy` (8482): slot `index` holds `item_id` and is not bought (3), buys left (6), level, row VIP limits (7, 19); pay `Point` or `GiftToken` (`pay_type 2` allows bound) (11 on failure); transaction: debit, mark bought, `buy_count + 1`, add points, grant the item (12 when sent by mail because the bag is full). Reply 4383 `{result: 1, buy_count, score}` then 115 and 3. Rare item -> insert `auction.mystery_event`, push 4470 to online players (assumption).
- Exchange purchases arrive through the shops module 8970 handler; it must call `auction::mystery::spend_points_and_count(player, Score * count)` for `ShopType 7` rows and then push 4383 with the new `score` and `buy_count`.
- Daily resets: `buy_count` at 05:00 (help), `paid_refresh_count` at 00:00 (assumption); include `buy_count` in 4202.

## 9. Open questions and assumptions

- Open: `ShopType 5` and `7` rows are missing from the shipped `ShopTempInfos.xml`; the shop cannot work until data is provided.
- Open: no reachable entry (hub never opened); the NPC "Rona, Loja Misteriosa" opens the shops feature `outercityshop` instead.
- Assumption: refresh period 4 h, `max_buy_count` 10, points earned per action, rare broadcast.

## 10. Implementation checklist

- [ ] Screens: SupermarketFrame hub, MysteryShopFrame tabs 1 and 2, NumBuyFrame path
- [ ] Route 8483 `C_SHOPITEM_FRESH` (load, automatic, paid)
- [ ] Route 8482 `C_SHOPITEM_BUY`
- [ ] Hook in the shops module for 8970 rows of `ShopType 7`
- [ ] Server messages 4384, 4383, 4470; `buy_count` in 4202
- [ ] Tables `auction.mystery_state`, `auction.mystery_slot`, `auction.mystery_event`
- [ ] Rules M1..M9 and daily resets
- [ ] Data: `ShopType 5` and `7` rows
- [ ] Test: hero "Troca de itens" view gets a valid 4384 at level 26
- [ ] Test: paid refresh limits and diamond debit; buy limit; bought slot cannot be bought again
