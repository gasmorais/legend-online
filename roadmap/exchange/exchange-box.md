# Caixa de Moda and Caixa de Montaria (exchange box)

Path aliases:

| Alias | File |
|---|---|
| EBM | `decompiled/core_module/scripts/managers/ExchangeBoxManager.as` |
| EBO | `decompiled/core_module/scripts/mvc/module/exchange/ExchangeBoxModel.as` |
| EBC | `decompiled/core_module/scripts/mvc/controler/ExchangeBoxControler.as` |
| EBF | `decompiled/m11/scripts/exchangebox/ExchangeBoxFrame.as` |
| SBV | `decompiled/m15/scripts/view/inside/ShopBoxView.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| FMT | `decompiled/core_module/scripts/com/road/yishi/proto/active/FMType.as` |
| FMO | `decompiled/core_module/scripts/com/road/yishi/proto/active/FMOp.as` |

## 1. Overview

A daily diamond lottery with two variants (Chinese "时装宝盒" fashion box and "坐骑宝盒" mount box):

- **Normal draw** (left button, "comprar"): costs 200 diamonds, at most 20 per day. Gives `onceBuyCount` units of a material (fashion: 1 "Alma da Moda" 208020; mount: 10 "Pedra Bestial" 208017) and one random item of the normal drop list. Every 10th draw of the day gives a random fashion or mount ("Comprando 10 vezes ganhará moda aleatória", "Comprando dez vezes poderá obter montaria aleatória"). A "x10" button buys 10 draws at once.
- **Collection chest draw** (right button, "聚宝箱", "Baú de Coleção"): costs 1000 diamonds, at most 3 per day. Gives 6 random items with a chance of the item of the day. A key ("Chave do Baú de Coleção de Moda" 208132, "Chaves do Baú de Coleção de Montaria" 212600721) is used before diamonds and lifts the daily limit.

Counters reset daily at 00:00 ("Os pontos serão redefinidos diariamente às 0h").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `exchangebox.ExchangeBoxFrame` (`EBF`) | "Caixa de Moda" (`ui.toptoolbar.TopToolsBar.tipData_fashionbox`) or "Caixa de Montaria" (`tipData_mountbox`) (`EBF:619-658`) | Collection bar (fashions owned / all, or mounts owned / all) with tips "Modas colecionadas: {0}/{1}", "Montarias colecionadas: {0}/{1}"; normal cost and "Número de compras restantes: {0}"; hot cost and remaining; "draws until guarantee" digits `10 - hasBuy % 10`; fashion key count "Chaves do Baú de Coleção de Moda:{0}"; hot item row; buttons draw, draw x10, chest; book button to the fashion or mount collection (`EBF:396-406`); result animation with up to 6 items (`EBF:261-302`) | `ExchangeBoxControler` with openType 1 or 2 (`EBC:20-29`, `EBF:660-665`) from the space NPC options 114 / 115 (`SwitchPageHelp.as:2281-2309`) | config, `ExchangeBoxModel`, extra fields |
| `view.inside.ShopBoxView` (`SBV`) | shop tab | Same logic inside the shop; also shows the mount key count and spends it first (`SBV:270-273`, `:640`, `:657`, `:669`) | shops feature | same |

Tips: normal button "Ao comprar {0} x{1}, obterá um item aleatório" (material name, `onceBuyCount`; x10 button shows `onceBuyCount*10`); chest button "Compre e obtenha 6 sorteios, com chances de obter o item destaque de hoje (primeiro são usadas Chaves do Baú de Coleção de Moda)" (fashion) or "Ao comprar será presenteado 6 itens aleatórios, tem a chance de obter o item do dia" (mount); drop tips "Ao comprar poderá obter 1 dos seguinte itens:" + type ("Moda" / "Carta de Montaria") + normal drops, and "Ao comprar poderá obter 6 itens aleatórios dos seguintes itens:" + hot drops + hot items (`EBF:330-373`).

## 3. Routes (client to server)

All routes use C>S 9613 (0x258d) `C_FASHION_MOUNT_LOTTERY` with `FMReqMsg` (package `active`): `op` (#1, ENUM `FMOp`: 0 `NORMAL`, 1 `ADVANCED` = x10), `type` (#2, ENUM `FMType`: 0 `FASHION`, 1 `MOUNT`, 2 `FASHION_HOT_BUY`, 3 `MOUNT_HOT_BUY`, 4 `HOT_ITEM_DATA`, 5 `DROP_ITEM_DATA`) (`FMO:6-8`, `FMT:6-16`), `payType` (#3, INT32) 0 = bound diamonds may be used, 1 = diamonds only; sender `ExchangeBoxManager.sendExchangeBoxOperate(type, op = 0, payType = 1)` (`EBM:154-162`).

| # | Action | UI | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|
| R1 | Hot items of the day | frame build (`EBF:122`), shop tab build (`SBV:141`) | none | `type 4` | 368 (S2) |
| R2 | Drop lists | frame build (`EBF:123`), shop tab (`SBV:142`) | none | `type 5` | 369 (S3) |
| R3 | Normal draw | left button `__LeftBtnClickHandler` (`EBF:408-463`) | `hasBuy + 1 <= maxCount` else "Limite de compras atingida"; confirm "Deseja consumir {0} diamantes para efetuar {1} compras" with a bound diamond checkbox; balance `allPoint` (bound allowed) or `point` >= cost else recharge (`EBF:465-490`) | `type 0` (fashion) or `1` (mount), `op 0`, `payType` 0 or 1 | 367 (S1), 115, 3, 260 |
| R4 | x10 draw | "x10" button, same handler | `hasBuy + 10 <= maxCount` else "Compras diárias insuficientes a 10"; cost `10 * cost` | `type 0/1`, `op 1`, `payType` | 367, 115, 3, 260 |
| R5 | Chest draw | right button `__oneRightBtnHandler` (`EBF:492-531`) | fashion: `hotHasBuy < hotMax` or fashion key > 0; mount: `hotHasBuy < hotMax` (the shop tab also accepts a mount key, `SBV:640`); confirm "Deseja gasta {0} diamantes para comprar {1} vezes?\n(primeiro são usadas Chaves do Baú de Coleção de Moda)" (fashion) or the normal text; key > 0 or `point >= 1000` else recharge (`EBF:533-567`) | `type 2` or `3`, `op 0`, `payType 1` | 367, 115, 3, 260 |

## 4. Server messages (server to client)

### S1 367 (0x016f) U_C_FASHION_MOUNT_LOTTERY

- `FMResMsg` (package `active`): `op` (#1, ENUM FMOp), `type` (#2, ENUM FMType), `item` (#3, repeated `FMBaseItem`: `itemId` (#1, INT32), `itemCount` (#2, INT32)) items won by this request.
- Receiver `ExchangeBoxManager.__updateBuyDataHandler` (`EBM:59-78`) -> `EXCHANGE_BUY_BACK` -> `EBF.__updatBuyResultHandler` (`EBF:261-302`): disables the buttons and the close button, plays the animation for `type` (index 2 for chest types or `op 1`, else 1, `EBF:304-311`), shows each item, then re-enables. Max 10 items for x10 (assumption) and 6 for chest.
- When: reply to R3, R4, R5 on success only. On failure send nothing (the client has no error receiver; buttons stay enabled).

### S2 368 (0x0170) U_C_FASHION_MOUNT_HOT_ITEM_MSG

- `HotItemMsg`: `fashion` (#1, repeated FMBaseItem) fashion box items of the day; `mount` (#2, repeated FMBaseItem) mount box items of the day.
- Receiver `EBM.__updateHotListHandler` (`EBM:80-106`) -> `hotFashionArr`, `hotMountArr` sorted by template id -> hot row (`EBF:313-328`).
- When: reply to R1; push at the daily rotation to players with the frame open (assumption).

### S3 369 (0x0171) U_C_FASHION_MOUNT_DROP_ITEM_MSG

- `FMDropMsg`: `fashionDrop` (#1), `mountDrop` (#2), `fashionHotDrop` (#3), `mountHotDrop` (#4), all repeated FMBaseItem; possible rewards of the normal and chest draws.
- Receiver `EBM.__updateDropListHandler` (`EBM:108-152`) -> tooltips (`EBF:330-350`).
- When: reply to R2.

### S4 260 (0x0104) U_C_PLAYER_EXTRA_FIELD_MSG

- `PlayerExtraFieldMsg` (package `player`): `extraField` (#1, repeated `ExtraFieldInfoMsg`: `fieldId` (#1, INT32), `field_Type` (#2, INT32), `userId` (#3, INT32), `value` (#4, STRING)).
- Fields used here (`BM:937-952`): 16 normal fashion draws today (`fashionHasBuy`), 17 fashion chest draws today (`hotFashionHasBuy`), 18 normal mount draws today (`mountHasBuy`), 19 mount chest draws today (`hotMountHasBuy`). The event `PLAYER_EXTRA_FIELD` repaints the frame (`EBF:256-259`).
- When: at login and after every draw, and at the 00:00 reset with zeros. Owner of the message: [../hero/README.md](../hero/README.md).

## 5. Rules and formulas

- B1 Unlock: fashion box level 10, mount box level 16, version switches on (`SwitchPageHelp.as:2281-2309`).
- B2 Config (`raw/xml/tempinfos/ConfigInfos.xml`, read by `CIM:377-385` and `EBF:126-140`): `fashion_lottery_buy = 200,20,1|1000,3` and `mount_lottery_buy = 200,20,10|1000,3` = normal cost, normal daily limit, material units per normal draw | chest cost, chest daily limit.
- B3 Normal draw reward: `onceBuyCount` units of 208020 (fashion) or 208017 (mount) plus one random item of `fashionDrop` / `mountDrop`. x10 = 10 independent draws.
- B4 Guarantee: when the daily normal draw counter reaches a multiple of 10, that draw gives a random fashion (fashion box) or mount card (mount box) (strings `ExchangeBoxFrame.alertText.text1/2`). Counter shown as `10 - hasBuy % 10` (`EBF:585`, `:596`).
- B5 Chest draw reward: 6 random items from `fashionHotDrop` / `mountHotDrop` plus a chance of an item of the day (`HotItemMsg`).
- B6 Keys: chest draws consume 1 key (208132 fashion, 212600721 mount) before diamonds; a key draw is allowed even when the daily chest limit is reached (client checks, `EBF:503-504`, `SBV:640`) and does not increment the daily counter (assumption).
- B7 Payment: `payType 0` uses bound diamonds first (`allPoint = point + giftToken`), `payType 1` diamonds only. Chest draws are always sent with `payType 1`.
- B8 Daily reset at 00:00 of fields 16..19.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `fashion_lottery_buy`, `mount_lottery_buy` | see B2 |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208020 "Alma da Moda", 208017 "Pedra Bestial", 208132 "Chave do Baú de Coleção de Moda", 212600721 "Chaves do Baú de Coleção de Montaria" | names and icons |

Drop pools and items of the day are server data.

## 7. Persistent state

```sql
CREATE TABLE exchange.box_pool (
  box_type     SMALLINT  NOT NULL CHECK (box_type IN (0, 1)),
  pool         SMALLINT  NOT NULL CHECK (pool IN (1, 2, 3)),
  item_id      INTEGER   NOT NULL,
  item_count   INTEGER   NOT NULL CHECK (item_count > 0),
  weight       INTEGER   NOT NULL DEFAULT 1 CHECK (weight > 0),
  PRIMARY KEY (box_type, pool, item_id, item_count)
);

CREATE TABLE exchange.box_hot_item (
  day          DATE      NOT NULL,
  box_type     SMALLINT  NOT NULL CHECK (box_type IN (0, 1)),
  item_id      INTEGER   NOT NULL,
  item_count   INTEGER   NOT NULL CHECK (item_count > 0),
  chance_ppm   INTEGER   NOT NULL CHECK (chance_ppm BETWEEN 0 AND 1000000),
  PRIMARY KEY (day, box_type, item_id)
);

CREATE TABLE exchange.box_daily (
  player_id          INTEGER   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day                DATE      NOT NULL,
  fashion_draws      SMALLINT  NOT NULL DEFAULT 0,
  fashion_chests     SMALLINT  NOT NULL DEFAULT 0,
  mount_draws        SMALLINT  NOT NULL DEFAULT 0,
  mount_chests       SMALLINT  NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, day)
);
```

- `box_type`: 0 fashion, 1 mount. `pool`: 1 normal drop, 2 chest drop, 3 guaranteed pool for every 10th normal draw.
- `box_daily` maps to extra fields 16 (`fashion_draws`), 17 (`fashion_chests`), 18 (`mount_draws`), 19 (`mount_chests`).

## 8. Backend implementation notes

- `exchange::box::handle_op` (9613) dispatches on `type`:
  - 4 `exchange::box::handle_hot_items`: reply 368 from `box_hot_item` of today (both boxes).
  - 5 `exchange::box::handle_drop_lists`: reply 369 from `box_pool` pools 1 and 2.
  - 0 / 1 `exchange::box::handle_draw`: level (10 or 16) -> draws `n = op == 1 ? 10 : 1` -> `draws_today + n <= 20` -> balance (`payType`) >= `200 * n`. Transaction: debit, roll `n` draws (pool 3 on every multiple of 10 of the running counter, else pool 1) plus `n * onceBuyCount` material, grant, update `box_daily`. Reply 367 with the items, then 115, 3, 260 (fields 16/18).
  - 2 / 3 `exchange::box::handle_chest`: key in bag -> consume key; else `chests_today < 3` and diamonds >= 1000 -> debit and increment. Roll 6 items from pool 2 with the hot item chance. Reply 367, 115, 3, 260 (fields 17/19).
- Daily job at 00:00: rotate `box_hot_item` (assumption: drawn from a configured list), push 260 zeros to online players (or lazily by `day`).

## 9. Open questions and assumptions

- Assumption: key draws bypass and do not count toward the chest daily limit.
- Assumption: every 10th normal draw replaces the random item by a guaranteed fashion or mount; the pool contents are server data.
- Open: item of the day selection and probabilities.
- Open: behavior when the bag is full (assumption: overflow by mail).

## 10. Implementation checklist

- [ ] Screen: ExchangeBoxFrame (fashion and mount) and shop tab parity
- [ ] Route 9613 type 4 and type 5
- [ ] Route 9613 type 0/1 op 0 and op 1
- [ ] Route 9613 type 2/3 with keys
- [ ] Server messages 367, 368, 369; extra fields 16..19 in 260
- [ ] Tables `exchange.box_pool`, `exchange.box_hot_item`, `exchange.box_daily`
- [ ] Rules B1..B8 and daily reset
- [ ] Test: daily limits 20 and 3, x10 refused when fewer than 10 draws remain
- [ ] Test: guarantee on the 10th, 20th draw
- [ ] Test: key consumed before diamonds
