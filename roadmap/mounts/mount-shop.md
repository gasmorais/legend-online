# Mount shop ("Loja de montaria") and mount coin ("Essência da Fera")

Scope: the personal mount card shop paid with the mount coin token ("Essência da Fera", token masterType 14), its diamond refresh, the pool preview ("Previsão de Qualidade"), and where the coin comes from (mount card decomposition). The separate "Troca de Montaria" exchange shop (shop type 6) and the mount box lottery are owned elsewhere (see section 9).

Path aliases (all under `decompiled/`):

| Alias | File |
|---|---|
| MM | `core_module/scripts/managers/MountsManager.as` |
| WSC | `core_module/scripts/mvc/module/mounts/WildSoulCollection.as` |
| MSI | `core_module/scripts/mvc/module/mounts/MountShopInfo.as` |
| SC | `core_module/scripts/mvc/controler/ShopControler.as` |
| MSF | `m15/scripts/view/subshop/MountShopFrame.as` |
| MSGI | `m15/scripts/view/subshop/MountShopGoodsItem.as` |
| MPF | `m15/scripts/view/subshop/MountPreviewFrame.as` |
| MF | `m14/scripts/mounts/MountsFrame.as` |
| PCM | `core_module/scripts/managers/PlayerCurrencyManager.as` |

## 1. Overview

The shop shows `mount_shop_item_count` (30) mount cards (`ItemTempInfos` SonType 218), each with a price in mount coin and a "can buy" flag. Buying puts the card in the bag; using the card activates the avatar ([avatars-and-wild-souls.md](avatars-and-wild-souls.md)). A card for an avatar already owned (or a card already in the bag) cannot be bought. The list can be re-rolled for `mount_shop_refresh_cost` (999) diamonds. The preview lists the whole pool of cards that can appear. Mount coin is earned by decomposing duplicate permanent mount cards (`Power * 4`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `view.subshop.MountShopFrame` (`MSF`), stylename `shop.MountShopFrame` | "Loja de montaria" (`MSF:93`) | Buy cards, refresh | MountsFrame shop button `mounts.mountShopBtn` (`MF:471-475`) -> controller `shop` openType 1002 (`SC:139-142`). Requests op 8 on open (`MSF:76-84`) | Mount coin balance (`PlayerCurrencyManager.currencyInfo.mountCoin.amount`, `MSF:175-178, 211`) with tip "A essência da fera pode ser obtida através da decomposição"; 30 slots (`MSF:191-206`); refresh button tip "Consuma {0} diamantes para resfriar imediatamente, apenas pode resfriar no mínimo uma montaria não ativada" (`MSF:212`), enabled when the list is not empty |
| `view.subshop.MountShopGoodsItem` (`MSGI`) | slot | One card | MSF | item icon and name, price with coin icon, "Obtido" when the avatar is owned or the card is in any bag, buy button disabled in that case or when `can_buy` is false (`MSGI:139-179`) |
| `view.subshop.MountPreviewFrame` (`MPF`), stylename `shop.MountPreviewFrame` | "Previsão de Qualidade" (`MPF:69`) | Paged list of every card of the pool | MSF list button (`MSF:144-148` -> `SC.openMountPreviewFrame`, `SC:231-235`). Requests op 11 on open (`MPF:55-62`) | item icons and counts, page "{0}/{1}" |

## 3. Routes (client to server)

All: 8529 (0x2151) `C_MOUNT_OP`, `MountEditMsg` (`property_type` #1, `pay_type` #2, `param1` #3, `param2` #4, `op` #5).

### S-R1. Open the shop (op 8, `MOUNTSHOP_REQUEST`)
- Sender: `MSF` constructor (`MSF:83`). Request: `op` = 8, all params 0.
- Response: 4975 `MountShopMsg` with the current list.

### S-R2. Buy a card (op 9, `MOUNTSHOP_BUY`)
- UI: slot buy button (`MSGI:105-137`).
- Client checks: avatar of the card (`Property1`) already owned, or the card exists in any bag -> "Fera já ativada, não é possível comprar."; mount coin < price -> "Essência da Fera insuficiente, não pode trocar"; confirm "Quer gastar Essência da Fera*{0} para trocar por {1}?".
- Request: `op` = 9, `param1` = item template id, `param2` = slot index (0-based position in the last 4975 list, `MM:278`).
- Response: 4975 with that slot `can_buy` = false; 115 `U_C_BAG_MOVE_UPDATE` with the card; 4725 `U_C_PLAYER_TOKENINFO` with the new mount coin balance (refreshes the label through `CURRENCYREFRESH`, `MSF:130, 175-178`).

### S-R3. Refresh the list (op 10, `MOUNTSHOP_REFRESH`)
- UI: refresh button (`MSF:150-183`).
- Client checks: 400 ms throttle; real diamonds `point` < `mount_shop_refresh_cost` -> recharge alert; confirm "Quer gastar {0} diamamtes para atualizar?" with "Não alertar mais" (key `mounts.MountKingTrainView.refreshAlert`).
- Request: `op` = 10, all params 0.
- Response: 4975 with a new list; 3 `U_C_PLAYER_INFO` with the new diamonds.

### S-R4. Preview the pool (op 11, `OP_SHOP_PREVIEW`)
- Sender: `MPF` constructor (`MPF:61`). Request: `op` = 11.
- Response: 305 `MountShopMsg` with every possible card (`item_temp_id`, `item_count`).

## 4. Server messages (server to client)

### S1. 4975 (0x136f) `U_C_MOUNT_SHOP`, `MountShopMsg` (package `campaign`)
Receiver `MM.__onMountShopListHandler` (`MM:264-287`), dispatches `mountShopInfoChange` (`WSC:405-408`).

| Field | Tag, type | Meaning |
|---|---|---|
| `itemList` | #1, `MountShopItemMsg`, repeated | slots in display order; the client assigns `index` = position |

`MountShopItemMsg`: `item_temp_id` (#1, INT32) card item template; `item_count` (#2, INT32) quantity; `price` (#3, INT32) mount coin price; `can_buy` (#4, BOOL) false after purchase.

### S2. 305 (0x0131) `U_C_MOUNT_SHOP_PREVIEW`, `MountShopMsg`
Receiver `MM.__mountPreviewShopListHandler` (`MM:289-309`); reads only `item_temp_id` and `item_count`; dispatches `MOUNT_SHOP_PREVIEW`.

### S3. 4725 `U_C_PLAYER_TOKENINFO` (cross feature)
Token list push handled by `PCM.__currencyRefreshHandler` (`PCM:71-74`); masterType 14 is the mount coin (`PCM:248-254`, `core_module/scripts/mvc/module/currency/CurrencyType.as:40` `MOUNT_COIN = 14`). Missing from `protocol/opcodes.csv`. Owned by [../currency/README.md](../currency/README.md).

### Current server behavior
No rule answers ops 8..11; the shop opens empty and the refresh button stays disabled.

## 5. Rules and formulas

- Slots per list: `mount_shop_item_count` = 30 (`raw/xml/tempinfos/ConfigInfos.xml`, `MSF:80, 196`).
- Refresh cost: `mount_shop_refresh_cost` = 999 real diamonds (`MSF:79, 162-163`; the client checks `point` only, so bound diamonds are not accepted, assumption).
- The refresh tip says "apenas pode resfriar no mínimo uma montaria não ativada": the new list should contain at least one card whose avatar is not owned (assumption on meaning).
- Buy rules (server): slot index valid and `item_temp_id` matches; `can_buy` true; the card's avatar not owned and the card not in any bag; mount coin >= price. Effects: debit coin, add the card (count `item_count`), set `can_buy` false.
- Pool, prices and list generation are not in any template (assumption: a server config table of SonType 218 cards with weights and prices; suggested price proportional to the template `Power`, mirroring the decomposition value `Power * 4`).
- Automatic refresh: none visible in the client (no timer or countdown); assumption: daily reset at 00:00 server time plus manual refresh.
- Mount coin income: decomposition of a permanent mount card whose avatar is permanent and owned, value `MountTempInfo.Power * mount_card_resolve_multiple` (4) (`core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:456-485`). Other sources (rewards, lotteries) may grant it as token 14.

## 6. Templates

| File | Records and fields used |
|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `mount_shop_item_count` = 30; `mount_shop_refresh_cost` = 999; `mount_card_resolve_multiple` = 4 |
| `raw/xml/tempinfos/ItemTempInfos.xml` | SonType 218 cards (`Property1` = mount template) |
| `raw/xml/tempinfos/MountTempInfos.xml` | `Power` for decomposition value and sorting |

## 7. Persistent state

```sql
CREATE TABLE mounts.shop_pool (
  item_template_id  INTEGER  PRIMARY KEY,
  item_count        INTEGER  NOT NULL DEFAULT 1 CHECK (item_count > 0),
  price             INTEGER  NOT NULL CHECK (price > 0),
  weight            INTEGER  NOT NULL DEFAULT 1 CHECK (weight > 0),
  enabled           BOOLEAN  NOT NULL DEFAULT true
);

CREATE TABLE mounts.shop_slot (
  player_id         BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  slot_index        SMALLINT NOT NULL CHECK (slot_index BETWEEN 0 AND 29),
  item_template_id  INTEGER  NOT NULL REFERENCES mounts.shop_pool(item_template_id),
  item_count        INTEGER  NOT NULL CHECK (item_count > 0),
  price             INTEGER  NOT NULL CHECK (price > 0),
  can_buy           BOOLEAN  NOT NULL DEFAULT true,
  PRIMARY KEY (player_id, slot_index)
);

CREATE TABLE mounts.shop_state (
  player_id         BIGINT      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  generated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  manual_refreshes  INTEGER     NOT NULL DEFAULT 0
);
```

`shop_pool` is server configuration (seeded from SonType 218 cards); 305 is built from it. Mount coin balance is a currency token (masterType 14).

## 8. Backend implementation notes

Handlers:
- `mounts::shop::handle_shop_request` (op 8): generate the list when missing or stale (daily reset assumption), send 4975.
- `mounts::shop::handle_shop_buy` (op 9): validate as in 5; transaction locks `shop_slot` and the token balance, debits coin, adds the item through the inventory service, sets `can_buy` false; pushes 4975, 115, 4725.
- `mounts::shop::handle_shop_refresh` (op 10): check `point >= 999`; debit; regenerate 30 slots with weighted random picks from `shop_pool` excluding cards whose avatar is permanently owned (assumption) and guaranteeing at least one not-owned avatar; increment `manual_refreshes`; pushes 4975 and 3.
- `mounts::shop::handle_shop_preview` (op 11): send 305 with every enabled pool entry.

Validation order for buy: lord grade >= 16 -> slot exists -> template matches -> `can_buy` -> ownership checks -> balance.

## 9. Open questions and assumptions

- Pool contents, weights and prices (not in client data; assumption: config table).
- Automatic refresh schedule (assumption: daily).
- Whether bound diamonds may pay the refresh (assumption: no).
- Meaning of the refresh tip "no mínimo uma montaria não ativada" (assumption: guarantee one unowned card).

Related but not in this module:
- "Troca de Montaria" (`view.subshop.MountConversionShopFrame`, `SC.initMountExchangeShop` `SC:706-727`, shop type 6 from `ShopTempInfos`): owned by [../shops/README.md](../shops/README.md).
- "Caixa de Montaria" mount box lottery (9613 (0x258d) `C_FASHION_MOUNT_LOTTERY` with 367/368/369, client package `exchangebox`, proto package `active`, `ExchangeBoxManager` `core_module/scripts/managers/ExchangeBoxManager.as:52-162`, frame `m11/scripts/exchangebox/ExchangeBoxFrame.as` type 2, opened by `SwitchPageHelp.openMountBoxFrame` at lord grade 16 with `VersionSwitch.MOUNT_BOX`, config `mount_lottery_buy`): see [../lotteries/README.md](../lotteries/README.md) and [../fashion/README.md](../fashion/README.md).

## 10. Implementation checklist

- [ ] Screen `view.subshop.MountShopFrame` and `MountShopGoodsItem` from 4975
- [ ] Screen `view.subshop.MountPreviewFrame` from 305
- [ ] Route op 8 open
- [ ] Route op 9 buy (index + template)
- [ ] Route op 10 refresh (999 diamonds)
- [ ] Route op 11 preview
- [ ] Server message 4975 `MountShopMsg`
- [ ] Server message 305 `MountShopMsg`
- [ ] Token push 4725 for mount coin (currency feature)
- [ ] Table `mounts.shop_pool`
- [ ] Table `mounts.shop_slot`
- [ ] Table `mounts.shop_state`
- [ ] Rule: buy blocked for owned avatars and cards already in the bag
- [ ] Rule: list generation and daily reset
- [ ] Test: buy then 4975 shows `can_buy` false and the bag has the card
- [ ] Test: refresh without 999 diamonds rejected
