# Time limited offers (Compra Limitada)

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/managers/ShopManager.as` |
| SMOD | `decompiled/core_module/scripts/mvc/module/shop/ShopModel.as` |
| MSI | `decompiled/core_module/scripts/mvc/module/shop/MainShopInfo.as` |
| TBF | `decompiled/m11/scripts/timebuy/TimeBuyFrame.as` |
| TBI | `decompiled/m11/scripts/timebuy/TimeBuyItem.as` |
| STBV | `decompiled/m15/scripts/view/timebuy/ShopTimeBuyView.as` |
| GI5 | `decompiled/m15/scripts/view/GoodsItem5.as` |
| TOP | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TOPC | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

The server defines diamond offers (`MainDiscountInfo`) that are not in any XML template. One list, pushed on 4238, carries every offer kind; the client splits it by `type` (`SMOD.mainDiscountList` setter, `SMOD:446-564`):

| `type` | Client list | Shown in | Module |
|---|---|---|---|
| 1 | `_timeBuyList` and `_mainDiscountList` | mall home tab "Compra Limitada" (`ShopTimeBuyView`), VIP variant when `vip > 0` | this module |
| 2 | `_timeBuyList` and `_loopItemList` | top bar "Compra Limitada" frame (`TimeBuyFrame`), rotating stock refilled every `refresh_interval` | this module |
| 3 | `_groupBuyList` | group buy event | [group-buy.md](group-buy.md) |
| 4, 5, 6 | `_promotionalGoodsList` | mall home right column | [promotions.md](promotions.md) |
| 7 | `_artifactList` | artifact shop | [promotions.md](promotions.md) and [../divine-weapon/README.md](../divine-weapon/README.md) |

Offers are always paid with diamonds (no bound diamonds) and bought with `is_discount = true`.

Entry points:
- Mall home tab (first tab, visible when `getTimeBuyList(0)` has items or promotional offers exist, `decompiled/m15/scripts/view/inside/ShopTypeTabView.as:96-104`).
- Top bar button key `limitbuy` ("Compra Limitada", `ui.toptoolbar.TopToolsBar.timeBuy.tipsData`): visible when level >= 10 and `getTimeBuyList2()` (type 2, `vip <= 0`) is not empty (`TOPC:269-270`); click opens controller `timebuy` (`TOP:1192-1194`).
- Task trace tip "Atualização da Loja" / "Atualização na área de VIP da Loja" (`SM.showShopTimeBuyTip`, `SM:1062-1083`) with button "Direção da Loja" that opens the mall.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `timebuy.TimeBuyFrame` | "Compra Limitada" (`TBF:83`) | 9 type 2 offers per page (`TBF:164-214`), balance, recharge button; closes itself when the list is empty | top bar `limitbuy` | per item: name, price, discount, "Limitada" counter `limitCount - count`, remaining time until the next refresh (`ShopManager.timeBuyDesc`) |
| `view.timebuy.ShopTimeBuyView` | mall home tab | 6 type 1 offers per page (`STBV:136-148,240-286`), cart button, recharge, right column `MainRightView` | mall home tab | per item (`GoodsItem5`): price, discount, remaining time `endDate - now`, total stock `canTotalCount`, daily limit |
| `tasktracetip.view.ShopTimeBuyTipView` | "Loja" tip | Notice that offers changed | `SM.showShopTimeBuyTip` | |
| `yishi.view.frame.ShopMainBuyFrame` | "Comprar" | Buy frame for one offer | 4599 reply | [purchase.md](purchase.md) |

## 3. Routes (client to server)

### R1. Refresh loop offers (8632)

- UI: open of `TimeBuyFrame` (`TBF.show`, `TBF:337-344`); open of the mall home tab (`STBV.initTimeGoods`, `STBV:159-163`); countdown reaching 0 in `TBF.__updateTimeHandler` (`TBF:216-256`), `STBV.__updateTimeHandler` (`STBV:325-366`) and `MainRightView` (`decompiled/m15/scripts/view/inside/MainRightView.as:203-234`), which also zero the local type 2 counters (`SM.refreshGoodsCount`, `SM:755-771`).
- Sender: `ShopManager.refreshTimeGoods()` (`SM:701-706`).
- Route: send 8632 (0x21b8) `C_FLASH_SALE_FRESH`, empty body.
- Response: 4547 (S3).

### R2. Buy an offer

- UI: buy button of `TimeBuyItem` (`TBI:152-173`) or `GoodsItem5` (`GI5:140-160`).
- Type 1: `ShopManager.type = 1`, `currBuyGoods = offer`, `getGoodsBuyNum(id, 0)` -> 8693 with `is_discount = true`, `type = 0`. Type 2: `getGoodsBuyNum(id, 2)` -> 8693 with `type = 2` (`TBI:162-167`); in the mall home tab type 2 offers go straight to the buy frame (`GI5:152-156`).
- 4599 opens `ShopMainBuyFrame`; confirm sends 8970 with one line `{shopId = offer id, counts, payType = 1, isDiscountShop = true}` and optional coupon (`decompiled/core_module/scripts/yishi/view/frame/ShopMainBuyFrame.as:83-135`).
- Client checks: diamonds >= price x quantity else recharge; quantity clamp to `min(limitCount - count, floor(point / price))` for type 2 and `canBuyNum` for type 1 (`decompiled/core_module/scripts/yishi/view/frame/BuyFrameI.as:1130-1160`).
- Full route and result codes: [purchase.md](purchase.md) R1, R2.

## 4. Server messages (server to client)

### S1. 4238 (0x108e) `U_C_SHOP_MAIN`

- Message `ShopMainRspMsg`:
  - `urlInfo` (#1, MainUrlInfo, repeated): `id` (#1, INT32), `url` (#2, STRING) banner image path, `site` (#3, INT32) slot. Stored in `SMOD.mainUrlList` (sorted by `site`), only used by the dead `ShopMainView`.
  - `goodInfo` (#2, MainGoodInfo, repeated): `id` (#1), `shopId` (#2) ShopTempInfos Id, `templateId` (#3), `sortId` (#4), `types` (#5). Stored in `SMOD.mainNewList`, only used by the dead `ShopMainView`.
  - `discountInfo` (#3, MainDiscountInfo, repeated), fields: `id` (#1, INT32) offer id; `site` (#2, INT32) position; `shopId` (#3, INT32) source row (unused); `templateId` (#4, INT32) and `counts` (#5, INT32) first item; `shopId1..shopId8`, `templateId1..templateId8`, `count1..count8` (#6..#29, INT32) extra items of a bundle; `sortId` (#30, INT32) order; `discount` (#31, INT32) percent shown (divided by 100 for display, `SMOD:500`); `beginDate` (#32, STRING) and `endDate` (#33, STRING) `YYYY-MM-DD hh:mm:ss`; `oneDayCount` (#34, INT32) per player limit per day (-1 none); `maxCount` (#35, INT32) server wide stock (-1 none); `currentCount` (#36, INT32) server wide sold; `maxCurrentDate` (#37, STRING) day the stock counter belongs to; `isGift` (#38, BOOL) bundle offer with icon `url` and name `names`; `url` (#39, STRING); `names` (#40, STRING); `price` (#41, INT32) diamonds per unit; `type` (#42, INT32) offer kind (section 1); `limitCount` (#43, INT32) per player limit per refresh window for type 2; `vip` (#44, INT32) minimum VIP grade (0 = everyone); `level1`/`price1`, `level2`/`price2`, `level3`/`price3` (#45..#50, INT32) group buy price tiers; `sendDate` (#51, STRING) end of the group buy payment window; `refreshInterval` (#52, INT32) seconds; `frontMoney` (#53, INT32) group buy deposit.
  - `flag` (#4, INT32) chunk key: when equal to the previous `flag`, the new `discountInfo` is appended to the stored list, else the list is replaced (`SM:383-393`).
- Receiver: `ShopManager.__shopHandler` (`SM:350-405`): offers whose `beginDate` is in the future go to `timeArr`; new offers already started and not known before raise the time buy tip (VIP tip when `vip > 0`) and the top bar effect `SHOWTIMEBUYEFF`; dispatch `SHOPHOMEPAGE_UPDATA`.
- When: login push; again whenever the offer set changes (new event, offer start or end). Only offers with `endDate > now` are listed by the client (`MSI.remainTime`, `MSI:208-221`).

### S2. 4375 (0x1117) `U_C_SHOP_DISCOUNT`

- Message `MainDiscountInfo` (single offer, same fields as above).
- Receiver: `ShopManager.__shopDiscountHandler` (`SM:302-348`): finds the offer by `id` in type 1/2 lists or promotional list and updates `currentCount`, `oneDayCount`, `maxCount`, `maxCurrentDate`, `beginDate`, `endDate`; dispatch `SHOPHOMEPAGE_UPDATA`. Note a client quirk: `beginDate` is stored as seconds relative to now (`SM:322,341`).
- When: push to all online players after any purchase that changes `currentCount` (server wide stock), and when an offer is edited.

### S3. 4547 (0x11c3) `U_C_FLASHSALE_FRESH`

- Message `ShopMsg`: `refresh_date` (#3, STRING) start of the current refresh window; `refresh_interval` (#6, INT32) seconds (client uses 3600 when <= 0); `hasDataInfo` (#2, repeated `HasDataInfo`): `item_id` (#2) offer id, `counts` (#3) bought by this player in the window, `user_id` (#1), `buy_date` (#4), `is_discount` (#5).
- Receiver: `ShopManager.__refreshTimeBuyHandler` (`SM:708-753`): `timeBuyDesc = refresh_date + refresh_interval` (next refresh), `_refreshTime = interval / 3600` hours (text "A cada {0} horas tem {1} limite de compra", `shop.view.GoodsItem.limited06`), sets `count` of matching offers, dispatch `SHOP_TIME_BUY_REFRESH`, starts a 1 s timer that shows the tip when the window ends (`SM:1085-1100`).
- When: reply to 8632.
- Current server: `server/flows/navigation.json:1138-1153` answers 8632 with an empty 4547 and interval 3600.

## 5. Rules and formulas

- Visibility: `remainTime > 0` (between `beginDate` and `endDate`). Home tab lists type 1 offers with `vip == 0` (`SMOD.getTimeBuyList(0)`, `SMOD:351-385`); VIP list `vip > 0` (`getTimeBuyList(1)`, not reachable in this build because `ShopTimeBuyView.isVIPShop` is always false, `decompiled/m15/scripts/view/inside/ShopTypeTabView.as:242`); top bar frame lists type 2 offers with `vip <= 0` (`SMOD.getTimeBuyList2`, `SMOD:387-408`). Order: by `type` then `sortId` descending numeric (`SMOD:563`, flags `2 | 0x10`).
- Type 1 limits: per player `oneDayCount` per day; server wide `maxCount` per `maxCurrentDate` day (`MSI.canTotalCount`, `MSI:135-164`).
- Type 2 limits: per player `limitCount` per refresh window of `refresh_interval` seconds; `oneDayCount - count` is the displayed remaining (`MSI:180-183`); server wide `maxCount - currentCount` without daily reset (`MSI:159-163`).
- Price: `price` diamonds per unit, coupon allowed (types 1 and 2 only, `decompiled/core_module/scripts/yishi/view/frame/BuyFrameI.as:592-622`), no bound diamonds.
- VIP gate: `vip` minimum VIP grade (result 7 or 19 when not met).
- Delivery: `templateId x counts`, plus `templateId1..8 x count1..8` for bundles, multiplied by the purchased quantity.

## 6. Templates

No XML template. Offers are server configuration (operator defined). Item templates for `templateId*` come from the item catalog ([../inventory/README.md](../inventory/README.md)).

## 7. Persistent state

```sql
CREATE TABLE shops.discount_offer (
  offer_id          INTEGER     PRIMARY KEY,
  offer_type        SMALLINT    NOT NULL CHECK (offer_type BETWEEN 1 AND 7),
  site              INTEGER     NOT NULL DEFAULT 0,
  sort_id           INTEGER     NOT NULL DEFAULT 0,
  is_bundle         BOOLEAN     NOT NULL DEFAULT false,
  bundle_name       TEXT,
  icon_url          TEXT,
  price             INTEGER     NOT NULL CHECK (price >= 0),
  discount_percent  INTEGER     NOT NULL DEFAULT 0,
  begin_at          TIMESTAMPTZ NOT NULL,
  end_at            TIMESTAMPTZ NOT NULL,
  one_day_count     INTEGER     NOT NULL DEFAULT -1,
  max_count         INTEGER     NOT NULL DEFAULT -1,
  limit_count       INTEGER     NOT NULL DEFAULT 0,
  refresh_interval  INTEGER     NOT NULL DEFAULT 3600,
  min_vip           SMALLINT    NOT NULL DEFAULT 0,
  front_money       INTEGER     NOT NULL DEFAULT 0,
  payment_end_at    TIMESTAMPTZ,
  CHECK (end_at > begin_at)
);

CREATE TABLE shops.discount_offer_item (
  offer_id          INTEGER  NOT NULL REFERENCES shops.discount_offer(offer_id) ON DELETE CASCADE,
  slot              SMALLINT NOT NULL CHECK (slot BETWEEN 0 AND 8),
  shop_row_id       INTEGER,
  item_template_id  INTEGER  NOT NULL,
  item_count        INTEGER  NOT NULL CHECK (item_count > 0),
  PRIMARY KEY (offer_id, slot)
);

CREATE TABLE shops.discount_offer_tier (
  offer_id   INTEGER  NOT NULL REFERENCES shops.discount_offer(offer_id) ON DELETE CASCADE,
  tier       SMALLINT NOT NULL CHECK (tier BETWEEN 1 AND 3),
  min_buyers INTEGER  NOT NULL,
  price      INTEGER  NOT NULL,
  PRIMARY KEY (offer_id, tier)
);

CREATE TABLE shops.discount_offer_stock (
  offer_id     INTEGER     NOT NULL REFERENCES shops.discount_offer(offer_id) ON DELETE CASCADE,
  stock_day    DATE        NOT NULL,
  sold_count   INTEGER     NOT NULL DEFAULT 0 CHECK (sold_count >= 0),
  PRIMARY KEY (offer_id, stock_day)
);
```

- Per player counters use `shops.purchase_counter` with `source = 1`: type 1 `period_kind = 1` (daily); type 2 `period_kind = 5` with `period_start` = start of the refresh window (`begin_at + n x refresh_interval`).
- For type 2 offers `stock_day` holds the offer lifetime key (use `begin_at::date`) because their stock does not reset daily.

## 8. Backend implementation notes

- `shops::timebuy::build_main_msg(player)`: all offers with `end_at > now` (include future offers, the client keeps them in `timeArr`), filter nothing by VIP (client filters), fill `currentCount` from today's stock, `maxCurrentDate = today`. Send 4238 at login and broadcast on offer changes; use a new `flag` value per full send.
- `shops::timebuy::handle_flash_sale_refresh` (8632): compute current window of type 2 offers (assumption: all type 2 offers share one window anchored at 00:00 and the smallest `refresh_interval`), reply 4547 with the player's counters in that window.
- Purchase validation hook used by `shops::purchase::handle_cart_buy` for `isDiscountShop = true`: offer active, VIP, `oneDayCount` or `limitCount`, server stock; increment `discount_offer_stock` and broadcast 4375 to online players when `max_count != -1`.
- Scheduler `shops::timebuy::tick` every minute: detect offers that start or end, broadcast 4238.

## 9. Open questions and assumptions

- Assumption: window anchor of type 2 offers (client only needs `refresh_date` and `refresh_interval`).
- Assumption: `discount` is informational (the client shows `discount / 100` but always charges `price`).
- Open: meaning of `MainGoodInfo.types` and `shopId` inside `MainDiscountInfo` (unused by the client).
- Open: whether VIP offers (`vip > 0`) were shown anywhere in this build (no live screen).

## 10. Implementation checklist

- [ ] Tables `shops.discount_offer`, `shops.discount_offer_item`, `shops.discount_offer_tier`, `shops.discount_offer_stock`
- [ ] Operator tooling or seed for offers
- [ ] Encoder 4238 with chunk `flag`
- [ ] Encoder 4375 broadcast on stock change
- [ ] Route 8632 `shops::timebuy::handle_flash_sale_refresh` and encoder 4547
- [ ] Offer purchase validation in 8970 (type 1 daily, type 2 window, stock, VIP)
- [ ] Scheduler `shops::timebuy::tick`
- [ ] Screens TimeBuyFrame and mall home tab
- [ ] Tests: offer outside dates rejected, stock exhaustion broadcast, type 2 window reset
