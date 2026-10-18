# Guild shops (economy module)

Scope: (1) the "Câmara de Comércio" (commerce chamber: supply hall unlocked with guild production and member trade hall paid with merit), opcode 5438; (2) the "Loja da Guilda" building shop, a tab set of the generic shop system priced in guild currencies; (3) the legacy supply round driven by `ConsortiaShopTempInfos.xml`, still loaded by the client but unreachable.

Path aliases:

| Alias | File |
|---|---|
| CSOM | `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as` |
| CM | `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as` |
| CC | `decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaModel.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| V | `decompiled/m6/scripts/consortia/view/myConsortia/` |
| SHOPF | `decompiled/m15/scripts/view/subshop/ConsortiaShopFrame.as` |
| GI | `decompiled/m15/scripts/view/GoodsItem.as` |
| SC | `decompiled/core_module/scripts/mvc/controler/ShopControler.as` |
| SMGR | `decompiled/core_module/scripts/managers/ShopManager.as` |

## Overview

Câmara de Comércio:
- Supply hall ("Reabastecimento"): 12 item slots (`commerce_supply_TotalQuantity = 12`). Holders of the right "1" or the vice permission 43 unlock the next slot by paying guild production (100 for slots 1..6, 120 for slots 7..12, `commerce_supply_deblocking`). Each unlocked slot shows one `CommerceShopTemplates` entry (`mapShopId`).
- Trade hall ("Salão de Trocas"): opens when at least 6 slots are unlocked (`commerce_business_condition = 6`). Each member sees a personal list of `mapShopId` entries and buys each once, paying personal merit `CostPersonReputation` plus `Point` diamonds.
- Calendar (`commerce_time = 1,00:00|4,00:00|4,00:00|1,00:00`, weekday 0 = Sunday per "secret.day.tip"): supply hall from Monday 00:00 to Thursday 00:00, trade hall from Thursday 00:00 to Monday 00:00.

Loja da Guilda: `openControllerByInfo("shop",2,{type})` -> `consortia.ConsortiaShopFrame` (`SC:57-65`). Tabs when `shopLevel > 0`: guild shop (ShopType 2, personal contribution), advanced shop (ShopType 17, guild skill points currency -1400), treasure shop (ShopType 1009, Cristais amarelos -4100), copy shop (ShopType 1014, Prata de Moréia -4700); then cross guild, new boss, Minos and chess shops owned by other modules (`SHOPF:198-229`).

Entry points:
- Building map assassin camp -> `CC.showBusinessFrame(5)` -> openType 9 `consortia.ConsortiaBusinessFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaBuildingView.as:254-258`, `CC:249-252`).
- Top toolbar operate button (right 9) -> ConsortiaBusinessFrame (`docs/ui/navigation.md:157`).
- "Visualizar suprimentos" -> openType 13 `consortia.ConsortiaCommerceShopFrame` (`V/ConsortiaBusinessFrame.as:225-228`).
- Building map Loja -> `openControllerByInfo("shop",2)` (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaBuildingView.as:285-288`); activity items open the shop with `{type: 4|5|0|1}` (`V/item/ConsortiaActivityItem.as:119-144`).

## Screens

| Class | pt-BR title | Purpose | Data |
|---|---|---|---|
| `V/ConsortiaBusinessFrame.as` | "Câmara de comércio" (`:344`) | Two tabs: supply (0) and trade (1), 6 items per page over 12 entries (`:151-170`) | production (`consortiaAsset`) on tab 0, merit (`reputation`) on tab 1 (`:278-279`); "Condições de ativação do Salão de Trocas não atingidas" label on tab 1 (`:261-268`). The refresh button and its price text are always hidden in this build (`:291`) |
| `V/item/ConsortiaBusinessItem.as` | "Condições para compra de membros", "Mérito individual: {0}", "Diamantes: {0}", "Produção da Guilda: {0}" | Supply slot (unlock button on the next locked slot only, `:227-238`) or trade item (buy button enabled when state 0, `:211-213`) or preview | `supplyList`, `tradeList`, `tradeStateList`, template |
| `V/ConsortiaCommerceShopFrame.as` | "Visualizar suprimentos" | Read only list of all `CommerceShopTemplates` | template |
| `V/ConsortiaBusinessBuyFrame.as` | "Reabastecimento da guilda" / "Compra de membros" | Legacy quantity picker for `ConsortiaShopTempInfos` (never instantiated) | legacy |
| `SHOPF` | "Loja da Guilda Nv. {0}" or "Loja da Guilda" (`:154-162`) | Generic 9 item grid per tab, page buttons, currency counter | personal contribution, `guildSkill`, `yellowCoin`, `copyConsortia` amounts (`:414-484`) |
| `GI` | "Disponível quando loja da Guilda atingir Nv. {0}" | Item cell; disabled text when `NeedConsortiaLevels > shopLevel` (`GI:565-575`) | `ShopTempInfos` row |

## Actions

All commerce requests: route send 5438 (0x153e) `C_CONSORTIA_SHOP_BUY`, sender `CSOM.businessBuyRequest(p1, p2, p3)` (`CSOM:372-380`), message `com.road.yishi.proto.player.CommonMsg`: `param1` (#1, INT32), `param2` (#2, INT32), `param3` (#3, INT32) = operation; `param4..param7` unused.

| # | Operation (`param3`) | UI and file:line | Client checks | `param1`, `param2` | Expected replies |
|---|---|---|---|---|---|
| C1 | 4 = load state | `ConsortiaBusinessFrame` ctor (`V/ConsortiaBusinessFrame.as:95`) | none | 0, 0 | 181 then 182 |
| C2 | 1 = unlock next supply slot | `ConsortiaBusinessItem.__unLockBtnClickHandler` (`V/item/ConsortiaBusinessItem.as:103-139`) | right 1 (`getRightsByIndex(1)`) or `getRightsByNum(43)` (`CC:568-594`: only when the player has right 19 and the vice duty rights string contains 43) else "Apenas o presidente e membros autorizados podem liberar"; confirm "Deseja gastar {0} de Produção da Guilda para liberar esta coluna de itens?"; `consortiaAsset >= deblocking[index]` else "Produção da guilda insuficiente" | 0, 0 | 181 to all online members; 164 with new `consortia_asset` |
| C3 | 2 = buy trade item | `ConsortiaBusinessItem._buyBtnClickHandler` / `buyResultHandler` (`V/item/ConsortiaBusinessItem.as:141-170`) | confirm "Deseja gastar {0} de Mérito Individual para comprar {1} x{2}?" or with diamonds "Deseja gastar {0} de Mérito Individual e {3} Diamante(s) para comprar {1} x{2}?"; `reputation >= CostPersonReputation` else "Mérito individual insuficiente"; `allPoint >= Point` else recharge | `mapShopId`, 0 | 182 (state updated), 180 (merit), 115 (item), 3 (diamonds), 179/180 quest progress for condition 9 |
| C4 | 3 = refresh trade hall | `ConsortiaBusinessFrame.__refreshBtnClickHandler` / `refreshResultHandler` (`V/ConsortiaBusinessFrame.as:207-223`) | confirm "Deseja gastar {0} Diamante(s) para atualizar o Salão de Trocas? (Diamantes vinculados são usados primeiro)" with `commerce_business_random[0] = 100`; `allPoint >= 100`. Button hidden in this build | 0, 0 | 182 with new list and `refreshCounts` |
| L1 | 1 = restock / 2 = member buy (legacy) | `ConsortiaBusinessBuyFrame.__buyBtnClickHandler` (`V/ConsortiaBusinessBuyFrame.as:176-195`), never opened | quantity <= `MaxSupplyCount - stocked` (restock, cost `CostConsortiaAsset * n`) or `<= min(PersonBuyLimit - selfBought, stocked - boughtTotal)` (buy, cost `CostPersonReputation * n`) | `TemplateId` (191..196), count | legacy messages `ConsortiaShopListMsg` / `ConsortiaShopSelfBuyListMsg` are never read |

Loja da Guilda purchase (generic shop module, documented here for the guild specific checks):
- G1 `GI.__onBuyBtnHandler` (`GI:198-336`) for ShopType 2, 17, 1009, 1014 sets `ShopManager.type` and calls `SMGR.getGoodsBuyNum(id, 0, false)` (`SMGR:930-940`): send 8693 (0x21f5) `C_BUY_DISCOUNT`, `ShopMsg.buyInfo` (#1, `BuyInfo`: `good_id` (#2, INT32), `type` (#6, INT32) = 0, `is_discount` (#1, BOOL) = false). Reply 4599 (0x11f7) `U_C_BUY_DISCOUNT` with `buyInfo.count` = already bought (`SMGR:210-230`).
- G2 the buy frame `BuyFrameI` sends 8970 (0x230a) `C_SHOPCAR_BUY` with `shop.ShopCarListMsg` (one line, `type` = ShopType), optionally preceded by the limit query 8693; reply 4783 plus counter pushes. Full pipeline, fields, result codes and bound diamond rules: [../shops/purchase.md](../shops/purchase.md). `ShopManager.sendShoping` (5154 `U_C_SHOP_BUY`, `ShopMsg`, reply 90) exists at `decompiled/core_module/scripts/managers/ShopManager.as:604-643` but has no caller in this client, so 5154 is dead in this build.
- Guild checks the server must add: buyer in a guild; `NeedConsortiaLevels <= shop_level` for types 2, 17, 1009 (client shows the row up to `shop_level + 1` but disables it, `SC:470-481`, `GI:569-575`); currency: type 2 `ConsortiaOffer` personal contribution, type 17 `Score` in currency -1400, type 1009 `Score` in -4100, type 1014 `Score` in -4700; purchase limit `VIP{n}Count` per player (assumption: daily).

## Server messages

| Opcode | Name | Message | Handler | Fields | When |
|---|---|---|---|---|---|
| 181 (0x00b5) | `U_C_CONSORTIA_SHOP_LIST` | `ConsortiaShopSupplyRespMsg`: `mapShopId` (#1, INT32, repeated) | `CM.__businessInfoUpdateHandler` (`CM:1243-1250`) | ordered list of unlocked supply slots, each a `CommerceShopTemplates.MapShopId`; length = unlocked count | Reply to C1; push to all online members after C2 and at the weekly reset |
| 182 (0x00b6) | `U_C_CONSORTIA_SHOP_SELF_BUY` | `ConsortiaShopTradingRespMsg`: `shopInfo` (#1, repeated `ConsortiaShopRespMsg`: `mapShopId` (#1, INT32), `state` (#2, INT32: 0 buyable, non zero bought)), `refreshCounts` (#2, INT32) refreshes used, `state` (#3, BOOL) and `newState` (#4, INT32) not read | `CM.__businessSelfInfoUpdateHandler` (`CM:1252-1274`) | rebuilds `tradeList`, `tradeStateList`, `refreshCounts` | Reply to C1, C3, C4 |
| 164 (0x00a4) | `U_CH_CONSORTIA_FRESHINFO` | `ConsortiaInfoMsg.consortia_asset` (#71) | `CM:457` | production after unlock | Push after C2 |
| 180 (0x00b4) | `U_C_CONSORTIA_USER_JOIN_INFO` | `ConsortiaUserJoinMsg.reputation` (#3) | `CM:1163` | merit after C3 | Push after C3 |
| 4599 (0x11f7), 90 (0x005a) | `U_C_BUY_DISCOUNT`, `U_C_SHOP_BUY` | `ShopMsg` | `SMGR` | generic shop | G1, G2 |

Both 181 and 182 notify `UPDATE_BUSINESS_INFO` which repaints the frame (`V/ConsortiaBusinessFrame.as:240-243`).

## Rules and formulas

- Supply slot unlock order is strictly sequential (button enabled only on `index == supplyList.length`).
- Unlock price by slot index 0..11: 100,100,100,100,100,100,120,120,120,120,120,120 production (`CIM:1988-2000`, config `commerce_supply_deblocking`).
- Trade hall available when `supplyList.length >= 6` (`CIM:2002-2009`, `V/ConsortiaBusinessFrame.as:294-297`) and only during its calendar window.
- Trade refresh: 100 diamonds, at most 6 per period (`commerce_business_random = 100,6`, `CIM:2011-2023`).
- Weekly reset: supply slots and personal trade lists reset when the supply window opens (Monday 00:00); "O número de compra é resetado diariamente à meia-noite de domingo" (`Consortia.ConsortiaBusinessFrame.alertText.text0`). Assumption: everything resets Monday 00:00.
- Trade item rows (`raw/xml/tempinfos/CommerceShopTemplates.xml`): 1001 Fogo das Estrelas x15 for 300 merit; 1002 Atração do Fogo das Estrelas x15, 300; 1004 Pedra de Refinação de Moda x15, 700; 1005 Pedra Requintada x15, 300; 1006 Talismã de Experiência x15, 300; 1008 Carta Celeste Geral x15, 300; 1009 Pedra de Gravação de Brasões Mágicos x15, 300; 1011 Larimar x15, 300; 1012 Cristal da Vingança x4, 300; all `Point = 0`; `Weight` 10 (1012 has 5).
- Slot content selection: assumption, the server rolls a `MapShopId` by `Weight` when a slot is unlocked; the trade list of a member is rolled from the unlocked supply items.
- Quest hook: a trade purchase advances condition type 9 "Realizar 1 compra na Câmara de Comércio" (`quests.md`).
- Loja da Guilda currencies and data (`raw/xml/tempinfos/ShopTempInfos.xml`): ShopType 2 has 27 rows (e.g. 20001 Gema da Sorte Nv. 1 for 2 contribution, limit `VIP0Count` 500; 20014 Baú das coordenações do Plano at shop level 2 for 1000; 20046 Selo da Alma at level 10); ShopType 17 has 14 rows from shop level 6 (170001 Poção Invisível 208040 for 1 point, limit 9999); ShopType 1009 has 6 rows (1008006 Pacote de Pedra Bestial Alto 1000 yellow crystals ...); ShopType 1014 has 12 rows (copy shop).

## Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/CommerceShopTemplates.xml` | `CommerceShopTemplate` -> `ConsortiaCommerceShopTempInfo` (`decompiled/core_module/scripts/yishi/datas/templates/ConsortiaCommerceShopTempInfo.as`), cate keyed by `MapShopId` | `MapShopId`, `ItemTempId`, `Count` per purchase, `CostPersonReputation` merit, `Point` diamonds, `Weight` |
| `raw/xml/tempinfos/ConsortiaShopTempInfos.xml` (legacy) | `ConsortiaShopTempInfo` -> `ConsortiaBusinessTempInfo`, grouped by `ShopLevel` in `CMOD.businessTempDic` (`CMOD:410-419`) | `TemplateId` 191..196, `ShopLevel` 1, `ItemTempId` (8001016, 8001017, 208055, 8407001, 8001015, 2131521), `MaxSupplyCount` 2000, `PersonBuyLimit` 25, `CostConsortiaAsset` 20/50, `CostPersonReputation` 20/50 |
| `raw/xml/tempinfos/ShopTempInfos.xml` | rows with `ShopType` 2, 17, 1009, 1014 | `Id`, `ItemId`, `ConsortiaOffer`, `Score`, `PayType`, `NeedConsortiaLevels`, `VIP0Count..VIP6Count`, `Sort` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `commerce_supply_TotalQuantity`, `commerce_supply_deblocking`, `commerce_business_condition`, `commerce_business_random`, `commerce_time` | |

## Persistent state

```sql
CREATE TABLE guild.commerce_period (
  guild_id     INTEGER   NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  period_start DATE     NOT NULL,
  PRIMARY KEY (guild_id, period_start)
);

CREATE TABLE guild.commerce_supply_slot (
  guild_id     INTEGER  NOT NULL,
  period_start DATE     NOT NULL,
  slot_index   SMALLINT NOT NULL CHECK (slot_index BETWEEN 0 AND 11),
  map_shop_id  INTEGER  NOT NULL,
  unlocked_by  INTEGER   NOT NULL REFERENCES public.player(id),
  unlocked_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (guild_id, period_start, slot_index),
  FOREIGN KEY (guild_id, period_start) REFERENCES guild.commerce_period(guild_id, period_start) ON DELETE CASCADE
);

CREATE TABLE guild.commerce_trade_offer (
  player_id    BIGINT   NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  period_start DATE     NOT NULL,
  position     SMALLINT NOT NULL CHECK (position BETWEEN 0 AND 11),
  map_shop_id  INTEGER  NOT NULL,
  bought_at    TIMESTAMPTZ,
  PRIMARY KEY (player_id, period_start, position)
);

CREATE TABLE guild.commerce_trade_refresh (
  player_id    BIGINT   NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  period_start DATE     NOT NULL,
  refresh_count SMALLINT NOT NULL DEFAULT 0 CHECK (refresh_count BETWEEN 0 AND 6),
  PRIMARY KEY (player_id, period_start)
);

CREATE TABLE guild.shop_purchase (
  player_id  BIGINT  NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  shop_id    INTEGER NOT NULL,
  day        DATE    NOT NULL,
  count      INTEGER NOT NULL CHECK (count >= 0),
  PRIMARY KEY (player_id, shop_id, day)
);
```

`guild.shop_purchase` can be replaced by the generic shop module limit table if it exists.

## Backend implementation notes

- `guild::shop::handle_commerce_op` (5438) dispatching on `param3`:
  - `guild::shop::handle_commerce_info` (4): ensure current period rows exist; reply 181 (guild slots in order) then 182 (personal list, `refreshCounts`).
  - `guild::shop::handle_supply_unlock` (1): in guild -> right 1 or permission 43 -> supply window open -> slot count < 12 -> production >= price of next index. Transaction: `guild::funds::spend_asset` (debits `guild.guild.asset`), insert slot with rolled `map_shop_id`. Push 181 and 164 to all online members.
  - `guild::shop::handle_trade_buy` (2): in guild -> trade window open -> unlocked slots >= 6 -> `param1` present in the player's list and not bought -> merit >= cost -> diamonds >= `Point`. Transaction: `guild::funds::spend_merit` and diamonds, mark bought, grant `Count` of `ItemTempId`, advance quest condition 9. Reply 182, push 180, 115, 3.
  - `guild::shop::handle_trade_refresh` (3): trade window open -> `refresh_count < 6` -> 100 diamonds (bound first) -> reroll unbought positions. Reply 182, push 3.
  - Legacy `param3` 1/2 with `param1` in 191..196: reject (not reachable).
- Generic shop hook `guild::shop::validate_guild_shop_buy` called by the shop module for ShopType 2, 17, 1009, 1014 (8970): guild membership, `NeedConsortiaLevels <= shop_level` (types 2, 17, 1009), currency balance, limits.
- Weekly job `guild::shop::rollover_commerce` at Monday 00:00: start a new period (old rows kept for audit or deleted).

## Open questions

- How the trade list of a member is generated (size, source = unlocked supply items or full template by weight).
- What `state` values other than 0 mean in `ConsortiaShopRespMsg` and what `newState` encodes.
- Whether the supply items are also bought by members (the legacy flow had a stock) or only displayed.
- Purchase limit window for `VIP{n}Count` in the guild shop (daily or weekly).

## Implementation checklist

- [ ] Client screen: ConsortiaBusinessFrame supply tab (unlock) and trade tab (buy)
- [ ] Client screen: ConsortiaCommerceShopFrame preview
- [ ] Client screen: ConsortiaShopFrame guild tabs with level gating
- [ ] Tables `guild.commerce_period`, `guild.commerce_supply_slot`, `guild.commerce_trade_offer`, `guild.commerce_trade_refresh`
- [ ] Table `guild.shop_purchase` (or reuse shop module limits)
- [ ] Template loader `CommerceShopTemplates.xml`, `ShopTempInfos.xml` guild rows, commerce config keys
- [ ] Handler `guild::shop::handle_commerce_op` (5438) with sub handlers 1..4
- [ ] Encoders 181 `ConsortiaShopSupplyRespMsg`, 182 `ConsortiaShopTradingRespMsg`
- [ ] Weekly job `guild::shop::rollover_commerce`
- [ ] Shop module hook `guild::shop::validate_guild_shop_buy` for 8693/8970
- [ ] Quest condition 9 increment on trade purchase
