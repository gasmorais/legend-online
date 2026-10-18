# Listing (sell tabs of the Leilão)

Path aliases:

| Alias | File |
|---|---|
| AMS | `decompiled/core_module/scripts/mediator/AuctionMessageSender.as` |
| AMH | `decompiled/core_module/scripts/mediator/AuctionMessageHandler.as` |
| SRT | `decompiled/core_module/scripts/yishi/datas/consant/SellResultType.as` |
| VO | `decompiled/core_module/scripts/mvc/module/auction/SellItemVO.as` |
| AF | `decompiled/m7/scripts/auction/view/AuctionFrame.as` |
| ATB | `decompiled/m7/scripts/auction/view/AuctionTopBar.as` |
| SSP | `decompiled/m7/scripts/auction/view/sell/AuctionSellSubmitPane.as` |
| SNP | `decompiled/m7/scripts/auction/view/sell/AuctionSellNumPane.as` |
| SRP | `decompiled/m7/scripts/auction/view/sell/AuctionSellResultPane.as` |
| SBP | `decompiled/m7/scripts/auction/view/sell/AuctionSellBagPane.as` |
| ABF | `decompiled/m7/scripts/auction/view/sell/AuctionBagFrame.as` |
| PSV | `decompiled/m7/scripts/auction/view/sell/PetSellView.as` |
| GMC | `decompiled/m7/scripts/auction/view/sell/AuctionGoodMoveControl.as` |
| BCM | `decompiled/m7/scripts/auction/view/sell/AuctionBagCellClickMediator.as` |
| BDM | `decompiled/m7/scripts/auction/view/sell/AuctionBagCellDropMediator.as` |

## 1. Overview

The seller puts one bag stack (or part of it) or one Einherjar in escrow, sets a minimum bid ("Lance mínimo") and a buyout ("Oferta fixa"), both in diamonds, chooses a duration of 8, 24 or 48 hours and pays a gold custody fee of 250 gold per hour. A player has at most 9 active listings. While a listing has no bid it can be cancelled. Item taxonomy and binding semantics are documented in [../inventory/README.md](../inventory/README.md); this module only states which flags block a listing.

Two tabs share the same code: "Vender itens" (`AuctionSellPane(1)`, `AF:143-154`) and "Vender Einherjar" (`AuctionSellPane(2)`, `AF:156-175`, level 50).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `auction.view.AuctionSellPane` | sell tab | Submit pane (left) and my listings pane (right) (`decompiled/m7/scripts/auction/view/AuctionSellPane.as:20-40`) | top bar sell button (`AF:143-154`) or sell Einherjar button (`AF:156-175`; disabled under level 50, `ATB:47-51`, click tip "Função habilitada no Nv. 50") | |
| `AuctionSellSubmitPane` (`SSP`) | top tip "Clique aqui para colocar item à venda" | Target cell, item name, minimum bid input, buyout input (digits only, max 9 chars, `SSP:113-119`), duration buttons "8 Horas", "24 Horas", "48 Horas" (`SSP:120-129`), custody fee text with gold icon (`SSP:142-145`), "Iniciar leilão" button | sell tab | Prices prefilled from `StartingPrice` (`SSP:299-309`) or from the last submitted values for the same template and count (`SSP:331-366`) |
| `AuctionSellNumPane` (`SNP`) | "Quantidade à Leiloar" | Quantity picker 1..min(stack, 999) with hold to repeat (150 ms) (`SNP:132-157`, `:222-234`) | dropping a stack with `count > 1` on the target cell (`GMC:92-108`) | warm text "Insira quantidade à leiloar" |
| `AuctionBagFrame` (`ABF`) | "Mochila" | 7x8 grid of listable bag items (`ABF:87-95`, `SBP:83-104`) | item tab, opens automatically after 20 ms (`SRP:157-170`) and on click of the target cell (`decompiled/m7/scripts/auction/view/AuctionSellPane.as:44-56`) | general bag and storehouse items filtered by `canSell` |
| `PetSellView` (`PSV`) | "Selecione Einherjar à venda" | List of sellable Einherjar; "Não poderá vender Einherjar." when empty (`PSV:67-107`) | Einherjar tab | `PSV:109-127` filter |
| `AuctionSellResultPane` (`SRP`) | my listings | 9 rows of `AuctionListItem1` (`SRP:82`), local sort by clicking column titles (`SRP:122-149`), "Cancelar" button (`SRP:209-238`), diamond balance (`decompiled/m7/scripts/auction/view/sell/AuctionSellBottomBar.as:47-50`) | sell tab | `AuctionModel.soldList` (`SRP:66-67`) |

Help for the Einherjar tab (`AuctionFrame.helpPet`): "1. Apenas Einherjar não vinculado pode ser vendido no Leilão. 2. Einherjar coletado do email, aparecerá na lista de Einherjar. 3. Ao atingir número máximo de Einherjar, comprados no leilão não poderão ser retirados do email."

## 3. Routes (client to server)

### R1 Create listing (C_MALL_SELL_ITEM)

- UI control: "Iniciar leilão" (`auction.startAuctionBtn`) -> `AuctionSellSubmitPane.onSellBtnClick` (`SSP:147-221`) -> `AuctionGoodMoveControl.storeTargetData` -> `AuctionMessageSender.sendSellItemMessage` (`AMS:19-32`).
- Client checks, in order (`SSP:152-204`), each shows an alert and stops:

| # | Check | pt-BR message |
|---|---|---|
| 1 | target cell empty | "Selecione item à vender" (`Auction.SubmitAlert1`) |
| 2 | minimum bid empty | "Insira lance mínimo" (`SubmitAlert6`) |
| 3 | minimum bid < 2 | "O preço inicial não pode ser inferior a 2" (`SubmitAlert2`) |
| 4 | minimum bid < `StartingPrice * willSellCount` | "Lance mínimo muito baixo" (`SubmitAlert5`) and the field is reset to the floor |
| 5 | buyout < 1 | "Insira oferta fixa" (`SubmitAlert3`) |
| 6 | buyout <= minimum bid | "Oferta fixa precisa ser maior que lance mínimo" (`SubmitAlert4`) |
| 7 | Einherjar on remote expedition (`isRemote`) | "Einherjar não pode ser vendido na expedição de Einherjar de equipe" (`pet.inRemotePet4`) |

- Earlier checks when the item is moved to the target cell: locked item (`isLock`, vice password) -> "Apenas poderá vender, após desbloquear itens" (`BCM:39-44`, `:56-61`, `BDM:66-72`); only listable items are shown at all (rule L1, L2).
- No client check of gold for the custody fee, no client check of the 9 listing cap and no client level gate other than the Einherjar tab.
- Route: C>S 8448 (0x2100) `C_MALL_SELL_ITEM`.
- Request `SellItemReqMsg` (package `mall`), filled from `SellItemVO` (`VO:3-31`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `item_id` | 1 | INT32 | Item instance id (`GoodsInfo.id`); 0 for Einherjar |
| `item_pos` | 2 | INT32 | Bag position of the item; for Einherjar the `petId` |
| `count` | 3 | INT32 | Quantity to sell: `willSellCount` from the quantity picker, else the whole stack (`SSP:205-212`) |
| `point` | 4 | INT32 | Minimum bid in diamonds |
| `fix_point` | 5 | INT32 | Buyout in diamonds |
| `hour` | 6 | INT32 | 8, 24 or 48 (`SSP:229-240`) |
| `sellType` | 7 | INT32 | 1 item, 2 Einherjar (`VO:6-8`) |
| `fromBagType` | 8 | INT32 | Source bag: 1 general bag or 34 storehouse; default 1 for Einherjar |

- Expected server replies in order: 4352 `U_C_MALL_SELL_ITEM` (S1); on success also 115 `U_C_BAG_MOVE_UPDATE` (stack removed or reduced) or 4540 `U_C_PLAYER_PETINFO` (pet entry with `isDel = true`), then 3 `U_C_PLAYER_INFO` (gold after the fee).

### R2 My listings (C_MALL_LIST_SELL)

- UI: opening either sell tab (`AF:153`, `AF:174`), after a successful create when the list already had more than 8 rows (`AMH:126-129`), after a failed cancel (`AMH:244`).
- Sender: `AuctionMessageSender.sendMyAuctionListReq(page, count, from)` (`AMS:34-42`), always `(1, 9, 1)` except the cancel failure path (`(currentPage, 9, 1)`).
- Route: C>S 8449 (0x2101) `C_MALL_LIST_SELL`; `MallItemViewReqMsg`: `page` (#1, INT32), `count` (#2, INT32) = 9, `from` (#3, INT32) = 1 (assumption: 1 = own listings), `order_by` (#4, INT32) unset, `order_type` (#5, INT32) unset.
- Expected response: 4353 `U_C_MALL_LIST_SELL` (S2).

### R3 Cancel listing (C_MALL_CANCEL_SELL)

- UI: select a row of my listings, "Cancelar" -> confirmation "Cancelar leilão do item?" (`Action.SellGoods.CancelSell`) -> `cancelSell` (`SRP:209-238`) -> `AuctionMessageSender.sendCancelItemMessage(goodId)` (`AMS:84-90`). No row selected -> "Selecione item".
- Client checks: none (the client does not block listings with bids).
- Route: C>S 8454 (0x2106) `C_MALL_CANCEL_SELL`; `AuctionItemReqMsg`: `id` (#1, INT32) listing id, `point` (#2, INT32) unset.
- Expected response: 4358 `U_C_MALL_CANCEL_SELL` (S3), then the item return (rule L8).

## 4. Server messages (server to client)

### S1 4352 (0x1100) U_C_MALL_SELL_ITEM

- `SellItemRspMsg` (package `simple`): `result` (#1, INT32) result code, `item` (#2, MallItemMsg) the new listing (fields in [market-browse.md](market-browse.md) S1).
- Receiver `AuctionMessageHandler.onSellResultEvent` (`AMH:114-139`): `result == 0` appends the listing to `soldList`, requests 8449 if the list had more than 8 rows, clears the target cell. Otherwise alert "Aviso" + `Auction.ResultAlert<abs(result)>` and the bag filters are reset (`RETURN_REFRESH`).
- When: response to R1.

### S2 4353 (0x1101) U_C_MALL_LIST_SELL

- `AuctionItemsMsg`: `page_idx` (#1), `page_count` (#2), `sellItem` (#4, repeated MallItemMsg) the caller's active listings (up to 9), `itemBuy` (#3) empty.
- Receiver `AuctionMessageHandler.updateSoldPaneList` (`AMH:73-91`) -> `soldList.update`.
- When: response to R2.

### S3 4358 (0x1106) U_C_MALL_CANCEL_SELL

- `CanceltemRspMsg` (package `simple`): `result` (#1, INT32), `id` (#2, INT32) listing id, `item` (#3, MallItemMsg) not read.
- Receiver `AuctionMessageHandler.onCancelItemResult` (`AMH:228-246`): `result == 0` removes the row; any other result silently re-requests 8449 (no alert).
- When: response to R3.

### Result codes (`SRT:8-44`, text `Auction.ResultAlert<n>`)

| Code | Constant | pt-BR text | Used by |
|---|---|---|---|
| 0 | `SUCC` | "Sucedido" | all |
| -1 | `FAIL` | "Fracasso" | generic |
| -2 | `MALL_ITEN_NULL` | "Item inexistente" | listing gone (bid, buyout) |
| -3 | `MALL_ILLEGAL_COUNT` | "Quantidade inválida" | R1 count < 1 or > stack |
| -4 | `MALL_POINT_ERR` | "Lance precisa ser maior que o lance atual, insira novamete" | bid |
| -5 | `MALL_FIXPOINT_ERR` | "Erro no lance fixo" | R1 buyout <= bid, buyout mismatch |
| -6 | `MALL_HOUR_ERR` | "Erro no tempo" | R1 hour not 8/24/48 |
| -7 | `MALL_ITEM_BIND` | "Item foi vinculado" | R1 bound item or pet |
| -8 | `MALL_ITEM_NOT_EXIST` | "Item inexistente" | R1 item or pet not owned |
| -9 | `MALL_ITEM_SELLING` | "Item está à venda" | R1 item already in escrow |
| -10 | `MALL_NO_GOLD` | "Ouro insuficiente" | R1 custody fee |
| -11 | `MALL_NO_POINT` | "Diamante insuficiente" | bid, buyout (client opens recharge) |
| -12 | `MALL_CAN_NOT_AUCTION` | "Item não pode ser leiloado" | R1 locked, equipped, in war, practice, remote, arena formation |
| -13 | `MALL_AUCTION_FAIL` | "Falha ao dar lance no item" | bid |
| -14 | `MALL_FIX_AUCTION_FAIL` | "Falha ao comprar item" | buyout |
| -15 | `MALL_DEL_ITEM_FAIL` | "Falha ao deletar item" | R3 (has bids, not owner, closed) |
| -16 | `MALL_BUY_SELF_ITEM` | "Próprio item não pode ser comprado" | buyout own |
| -17 | `MALL_AUCTION_BY_SELF` | "Falha ao dar lance, o seu lance já é o mais alto" | bid while already highest bidder |
| -18 | `MALL_SELL_MAX_COUNT` | "Quantidade de itens à venda não pode ultrapassar 9" | R1 cap |
| -19 | (no constant) | "Preço inicial não pode ser menor do predefinido" | R1 bid < `StartingPrice * count` |
| -20 | (no constant) | "Nv.Insuficiente,  não pode realizar licitação" | R1 Einherjar tab below 50 (assumption) |
| -51 | (no constant) | "Leilão será liberado após atingir nv.40." | any route below level 40 |
| -52 | (no constant) | "Limite de compra diária através do leilão" | bid, buyout daily cap ([settlement.md](settlement.md)) |

## 5. Rules and formulas

- L1 Listable items (`SBP:287-304`, `SBP:433-446`): items of the general bag (`bagType 1`, `objectId 0`) and of the storehouse bag (`bagType 34`) whose `isBinds` is false. Equipped items, the guild warehouse and other bags are not offered. Locked items (`isLock`) are shown but cannot be moved to the target cell (`BCM:39-44`). Server must re-check every condition: owned, in bag 1 or 34, not bound, not locked, not already in escrow, `count` between 1 and the stack.
- L2 Listable Einherjar (`PSV:109-127`, `SSP:188-197`): `!isBind && !isEnterWar && !isPractice`, not in the arena formation (`petChallengeFormationOfArray`), not on remote expedition (`isRemote`). Assumption: also not the last remaining pet if the game requires one, and the pet loses no equipment check (pet equipment is part of the pet string).
- L3 Quantity: 1..min(stack, 999) (`SNP:222-234`).
- L4 Minimum bid floor: `max(2, StartingPrice * count)` with `StartingPrice` from `ItemTempInfos` (`SSP:163-175`, `:299-309`). For Einherjar the template is -900 (`StartingPrice = 10`, count 1, so floor 10). Server answers -19 below the floor and -4 below 2 (assumption).
- L5 Buyout: `fix_point > point` (`SSP:182-186`); both at most 999999999 (9 digits).
- L6 Duration and custody fee: `hour in {8, 24, 48}`, fee `250 * hour` gold = 2000, 6000 or 12000 gold (`SSP:142-145`, help "Vender itens consume ouro como taxa de custódia"). The fee is not refunded on cancel or expiry (assumption).
- L7 Cap: at most 9 active listings per seller (code -18).
- L8 Cancel: allowed only while the listing has no bid ("Itens com lances dados não podem ser cancelados do leilão", help line 5). Returned items: assumption, sent by system mail like an expired listing (pets with mail type 5); alternative: direct return to the bag when there is space.
- L9 Einherjar listing payload: the client converts the pet with `PetData.convertToGoods` (`decompiled/core_module/scripts/mvc/module/pet/PetData.as:1315-1324`): template -900, count 1. Listings shown to others must carry `item_info.template_id = -900`, `count = 1` and `property1` = `templateId,temQuality,qualityGp,_,grade,curExp,totalExp,initQuality|coeStrength,coeIntellect,coeStamina,coeArmor,strength,intellect,stamina,armor|resFire,resWater,resElect,resWind,resDark,resLight|followSkills|changeSkills` (parser `PetData.createWidthString`, `PetData.as:638-686`; `GoodsInfo.property1` setter, `decompiled/core_module/scripts/yishi/datas/goods/GoodsInfo.as:111-123`).
- L10 Quest hook: quest 825 "Leiloar" (condition type 56, `Para2 = 1`): assumption, +1 on every successful listing.
- L11 Listing visibility delay: help line 8 "Os itens leiloados apenas apareceram no leilão depois de algum tempo"; see [settlement.md](settlement.md) T8.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | `ItemTempInfo` | `StartingPrice` (minimum unit bid), `TemplateName`, `MasterType`, `SonType`, `NeedGrades`, `Profile`, `Job` (denormalized into the listing); template -900 for Einherjar |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS auction;

CREATE TABLE auction.listing (
  listing_id      BIGSERIAL    PRIMARY KEY,
  seller_id       INTEGER      NOT NULL REFERENCES player.players(player_id),
  sell_type       SMALLINT     NOT NULL CHECK (sell_type IN (1, 2)),
  template_id     INTEGER      NOT NULL,
  item_count      INTEGER      NOT NULL CHECK (item_count BETWEEN 1 AND 999),
  item_snapshot   JSONB        NOT NULL,
  pet_id          INTEGER,
  start_point     INTEGER      NOT NULL CHECK (start_point >= 2),
  current_point   INTEGER      NOT NULL,
  fix_point       INTEGER      NOT NULL,
  duration_hours  SMALLINT     NOT NULL CHECK (duration_hours IN (8, 24, 48)),
  custody_fee     INTEGER      NOT NULL,
  highest_bid_id  BIGINT,
  status          SMALLINT     NOT NULL DEFAULT 0,
  item_name       TEXT         NOT NULL,
  master_type     SMALLINT     NOT NULL,
  son_type        SMALLINT     NOT NULL,
  need_grade      SMALLINT     NOT NULL,
  quality         SMALLINT     NOT NULL,
  job             SMALLINT     NOT NULL,
  created_at      TIMESTAMPTZ  NOT NULL DEFAULT now(),
  visible_at      TIMESTAMPTZ  NOT NULL,
  expires_at      TIMESTAMPTZ  NOT NULL,
  closed_at       TIMESTAMPTZ,
  CHECK (fix_point > start_point),
  CHECK ((sell_type = 2) = (pet_id IS NOT NULL))
);
CREATE INDEX listing_seller_idx ON auction.listing (seller_id, status);
CREATE UNIQUE INDEX listing_active_pet_uq ON auction.listing (pet_id) WHERE status = 0 AND pet_id IS NOT NULL;
```

- `status`: 0 active, 1 sold by bid, 2 bought out, 3 expired without bid, 4 cancelled.
- `item_snapshot`: full item instance (all `SimpleItemInfoMsg` fields, `property1` for pets) so the escrowed item can be recreated for the buyer or the seller. The item row is removed from the inventory in the same transaction (escrow). If the inventory module prefers to keep the row with an "escrow" location, store its id instead (decision for the inventory owner).
- `current_point` starts at `start_point`; `highest_bid_id` references `auction.bid` ([bidding.md](bidding.md)).

## 8. Backend implementation notes

- `auction::listing::handle_sell` (8448). Validation order: level >= 40 (-51) -> `sell_type` 2 requires level >= 50 (-20, assumption) -> `hour` (-6) -> `count >= 1` (-3) -> active listings < 9 (-18) -> load item (bag `fromBagType` in {1, 34}, `item_id`, `item_pos`, owner) or pet (`item_pos` = pet id) (-8) -> not already listed (-9) -> not bound (-7) -> not locked, pet not in war, practice, arena formation, remote (-12) -> `count <= stack` (-3) -> `point >= max(2, StartingPrice*count)` (-19) -> `fix_point > point` (-5) -> gold >= `250*hour` (-10). Transaction: debit gold, remove or split the stack (or detach the pet), insert `auction.listing` with snapshot and `visible_at = now() + delay`, `expires_at = now() + hour`. Reply 4352 then 115 or 4540, then 3. Increment quest condition 56.
- `auction::listing::handle_list_own` (8449): select active listings of the caller ordered by `created_at`, page size from `count` (clamp 1..9). Reply 4353.
- `auction::listing::handle_cancel` (8454): owner check, `status = 0`, `highest_bid_id IS NULL` else -15. Transaction: `status = 4`, `closed_at = now()`, create the return mail with the snapshot ([../mail/README.md](../mail/README.md)). Reply 4358 with `result`, `id`.
- Row locking: `SELECT ... FOR UPDATE` on the listing for cancel, so a concurrent bid either sees status 4 or blocks the cancel.
- No pushes to other players.

## 9. Open questions and assumptions

- Assumption: cancel and expiry return the item by mail; custody fee never refunded.
- Assumption: -20 is the Einherjar level gate; -19 is the `StartingPrice` floor.
- Assumption: `from = 1` in `MallItemViewReqMsg` means "own listings".
- Assumption: the listing counts for quest condition 56.
- Open: should storehouse (`bagType 34`) items require the storehouse to be open? The client lists them unconditionally (`SBP:292-293`).
- Open: whether a strengthened or socketed equipment keeps all properties (yes via snapshot) and whether pet equipment travels with the pet.

## 10. Implementation checklist

- [ ] Screen: sell items tab (bag frame, quantity picker, submit pane, my listings)
- [ ] Screen: sell Einherjar tab (PetSellView, level 50)
- [ ] Route 8448 `C_MALL_SELL_ITEM` with validation order and all result codes
- [ ] Route 8449 `C_MALL_LIST_SELL`
- [ ] Route 8454 `C_MALL_CANCEL_SELL`
- [ ] Server messages 4352, 4353, 4358, plus 115, 4540, 3 side effects
- [ ] Table `auction.listing` and indexes
- [ ] Escrow helper with the inventory module (remove, split stack, snapshot, recreate)
- [ ] Pet escrow helper with the Einherjar module (`property1` encoder)
- [ ] Rules L1..L11
- [ ] Test: bound item rejected (-7), locked item rejected (-12), 10th listing rejected (-18)
- [ ] Test: fee 2000/6000/12000 gold, insufficient gold (-10)
- [ ] Test: cancel without bids returns item by mail; cancel with a bid fails (-15)
- [ ] Test: Einherjar listing round trip (sell, buy, mail with pet)
