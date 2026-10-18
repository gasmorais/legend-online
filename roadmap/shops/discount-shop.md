# Discount shop (Desconto da Alegria)

Path aliases:

| Alias | File |
|---|---|
| DSM | `decompiled/core_module/scripts/yishi/manager/DiscountShopManager.as` |
| DSMOD | `decompiled/core_module/scripts/mvc/module/discountshop/DiscountShopModel.as` |
| DSF | `decompiled/m11/scripts/discountshop/DiscountShopFrame.as` |
| DSBF | `decompiled/m11/scripts/discountshop/DiscountShopBuyFrame.as` |
| DGI | `decompiled/m11/scripts/discountshop/DiscountGoodsItem.as` |
| IRI | `decompiled/m11/scripts/discountshop/IntegralRewardsItem.as` |
| TOPC | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

Timed event shop. On first visit the player flips a card to draw a personal discount ("Você está com sorte, parabéns, você sorteou: {0}%OFF, favor fazer compras!"). The event list of items is then sold at `max(1, floor(price x myDisc / 10))` diamonds, each with a per player limit. Purchases add points ("Meus pontos:"); point thresholds unlock one time rewards ("Atingiu {0} pontos").

Entry: top bar button `discountshop` ("Loja de Descontos", `docs/ui/navigation.md:278`), visible when `VersionSwitch.DISCOUNT_SHOP_SWITCH` and `DiscountShopModel.showTopIcon` (`TOPC:311-312`); `showTopIcon` becomes true when a 389 with a non null `begin` arrives (`DSM:101-111`). Click opens controller `discountshop` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1347-1348`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `discountshop.DiscountShopFrame` 860x640 | "Desconto da Alegria" (`DSF:268-272`) | Before the draw: card with question mark and "try" button; after: discount digits `(10 - myDisc) x 10` % OFF, 2 column scroll list of items (`decompiled/m11/scripts/discountshop/DiscountGoodsView.as:31-53`), left column of point rewards (one `IntegralRewardsItem` per `scores` entry, `DSF:124-132`), "Meus pontos:", "Tempo da sorte dos previlégios:" with `begin-end` | top bar | 389 |
| `discountshop.DiscountGoodsItem` | | "Original" price and "Preço Atual" (`DGI:132-142`), stock `count` | list | `items[]` |
| `discountshop.DiscountShopBuyFrame` | "Comprar" | Quantity 1..`limit - buycount`, total price, "Evento do Limite de compra:" `remain/limit` (`DSBF:243-262`) | item click (`DGI:120-129`) | |
| `discountshop.IntegralRewardsItem` | "Atingiu {0} pontos" | Reward icon and count; glowing claim button when `myscore >= score` and not taken (`IRI:90-112`) | frame | `scores[]` |

## 3. Routes (client to server)

All routes: send 9628 (0x259c) `C_DISCOUNT_MALL_OP`, message `com.road.yishi.proto.active.DiscountMallRequestMsg`: `op` (#1, INT32), `param1` (#2, INT32), `param2` (#3, INT32). Sender `DiscountShopManager.operationDiscountShop(op, param1, param2)` (`DSM:130-138`).

| # | op | UI | Params | Client checks | Response |
|---|---|---|---|---|---|
| R1 | 2 draw discount | card "try" button (`DSF:213-241`) | none | only shown while `myDisc <= 0` | 389 with `myDisc > 0` |
| R2 | 3 buy | `DiscountShopBuyFrame.__confirmBuy` (`DSBF:198-211`) | `param1` = item `index`, `param2` = quantity | quantity > 0; total `<= point` (diamonds only) else recharge; quantity <= `limit - buycount` | 389 |
| R3 | 4 claim point reward | `IntegralRewardsItem.__getRewardsHandler` (`IRI:68-79`) | `param1` = reward `score` threshold | not `isTake`; button enabled only when `myscore >= score` | 389 |
| (R0) | 1 | no sender in this build | | | assumption: info request |

## 4. Server messages (server to client)

### S1. 389 (0x0185) `U_C_DISCOUNT_MALL`

- `com.road.yishi.proto.active.DiscountMallMsg`:
  - `id` (#1, STRING) event id; `begin` (#2, STRING) and `end` (#3, STRING) display dates (`begin` null or absent hides the top icon and stops, `DSM:101-106`); `logo` (#4, STRING).
  - `items` (#5, repeated `DiscountMallItemInfo`): `index` (#1, INT32) line key used by op 3; `itemId` (#2, INT32) item template; `price` (#3, INT32) original diamond price; `limit` (#4, INT32) per player limit; `count` (#5, INT32) items granted per purchase; `buycount` (#6, INT32) already bought by this player.
  - `scores` (#6, repeated `DiscountMallScoreInfo`): `score` (#1, INT32) threshold; `itemId` (#2, INT32); `count` (#3, INT32); `isTake` (#4, BOOL) claimed. Sorted ascending by score client side.
  - `myscore` (#7, INT32) player points; `myDisc` (#8, INT32) drawn discount in tenths (0 = not drawn, 7 = pay 70 percent = "30%OFF").
- Receiver: `DiscountShopManager.__discountShopInfoHandler` (`DSM:56-113`) -> `DISCOUNTSHOP_UPDATE` -> `DSF._refreshView` (`DSF:142-199`).
- When: login push while an event runs (and when it starts or ends, with empty `begin` to hide), reply to every op.

## 5. Rules and formulas

- Unit price: `max(1, floor(price x myDisc / 10))` diamonds (`DGI:139`, `DSBF:178`); diamonds only (balance `point`).
- Discount shown: `(10 - myDisc) x 10` percent off.
- Draw: once per event per player (assumption); distribution of `myDisc` is server data (assumption: weighted table 1..9).
- Limits: `buycount + quantity <= limit` per line.
- Points: earned per purchase (assumption: diamonds spent); rewards claimable once each when `myscore >= score`. The reward item template label has a hard coded Chinese placeholder "达到7000积分" replaced at runtime (`IRI:60`).

## 6. Templates

None in `raw/xml/tempinfos`. Events, items, discount table and reward thresholds are server configuration.

## 7. Persistent state

```sql
CREATE TABLE shops.discount_mall_event (
  event_id    TEXT        PRIMARY KEY,
  begin_at    TIMESTAMPTZ NOT NULL,
  end_at      TIMESTAMPTZ NOT NULL,
  logo        TEXT,
  CHECK (end_at > begin_at)
);

CREATE TABLE shops.discount_mall_item (
  event_id          TEXT     NOT NULL REFERENCES shops.discount_mall_event(event_id) ON DELETE CASCADE,
  line_index        INTEGER  NOT NULL,
  item_template_id  INTEGER  NOT NULL,
  price             INTEGER  NOT NULL CHECK (price > 0),
  per_player_limit  INTEGER  NOT NULL CHECK (per_player_limit > 0),
  item_count        INTEGER  NOT NULL CHECK (item_count > 0),
  PRIMARY KEY (event_id, line_index)
);

CREATE TABLE shops.discount_mall_reward (
  event_id          TEXT     NOT NULL REFERENCES shops.discount_mall_event(event_id) ON DELETE CASCADE,
  score_threshold   INTEGER  NOT NULL,
  item_template_id  INTEGER  NOT NULL,
  item_count        INTEGER  NOT NULL,
  PRIMARY KEY (event_id, score_threshold)
);

CREATE TABLE shops.discount_mall_discount_weight (
  event_id   TEXT     NOT NULL REFERENCES shops.discount_mall_event(event_id) ON DELETE CASCADE,
  tenths     SMALLINT NOT NULL CHECK (tenths BETWEEN 1 AND 10),
  weight     INTEGER  NOT NULL CHECK (weight > 0),
  PRIMARY KEY (event_id, tenths)
);

CREATE TABLE shops.discount_mall_player (
  event_id     TEXT     NOT NULL REFERENCES shops.discount_mall_event(event_id) ON DELETE CASCADE,
  player_id    INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  discount     SMALLINT NOT NULL DEFAULT 0 CHECK (discount BETWEEN 0 AND 10),
  score        INTEGER  NOT NULL DEFAULT 0 CHECK (score >= 0),
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE shops.discount_mall_purchase (
  event_id    TEXT     NOT NULL,
  player_id   INTEGER  NOT NULL,
  line_index  INTEGER  NOT NULL,
  bought      INTEGER  NOT NULL DEFAULT 0 CHECK (bought >= 0),
  PRIMARY KEY (event_id, player_id, line_index),
  FOREIGN KEY (event_id, player_id) REFERENCES shops.discount_mall_player(event_id, player_id) ON DELETE CASCADE
);

CREATE TABLE shops.discount_mall_claim (
  event_id         TEXT     NOT NULL,
  player_id        INTEGER  NOT NULL,
  score_threshold  INTEGER  NOT NULL,
  claimed_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (event_id, player_id, score_threshold),
  FOREIGN KEY (event_id, player_id) REFERENCES shops.discount_mall_player(event_id, player_id) ON DELETE CASCADE
);
```

## 8. Backend implementation notes

- `shops::discount_shop::handle_op` (9628), all ops require an active event (else reply 389 with empty `begin`):
  - `handle_draw` (2): only when `discount = 0`; weighted pick; save; reply 389.
  - `handle_buy` (3): discount drawn; line `param1` exists; `param2 >= 1` and `bought + param2 <= limit`; cost `max(1, floor(price x discount / 10)) x param2` diamonds (unbound only); grant `item_count x param2`; `score += cost` (assumption); reply 389 and diamond push.
  - `handle_claim` (4): threshold `param1` exists, `score >= param1`, not claimed; grant; reply 389.
  - `handle_info` (1): reply 389 (defensive).
- Scheduler: at event start and end push 389 to online players (end: `begin` empty to hide the icon).

## 9. Open questions and assumptions

- Assumption: points equal diamonds spent in this shop.
- Assumption: discount drawn once per event.
- Open: op 1 semantics.

## 10. Implementation checklist

- [ ] Tables `shops.discount_mall_*`
- [ ] Route 9628 ops 1..4 and encoder 389
- [ ] Event start and end pushes
- [ ] Screen DiscountShopFrame (card draw, list, rewards)
- [ ] Tests: buy before draw rejected, limit, reward claim twice rejected, price floor 1
