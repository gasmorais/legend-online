# Toy exchange ("Colocar Baloiço de Gato", "Tapete de Gato", ...)

Module `toy-exchange` of feature `cat-house`. Buying cat toys with gold or cat materials, with a diamond top up for missing materials.

Path aliases:

| Alias | File |
|---|---|
| CHM | `decompiled/core_module/scripts/managers/CatHouseManager.as` |
| CHC | `decompiled/core_module/scripts/mvc/controler/CatHouseController.as` |
| CHTC | `decompiled/core_module/scripts/yishi/datas/templates/cate/CatHouseTemplateCate.as` |
| CHEF | `decompiled/m11/scripts/cathouse/CatHouseExchangeFame.as` |
| CHEI | `decompiled/m11/scripts/cathouse/CatHouseExchangeItem.as` |
| CHCB | `decompiled/m11/scripts/cathouse/CatHouseCurrencyBar.as` |
| CHCI | `decompiled/m11/scripts/cathouse/CatHouseCurrencyItem.as` |
| COPC | `decompiled/m11/scripts/cathouse/CatObjectPutConatiner.as` |
| CT | `decompiled/core_module/scripts/mvc/module/currency/CurrencyType.as` |
| PCM | `decompiled/core_module/scripts/managers/PlayerCurrencyManager.as` |

## 1. Overview

Each of the 5 courtyard spots accepts one toy type (`CHTC:19` `INDEX_TO_TYPE = [102,105,101,103,104]`). The "lay" button of an empty spot opens the exchange list for that type. For each toy template the list shows the price (up to 3 cost lines) and either "buy" (no stock) or "place" with "Quantidade atual: {0}" (stock > 0, `CHEI:111-121`). Buying adds the toy to the stock; placing is in [courtyard.md](courtyard.md).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `CatHouseExchangeFame` (`CHEF`) | `cathouse.CatHouseExchangeFame.titleText{type}`: 101 "Colocar Baloiço de Gato", 102 "Tapete de Gato", 103 "Vara de Gato", 104 "Bola de Gato", 105 "Caixa de Gato" | list of the 5 toys of one type | spot "lay" button (`COPC:199-202`) -> `CHC` openType 1, `frameData = type` (`CHC:19-39`) | one `CatHouseExchangeItem` per template of the type (`CHEF:58-72`) |
| `CatHouseExchangeItem` (`CHEI`) | | icon (`{RES}` cat house icon `Icon`), name, quality frame, cost lines, buy or place button | `CHEF` | costs from `NeedItem1..3`/`NeedCount1..3` (`CHEI:77-96`), cost red when not enough (`CHEI:235-252`), stock count |
| `CatHouseCurrencyBar` (`CHCB`) | | the 7 material balances | `CatHouseFrame` | `PlayerCurrencyInfo.getCatToyCurrencyInfoByType(1001..1007)` refreshed on `CURRENCYREFRESH` (`CHCB:45-70`) |

## 3. Routes (client to server)

Route: C>S 9585 (0x2571) `C_CATTOYS_OP`, `CattoysInfoMsg`. Sender `CHM.OperateCatHouse(op, templateId, id, payType)` (`CHM:137-146`) sets only `op (#14, INT32)`, `templateId (#2, INT32)`, `id (#1, INT32)`, `payType (#18, INT32)`. Every request closes the exchange frame (`CHEI:224-228`).

### E1. Exchange a gold toy (op 1)
- UI: buy button on a toy whose only cost is gold (`NeedItem1 = -100`, the 5 "Simples" toys, 10000 gold).
- Client check: gold < cost -> tip `public.gold` (`CHEI:158-170`).
- Fields: `op = 1`, `templateId` = toy template, `id` = toy type of the spot (101..105), `payType = 0`.

### E2. Exchange a material toy (op 1)
- UI: buy button on a toy priced in materials (`CHEI:171-194`).
- Client: for each cost line compute the shortage; `needPoint = sum(shortage) * Cattoys_Point` (config `Cattoys_Point = 1` diamond per missing unit). If `needPoint == 0` send directly with `payType = 0`. Otherwise show "Deseja consumir {0} diamantes para comprar material extra?\n(Uso prioritário de itens)" through `SharedManagerHelper.needAlert` type "" (alert with a check box, skippable for the day) (`CHEI:191-193`).
- Callback (`CHEI:201-222`): check box on -> compare against `allPoint` (diamonds plus bound diamonds) and send `payType = 0`; off -> compare against `point` (diamonds only) and send `payType = 1`. Not enough -> recharge alert.
- Fields: `op = 1`, `templateId`, `id` = toy type, `payType` 0 or 1.

### Expected responses (E1, E2)
- 331 `U_C_CATTOYS_INFO` with the full list (the new toy with `isExist = true`, `rotatePos = -1`).
- 4725 `U_C_PLAYER_TOKENINFO` with the updated material balances (`PCM:520-545`).
- Gold or diamond update push (player resources, assumption: 3 `U_C_PLAYER_INFO` for diamonds, the castle resource push for gold).
- No result code exists; on failure send nothing but a 331 refresh (assumption) and optionally a system tip.

## 4. Server messages (server to client)

### S1. 331 (0x014b) `U_C_CATTOYS_INFO`, `CattoysInfoListMsg`
See [courtyard.md](courtyard.md) for the field table. For this module: `getCountByTemplateId` counts list entries with `isExist = true` per `templateId` (`CHM:81-88,98-106`); that count is the stock shown as "Quantidade atual" and enables the place button.

### S2. 4725 (0x1275) `U_C_PLAYER_TOKENINFO`, `PlayerTokenInfoMsg`
`tokenInfos (#1, TokenInfoMsg, repeated)`: `masterType (#1, INT32)`, `amount (#2, INT32)`, `expiredDate (#3, STRING)`. Cat materials use `masterType` 1001..1007 (`CT:132`), mapped to item ids -2000..-2600 (`CT:134`). Receiver `PCM.__currencyRefreshHandler` (`PCM:71-556`), then `CURRENCYREFRESH`.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Toy types | 101 swing ("Baloiço"), 102 pad ("Tapete"), 103 stick ("Vara"), 104 ball ("Bola"), 105 box ("Caixa") | `CHTC:9-17`, `CattoysTemplateInfos.xml` |
| Spot to type | spot 0 -> 102, 1 -> 105, 2 -> 101, 3 -> 103, 4 -> 104 | `CHTC:19` |
| Gold toys | Profile 1 ("Simples") of every type: 10000 gold (`NeedItem1 = -100`) | `CattoysTemplateInfos.xml` |
| Material toys | Profile 2..5 cost 3 materials each (table below) | `CattoysTemplateInfos.xml` |
| Diamond top up | 1 diamond per missing material unit (`Cattoys_Point`) | `CHEI:173-185`, `ConfigInfos.xml` |
| Pay type | 0: bound diamonds first then diamonds (`allPoint`); 1: diamonds only (`point`) | `CHEI:205-216` |
| Materials | 1001 "Madeira" (-2000), 1002 "Corda" (-2100), 1003 "Flanela" (-2200), 1004 "Jornal" (-2300), 1005 "Algodão" (-2400), 1006 "Pena" (-2500), 1007 "Nepenta" (-2600) | `CT:132-134`, `ItemTempInfos.xml` |
| Image index | `-(id + 2000) / 100`, gold -> 7 | `CHEI:254-266` |

Toy costs (`NeedItem x NeedCount`):

| Profile | Swing 101 | Pad 102 | Stick 103 | Ball 104 | Box 105 |
|---|---|---|---|---|---|
| 1 Simples | gold 10000 | gold 10000 | gold 10000 | gold 10000 | gold 10000 |
| 2 Normal | -2000x5, -2100x3, -2200x2 | -2000x1, -2100x1, -2200x1 | same as pad | same as pad | same as pad |
| 3 Bonito | -2100x12, -2200x8, -2300x6 | -2100x6, -2200x4, -2300x2 | -2100x3, -2200x2, -2300x1 | -2100x4, -2200x3, -2300x2 | -2100x4, -2200x2, -2300x1 |
| 4 Sofisticado | -2200x30, -2300x20, -2400x10 | -2200x20, -2300x10, -2400x7 | -2200x8, -2300x6, -2400x4 | -2200x20, -2300x10, -2400x7 | -2200x10, -2300x8, -2400x4 |
| 5 Luxuoso | -2400x100, -2500x80, -2600x60 | -2400x60, -2500x40, -2600x20 | -2400x35, -2500x25, -2600x15 | -2400x60, -2500x40, -2600x20 | -2400x50, -2500x35, -2600x20 |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `CattoysTemplateInfos.xml` Types 101..105 | toy | `TemplateId`, `TemplateName`, `Icon`, `Avatar`, `Types`, `Profile`, `NeedItem1..3`, `NeedCount1..3` (plus courtyard fields) |
| `ConfigInfos.xml` | constant | `Cattoys_Point` = 1 |
| `ItemTempInfos.xml` | materials | -2000..-2600 names and descriptions for the currency tips (`CHCI:36-51`) |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS cat_house;

CREATE TABLE cat_house.toys (
  toy_id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id   INTEGER NOT NULL,
  spot_index    SMALLINT CHECK (spot_index BETWEEN 0 AND 4),
  state         SMALLINT NOT NULL DEFAULT 0 CHECK (state IN (0,1,2,3)),
  cat_template_ids INTEGER[] NOT NULL DEFAULT '{}' CHECK (cardinality(cat_template_ids) <= 5),
  placed_at     TIMESTAMPTZ,
  ready_at      TIMESTAMPTZ,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX toys_player ON cat_house.toys (player_id);
CREATE UNIQUE INDEX toys_player_spot ON cat_house.toys (player_id, spot_index) WHERE spot_index IS NOT NULL;
```

Material balances: generic token table of [currency](../currency/README.md) (`master_type` 1001..1007). Optional audit:

```sql
CREATE TABLE cat_house.exchange_log (
  log_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  player_id    BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id  INTEGER NOT NULL,
  gold_spent   BIGINT  NOT NULL DEFAULT 0,
  points_spent INTEGER NOT NULL DEFAULT 0,
  pay_type     SMALLINT NOT NULL,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 9585 op 1 | `cat_house::toy_exchange::handle_exchange` |

- Validation order: template exists with `Types` 101..105 -> (optional) `id` equals the template type -> gold path: gold >= cost -> material path: shortage `* Cattoys_Point` <= available diamonds per `payType` -> one transaction: debit materials (use what is owned first), debit diamonds for the shortage (`payType` 0: bound first), debit gold, insert `cat_house.toys` row with `spot_index NULL`, `state 0` -> push 4725, resource push, 331.
- Stock cap: none in the client. Assumption: no cap.
- No timers, no battle.

## 9. Open questions and assumptions

- Assumption: `id` in op 1 carries the toy type (the client sends `_type`, `CHEI:167,188,216`); the server can ignore it and use the template type.
- Assumption: `payType` meaning as derived from `allPoint` vs `point`.
- Assumption: no error packet; the client closes the frame anyway.

## 10. Implementation checklist

- [ ] Screens (client ready): `CatHouseExchangeFame`, `CatHouseExchangeItem`, `CatHouseCurrencyBar`.
- [ ] Route 9585 op 1, gold path.
- [ ] Route 9585 op 1, material path with diamond top up and both pay types.
- [ ] Messages 331, 4725, resource pushes.
- [ ] Tables `cat_house.toys`, `cat_house.exchange_log`.
- [ ] Tests: gold toy with 9999 gold refused; material toy with full materials spends no diamonds; shortage of 3 units spends 3 diamonds; payType 1 refuses when only bound diamonds suffice; stock count appears in 331.
