# Star shop ("Resgatar Pontos")

Module `star-shop` of feature `cosmos`. Astrology points ("pontos de astrologia", `starPoint`) earned by rolling stars ([star-divination.md](star-divination.md)) buy specific star templates directly into the cosmos bag.

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/yishi/manager/StarManager.as` |
| SSF | `decompiled/m15/scripts/view/subshop/StarShopFrame.as` |
| SSI | `decompiled/m15/scripts/view/subshop/StarShopItem.as` |
| NBF | `decompiled/core_module/scripts/yishi/view/frame/NumBuyFrame.as` |
| SHC | `decompiled/core_module/scripts/mvc/controler/ShopControler.as` |
| STC | `decompiled/core_module/scripts/yishi/datas/templates/cate/StarTempalteCate.as` |

## 1. Overview

The catalogue is every `starTempInfos` row with `StarPoint > 0` (53 rows): energy stars 4 "Fonte de Energia" (1000) and 5 "Energia da Estrela" (5000), Profile 4 stars (2000), Profile 5 stars (7000, advanced family 30000), Profile 7 "Divino" stars (15000) and advanced "Deus·Gêmeos", "Deus·Peixes", "Santo · Cancer" (45000). Sorted energy first, then by Profile descending (`STC:69-80`). No stock or daily limit exists in the client.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SSF` | "Resgatar Pontos" (`:71`) | 6 items per page, page buttons, current points | "Resgatar" in `MakeStarView` (`decompiled/m5/scripts/star/view/MakeStarView.as:202-206`) -> shop controller openType 101 (`SHC:83-86`), list built by `SHC.initStarShopFrame` (`SHC:1476-1484`) | `starPoint` (`:84,175-178`), page "x/y" |
| `SSI` | buy button | one star: icon, name colored by profile, attribute text (`StarHelper.getStarAttributeAdd` at grade 1), price in points | `SSF` | (`SSI:193-236`) |
| `NBF` | quantity frame | multi buy for energy stars 4 and 5 | `SSI` | max = `min(free bag cells, floor(starPoint / StarPoint))` (`NBF:288-297`) |

## 3. Routes (client to server)

### B1. Buy one star
- UI: `SSI.__buyClick` (`SSI:100-139`).
- Client checks: `starPoint < StarPoint` -> "Pontos insuficientes"; bag full (`SM.checkStarPlayerBagIsFull`, `SM:497-505`) -> "Mochila de cosmos cheia"; templates 4 or 5 -> quantity frame (B2); `NeedGrades >= 80 && vocationGrades <= 0` -> confirm "Apenas slots de cosmos avançados,  podem equipar neste cosmo" (no catalogue row hits this today); final confirm "Gastar {0} pontos para trocar cosmo?" + star name (`SSI:141-176`).
- Sender: `SM.sendExchangeStar(templateId)` (`SM:443-449`).
- Route: C>S 8341 (0x2095) `C_STARSHOP_BUY`, `StarShopMsg`: `good_id (#1, INT32)` star template id; `result (#2, INT32)` not set.
- Response: 4261 with `result`, 4178 with the new bag 1 star (grade 1, gp 0), 3 with the new `starpoint`.

### B2. Buy several energy stars
- UI: `NumBuyFrame` for `StarTemplate` data; the client sends 8341 once per unit in a loop (`NBF:199-206`).
- Same route and responses as B1, repeated `count` times.

## 4. Server messages (server to client)

### S1. 4261 (0x10a5) `U_C_STARSHOP_BUY`, `StarShopMsg`
Receiver `SSF.__exchangeStarHandler` (`SSF:145-173`), registered only while the frame is open (`SSF:125`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `good_id` | #1 | INT32 | template bought |
| `result` | #2 | INT32 | 1 success, anything else failure |

Client reaction: `result == 1` -> tip "Troca sucedida" and a local chat line (channel 3) "Cosmo {0} adquirido"; otherwise "Falha na troca".

Plus 4178 ([star-equip.md](star-equip.md)) and 3 `starpoint` ([star-divination.md](star-divination.md)).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Catalogue | `starTempInfos` rows with `StarPoint > 0` | `STC:36-67`, `SHC:1476-1484` |
| Price | `StarPoint` points per unit | `SSI:110,155` |
| Destination | first free cell of bag 1; requires a free cell | `SSI:116-120` |
| Level gate | assumption: enforce template `NeedGrades` (40 or 60 for some rows) against hero level; the client does not check it |
| Page size | 6 | `SHC:1479` |

## 6. Templates

| File | Fields used |
|---|---|
| `starTempInfos.xml` | `TemplateId`, `TemplateName`, `Profile`, `StarPoint`, `NeedGrades`, `Icon`, stats |

## 7. Persistent state

No new table: debit `cosmos.star_state.star_point`, insert into `cosmos.stars` ([star-divination.md](star-divination.md)). Optional audit log:

```sql
CREATE TABLE cosmos.star_shop_log (
  log_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  player_id    BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id  INTEGER NOT NULL,
  price        INTEGER NOT NULL CHECK (price > 0),
  bought_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX star_shop_log_player ON cosmos.star_shop_log (player_id, bought_at);
```

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 8341 | `cosmos::star_shop::handle_buy` |

- Validation order: template exists with `StarPoint > 0` -> (assumption) hero level >= `NeedGrades` -> `star_point >= StarPoint` -> bag has a free cell -> one transaction (debit points, insert star in bag 1, log) -> push 4178, 3, then 4261 `result = 1`. On any failure push 4261 with `result = 0`.
- No timers, no battle.

## 9. Open questions and assumptions

- Assumption: server enforces `NeedGrades`.
- Assumption: result codes other than 1 are not distinguished by the client; use 0.

## 10. Implementation checklist

- [ ] Screens (client ready): `StarShopFrame`, `StarShopItem`, `NumBuyFrame` star branch.
- [ ] Route 8341 with points and bag space checks.
- [ ] Push 4261, 4178, 3.
- [ ] Optional table `cosmos.star_shop_log`.
- [ ] Tests: insufficient points -> result 0; full bag -> result 0; success inserts grade 1 star and debits points; quantity buy of 3 energy stars sends 3 requests and yields 3 stars.
