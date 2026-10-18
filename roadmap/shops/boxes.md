# Fashion and mount boxes (Baú de Moda, Baú de Montaria)

Path aliases:

| Alias | File |
|---|---|
| SBV | `decompiled/m15/scripts/view/inside/ShopBoxView.as` |
| EBM | `decompiled/core_module/scripts/managers/ExchangeBoxManager.as` |
| EBMOD | `decompiled/core_module/scripts/mvc/module/exchange/ExchangeBoxModel.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |

## 1. Overview

Two lottery tabs of the mall (`shop.fashionBoxBtn`, `shop.mountBoxBtn`, `decompiled/m15/scripts/view/inside/ShopTypeTabView.as:207-212`). Each tab has:
- Normal buy (left button, "Ao comprar {item} x{n}, obterá um item aleatório"): buys the box item (fashion: item 208020 x1; mount: item 208017 x10 per purchase) and rolls one random reward from the normal drop list. A "10x" button (`_oneKeyBtn`) does ten purchases at once. Every 10 normal purchases grant a random fashion or mount card ("Comprando 10 vezes ganhará moda aleatória", "Os pontos serão redefinidos diariamente às 0h").
- Collection buy (right button, "Ao comprar será presenteado 6 itens aleatórios, tem a chance de obter o item do dia"): six random rewards from the hot drop list with a chance of the featured item of the day; a collection key (fashion 208132 "Chaves do Baú de Coleção de Moda", mount 212600721 "Chaves do baú") is consumed first, otherwise diamonds.

Purchase counters live in player extra fields 16..19 pushed on 260.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `view.inside.ShopBoxView(index)` (index 1 fashion, 2 mount) | mall tabs Baú de Moda / Baú de Montaria | Left and right buy buttons, price texts, "Número de compras restantes: {0}" for each side, counter "10 - bought % 10" big digits, key counts, hot list preview, drop list tooltips ("Ao comprar poderá obter 1 dos seguinte itens:" / "Ao comprar poderá obter 6 itens aleatórios dos seguintes itens:"), result animation with won items, cart and recharge buttons | mall tabs | config prices and limits, `EBMOD` counters, hot and drop lists |
| `view.inside.ShopBoxFrame`, `ShopAvatarFrame` | | Preview of drop items and avatar try on | `ShopBoxView` | |

## 3. Routes (client to server)

All actions use one opcode: send 9613 (0x258d) `C_FASHION_MOUNT_LOTTERY`, message `com.road.yishi.proto.active.FMReqMsg`:
- `op` (#1, ENUM `FMOp`, required): 0 `NORMAL` single purchase, 1 `ADVANCED` ten purchases.
- `type` (#2, ENUM `FMType`, required): 0 `FASHION` normal fashion box, 1 `MOUNT` normal mount box, 2 `FASHION_HOT_BUY` fashion collection box, 3 `MOUNT_HOT_BUY` mount collection box, 4 `HOT_ITEM_DATA` request featured lists, 5 `DROP_ITEM_DATA` request drop lists.
- `payType` (#3, INT32): 0 = bound diamonds allowed (balance `allPoint`), 1 = diamonds only (default).

Sender: `ExchangeBoxManager.sendExchangeBoxOperate(type, op = 0, payType = 1)` (`EBM:154-163`).

| # | UI | Fields | Client checks | Response |
|---|---|---|---|---|
| R1 | open of a box tab (`SBV:134-143`) | type 4 then type 5 | none | 368, 369 |
| R2 | left button or 10x button (`SBV:539-593`, confirm `SBV:595-620`) | type 0 or 1; op 0 single, 1 ten; payType 0 when the alert's bound diamond checkbox is set, else 1 | remaining normal buys `max - bought >= 1` (or `>= 10` for 10x, else "Compras diárias insuficientes a 10"); confirm "Deseja consumir {0} diamantes para efetuar {1} compras" with bound diamond option; balance `point` or `allPoint` >= cost else recharge | 367, 260 |
| R3 | right button (`SBV:622-681`, `rightBuyResultHandler` `SBV:663-681`, `rightBuyResultHandler2` `SBV:683-700`) | type 2 (fashion) or 3 (mount); op 0; payType 1 | `hotBought < hotMax` or key count > 0 else "Limite de compras atingida"; confirm "Deseja gasta {0} diamantes para comprar {1} vezes?\n(primeiro são usadas Chaves do Baú de Coleção de Moda)" or the mount variant; key count > 0 or `point >= cost` else recharge | 367, 260 |

## 4. Server messages (server to client)

### S1. 367 (0x016f) `U_C_FASHION_MOUNT_LOTTERY`

- `FMResMsg`: `op` (#1, ENUM) echo, `type` (#2, ENUM) echo, `item` (#3, repeated `FMBaseItem`: `itemId` (#1, INT32) template id, `itemCount` (#2, INT32)) rewards won.
- Receiver: `ExchangeBoxManager.__updateBuyDataHandler` (`EBM:59-78`) -> observer `EXCHANGE_BUY_BACK` -> `ShopBoxView.__updatBuyResultHandler` (`SBV:377-...`) plays `ExchangeBoxFrame.buyResultMc{type}_{op}` and shows the items (one item: single slot; several: grid).
- When: reply to R2 and R3. Items are delivered to the bag (or mail) through the normal inventory pushes.
- Current server: `server/flows/navigation.json:1155-1170` answers 9613 with an empty item list.

### S2. 368 (0x0170) `U_C_FASHION_MOUNT_HOT_ITEM_MSG`

- `HotItemMsg`: `fashion` (#1, repeated FMBaseItem) featured fashion items of today, `mount` (#2, repeated FMBaseItem) featured mount items. Stored sorted by `itemId` in `hotFashionArr` / `hotMountArr` (`EBM:80-106`).
- When: reply to R1 type 4, and push at the daily rotation (assumption).

### S3. 369 (0x0171) `U_C_FASHION_MOUNT_DROP_ITEM_MSG`

- `FMDropMsg`: `fashionDrop` (#1), `mountDrop` (#2), `fashionHotDrop` (#3), `mountHotDrop` (#4), all repeated FMBaseItem. Drop pools shown in the tooltips (`EBM:108-152`).
- When: reply to R1 type 5.

### S4. 260 (0x0104) `U_C_PLAYER_EXTRA_FIELD_MSG`

- `PlayerExtraFieldMsg.extraField` (#1, repeated `ExtraFieldInfoMsg`: `fieldId` (#1, INT32), `field_Type` (#2, INT32), `userId` (#3, INT32), `value` (#4, STRING)).
- Box fields (`BM:938-952`): 16 = normal fashion purchases today, 17 = fashion collection purchases today, 18 = normal mount purchases today, 19 = mount collection purchases today. Dispatches `PLAYER_EXTRA_FIELD`, which refreshes the counters (`SBV:285`).
- When: after each R2 or R3, at login and at the 00:00 reset. Owner of the message: [../hero/README.md](../hero/README.md) (shared extra field channel).

## 5. Rules and formulas

Config (`raw/xml/tempinfos/ConfigInfos.xml`, read by `CIM.getFashionBoxArr` / `getMountBoxArr`, `CIM:377-385`; parsed in `SBV.resolveConfigValue`, `SBV:252-266`):

| Key | Value | Meaning |
|---|---|---|
| `fashion_lottery_buy` | `200,20,1|1000,3` | normal: 200 diamonds per purchase, 20 purchases per day, 1 box item per purchase; collection: 1000 diamonds, 3 per day |
| `mount_lottery_buy` | `200,20,10|1000,3` | normal: 200 diamonds, 20 per day, 10 box items per purchase; collection: 1000 diamonds, 3 per day |

- 10x purchase costs `10 x 200` and needs at least 10 normal purchases left.
- Guaranteed reward every 10 normal purchases: counter shown `10 - bought % 10`; resets daily at 00:00 with the purchase counts.
- Collection purchase: key first (no diamond debit, does not count against the 3 daily limit per client check `hotBought < hotMax || keys > 0`), else 1000 diamonds (diamonds only, payType 1).
- Normal purchase can use bound diamonds when the player ticks the alert checkbox (payType 0).
- Rewards: weighted random from the normal pool (1 item) or the hot pool (6 items), with a chance of the day's featured item. Pools and weights are server data (no XML in the client); the client only displays 368/369.

## 6. Templates

- `ConfigInfos.xml` keys above.
- Items 208020 (fashion box item), 208017 (mount box item), 208132 (fashion collection key), 212600721 (mount collection key) from the item catalog.
- No drop table in `raw/xml/tempinfos`; pools must be authored server side.

## 7. Persistent state

```sql
CREATE TABLE shops.box_pool_item (
  box_kind          SMALLINT NOT NULL CHECK (box_kind BETWEEN 0 AND 3),
  item_template_id  INTEGER  NOT NULL,
  item_count        INTEGER  NOT NULL CHECK (item_count > 0),
  weight            INTEGER  NOT NULL CHECK (weight > 0),
  PRIMARY KEY (box_kind, item_template_id, item_count)
);

CREATE TABLE shops.box_featured_item (
  feature_day       DATE     NOT NULL,
  box_kind          SMALLINT NOT NULL CHECK (box_kind IN (0, 1)),
  item_template_id  INTEGER  NOT NULL,
  item_count        INTEGER  NOT NULL,
  PRIMARY KEY (feature_day, box_kind, item_template_id)
);

CREATE TABLE shops.box_daily_purchase (
  player_id         INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day               DATE     NOT NULL,
  fashion_normal    INTEGER  NOT NULL DEFAULT 0,
  fashion_hot       INTEGER  NOT NULL DEFAULT 0,
  mount_normal      INTEGER  NOT NULL DEFAULT 0,
  mount_hot         INTEGER  NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, day)
);
```

`box_kind`: 0 fashion normal, 1 mount normal, 2 fashion hot, 3 mount hot. `box_featured_item.box_kind`: 0 fashion, 1 mount.

## 8. Backend implementation notes

- `shops::boxes::handle_lottery` (9613) dispatching on `type`:
  - 4: reply 368 with today's featured items (create them at first use of the day by weighted pick from the hot pools).
  - 5: reply 369 with the four pools.
  - 0/1: validate daily remaining (20 minus today, 10 needed for op 1); cost `200 x n`; payType 0 -> bound first then diamonds, items bound when bound diamonds were used (assumption, same rule as the mall); grant `box item x per purchase x n` plus `n` random rewards; every time the counter crosses a multiple of 10 add one guaranteed reward; update counters; reply 367 with all rewards; push 260 fields 16/18.
  - 2/3: key in bag -> consume one key; else hot limit 3 and 1000 diamonds; roll 6 rewards from the hot pool including today's featured item with a configured chance; reply 367; push 260 fields 17/19.
- Daily job 00:00: new featured items, counters roll by `day`, push 260 with zeros to online players.

## 9. Open questions and assumptions

- Assumption: the box item bought (208020, 208017) is delivered in addition to the random reward, as the tooltip "Ao comprar {item} x{n}, obterá um item aleatório" suggests.
- Assumption: featured item chance and pools are server data (not in client templates).
- Open: whether key usage counts against the 3 daily collection purchases.

## 10. Implementation checklist

- [ ] Tables `shops.box_pool_item`, `shops.box_featured_item`, `shops.box_daily_purchase`
- [ ] Route 9613 `shops::boxes::handle_lottery` with types 0..5
- [ ] Encoders 367, 368, 369
- [ ] Extra fields 16..19 in 260
- [ ] Daily rotation job
- [ ] Tests: 10x with 9 left rejected, key consumption, guaranteed reward at 10
