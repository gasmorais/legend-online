# Poseidon shop (Loja Poseidon)

Path aliases:

| Alias | File |
|---|---|
| PM | `decompiled/core_module/scripts/managers/PoseidonManager.as` |
| PC | `decompiled/core_module/scripts/mvc/controler/PoseidonController.as` |
| PF | `decompiled/m11/scripts/poseidon/PoseidonFrame.as` |
| PV | `decompiled/m11/scripts/poseidon/view/PoseidonView.as` |
| PI | `decompiled/m11/scripts/poseidon/item/PoseidonItem.as` |
| PBF | `decompiled/m11/scripts/poseidon/PoseidonBuyFrame.as` |
| PBV | `decompiled/m11/scripts/poseidon/view/PoseidonBuyView.as` |
| RTC | `decompiled/core_module/scripts/yishi/datas/templates/cate/RoyaltyTempCate.as` |
| SPH | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as` |

## 1. Overview

Shop of the "Caminho da Realeza" ([../royalty-boss/README.md](../royalty-boss/README.md)). Items are grouped by currency (left tabs: Gema Poseidon, currency 58 `poseidonCoin`, "poseidon.shop.type"; or diamonds) and by floor (right tabs "Normal {n}º Piso" / "Avançado {n}º Piso"), each floor unlocked by royalty level. Every item has its own royalty level requirement and a purchase limit: one time ("Compras Restritas Únicas ... até quanto durar o estoque") or daily ("A quantidade de itens da Compra Restrita Diária atualizam às 0h todos os dias", `poseidon.shop.helpTip`).

Entry: `SwitchPageHelp.openPoseidonFrame` (`SPH:3065-3074`), blocked with "Abre com Realeza Nv. {0}" when royalty level < floor 1 unlock level; called from the Royalty fight frame (`decompiled/m11/scripts/royaltyboss/RoyaltyFightFrame.as:134`), the Reino do Céu NPC dialog (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:872`) and the hero resource link (`decompiled/m5/scripts/armyII/viewII/information/GoodsExchangeItem.as:630`). Controller key `poseidonshop` (`PC:45-52`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `poseidon.PoseidonFrame` | "Loja Poseidon" (`PF:82-86`) | Container with help | entry | |
| `poseidon.view.PoseidonView` | | Left currency tabs (2), right floor tabs (one per `OpenShopLevel` up to `maxLv`, locked label "Desbloqueia com Realeza Nv. {0}", `PV:124-152`), grid of up to 12 items (`PV:111-122`) sorted by `Id`, balance of the selected currency | frame | `PoseidonShopTemplates` rows of (ShopType, ShopLevel) (`PV:154-206`) |
| `poseidon.item.PoseidonItem` | | Icon, name, price, currency icon, limit type icon, "Compra liberada com Nv. de Realeza {0}" when locked (`PI:87-120`) | grid | |
| `poseidon.PoseidonBuyFrame` (openType 1, `PC:47-50`) + `PoseidonBuyView` | "Aviso" | "Qtd de compras", "Preço total", limit `bought/LimitNumber` (`PBV:107-152`) | item buy (`PI:157-160`) | |

## 3. Routes (client to server)

### R1. Load purchase counts (9704)

- UI: first `refreshView` of `PoseidonView` (`PV:200-204`).
- Sender: `PoseidonManager.requestInfo()` (`PM:88-92`).
- Route: send 9704 (0x25e8) `C_POSDIDON_SHOP_PANEL`, empty body.
- Response: 522 (S1).

### R2. Buy (9705)

- UI: `PoseidonBuyFrame.confrimHandler` (`PBF:46-72`): diamond items (ShopType 2) ask "Quer usar {0} diamantes para comprar {1} {2}?"; coin items buy without confirm.
- Client checks (`PBV:107-152,180-195`): quantity <= `min(floor(balance / Price), LimitNumber - bought)`, balance = `poseidonCoin` for ShopType 1, `point` (unbound diamonds) for ShopType 2; item visible only when royalty level >= `OpenCondition`.
- Sender: `PoseidonManager.buyGood(id, count)` (`PM:94-101`).
- Route: send 9705 (0x25e9) `C_POSDIDON_SHOP_BUY`, `com.road.yishi.proto.poseidonshop.PoseidonShopBuyReqMsg`: `id` (#1, INT32) template `Id`; `count` (#2, INT32) quantity.
- Response: 523 (S2), then currency and bag pushes.

## 4. Server messages (server to client)

### S1. 522 (0x020a) `U_C_POSDIDON_SHOP_PANEL`

- `PoseidonShopInfoListMsg`: `currLevel` (#1, INT32) royalty level (ignored by the client); `list` (#2, repeated `PoseidonShopInfoMsg`: `id` (#1, INT32) template Id, `buyNumber` (#2, INT32) bought in the current limit period).
- Receiver: `PoseidonManager.__goodInfosHandler` (`PM:51-69`) -> `EVENT_POSEIDON_REFRESH`.
- When: reply to R1; push at 00:00 for daily items (assumption).

### S2. 523 (0x020b) `U_C_POSEIDON_SHOP_BUY`

- `PoseidonShopBuyRspMsg`: `id` (#1, INT32) template Id; `result` (#2, INT32) used by the client as the new bought count (`PM:71-86`: `buyCount = result`).
- When: reply to R2. On failure send the unchanged bought count (the client has no error branch; assumption: errors also go through a system message).

## 5. Rules and formulas

- Floor unlock: floor `n` requires royalty level `min(RoyaltyLevel)` over `RoyaltyTemplates` rows with `OpenShopLevel = n` (`RTC:60-82,162-166`): floors 1..9 -> 1, 5, 10, 15, 20, 25, 29, 33, 38.
- Item unlock: royalty level >= `OpenCondition` (1, 5, 10, ..., 40).
- Currency: ShopType 1 -> currency 58 Gema Poseidon; ShopType 2 -> diamonds (unbound only, the client checks `point`).
- Limit: `LimitType` 1 = one time per account (all 115 rows in the XML), 2 = daily reset at 00:00 (no rows); `LimitNumber` max units.
- Total price = `count x Price`.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/PoseidonShopTemplates.xml` | 115 rows (`PoseidonShopTempInfo`, cate keyed `ShopType_ShopLevel`, `decompiled/core_module/scripts/yishi/datas/templates/cate/PoseidonShopCate.as:49-53`): ShopType 1 coin rows (6 on floor 1, 8 per floor 2..9), ShopType 2 diamond rows (5 per floor 1..9) | `Id` (floor and slot encoded, e.g. 10101), `ShopType` currency, `ShopLevel` floor, `ItemId`, `OpenCondition` royalty level, `LimitType`, `LimitNumber`, `Price` |
| `raw/xml/tempinfos/RoyaltyTemplates.xml` | royalty levels | `RoyaltyLevel`, `OpenShopLevel` |

## 7. Persistent state

```sql
CREATE TABLE shops.poseidon_purchase (
  player_id    INTEGER NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id  INTEGER NOT NULL,
  period_day   DATE    NOT NULL DEFAULT DATE '1970-01-01',
  bought       INTEGER NOT NULL DEFAULT 0 CHECK (bought >= 0),
  PRIMARY KEY (player_id, template_id, period_day)
);
```

`period_day` stays `1970-01-01` for one time limits (LimitType 1) and is the current day for daily limits (LimitType 2).

## 8. Backend implementation notes

- `shops::poseidon::handle_panel` (9704): list all templates with a counter for the current period; reply 522 with `currLevel` = royalty level.
- `shops::poseidon::handle_buy` (9705): template exists; royalty level >= floor unlock and >= `OpenCondition`; `count >= 1`; `bought + count <= LimitNumber`; debit `count x Price` from currency 58 (`currency::spend`) or unbound diamonds; grant `ItemId x count`; update counter; reply 523 with the new `bought`.
- Royalty level comes from `royalty_boss` state.

## 9. Open questions and assumptions

- Assumption: 523 `result` doubles as the new bought count; error codes are not distinguishable by the client.
- Open: whether daily items existed in another template version.

## 10. Implementation checklist

- [ ] Template loader `PoseidonShopTemplates.xml` and royalty unlock table
- [ ] Table `shops.poseidon_purchase`
- [ ] Route 9704 and encoder 522
- [ ] Route 9705 and encoder 523
- [ ] Tests: locked floor, one time limit, coin and diamond paths
