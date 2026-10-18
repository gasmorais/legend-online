# Mall promotions: featured offer, daily gift boxes, artifact offers, limited time discount

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/managers/ShopManager.as` |
| SMOD | `decompiled/core_module/scripts/mvc/module/shop/ShopModel.as` |
| MSI | `decompiled/core_module/scripts/mvc/module/shop/MainShopInfo.as` |
| MRV | `decompiled/m15/scripts/view/inside/MainRightView.as` |
| STI | `decompiled/m15/scripts/view/inside/ShopTimeItem.as` |
| SGBV | `decompiled/m15/scripts/view/inside/ShopGiftBoxView.as` |
| GI9 | `decompiled/m15/scripts/view/GoodsItem9.as` |
| LTD | `decompiled/core_module/scripts/mvc/module/shop/LimiteTimeDiscountInfo.as` |

## 1. Overview

`MainDiscountInfo` offers of type 4, 5, 6 and 7 (pushed on 4238, see [timebuy.md](timebuy.md)) plus the separate limited time discount activity (4890):

| Kind | Source | Screen | Action |
|---|---|---|---|
| Featured offer (type 4) | 4238 | mall home tab right column, `ShopTimeItem` with countdown | buy (8693 type 4 -> 8970) |
| Daily free gift (type 5) | 4238 | right column gift box 1 ("asset.shop.daygift") | claim (9545) |
| Daily consume gift (type 6) | 4238 | right column gift box 2, tooltip "Diariamente ao consumir valor desejado de diamantes não vinculados poderá coletar" (`shop.dayCost.alertData`) | claim (9545) when `PlayerMsg.is_cost` is true |
| Artifact offer (type 7) | 4238 | `ArtifactShopView` grid of `GoodsItem9` (owner [../divine-weapon/README.md](../divine-weapon/README.md)) | buy (8693 type 7 -> `ArtifactBuyFrame` -> 8970) |
| Limited time discount | 4890 `ShopDiscountActiveMsg` | `LimiteTimeDiscountView` (never instantiated in this build) | buy (8970 with `type = 1`) |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `view.inside.MainRightView` | right column of the "Compra Limitada" home tab | featured offer, two gift boxes, "Loja Misteriosa" button, 2 preview cells (`MRV:58-96`) | mall home tab | offers of type 4, 5, 6 (`SMOD.getPromotionalGoodsList`, `SMOD:410-431`, sorted by type) |
| `view.inside.ShopTimeItem` | | Featured offer: icon, price, "Quantidade：{0}" (`shop.mainRightView.shoptimeitem.counttitle`, server stock `canTotalCount`), "Restante:" countdown | `MainRightView` | type 4 offer |
| `view.inside.ShopGiftBoxView` | | Gift box with glow when claimable, grey with "IntergalBoxGeted" stamp when claimed | `MainRightView` | type 5 or 6 offer: bundle icon `url`, name `names`, content list |
| `view.GoodsItem9` (from `ArtifactShopView`) | "view.GoodsItem9.title" | Artifact offer cell | divine weapon artifact shop | type 7 offer, total limit |
| `view.limiteTimeDiscountBuy.LimiteTimeDiscountView` + `yishi.view.frame.ShopLimiteTimeDiscountBuyFrame` | | Limited time discount list (dead) | none | 4890 data |

## 3. Routes (client to server)

### R1. Buy the featured offer (type 4)

- UI: click on `ShopTimeItem` (`STI:162-173`): `ShopManager.type = 1`, `currBuyGoods = offer`, `getGoodsBuyNum(id, 4)`.
- Route: 8693 `C_BUY_DISCOUNT` with `buyInfo {good_id = offer id, type = 4, is_discount = true}` -> 4599 -> `ShopMainBuyFrame` -> 8970 one line `{shopId = offer id, payType = 1, isDiscountShop = true}` ([purchase.md](purchase.md) R1, R2).

### R2. Query and claim a daily gift (types 5, 6)

- On display: `ShopGiftBoxView.updateView` sends `getGoodsBuyNum(id, type)` (`SGBV:103-111`) -> 8693 `buyInfo {good_id, type = 5 or 6, is_discount = true}`; the 4599 reply sets `dayGiftCount` or `costGiftCount` and greys the box when `oneDayCount - count <= 0` (`SGBV:71-101`).
- Claim UI: click on a glowing box (`SGBV:159-170`), anti double click 400 ms ("Clique excessivo, tente novamente"). Clickable when type 5, or type 6 and `PlayerInfo.isCost` (`SGBV:137-156`).
- Sender: `ShopManager.getGift(offerId)` (`SM:1240-1246`); identical `getShopGift` (`SM:693-699`) has no caller.
- Route: send 9545 (0x2549) `C_ShOP_DAILY`, message `com.road.yishi.proto.shop.CarItemInfoMsg`: `shopId` (#1, INT32) = offer id; `counts` (#2), `payType` (#3), `isDiscountShop` (#4), `type` (#5) unset.
- Followed immediately by 8693 for the same box (`SGBV:169`).
- Expected response: item delivery (bag or mail), then 4599 for the 8693 with the new claimed count. Assumption: no dedicated reply opcode exists (none is listened to).

### R3. Buy a limited time discount item (dead UI)

- Sender: `ShopLimiteTimeDiscountBuyFrame.__confirmHandler` -> `ShopManager.buyOneNew(id, num, selfId, payType 2 or 1, true, 1, couponId)` (`decompiled/core_module/scripts/yishi/view/frame/ShopLimiteTimeDiscountBuyFrame.as:53-90`).
- Route: 8970 with one line `{shopId = ShopItemInfoMsg.id, counts, payType, isDiscountShop = true, type = 1}`.

## 4. Server messages (server to client)

### S1. 4238 / 4375 offers

Types 4..7 arrive in `ShopMainRspMsg.discountInfo` and `MainDiscountInfo` updates; full field list in [timebuy.md](timebuy.md) S1 and S2. Relevant fields: type 4 uses `price`, `maxCount`/`currentCount`, `endDate`; types 5 and 6 use `isGift`, `url`, `names`, `templateId..templateId8`, `counts..count8`, `oneDayCount` (claims per day, usually 1); type 7 sets `oneDayCount = maxCount` client side (`SMOD:555-559`).

### S2. 4599 (0x11f7) `U_C_BUY_DISCOUNT` for types 5, 6, 7

`buyInfo.type` 5 -> `ShopManager.dayGiftCount`, 6 -> `costGiftCount`, both dispatch `SHOP_TIME_GIFT_REFRESH` and do not open any frame (`SM:219-230`); 7 updates the pending artifact offer counts (`SM:231-240`). The box compares `good_id` and `type` with its own (`SGBV:71-78`).

### S3. 4890 (0x131a) `U_C_SHOP_DISCOUNT_INFO`

- Message `com.road.yishi.proto.active.ShopDiscountActiveMsg`: `id` (#1, STRING) activity id; `begin` (#2, STRING); `end` (#3, STRING); `isopen` (#4, BOOL); `allItems` (#5, repeated `ShopItemInfoMsg`: `id` (#1, INT32) line id, `templateId` (#2, INT32), `num` (#3, INT32) per player limit, `price` (#4, INT32), `isBindMoney` (#5, BOOL) bound diamonds allowed); `buyInfos` (#6, repeated `UserBuyInfoMsg`: `id` (#1, INT32), `num` (#2, INT32) bought).
- Receiver: `ShopManager.__limiteTimeDiscountBtnDataHandler` (`SM:837-877`): stores `limiteTimeDiscountGoodsList` sorted by id with `count` from `buyInfos`; dispatch `SHOP_LIMITE_TIMEDISCOUNT_UPDATA` (repaints the mall tab bar, `decompiled/m15/scripts/view/inside/ShopTypeTabView.as:124-127`).
- When: login push and on change. Data only in this build.

### S4. 3 (0x0003) player info

`PlayerMsg.is_cost` (#114, BOOL) enables the daily consume gift (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1144-1147`). Owner: [../hero/README.md](../hero/README.md). The server sets it true once the player spent the configured amount of unbound diamonds today and pushes 3 again.

## 5. Rules and formulas

- Featured offer: one type 4 offer is shown (the first in the promotional list); countdown `endDate - now`; when it reaches 0 the client sends 8632 (`MRV:203-234`).
- Daily free gift (type 5): claimable `oneDayCount` times per day (assumption: 1).
- Daily consume gift (type 6): claimable when `is_cost` is true, i.e. the player consumed at least a threshold of unbound diamonds today (threshold not in client data; assumption: server configuration). Bound diamond spending does not count ("Não participa no evento de consumo").
- Artifact offers: per player limit `maxCount` (client copies it to `oneDayCount`).
- Limited time discount: per line limit `num`; `isBindMoney` allows bound diamonds (`payType = 2`).
- All daily counters reset at 00:00 (assumption).

## 6. Templates

None. Offers are server configuration (`shops.discount_offer` in [timebuy.md](timebuy.md)).

## 7. Persistent state

- Offers of type 4..7: `shops.discount_offer`, `shops.discount_offer_item` ([timebuy.md](timebuy.md)).
- Claims and purchases: `shops.purchase_counter` with `source = 1` ([purchase.md](purchase.md)).
- Daily consume tracking:

```sql
CREATE TABLE shops.daily_consumption (
  player_id        INTEGER NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day              DATE    NOT NULL,
  diamonds_spent   BIGINT  NOT NULL DEFAULT 0 CHECK (diamonds_spent >= 0),
  PRIMARY KEY (player_id, day)
);

CREATE TABLE shops.limited_discount_activity (
  activity_id   TEXT        PRIMARY KEY,
  begin_at      TIMESTAMPTZ NOT NULL,
  end_at        TIMESTAMPTZ NOT NULL,
  is_open       BOOLEAN     NOT NULL DEFAULT true
);

CREATE TABLE shops.limited_discount_item (
  activity_id      TEXT    NOT NULL REFERENCES shops.limited_discount_activity(activity_id) ON DELETE CASCADE,
  line_id          INTEGER NOT NULL,
  item_template_id INTEGER NOT NULL,
  per_player_limit INTEGER NOT NULL,
  price            INTEGER NOT NULL,
  allow_bound      BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (activity_id, line_id)
);
```

## 8. Backend implementation notes

- `shops::promotions::handle_daily_gift` (9545): offer exists, type 5 or 6, active; type 6 requires `daily_consumption.diamonds_spent >= threshold`; counter < `oneDayCount`; grant bundle items (bag or mail); increment counter with `period_kind = 1`. No direct reply; the following 8693 returns the new count.
- `shops::promotions::on_diamonds_spent(player, amount)`: called by currency when unbound diamonds are consumed; update `daily_consumption`; when the threshold is crossed set `is_cost` and push 3.
- Limited time discount: `shops::promotions::build_limited_discount(player)` for 4890 at login; purchase validation in `shops::purchase::handle_cart_buy` when `CarItemInfoMsg.type == 1`.
- Daily job at 00:00: reset `is_cost` and push 3 (counters roll by period).

## 9. Open questions and assumptions

- Assumption: threshold of the daily consume gift is server configuration; no client config key exists.
- Assumption: 9545 has no reply opcode.
- Open: whether 4890 should be sent at all, given the screen is unreachable.

## 10. Implementation checklist

- [ ] Featured offer purchase via 8693 type 4 and 8970
- [ ] Route 9545 `shops::promotions::handle_daily_gift`
- [ ] 4599 replies for types 5, 6, 7
- [ ] `is_cost` flag tracking and push 3
- [ ] Encoder 4890 and tables `shops.limited_discount_activity`, `shops.limited_discount_item`
- [ ] Table `shops.daily_consumption`
- [ ] Tests: claim free gift twice (second rejected), consume gift before and after threshold
