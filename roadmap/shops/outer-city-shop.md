# Outer city map shop (Loja Misteriosa, mercado do exterior da cidade)

Second screen titled "Loja Misteriosa" (`outercityshop.OuterCityShopFrame.titleText`). The market screen with the same title is [../auction/mystery-shop.md](../auction/mystery-shop.md). Protobuf package `mapshop`.

Path aliases:

| Alias | File |
|---|---|
| OCSM | `decompiled/core_module/scripts/managers/OuterCityShopManager.as` |
| OCMOD | `decompiled/core_module/scripts/mvc/module/outercityshop/OuterCityShopModel.as` |
| OCII | `decompiled/core_module/scripts/mvc/module/outercityshop/OuterCityShopItemInfo.as` |
| OCC | `decompiled/core_module/scripts/mvc/controler/OuterCityShopControler.as` |
| OCF | `decompiled/m7/scripts/outercityshop/OuterCityShopFrame.as` |
| OCRV | `decompiled/m7/scripts/outercityshop/view/OuterCityShopRandomView.as` |
| OCEV | `decompiled/m7/scripts/outercityshop/view/OuterCityShopExchangeView.as` |
| OCGI | `decompiled/m7/scripts/outercityshop/view/OuterCityShopGoodsItem.as` |
| OCLV | `decompiled/m7/scripts/outercityshop/view/OuterCityShopLeftView.as` |

## 1. Overview

- Random tab: 6 random items (template Type 2) priced in diamonds plus optional outer city resources: "Pedra Misteriosa" 2131057 (dropped by outer city monsters when the luck bar has 3 of 5 stars, `tips.mysteryTip.StripView`), Espírito (`strategy`), water crystal. Automatic refresh at 9h, 12h, 18h and 21h ("Todos os dias às 9h, 12h, 18h e 21h é atualizado o mercado do exterior da cidade", `outercityshop.helpContent`); manual refresh for diamonds with a daily cap; manual refreshes fill a luck bar that raises the chance of "brilhantes" (IsDrop) items.
- Exchange tab: fixed list (template Type 1) priced in shop points ("Pontos"); points are earned in the random tab (assumption: by purchases and refreshes).
- Each slot or exchange row can be bought once per list (random) or as allowed by the server (exchange).
- Unlock: level 26 ("Função ativada no Nv. 26").

Entry points:
- Mall home tab right column "Loja Misteriosa" button (`decompiled/m15/scripts/view/inside/MainRightView.as:109-120`).
- NPC "Rona, Loja Misteriosa" (`raw/xml/tempinfos/MapNodeInfos.xml`, node Id 10, MapId 10000, MasterType 61, SonType 3008, dialogue "Os itens de hoje são bons!", `Param3 = "100, Loja Misteriosa, 11"`): dialog option type 100 opens this shop (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:633-641`).
- Hero information resource link for currency -4 (`decompiled/m5/scripts/armyII/viewII/information/GoodsExchangeItem.as:338-345`).
All check level >= 26.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `outercityshop.OuterCityShopFrame` (controller `outercityshop`, `OCC:40-43`) | "Loja Misteriosa" | Tabs random and exchange (`OCF:209-256`), "Vezes restantes de atualização de hoje: X / 10" (`OCF:275-285`), "Tempo até a próxima atualização automática" countdown (`OCMOD.lastFreshTime`), points balance, Pedra Misteriosa count, help | entry points | 4946 |
| `outercityshop.view.OuterCityShopRandomView` | | 6 `OuterCityShopGoodsItem`, quick refresh button with price selector ("Diamantes 10", `OuterCityShopSelectedView`), luck bar (`LuckyProgressView`) | random tab | slots, refresh price |
| `outercityshop.view.OuterCityShopExchangeView` | | 6 exchange rows per page with page buttons (`OCEV:67-141`) | exchange tab | Type 1 templates sorted by `Sort` (`OCC:59-73`) |
| `outercityshop.view.OuterCityShopGoodsFrame` | "Previsão de Qualidade" (`outercityshop.OuterCityShopFrame.linkText`) | Preview of all `IsDrop == 1` random items, 30 per page (`OCC:45-51,92-109`) | link in the frame | |
| `outercityshop.view.OuterCityShopLeftView` | | Feed of lucky messages (`OCLV:72-85`) | frame left | 294 |

## 3. Routes (client to server)

All routes: send 9528 (0x2538) `U_C_MAPSHOPINFO` (named like the reply in `protocol/opcodes.csv`), message `com.road.yishi.proto.mapshop.MapShopquestMsg`: `op` (#1, INT32), `para1` (#2, INT32), `para2` (#3, INT32), `payType` (#4, INT32, sent only when not -1). Sender `OuterCityShopManager.sendAction(op, para1 = 0, para2 = 0, payType = -1)` (`OCSM:87-99`).

| # | op | UI | Fields | Client checks | Response |
|---|---|---|---|---|---|
| R1 | 1 load | frame open (`OCF:154-171`) | none | level >= 26 at the entry point | 4946 |
| R2 | 2 buy | slot or exchange buy (`OCGI:324-415`) | `para1` = template Type (2 random, 1 exchange); `para2` = slot index for Type 2, `MapShopId` for Type 1; `payType` 2 = bound diamonds allowed (checkbox of the "today" alert), 1 = not | every cost covered (`OCGI.checkGoods`, `OCGI:259-322`): points `Score` vs `consumePoints`, -400 diamonds vs `point + giftToken`, -300 `strategy`, -600 water crystal, 2131057 bag count, else "A compra não foi sucedida! A quantidade de \"{0}\" é insuficiente"; confirm "Ao comprar {0} vai Consumir" + cost list (`OCGI:361-379`) | 4946 |
| R3 | 3 refresh | quick refresh (`OCRV:73-182`) | `para1` = refresh currency (`OuterCityShopSelectedView.payType`, always 1 = diamonds; 2 = points path exists in `OCRV:139-146`); `para2` = 2 bound allowed / 1 not | anti double click 400 ms; unbought `IsDrop` slot -> confirm "A loja tem itens de qualidade alta, deseja continuar operação?"; diamonds `point + giftToken >= MapShopPoint` else recharge (points path: points >= price else "Pontos insfucientes..."); daily confirm "Quer consumir {0} Diamantes para atualizar de imediato ?" with bound option | 4946 |

## 4. Server messages (server to client)

### S1. 4946 (0x1352) `U_C_MAPSHOPINFO`

- `com.road.yishi.proto.mapshop.MapShopInfoMsg`: `userId` (#1, INT32); `fresh_time` (#2, STRING `YYYY-MM-DD hh:mm:ss`) next automatic refresh time (`OCMOD.lastFreshTime = fresh_time - now`, 14400 when missing, `OCMOD:55-62`); `bless` (#3, INT32) luck bar value (stored, not drawn in this build); `fresh_count` (#4, INT32) manual refreshes used today; `items` (#5, repeated `MapshopIteminfoMsg`: `mapshopitemid` (#1, INT32) Type 2 template `MapShopId`, `mapshopcostid` (#2, INT32) cost template id (ignored by the client), `isbuy` (#3, BOOL), `index` (#4, INT32) slot); `score` (#6, INT32) points balance.
- Receiver: `OuterCityShopManager.__mapShopInfoHandler` (`OCSM:65-85`) -> `FRESH_VIEW`.
- When: reply to every 9528 op.

### S2. 294 (0x0126) `U_C_OUTER_CITY_SHOP_PASS`

- `com.road.yishi.proto.item.BottlePassMsg`: `infos` (#2, STRING, repeated) chat formatted lines; `pass_type` (#1), `count` (#3), `dropId` (#4) unused here.
- Receiver: `OuterCityShopManager.__updateShopInfoHandler` (`OCSM:57-63`) -> `shopLuckShowInfo`, drawn by `OCLV`.
- When: push of the server wide lucky purchase feed (assumption: on load and when a player buys an `IsDrop` item).

## 5. Rules and formulas

- Refresh price: config `MapShopPoint` (default 10 diamonds when missing, `OCMOD:15-16`); `MapShopStrategy` 20000 and `MapShopStrategyMax` 1280000 (`OCMOD:17-20`) are alternative strategy prices not used by any live button. None of the three keys exists in `ConfigInfos.xml`, so defaults apply. The price label reuses `ShopFresh_DayCount` (10) (`decompiled/m7/scripts/outercityshop/view/OuterCityShopSelectedView.as:44-56`).
- Manual refresh cap per day: `ShopFresh_DayCount` = 10 (`OCF:100-106`).
- Automatic refresh at 09:00, 12:00, 18:00, 21:00 (help text); `fresh_time` must be the next of these.
- Luck bar: manual refreshes increase `bless`; when full, high chance of `IsDrop` items; an automatic refresh that yields an `IsDrop` item empties it (`outercityshop.view.progressTip`). Exact increments are not in client data (assumption: +1 per manual refresh, max 10, `LuckyProgressView.creatMask(0,10)`).
- Slot costs (`OCII:52-74`): `Point` -> diamonds (-400, bound allowed when `payType = 2`), `Score` -> shop points, `SecretStone` -> item 2131057, `Strategy` -> player strategy (-300), `Crystal` -> water crystal (-600).
- Template availability: `MinLevel <= level <= MaxLevel`; `NeedTransJob` (job advancement required, 323 random rows), `NeedJob` (all 0).
- Random roll: weighted by `Random` among Type 2 rows matching the player (assumption on weight meaning).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/MapShopItemTemplateInfos.xml` | 746 rows: Type 1 exchange (75 rows, all priced in `Score`, Ids 1001..), Type 2 random (671 rows, all with `Point`, 151 with `SecretStone`, 251 with `Strategy`, 125 with `Crystal`, 149 `IsDrop`), Type 3 planes shop (no rows; used by [../planes/README.md](../planes/README.md) through `getPlanesGoodsByMapShopId`) (`decompiled/core_module/scripts/yishi/resolve/OuterCityShopTemplateResolve.as`) | `MapShopId`, `Type`, `ItemId`, `Count`, `MinLevel`, `MaxLevel`, `NeedTransJob`, `NeedJob`, `Random`, `IsDrop`, `Sort`, `Point`, `Score`, `SecretStone`, `Strategy`, `Crystal` |
| `MapShopCost` (loaded by `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1201`, `OuterCityShopCostTemplateInfo`: `Id`, `MapShopId`, `NeedItemId`, `NeedItemCount`, `Random`, `DisCount`) | random alternative cost lines referenced by `mapshopcostid` | missing from `raw/xml/tempinfos` and from the packed `raw/xml/tempinfos.xml` |
| `ConfigInfos.xml` | `ShopFresh_DayCount` 10 | |

## 7. Persistent state

```sql
CREATE TABLE shops.map_shop_state (
  player_id        INTEGER     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  next_refresh_at  TIMESTAMPTZ NOT NULL,
  refresh_day      DATE        NOT NULL,
  manual_refreshes INTEGER     NOT NULL DEFAULT 0 CHECK (manual_refreshes >= 0),
  bless            INTEGER     NOT NULL DEFAULT 0 CHECK (bless >= 0),
  points           INTEGER     NOT NULL DEFAULT 0 CHECK (points >= 0)
);

CREATE TABLE shops.map_shop_slot (
  player_id    INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  slot_index   SMALLINT NOT NULL CHECK (slot_index BETWEEN 0 AND 5),
  map_shop_id  INTEGER  NOT NULL,
  cost_id      INTEGER  NOT NULL DEFAULT 0,
  is_bought    BOOLEAN  NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, slot_index)
);

CREATE TABLE shops.map_shop_feed (
  feed_id     BIGSERIAL   PRIMARY KEY,
  message     TEXT        NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

Points could be stored as currency "Pontos da Loja Misteriosa" in [../currency/README.md](../currency/README.md) instead of `points`.

## 8. Backend implementation notes

- `shops::map_shop::handle_op` (9528) dispatching on `op`:
  - `handle_load` (1): if `now >= next_refresh_at`, reroll (automatic: may reset `bless` when an IsDrop item appears) and set the next of 09/12/18/21; reset `manual_refreshes` on a new day. Reply 4946.
  - `handle_buy` (2): `para1 = 2`: slot `para2` exists, not bought, template matches level; `para1 = 1`: `MapShopId = para2` is a Type 1 row; debit every cost atomically (diamonds bound first when `payType = 2`); grant `ItemId x Count`; mark bought; add points (assumption); IsDrop -> feed + broadcast 294. Reply 4946.
  - `handle_refresh` (3): `manual_refreshes < 10`; debit `MapShopPoint` diamonds (bound first when `para2 = 2`) or points when `para1 = 2`; `bless += 1`; reroll with IsDrop bonus proportional to `bless`; reset `bless` when an IsDrop item is rolled (assumption). Reply 4946.
- Scheduler at 09:00, 12:00, 18:00, 21:00: mark lists stale (lazy reroll on next load) and push 4946 to players with the frame open (optional).

## 9. Open questions and assumptions

- Gap: `MapShopCost` template missing; cost lines (`mapshopcostid`) cannot be reproduced. Fallback: use the inline costs of `MapShopItemTemplateInfos.xml`.
- Gap: `MapShopPoint`, `MapShopStrategy`, `MapShopStrategyMax` config keys missing; client defaults 10, 20000, 1280000.
- Open: point earn rate, luck bar increments and bonus formula.
- Open: whether exchange rows have purchase limits (client sends `isBuy = false` always for exchange rows).

## 10. Implementation checklist

- [ ] Template loader `MapShopItemTemplateInfos.xml` (Types 1, 2)
- [ ] Tables `shops.map_shop_state`, `shops.map_shop_slot`, `shops.map_shop_feed`
- [ ] Route 9528 ops 1, 2, 3 and encoder 4946
- [ ] Encoder 294 feed
- [ ] Refresh schedule 09/12/18/21 and daily cap 10
- [ ] Multi cost debit (diamonds, points, 2131057, strategy, water crystal)
- [ ] Tests: buy with missing Pedra Misteriosa, refresh cap, level filtered roll
