# System auction event ("Evento do Leilão")

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/managers/SaleManager.as` |
| SMO | `decompiled/core_module/scripts/mvc/module/sale/SaleModel.as` |
| SD | `decompiled/core_module/scripts/mvc/module/sale/SaleData.as` |
| SCT | `decompiled/core_module/scripts/mvc/controler/SaleControler.as` |
| SF | `decompiled/m11/scripts/sale/SaleFrame.as` |
| SIV | `decompiled/m11/scripts/sale/SaleItemView.as` |
| SRV | `decompiled/m11/scripts/sale/SaleRightView.as` |
| CBF | `decompiled/m11/scripts/sale/ConfirmBidFrame.as` |
| SSF | `decompiled/m11/scripts/sale/SaleStorageFrame.as` |
| SBV | `decompiled/m11/scripts/sale/SaleBagView.as` |
| SBC | `decompiled/core_module/scripts/cell/view/sale/SaleBagCell.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |

## 1. Overview

A timed server event ("Sistema do Leilão", Chinese "系统拍卖") that sells system owned lots for diamonds. The window shows 5 lot slots, a daily special item on the right ("Itens valorosos diários") and a scrolling list of lucky player notices. Each lot can be an auction lot (bids, `startPoint > 0`), a fixed price lot (`fixPoint > 0`) or both. A lot ends when its timer reaches 0 or when someone pays the fixed price; the slot is then refilled with the next lot (the client flips the card with an animation when the `auctionId` of a slot changes, `SIV:169-192`). Purchases are delivered by mail and outbid bids are refunded by mail (help text `sale.helpFrame.helpContent`).

Help text (pt-BR, verbatim summary of `sale.helpFrame.helpContent`): lots are auction or fixed price; the highest bidder at the end gets the item; outbid diamonds are refunded by email; valuable items appear at random times; the bid step is 10% of the current price; purchases are sent by email.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `sale.SaleFrame` (`SF`) | "Evento do Leilão" (`SaleFrame.title`) | Column headers "Item", "Nome", "Tempo Restante", "Leiloar/Preço Fixo"; 5 `SaleItemView` rows; event countdown "Contagem do evento:" + time (`SF:92-111`, `:152-176`); help button | `SaleControler.showFrame` (`SCT:25-30`) sends op 2 first | `model.items`, `model.specialItem`, `model.leftSecond` |
| `SaleItemView` (`SIV`) | lot row | Icon with count, name, time left ("Menos de 1 min", "N min", "N h"; red under 60 s), current price, fixed price, "valuable" badge when `auctionId == specialId`, bid button (hidden when the player is the current bidder or `startPoint == 0`), fixed price button (when `fixPoint != 0`) (`SIV:194-239`) | SaleFrame | `SaleData` |
| `SaleRightView` (`SRV`) | "Itens valorosos diários" | Special item icon, name (truncated to 14 chars + "..."), "Preço Fixo:" value (`SRV:98-125`); preview button; lucky notices rendered as chat cells, channel 103 (`SRV:127-160`) | SaleFrame | `model.specialItem`, `model.luckShowInfo` |
| `ConfirmBidFrame` (`CBF`) | "Aviso" | openType 1 bid: input (max 8 digits), "O meu preço:", hint "Se fizer leilão de {0} diamantes ou inferior, irá fracassar."; openType 2 fixed: "Você deseja comprar {1} com {0} diamantes?" (`CBF:187-215`) | bid or fixed price button of a row (`SIV:287-304`) | lot |
| `SaleStorageFrame` (`SSF`) | "Armazém do Sistema do Leilão" | 8 column grid of every lot of the event (`SBV:27-48`, virtual bag type 35); filter combo "Todos os itens", "Itens Leiloados", "Itens Preço Fixo", "Itens Leiloados" (`SSF:111-135`); detail "Item:\nTempo:\nPreço inicial:\nPreço Fixo:" on click (`SSF:157-170`) | preview button of `SRV` (`SRV:194-201`) after the 329 preview reply (`SRV:188-192`) | `model.allItems` |
| `SaleBagCell` (`SBC`) | grid cell | State label "Vendido" (`states == 1`) or "Leiloado" (`states == 3`) (`SBC:44-60`) | storage frame | |

Preview filter (`SMO:39-77`): type 1 all; 2 lots with `fixPoint == 0` (auction only); 3 lots with `startPoint == 0` (fixed price only); 4 lots whose `buyUserId == self` (combo label "Itens Leiloados" again, it means "my won lots"). Sort (`SMO:95-122`): `states` 2 before 1, then ascending `states`, then ascending `auctionId`.

## 3. Routes (client to server)

All routes use C>S 9584 (0x2570) `C_AUCTION_OP` with `AuctionItemInfoMsg` (package `auction`), operation in `op` (#11, INT32) (`SM:28-34`).

| # | Action | UI and sender | Client checks | Fields set | Expected reply |
|---|---|---|---|---|---|
| R1 | op 2 get lots | frame open: `SaleControler.showFrame` -> `SaleManager.sendGetSaleInfos` (`SCT:25-30`, `SM:92-98`) | top toolbar visible only at level 35 with the event open (`TBH:301-302`); chat link only when open (`ChatOutputViewII.as:317-325`) | `op = 2` | 329 with `auctionItemInfos`, `allItemInfos` empty (S1) |
| R2 | op 1 bid | row "Leiloar" -> `ConfirmBidFrame.show(data, 1)` -> `__confirmHandler` (`CBF:119-149`) -> `SaleManager.sendBid` (`SM:100-108`) | `price >= ceil(currentPoint * 1.1)` else tip "Não pode leiloar menos de {0} diamantes" (`CBF:136-140`, `:217-225`); a price >= `fixPoint` (when `fixPoint != 0`) is replaced by `fixPoint` (`CBF:132-135`); `playerInfo.point >= price` else recharge prompt (`CBF:142-146`) | `op = 1`, `auctionId` (#1) lot id, `buyPoint` (#7) price | 329 refreshed lots (S1), 3 diamonds |
| R3 | op 1 fixed price | row "Preço Fixo" -> `ConfirmBidFrame.show(data, 2)` | `price = fixPoint`; `point >= price` else recharge | `op = 1`, `auctionId`, `buyPoint = fixPoint` | 329, 3 |
| R4 | op 3 preview | preview button -> `SaleManager.sendPreview` (`SM:118-124`, `SRV:194-201`) | none | `op = 3` | 329 with `allItemInfos` non empty (S1) -> opens `SaleStorageFrame` |
| R5 | op 4 close window | `SaleFrame.dispose` -> `SaleManager.sendCloseWindow` (`SF:234-241`, `SM:110-116`) | none | `op = 4` | none; server stops pushing 329 to this player |

Side request when the frame is built: `FunnyManager.sendGetBag(1)` = C>S 8586 (0x218a) `C_SUMACTIVE_GATE` (`SF:56`, `decompiled/core_module/scripts/managers/FunnyManager.as:969-978`), owned by [../seasonal-events/README.md](../seasonal-events/README.md) (`FunnyManager`); it is unrelated to the lots.

`AuctionItemInfoMsg` fields (package `auction`, `protocol/proto.json`): `auctionId` (#1, INT32) lot id; `templateId` (#2, INT32) item template; `counts` (#3, INT32) quantity; `startPoint` (#4, INT32) auction start price, 0 = fixed price only; `fixPoint` (#5, INT32) fixed price, 0 = auction only; `seconds` (#6, INT32) seconds left for this lot; `buyPoint` (#7, INT32) request: offered price; reply: final price; `buyUserId` (#8, INT32) winner or buyer; `states` (#9, INT32) 0 waiting, 1 sold, 2 in auction, 3 ended without sale (Chinese labels in `SSF:159`: "正常未参与竞拍", "出售成功", "正处于竞拍", "流拍"); `currentPoint` (#10, INT32) current price; `op` (#11, INT32) operation; `index` (#12, INT32) slot 0 special, 1..5 rows; `currentBidUserId` (#13, INT32) current highest bidder.

## 4. Server messages (server to client)

### S1 329 (0x0149) U_C_AUCTION

- `AuctionItemInfoListMsg` (package `auction`): `auctionItemInfos` (#1, AuctionItemInfoMsg, repeated) the 6 visible lots (`index` 0 special, 1..5 rows); `specialAuctionId` (#2, INT32) lot id marked "valuable" in the rows; `noticeTips` (#3, STRING, repeated) not read; `allItemInfos` (#4, AuctionItemInfoMsg, repeated) all lots of the event, only in the preview reply; `leftSecond` (#5, INT32) seconds until the event ends.
- Receiver `SaleManager.__saleDataHandler` (`SM:135-204`): rebuilds `model.items` (5 slots) and `model.specialItem` from `auctionItemInfos` on every message, then dispatches `SALE_PREVIEW_LOADED` when `allItemInfos` is non empty, else `SALE_DATA` (repaints `SaleFrame`, `SF:152-163`).
- When: reply to op 2 and op 3; push to every player with the window open (op 2 received and op 4 not yet) on any lot change: bid, sale, slot refill, lot timer end. Assumption: also a periodic push every 60 s to resync `seconds` (the client does not tick lot timers by itself; `SF.__timerHandler` is empty, `SF:140-142`).
- Mandatory: always include the current `auctionItemInfos` in the preview reply, because the receiver clears `model.items` before reading.

### S2 330 (0x014a) U_C_AUCTION_STATE

- `PropertyMsg` of package `simple` (not the `army` message that `protocol/proto.json` lists under the same name; source `decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as`): `param1..param3` (#1..#3, INT32), `param4..param6` (#4..#6, STRING), `param7` (#7, BOOL), `param8`, `param9` (#8, #9, BOOL), `param10`, `param11` (#10, #11, INT32), `param12` (#12, STRING). Only `param7` is read: event open.
- Receiver `SaleManager.__saleSwitchHandler` (`SM:126-133`) -> `model.isOpen`; `SALE_SWITCH` makes the top toolbar recompute its icons (`TTB:459`).
- When: at login (after the player data) and at event start and end, to every online player.

### S3 332 (0x014c) U_C_AUCTION_NOTIC

- `BottlePassMsg` (package `item`): `pass_type` (#1, INT32) not read, `infos` (#2, STRING, repeated) notice lines in chat markup (rendered with `ChatFormat.getContentCellData`, channel 103), `count` (#3) and `dropId` (#4) not read.
- Receiver `SaleManager.__saleNoticHandler` (`SM:83-90`) -> `model.luckShowInfo` -> `SaleRightView` list (newest on top).
- When: after every sale (winner announcement) to players with the window open, and with the reply to op 2 (assumption).

Errors: the client has no error receiver for 9584. On a rejected bid the server should push 329 again (fresh prices) and may use the generic system tip message of the chat module (open question).

## 5. Rules and formulas

- E1 Unlock: level 35 and event open (`TBH:301-302`). Server rejects ops 1 to 3 below level 35 or when closed.
- E2 Bid step: minimum bid = `ceil(currentPoint * 11 / 10)` (`CBF:217-225`). Before the first bid `currentPoint = startPoint` (assumption), so the first bid is also +10%.
- E3 A bid >= `fixPoint` (when `fixPoint != 0`) is a purchase at `fixPoint`.
- E4 Payment: non bound diamonds (`CBF:142`). Debited when the bid is placed; the previous highest bidder is refunded by mail.
- E5 Lot end: at `seconds == 0` with a bid -> `states = 1`, `buyUserId = currentBidUserId`, item mailed; without a bid -> `states = 3`. A fixed price purchase ends the lot at once with `states = 1`.
- E6 Slots: 5 active lots plus the special lot (index 0); when a lot ends the slot takes the next queued lot (`states = 0` until shown, `2` while open).
- E7 The bid button is hidden for the current highest bidder (`SIV:197`), so a player cannot outbid himself (server rejects too).
- E8 Delivery: mail with `templateId x counts` (items are created bound; the preview shows them as bound, `SMO:86`; assumption that delivered items are bound).

## 6. Templates

No client template. The lot catalog is server data (see `auction.system_lot_catalog`). Item names come from `raw/xml/tempinfos/ItemTempInfos.xml`.

## 7. Persistent state

```sql
CREATE TABLE auction.system_event (
  event_id     SERIAL       PRIMARY KEY,
  starts_at    TIMESTAMPTZ  NOT NULL,
  ends_at      TIMESTAMPTZ  NOT NULL,
  min_level    SMALLINT     NOT NULL DEFAULT 35,
  CHECK (ends_at > starts_at)
);

CREATE TABLE auction.system_lot_catalog (
  catalog_id   SERIAL    PRIMARY KEY,
  template_id  INTEGER   NOT NULL,
  counts       INTEGER   NOT NULL CHECK (counts > 0),
  start_point  INTEGER   NOT NULL DEFAULT 0 CHECK (start_point >= 0),
  fix_point    INTEGER   NOT NULL DEFAULT 0 CHECK (fix_point >= 0),
  duration_s   INTEGER   NOT NULL CHECK (duration_s > 0),
  is_special   BOOLEAN   NOT NULL DEFAULT false,
  weight       INTEGER   NOT NULL DEFAULT 1,
  CHECK (start_point > 0 OR fix_point > 0)
);

CREATE TABLE auction.system_lot (
  lot_id              SERIAL       PRIMARY KEY,
  event_id            INTEGER      NOT NULL REFERENCES auction.system_event(event_id),
  catalog_id          INTEGER      NOT NULL REFERENCES auction.system_lot_catalog(catalog_id),
  slot_index          SMALLINT     CHECK (slot_index BETWEEN 0 AND 5),
  queue_order         INTEGER      NOT NULL,
  template_id         INTEGER      NOT NULL,
  counts              INTEGER      NOT NULL,
  start_point         INTEGER      NOT NULL,
  fix_point           INTEGER      NOT NULL,
  current_point       INTEGER      NOT NULL,
  current_bidder_id   INTEGER      REFERENCES player.players(player_id),
  buyer_id            INTEGER      REFERENCES player.players(player_id),
  buy_point           INTEGER      NOT NULL DEFAULT 0,
  state               SMALLINT     NOT NULL DEFAULT 0 CHECK (state BETWEEN 0 AND 3),
  opens_at            TIMESTAMPTZ,
  ends_at             TIMESTAMPTZ
);
CREATE INDEX system_lot_event_idx ON auction.system_lot (event_id, state, queue_order);

CREATE TABLE auction.system_bid (
  bid_id      BIGSERIAL    PRIMARY KEY,
  lot_id      INTEGER      NOT NULL REFERENCES auction.system_lot(lot_id),
  player_id   BIGINT      NOT NULL REFERENCES player.players(player_id),
  amount      INTEGER      NOT NULL CHECK (amount > 0),
  refunded    BOOLEAN      NOT NULL DEFAULT false,
  created_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);
CREATE INDEX system_bid_lot_idx ON auction.system_bid (lot_id, amount DESC);

CREATE TABLE auction.system_notice (
  notice_id   BIGSERIAL    PRIMARY KEY,
  event_id    INTEGER      NOT NULL REFERENCES auction.system_event(event_id),
  text        TEXT         NOT NULL,
  created_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);
```

`specialAuctionId` = the `lot_id` of the current lot with `catalog.is_special` among the 5 rows (assumption; 0 when none).

## 8. Backend implementation notes

- `auction::system::handle_op` (9584) dispatches on `op`:
  - `auction::system::handle_get_lots` (2): event open and level >= 35, subscribe the session to the event room; reply 329 (current 6 lots, `leftSecond`), then 332 with the last notices.
  - `auction::system::handle_bid` (1): lot exists and `state = 2` -> if `fix_point > 0 and buyPoint >= fix_point` -> purchase; else `start_point > 0`, `buyPoint >= ceil(current_point * 1.1)`, bidder != `current_bidder_id`. Transaction with `FOR UPDATE` on the lot: debit diamonds, insert `system_bid`, refund the previous bid by mail, update `current_point` and `current_bidder_id`. Purchase: debit `fix_point`, close the lot (`state = 1`, `buyer_id`, `buy_point`), refund any bid, mail the item, insert a notice, refill the slot. Push 329 to the room, 332 on sale, 3 to the buyer.
  - `auction::system::handle_preview` (3): reply 329 with current lots and `allItemInfos` of the event.
  - `auction::system::handle_close` (4): unsubscribe.
- Scheduler `auction::system::tick` (every second or on the nearest `ends_at`): end lots, deliver, refill slots, push 329; open and close events and push 330 to all online players.
- Login: push 330 with `param7 = event open`.

## 9. Open questions and assumptions

- Open: lot catalog contents and event calendar (no template in this build).
- Open: error feedback for rejected ops (no client receiver).
- Assumption: first bid is +10% over `startPoint`; delivered items are bound; periodic 329 resync every 60 s.
- Assumption: `noticeTips` (#3) unused, notices go through 332.

## 10. Implementation checklist

- [ ] Screens: SaleFrame, ConfirmBidFrame, SaleStorageFrame, special item view, notices
- [ ] Route 9584 op 1 bid and fixed price
- [ ] Route 9584 op 2 get lots
- [ ] Route 9584 op 3 preview
- [ ] Route 9584 op 4 close window
- [ ] Server messages 329, 330 (`simple.PropertyMsg`), 332
- [ ] Tables `auction.system_event`, `auction.system_lot_catalog`, `auction.system_lot`, `auction.system_bid`, `auction.system_notice`
- [ ] Scheduler for lot end, slot refill, event open and close
- [ ] Rules E1..E8
- [ ] Test: bid step 10% rounding up (e.g. 105 -> 116)
- [ ] Test: fixed price purchase ends the lot and refunds the bidder
- [ ] Test: toolbar icon appears at level 35 when 330 opens the event
