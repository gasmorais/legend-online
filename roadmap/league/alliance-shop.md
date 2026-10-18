# Alliance event shop ("Loja do Evento")

Aliases: see [README.md](README.md) and [alliance-event.md](alliance-event.md). Extra aliases:

| Alias | File |
|---|---|
| SHV | `decompiled/m11/scripts/oldplayerreturn/shop/OldPlayerReturnShopView.as` |
| SHI | `decompiled/m11/scripts/oldplayerreturn/shop/OldPlayerReturnShopItem.as` |
| SBF | `decompiled/m11/scripts/oldplayerreturn/shop/OldPlayerReturnShopBuyFrame.as` |

## 1. Overview

Returnees spend "Prova do Retorno" (item 208701) and eternalists "Prova de Eternidade" (item 208702) on a catalog filtered by player type and job stage. Each row has a purchase limit that depends on the player's effective contract level. The shop is usable while `isShopOpen` (task phase plus `alliance_delaydays` = 7 days).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OldPlayerReturnShopView` (SHV) tab "Loja do Evento" | page "{n}/{total}" | 9 items per page (`OPRMOD:230-267`, `SHV:103-119`) | `OldPlayerReturnFrame` | `shopArr` |
| `OldPlayerReturnShopItem` (SHI) | "Limite de Compra: {0}/{1}" | Item cell, price, token icon frame = `PlayerType`; buy button | SHV | remaining = `Limited[contractLevel - 1] - bought` clamped at 0 (`SHI:121-163`) |
| `oldplayerreturn.shop.OldPlayerReturnShopBuyFrame` (SBF), `openType` 4 | "Aviso" title; "Qtd de compras", "Preço total" | Quantity selector bounded by `min(floor(tokens / MoneyNum), remaining)`; total price | SHI buy button when remaining > 0 (`SHI:91-103`) | item, remaining limit, price |

Catalog (`OPRMOD:197-228`): `stage` = 1 base, 2 if `vocationGrades > 0`, 3 if `isChangeJob`, 4 if `isAvenger`, 5 if `isHoly`; rows with `PlayerType == type` and `JobType` in 1..stage, sorted by `CommodityNum`. In this data every row has `JobType = 1`.

## 3. Routes (client to server)

### R1. Exchange (op 7)

- UI: SBF confirm (`SBF:209-222`).
- Client checks: remaining limit > 0 else "Limite de quantidade ultrapassada" (`SHI:97-101`); tokens in bag and depot >= `count * MoneyNum` else "Provas do Retorno Insuficientes" (type 1) / "Provas de Eternidade Insuficientes" (type 2) (`SBF:212-218`).
- Sender: `OldPlayerReturnManager.send(7, Id, count)`.
- Route: C>S 9717 (0x25f5) `C_ALLIANCE_REGRESSION_OP`, `allianceregression.CommonReq`: `op (#1, INT32)` = 7, `intParam1 (#2, INT32)` = `AllianceShopInfos.Id`, `intParam2 (#3, INT32)` = quantity.
- Response: 535 with `shopLimit` rows (the client only replaces the limits when the list is not empty, so always send the full list); token and item bag updates.

`SHI.buyCallBack` (`SHI:105-108`) would send op 7 with quantity 1 but is never called.

## 4. Server messages (server to client)

535 `U_C_ALLIANCE_USER_DATA` ([alliance-event.md](alliance-event.md)), field `shopLimit (#6, ShopLimitData, repeated)`:

| Field | Tag, type | Meaning |
|---|---|---|
| `GoodsId` | #1 INT32 | `AllianceShopInfos.Id` |
| `ExchangeCount` | #2 INT32 | quantity already bought in this event |

## 5. Rules and formulas

- Price: `MoneyNum` tokens per unit; token 208701 if `PlayerType == 1`, 208702 otherwise (`SBF:146`, `SBF:211`).
- Gain per unit: `CommodityAmount` of `CommodityId`.
- Limit: `Limited` is a comma list of 9 values indexed by `contractLevel - 1` (`SHI:150-157`); `contractLevel` per [alliance-contracts.md](alliance-contracts.md) (default 1 without allies). In this data every row has the same value for all levels (for example `1,1,...` or `2500,...`).
- Limits count over the whole event (assumption, no reset in the client).
- Usable while `isShopOpen`; the top bar stays visible in the shop phase (`TopBtnCheckShowHelper.as:421-424`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/AllianceShopInfos.xml` (73 rows: 47 for PlayerType 1, 26 for PlayerType 2) | shop row | `Id`, `PlayerType`, `JobType`, `CommodityNum` (sort), `CommodityId`, `CommodityAmount`, `MoneyNum`, `Limited` |

## 7. Persistent state

```sql
CREATE TABLE league.alliance_shop_purchases (
    event_id    bigint   NOT NULL REFERENCES league.alliance_events(event_id) ON DELETE CASCADE,
    player_id   bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    shop_row_id integer  NOT NULL,
    bought      integer  NOT NULL DEFAULT 0 CHECK (bought >= 0),
    PRIMARY KEY (event_id, player_id, shop_row_id)
);
```

## 8. Backend implementation notes

- `league::alliance::handle_shop_exchange` (op 7): validation order: event shop open, participant, row exists with `PlayerType` = caller type and `JobType <= stage`, quantity >= 1, `bought + qty <= Limited[level - 1]`, tokens >= `qty * MoneyNum`. Transaction: consume tokens (inventory API, bag then depot as the client counts both), add `CommodityAmount * qty` items (mail when full), upsert purchase; reply 535 with all `shopLimit` rows.
- At shop end tokens 208701 / 208702 may be removed (open).

## 9. Open questions and assumptions

- Assumption: limits are per event and never reset.
- Open: token cleanup after the shop closes.

## 10. Implementation checklist

- [ ] Screens SHV, SHI, SBF.
- [ ] Route 9717 op 7.
- [ ] `shopLimit` in 535.
- [ ] Table `league.alliance_shop_purchases`.
- [ ] Tests: buying past the limit rejected; insufficient tokens rejected; eternalist cannot buy a PlayerType 1 row.
