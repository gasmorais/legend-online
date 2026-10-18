# Market browse (buy tab of the Leilão)

Path aliases:

| Alias | File |
|---|---|
| AMS | `decompiled/core_module/scripts/mediator/AuctionMessageSender.as` |
| AMH | `decompiled/core_module/scripts/mediator/AuctionMessageHandler.as` |
| AM | `decompiled/core_module/scripts/mvc/module/auction/AuctionModel.as` |
| ALD | `decompiled/core_module/scripts/mvc/module/auction/AuctionListItemData.as` |
| ARL | `decompiled/core_module/scripts/mvc/module/auction/AuctionResultListData.as` |
| AF | `decompiled/m7/scripts/auction/view/AuctionFrame.as` |
| ATB | `decompiled/m7/scripts/auction/view/AuctionTopBar.as` |
| SP | `decompiled/m7/scripts/auction/view/buy/AuctionSearchPane.as` |
| SC | `decompiled/m7/scripts/auction/view/buy/AuctionSearchControl.as` |
| CP | `decompiled/m7/scripts/auction/view/buy/AuctionCategoryPane.as` |
| HS | `decompiled/m7/scripts/auction/view/buy/HotSearchItem.as` |
| BRP | `decompiled/m7/scripts/auction/view/buy/AuctionBuyResultPane.as` |
| LIB | `decompiled/m7/scripts/auction/view/common/AuctionListItemBase.as` |
| LTC | `decompiled/m7/scripts/auction/view/common/AuctionListTitleComponent.as` |
| PCC | `decompiled/m7/scripts/auction/view/common/AuctionPageControlComponent.as` |

## 1. Overview

The buy tab ("Comprar") is the default tab of the "Leilão" frame. The player searches active listings of other players and selects one row to bid on or buy out ([bidding.md](bidding.md)). The search is entirely server side: every change of filter, category, sort column or page sends one 8457 request and the reply replaces the visible page (7 rows).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `auction.view.AuctionFrame` (`AF`) | "Leilão" (`Auction.AuctionFrameTitle`, `AF:47`) | 905x580 frame with a top bar of tabs: buy, sell items, records, limited (disabled), sell Einherjar (`ATB:41-51`). Help button shows `auction.view.AuctionHelp.helpContent` or `AuctionFrame.helpPet` on the pet tab (`AF:111-127`) | `AuctionControl.showFrame` (`decompiled/core_module/scripts/mvc/controler/AuctionControl.as:22-28`), which also creates `AuctionMessageHandler` | Tabs; `show()` selects the buy tab (`AF:70-76`) |
| `auction.view.AuctionBuyPane` | buy tab | Search pane (top), category tree (left), result pane (right) (`decompiled/m7/scripts/auction/view/AuctionBuyPane.as:22-43`) | `AF.onBuyClick` (`AF:129-141`): clears the model, `currentModulIndex = 0`, then `restoreListTitle()` sends the first search | |
| `AuctionSearchPane` (`SP`) | labels as bitmaps | Name input (max 16 chars, double byte chars count 2, `SP:90`, `:276-294`), level combo, quality combo, class combo, "usable" check box, search and reset buttons, 6 hot search links (`SP:67-131`) | buy pane | Combo data from `AM:41-146` |
| `AuctionCategoryPane` (`CP`) | category tree | Menu from language key `AuctionCategoryPane.xml` (`CP:41-48`, `:69-97`). Top category "Einherjar" (Type 4) is disabled below level 50 with tip "Nv.{0} activado" (`CP:121-125`) | buy pane | First item "Todos" selected on open (`CP:128`) |
| `AuctionBuyResultPane` (`BRP`) | columns "Ícone", "Nome", level, "Tempo", "Vendedor", "Oferta Fixa", "Valor Atual" (`Auction.ResultListTitle1..7`) | 7 rows of `AuctionListItem1` (`BRP:68`), bottom bar with diamond balance, page control, "Dar Lance" and "Oferta Fixa" buttons (`decompiled/m7/scripts/auction/view/buy/AuctionBuyBottomBar.as:35-58`) | buy pane | `AuctionModel.forSaleList` (`BRP:52-53`) |
| `AuctionListItemBase` (`LIB`) | row | Icon, name, level, time left bucket, seller, buyout, current price, "auctioned" icon (tip "Outro jogador já deu lance nesse item"), unit price tips "Oferta Fixa:" / "Lance Atual:" price divided by `count` (`LIB:117-190`, `:255-264`). Double click on the icon copies the item name into the search box (`LIB:103-106`, `SP:173-177`) | result pane | `AuctionListItemData` |

Time left buckets (`ALD:58-81`, tips `LIB:230-253`): remaining = `hour*3600000 - (nowDate - startTime)`; >= 12 h "Muito longo" ("Mais que 12 horas"), 2 to 12 h "Longo" ("De 2 à 12 horas"), 0.5 to 2 h "Médio" ("De 30 minutos à 2 horas"), else "Curto" ("Menos que 30 minutos").

Category tree (`AuctionCategoryPane.xml`, pt-BR verbatim):

| Type (first level) | MenuName | Children (`son_type`) |
|---|---|---|
| 0 | Todos | none |
| 1 | Equipamentos | 101 Armamento, 104 Vestuário, 106 Colar, 103 Capacete, 107 Anel, 108 Acessórios |
| 2 | Itens | none |
| 4 | Einherjar (level 50) | 306 Esfera, 309 Einherjar, 304 Esfera de Energia |

The first level `Type` equals the item template `MasterType` (1 equipment, 2 items, 4 Einherjar related) and the child `Type` equals `SonType` (see [../inventory/README.md](../inventory/README.md)). Einherjar listings use template -900 "Carta de Selo do Einherjar vazio" (MasterType 4, SonType 309), see [listing.md](listing.md).

Hot searches (`HS:64-93`): six links that search by name: 0 "Pedra Legendária" (icon 2129400), 1 "Pedra de Sintetização" (2129003), 2 "Cristal de Almas" (208014), 3 "Cristal das Trevas" (208012), 4 "Doc. de Recompensa Avançado" (2130005), 5 "Pedra de Purificação" (2127003). Key `goodsName6` "Esfera de Energia" exists but is not used.

## 3. Routes (client to server)

### R1 Search (C_MALL_SEARCH)

- UI controls: "Buscar" button (`SC:132-137`), Enter in the name box (`SC:62-70`), hot search link (`SC:72-78`, `HS:114-117`), category click (`SC:172-175` -> `restoreListTitle`), column title click (`SC:185-211`), previous and next page (`SC:162-170`), refresh after a failed bid with result -2 or -4 (`SC:80-83`, `AMH:174-184`), and opening the tab (`AF:140`).
- Sender: `AuctionSearchControl.search(page=1, orderBy=0, orderType=0, name=null)` (`SC:85-130`) -> `AuctionMessageSender.search` (`AMS:92-96`).
- Client side state: `recordSearchData` stores the filters only when the search is "restored" (button, Enter, hot link, category, tab open) (`SC:139-160`, `:177-183`). Paging and sorting reuse the stored filters. The name is taken only if the player clicked the box and typed (`nameTextClicked`), trimmed.
- Client checks: none (no level gate in the client; the server answers -51 "Leilão será liberado após atingir nv.40." when the player is below level 40, assumption: on every auction request, see [settlement.md](settlement.md)).
- Route: C>S 8457 (0x2109) `C_MALL_SEARCH`.
- Request `SearchItemReqMsg` (package `mall`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `item_name` | 1 | STRING | Substring of the item name; "" for no filter. Hot links send the pt-BR name |
| `min_level` | 2 | INT32 | Level range from the combo: 1-10, 11-20, ..., 61-70 (`AM:41-94`); unset when "S/ Restrição" (id 0) |
| `max_level` | 3 | INT32 | Upper bound of the same range |
| `quality` | 4 | INT32 | 1 Branco, 2 Verde, 3 Azul, 4 Roxo, 5 Laranja, 6 Vermelho (`AM:96-121`); unset for no filter. Matches template `Profile` |
| `job` | 5 | INT32 | 1 "Gue." (warrior), 2 "Arq." (archer), 3 "Fei." (mage) (`AM:123-146`); unset for no filter. Matches template `Job` (0 = all classes, assumption: job 0 items always match) |
| `type` | 6 | INT32 | Category first level (`MasterType`), unset when 0 "Todos" |
| `son_type` | 7 | INT32 | Category child (`SonType`), unset when no child selected |
| `usable` | 8 | BOOL | "Disponível" check box: only items the player can use (assumption: `NeedGrades <= level` and `Job in (0, player job)`) |
| `page` | 9 | INT32 | 1-based page |
| `order_by` | 10 | INT32 | 0 none, 1 level (`titleGrade`), 2 time left (`titleTime`), 3 current price (`titleCurPrice`), 4 buyout (`titlePrice`) (`SC:188-201`) |
| `order_type` | 11 | INT32 | 0 none; first click on a column = 2, second click on the same column = 1 (`SC:202-209`, `LTC:122-145`). Assumption: 2 descending, 1 ascending (the local sort of [listing.md](listing.md) uses `Array.DESCENDING` for the first click) |

- Expected response: 4359 `U_C_MALL_SEARCH` (S1).

### R2 Player items (C_MALL_PLAYER_ITEMS), unused

- Sender: `AuctionMessageSender.sendPlayerAuctionListReq(page, count, from)` (`AMS:44-52`). No caller in the client.
- Route: C>S 8450 (0x2102) `C_MALL_PLAYER_ITEMS`, `MallItemViewReqMsg` (`page` #1 INT32, `count` #2 INT32, `from` #3 INT32, `order_by` #4 INT32, `order_type` #5 INT32).
- Expected response: 4354 `U_C_MALL_PLAYER_ITEMS` (S2). Implement it as an unfiltered search ("Todos") so the handler exists.

## 4. Server messages (server to client)

### S1 4359 (0x1107) U_C_MALL_SEARCH

- Message `AuctionItemsMsg` (package `simple`): `page_idx` (#1, INT32) current page, `page_count` (#2, INT32) total pages (>= 1), `itemBuy` (#3, MallItemBuyMsg, repeated) unused here, `sellItem` (#4, MallItemMsg, repeated) up to 7 listings.
- `MallItemMsg`: `id` (#1, INT32) listing id; `template_id` (#2, INT32); `user_id` (#3, INT32) seller; `nick_name` (#4, STRING) seller nickname; `point` (#5, INT32) current price (minimum bid while there is no bid, else highest bid); `fix_point` (#6, INT32) buyout; `hour` (#7, INT32) duration 8, 24 or 48; `item_from` (#8, INT32) not read (assumption: 1 item, 2 Einherjar); `start_time` (#9, STRING `YYYY-MM-DD hh:mm:ss`, server local time); `max_auction_id` (#10, INT32) id of the highest bid, 0 when no bid; `item_info` (#11, SimpleItemInfoMsg) the item snapshot.
- `SimpleItemInfoMsg` fields read by `ItemHelper.readGoodsInfo2` (`decompiled/core_module/scripts/com/road/pb/helper/item/ItemHelper.as:69-103`): `id`, `user_id`, `bag_type`, `object_id`, `pos`, `template_id`, `bind`, `count`, `strengthen_grade`, `join_1..4`, `random_skill_1..5`, `mould_grade`, `property1`, `appraisal_skill`, `is_locked`, `desc_templateId`, `life_skill`.
- Receiver: `AuctionMessageHandler.onSearchResult` (`AMH:248-266`) -> `readListItem` (`AMH:280-292`) -> `forSaleList.update(list, page_idx, page_count)` (`ARL:21-27`).
- Mandatory values: `item_info.user_id` must be the seller id (the own item check compares it, `decompiled/m7/scripts/auction/view/common/AuctionChecker.as:16-34`); `item_info.count >= 1` (the unit price tip divides by it, `LIB:255-264`); `start_time` in the client clock zone; for Einherjar `template_id = -900`, `count = 1` and `property1` = pet string (see [listing.md](listing.md) rule L9).
- When: response to R1. Errors are not handled by this receiver; on error reply an empty page (`page_idx = 1`, `page_count = 1`).

### S2 4354 (0x1102) U_C_MALL_PLAYER_ITEMS

Same `AuctionItemsMsg` with `sellItem`; receiver `AuctionMessageHandler.updateBuyPaneList` (`AMH:53-71`) updates `forSaleList`. Response to R2 only.

## 5. Rules and formulas

- B1 Page size: 7 rows on the buy tab (`BRP:68`). `page_count = max(1, ceil(total / 7))`. The page control enables previous when `page > 1` and next when `page < page_count` (`PCC:49-71`).
- B2 Visible listings: status active, not expired, and visible (listing delay, see [settlement.md](settlement.md) rule T8). Assumption: the seller's own listings are included (the client blocks bidding on them with "Não pode dar lance em item próprio").
- B3 Name filter: case insensitive substring on the template name (pt-BR). For Einherjar listings match the pet template name (`ALD:96-107`).
- B4 Level filter: equipment and items use template `NeedGrades`; Einherjar use the pet level (`ALD:83-94`).
- B5 Sorting: level -> `NeedGrades` or pet grade; time -> `expires_at`; current price -> `point`; buyout -> `fix_point`. Default order when `order_by = 0`: newest first (assumption).
- B6 The client UI does not restrict the buy tab by level except the Einherjar category (level 50, `CP:121-125`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | `ItemTempInfo` | `TemplateId`, `TemplateName` (name filter), `MasterType`, `SonType` (category), `NeedGrades` (level filter and sort), `Profile` (quality), `Job` (class), `StartingPrice` (see [listing.md](listing.md)) |
| `index/language.json` key `AuctionCategoryPane.xml` | category XML | `Menu@Type`, `MenuItem@Type`, `MenuName` |
| `raw/xml/tempinfos/MapNodeInfos.xml` | space nodes | `Param3` dialog options `type,title,level`; type 5 = auction (none shipped) |

No auction specific template exists.

## 7. Persistent state

Read only over `auction.listing` (defined in [listing.md](listing.md)). Search indexes:

```sql
CREATE INDEX listing_search_idx ON auction.listing (status, master_type, son_type, need_grade);
CREATE INDEX listing_quality_idx ON auction.listing (status, quality);
CREATE INDEX listing_expires_idx ON auction.listing (status, expires_at);
CREATE INDEX listing_name_trgm_idx ON auction.listing USING gin (lower(item_name) gin_trgm_ops);
```

The trigram index needs `CREATE EXTENSION IF NOT EXISTS pg_trgm;`. `item_name`, `master_type`, `son_type`, `need_grade`, `quality`, `job` are denormalized from the template at listing time so the search needs no join.

## 8. Backend implementation notes

- `auction::browse::handle_search` (8457): validate `page >= 1` (clamp), `order_by in 0..4`, `order_type in 0..2`; level 40 gate (reply 4359 empty, assumption: the client has no receiver for an error code here); build one SQL query with optional predicates; `LIMIT 7 OFFSET (page-1)*7`; second query `count(*)` for `page_count`; if `page > page_count` return the last page. Encode `MallItemMsg` from the listing row and its `item_snapshot`.
- `auction::browse::handle_player_items` (8450): same as an empty search, reply 4354.
- Read only, no transaction needed (use `REPEATABLE READ` for count and page consistency).
- No pushes to other players. Listing changes from other players are seen on the next request.

## 9. Open questions and assumptions

- Assumption: `order_type` 2 = descending, 1 = ascending.
- Assumption: `usable` = level and class fit.
- Assumption: the seller sees and can search his own listings.
- Open: entry point. No shipped `MapNodeInfos` row has dialog option 5, and the Mercado hub (`auction.SupermarketFrame`) is never opened. A decision is needed: add option `5,Leilão,40` to a space NPC (data change in `raw/xml/tempinfos/MapNodeInfos.xml`) or open `supermarket` from castle building 1506. The client code supports both without changes.
- Open: `from` (#3) meaning of `MallItemViewReqMsg` for 8450.

## 10. Implementation checklist

- [ ] Screen: AuctionFrame buy tab renders 7 rows, categories, combos, hot searches
- [ ] Route 8457 `C_MALL_SEARCH` with all 11 fields
- [ ] Route 8450 `C_MALL_PLAYER_ITEMS` (unused by the client, implemented for completeness)
- [ ] Server message 4359 `AuctionItemsMsg.sellItem` with valid `item_info.user_id`, `count`, `start_time`
- [ ] Server message 4354
- [ ] Denormalized search columns and indexes on `auction.listing`
- [ ] Rules B1..B6
- [ ] Entry point decision (space NPC option 5 or Mercado hub)
- [ ] Test: search by name, by category and child, by level, quality, class, usable
- [ ] Test: sort by each column both directions, paging beyond the last page
- [ ] Test: Einherjar listing renders name and level from `property1`
