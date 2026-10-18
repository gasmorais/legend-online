# Bidding and buyout

Path aliases:

| Alias | File |
|---|---|
| AMS | `decompiled/core_module/scripts/mediator/AuctionMessageSender.as` |
| AMH | `decompiled/core_module/scripts/mediator/AuctionMessageHandler.as` |
| ALD | `decompiled/core_module/scripts/mvc/module/auction/AuctionListItemData.as` |
| AC | `decompiled/m7/scripts/auction/view/common/AuctionChecker.as` |
| AIF | `decompiled/m7/scripts/auction/view/common/AuctionInputFrame.as` |
| LIB | `decompiled/m7/scripts/auction/view/common/AuctionListItemBase.as` |
| LIC | `decompiled/m7/scripts/auction/view/common/AuctionListComponent.as` |
| BRP | `decompiled/m7/scripts/auction/view/buy/AuctionBuyResultPane.as` |
| RRP | `decompiled/m7/scripts/auction/view/record/AuctionRecordResultPane.as` |
| RBB | `decompiled/m7/scripts/auction/view/record/AuctionRecordBottomBar.as` |
| AF | `decompiled/m7/scripts/auction/view/AuctionFrame.as` |

## 1. Overview

A buyer places a bid ("Dar Lance") on another player's listing, or pays the buyout ("Oferta Fixa") to take it at once. All prices are diamonds (`point`, never bound diamonds: the bid input is clamped to `playerInfo.point`, `AIF:92-98`). The "Meus lances" tab lists the listings the player has bid on, greys the rows where the player was outbid and allows to rebid or buy out from there. Settlement (escrow, refunds, delivery, fees, daily cap) is in [settlement.md](settlement.md).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `AuctionBuyResultPane` (`BRP`) | buy tab result list | Select a row, then "Dar Lance" (`auction.auctionBtn`) or "Oferta Fixa" (`auction.fixedPriceBtn`); double click on a row = "Dar Lance" (`BRP:72`, `LIC:81-87`) | buy tab ([market-browse.md](market-browse.md)) | `forSaleList` |
| `AuctionInputFrame` (`AIF`) | "Dar Lance" (`Auction.AuctionTitle`) | Numeric input, digits only, max 9 chars, value capped to the diamond balance; warm text "Insira valor do lance" (`AIF:60-81`, `:92-98`) | "Dar Lance" on the buy or record tab | |
| `auction.view.AuctionRecordPane` / `AuctionRecordResultPane` (`RRP`) | records tab | 9 rows of `AuctionListItem2` (`RRP:74`), sortable columns sent to the server (`RRP:115-141`), pager (`RRP:148-163`), "Dar Lance" and "Oferta Fixa" (`RBB:35-54`) | top bar records button (`AF:177-188`) | `recordList`; each row shows the player's own bid as `selfPrice` |
| `AuctionListItem2` | record row | Whole row tip "Outro jogador já deu lance mais alto nesse item" and grey filter when `selfPrice < currPrice` (`LIB:165-177`) | records tab | |

## 3. Routes (client to server)

### R1 Bid (C_MALL_AUCTION)

- UI: select a row, "Dar Lance" or double click -> `AuctionBuyResultPane.auction` (`BRP:111-129`) or `AuctionRecordResultPane.onAuction` (`RRP:171-189`) -> `AuctionInputFrame` -> confirm -> `inputPriceCallback(bid)` (`BRP:131-172`, `RRP:191-224`) -> `AuctionMessageSender.sendAuctionGoods(listingId, bid)` (`AMS:54-61`).
- Client checks:
  - no row selected: "Selecione item" (`Auction.PleaseSelectGood`);
  - own listing (`item_info.user_id == self`): tip "Não pode dar lance em item próprio" (`AC:16-24`);
  - empty input: alert "Insira valor do lance" and nothing is sent (`AIF:127-135`);
  - input above the diamond balance is rewritten to the balance (`AIF:92-98`);
  - buy tab only: `bid == currPrice` and the listing has no bid (`auctioned` false) -> sent as is (first bid may equal the minimum) (`BRP:142-149`);
  - `bid <= currPrice` -> alert "Lance precisa ser maior que o lance atual, insira novamete" (`Action.UnderCurrentPrice`), nothing sent (`BRP:150-158`, `RRP:202-210`);
  - `bid >= fixedPrice` -> confirm "Seu lance é maior que oferta fixa, comprar item no valor da oferta fixa?" (`Action.OuterFixedPrice`); on confirm it sends R2 with `point = fixedPrice` (`BRP:159-167`, `:174-180`);
  - else send R1.
- Route: C>S 8451 (0x2103) `C_MALL_AUCTION`; `AuctionItemReqMsg` (package `mall`): `id` (#1, INT32) listing id, `point` (#2, INT32) bid in diamonds.
- Expected replies: 4355 `U_C_MALL_AUCTION` (S1), then 3 `U_C_PLAYER_INFO` (diamonds after escrow). The previous highest bidder receives a refund mail ([settlement.md](settlement.md)).

### R2 Buyout (C_MALL_FIX_AUCTION)

- UI: select a row, "Oferta Fixa" -> own check "Não pode dar lance em item próprio" (`AC:26-34`) -> confirm "Comprar item com valor da oferta fixa?" (`Auction.FixedPriceBuy`) -> `fixedPriceBuy` (`BRP:182-215`, `RRP:234-267`) -> `AuctionMessageSender.sendFixPriceItemMessage(listingId, fixedPrice)` (`AMS:75-82`). Also reached from R1 when the bid reaches the buyout.
- Client checks: row selected, not own listing. No balance check (server answers -11 and the client opens the recharge prompt).
- Route: C>S 8453 (0x2105) `C_MALL_FIX_AUCTION`; `AuctionItemReqMsg`: `id` (#1, INT32) listing id, `point` (#2, INT32) the buyout price shown to the client (server must compare it with `fix_point`, -5 on mismatch).
- Expected replies: 4357 `U_C_MALL_FIX_AUCTION` (S2), then 3. The item arrives by mail.

### R3 My bids (C_MALL_LIST_AUCTION)

- UI: records tab open (`AF:186-187`), column title click (`RRP:115-141`), refresh after -2/-4 (`RRP:143-146`, `AMH:180-183`), previous and next page (`RRP:148-163`).
- Sender: `AuctionMessageSender.sendMyAuctionListHistoryReq(page, 9, 1, orderBy, orderType)` (`AMS:63-73`).
- Route: C>S 8452 (0x2104) `C_MALL_LIST_AUCTION`; `MallItemViewReqMsg`: `page` (#1, INT32), `count` (#2, INT32) = 9, `from` (#3, INT32) = 1, `order_by` (#4, INT32) 1 level, 2 time, 3 current price, 4 buyout, `order_type` (#5, INT32) 2 first click, 1 second click (same mapping as [market-browse.md](market-browse.md)).
- Expected response: 4356 `U_C_MALL_LIST_AUCTION` (S3).

## 4. Server messages (server to client)

### S1 4355 (0x1103) U_C_MALL_AUCTION

- `AuctionItemRspMsg` (package `simple`): `result` (#1, INT32); `item_buy` (#2, MallItemBuyMsg).
- `MallItemBuyMsg`: `id` (#1, INT32) bid id; `user_id` (#2, INT32) bidder; `mall_item` (#3, MallItemMsg) the listing after the bid (`point` = new current price, `max_auction_id` = this bid id); `bidup_point` (#4, INT32) the caller's bid; `buy_time` (#5, STRING `YYYY-MM-DD hh:mm:ss`).
- Receiver `AuctionMessageHandler.auctionResultHandler` (`AMH:141-186`): `result == 0` updates `selfPrice`, `currPrice`, `auctioned` of the row in `forSaleList` and in `recordList`. `-11` opens the recharge prompt (`RechargeAlertMannager.show`). Other codes: alert "Aviso" + `Auction.ResultAlert<abs(result)>`; for -4 and -2 the current tab is reloaded (buy tab repeats the search, records tab repeats R3).
- When: response to R1.

### S2 4357 (0x1105) U_C_MALL_FIX_AUCTION

- `FixAuctionItemRspMsg` (package `mall`): `result` (#1, INT32); `mall_item_id` (#2, INT32) listing id.
- Receiver `AuctionMessageHandler.onFixPriceResult` (`AMH:188-226`): `result == 0` removes the row from `forSaleList` and `recordList`. `-11` recharge prompt; others alert, -4/-2 reload.
- When: response to R2.

### S3 4356 (0x1104) U_C_MALL_LIST_AUCTION

- `AuctionItemsMsg`: `page_idx` (#1), `page_count` (#2), `itemBuy` (#3, repeated MallItemBuyMsg) one entry per listing the caller bid on, with `mall_item` the current listing and `bidup_point` the caller's latest bid; `sellItem` (#4) empty.
- Receiver `AuctionMessageHandler.onLookupMyAuctionResult` (`AMH:93-112`): `selfPrice = bidup_point` -> `recordList.update`.
- When: response to R3.

Result codes: see [listing.md](listing.md) section 4. Codes produced here: 0, -2, -4, -5, -11, -13, -14, -16, -17, -51, -52.

## 5. Rules and formulas

- P1 Valid bid: listing active and visible, not expired, bidder is not the seller (-16 for buyout, assumption -16 for bids too), bidder is not already the highest bidder (-17). If the listing has no bid: `bid >= current_point`; else `bid > current_point` (-4). Minimum increment: 1 diamond (assumption; the client only requires "greater than").
- P2 Bid at or above buyout: treat as a buyout at `fix_point` (assumption; the client never sends it because it converts to R2).
- P3 Buyout: `point == fix_point` (-5 otherwise); closes the listing immediately.
- P4 Currency: non bound diamonds only (`AIF:92-98`). Insufficient -> -11.
- P5 Daily purchase cap and level gate: [settlement.md](settlement.md) T5, T6 (-52, -51).
- P6 Escrow: the full bid is debited when placed; when outbid the previous bid is refunded in full by system mail ([settlement.md](settlement.md) T2).
- P7 Records list: active listings where the player has a bid, newest bid first by default; closed listings drop out (assumption: the result is communicated by mail only).

## 6. Templates

None. Prices come from the listing.

## 7. Persistent state

```sql
CREATE TABLE auction.bid (
  bid_id        BIGSERIAL    PRIMARY KEY,
  listing_id    BIGINT       NOT NULL REFERENCES auction.listing(listing_id),
  bidder_id     INTEGER      NOT NULL REFERENCES player.players(player_id),
  amount        INTEGER      NOT NULL CHECK (amount > 0),
  status        SMALLINT     NOT NULL DEFAULT 0,
  created_at    TIMESTAMPTZ  NOT NULL DEFAULT now(),
  resolved_at   TIMESTAMPTZ
);
CREATE INDEX bid_listing_idx ON auction.bid (listing_id, amount DESC);
CREATE INDEX bid_bidder_idx ON auction.bid (bidder_id, status, created_at DESC);
CREATE UNIQUE INDEX bid_one_active_uq ON auction.bid (listing_id) WHERE status = 0;

ALTER TABLE auction.listing
  ADD CONSTRAINT listing_highest_bid_fk FOREIGN KEY (highest_bid_id) REFERENCES auction.bid(bid_id);
```

- `status`: 0 highest (escrow held), 1 outbid and refunded, 2 won, 3 refunded because the listing was closed by buyout.

## 8. Backend implementation notes

- `auction::bidding::handle_bid` (8451). Validation order: level >= 40 (-51) -> listing exists, active, visible, not expired (-2) -> not seller (-16) -> not current highest bidder (-17) -> amount rule P1 (-4) -> amount >= `fix_point` -> delegate to buyout (P2) -> daily cap (-52) -> diamonds >= amount (-11). Transaction (`SELECT ... FOR UPDATE` on the listing): debit diamonds, insert bid status 0, previous highest bid -> status 1 and enqueue a refund mail, update `listing.current_point` and `highest_bid_id`, add to the daily cap counter. Reply 4355 with the updated listing, then 3. Any unexpected failure -> -13.
- `auction::bidding::handle_buyout` (8453). Validation: level (-51) -> listing active (-2) -> not seller (-16) -> `point == fix_point` (-5) -> daily cap (-52) -> diamonds (-11). Transaction: debit diamonds, close the listing with `status = 2`, refund the current highest bid (status 3), create the delivery mail to the buyer and the income mail to the seller ([settlement.md](settlement.md)). Reply 4357, then 3. Unexpected failure -> -14.
- `auction::bidding::handle_list_bids` (8452): distinct active listings with a bid of the caller, latest bid amount as `bidup_point`, page size 9, sort per `order_by`/`order_type`. Reply 4356.
- Concurrency: bids and buyouts serialize on the listing row lock; the expiry job takes the same lock.
- No push to the outbid player (the client has no receiver); the refund mail notifies him through the mail module.

## 9. Open questions and assumptions

- Assumption: bids are escrowed at once and refunded by mail when outbid (the player auction help does not say it; the system auction help does).
- Assumption: self bid on own listing returns -16.
- Assumption: minimum increment 1 diamond.
- Open: should a bidder who is outbid see the listing in "Meus lances" until it closes (current design: yes, greyed by the client because `selfPrice < currPrice`).

## 10. Implementation checklist

- [ ] Screen: bid input frame, buy tab buttons, records tab with pager and sort
- [ ] Route 8451 `C_MALL_AUCTION`
- [ ] Route 8453 `C_MALL_FIX_AUCTION`
- [ ] Route 8452 `C_MALL_LIST_AUCTION`
- [ ] Server messages 4355, 4357, 4356
- [ ] Table `auction.bid` and FK from `auction.listing`
- [ ] Rules P1..P7
- [ ] Test: first bid equal to minimum accepted; second equal bid rejected (-4)
- [ ] Test: outbid refund mail; rebid by the outbid player
- [ ] Test: buyout closes the listing and refunds the highest bidder
- [ ] Test: insufficient diamonds opens recharge (-11)
- [ ] Test: concurrent bids on the same listing serialize correctly
