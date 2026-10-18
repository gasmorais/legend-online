# Market stalls ("Barraca", item messages `MarketOpMsg`, `MarketMsg`, `StallMsg`)

Module of [README.md](README.md). Player stalls on the market map (map id 5801): a player sets up a stall at his position, puts up to 12 bag items or Einherjar for sale at a diamond price, opens the stall under a name, and other players on the map browse and buy. The messages are in the `item` proto package; the map scene belongs to the campaign/map code (`map.campaign`), which no feature package claims. Auction house sales are in [../auction/README.md](../auction/README.md).

Path aliases:

| Alias | File |
|---|---|
| MKM | `decompiled/core_module/scripts/map/campaign/data/MarketModel.as` |
| SI | `decompiled/core_module/scripts/map/campaign/data/StallInfo.as` |
| CSM | `decompiled/m3/scripts/map/campaign/CampaignSocketManger.as` |
| MMED | `decompiled/m3/scripts/map/campaign/mediator/market/MarketMediator.as` |
| MSF | `decompiled/m3/scripts/map/campaign/view/market/MarketSellFrame.as` |
| MBF | `decompiled/m3/scripts/map/campaign/view/market/MarketBagFrame.as` |
| MBLV | `decompiled/m3/scripts/map/campaign/view/market/MarketBagListView.as` |
| MBAF | `decompiled/m3/scripts/map/campaign/view/market/MarketBuyAlertFrame.as` |
| MSAF | `decompiled/core_module/scripts/cell/mediator/marketbag/MarketSellAlertFrame.as` |
| MBCD | `decompiled/core_module/scripts/cell/mediator/marketbag/MarketBagCellDropMediator.as` |
| MBCC | `decompiled/core_module/scripts/cell/mediator/marketbag/MarketBagCellClickMediator.as` |
| WBH | `decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as` |

## 1. Overview

- Only on the market map: `WBH.checkMarket(mapId) = mapId == 5801` (`WBH:300-303`); the map creates a `MarketModel` (`decompiled/core_module/scripts/map/campaign/CampaignManager.as:196-199`) and registers `MarketMediator` (`decompiled/m3/scripts/map/campaign/view/CampaignMapView.as:347-350`).
- Hero level >= 40 ("Nível baixo, função habilitada no Nv. {0}", `MMED:44`, `MMED:99-116`).
- Stall state (`StallInfo.state`): 0 none, 1 being arranged (position locked, items can be added), 2 selling. Leaving the map is blocked while the state is not 0 ("Arrumando barraca", `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1758-1762`).
- Stall slots: 12 (`pos < 12`, `CSM:688-691`); items in a stall live in bag type 32 (`BagType.MARKET`).
- Only unbound items of bag 1 are listed for sale (`MBLV:67`, `:138`, `:163`, `:182`); locked items cannot be sold (`vicepassword.description10`).
- Prices are in diamonds (`point`); the buyer needs `point >= price` (`MBAF:166-180`).

## 2. Screens

| Class | pt-BR title | Purpose |
|---|---|---|
| Sell button (`MarketMediator.sellbtn`) | | start arranging a stall at the current position (`MMED:92-117`) |
| `market.MarketBagFrame` | "Mochila" (`Auction.BagTitle`) | own bag (sellable items) next to the stall; closing ends the stall (`MBF:150-158`) |
| `market.MarketSellFrame` | stall name or "Barraca" (`market.MarketSellFrame.titleTxt`) | 12 stall slots, name input ("Clique para mudar o nome da barraca.", default "Barraca de {0}"), sell button, cancel ("Deseja cancelar barraca?"), "Clique para vender Einherjar" (`MSF:85-117`, `MSF:300-400`) |
| `market.MarketPetView` | "Selecione Einherjar à venda" | choose an Einherjar to sell |
| `cell.mediator.marketbag.MarketSellAlertFrame` | "Vender" | count and price for one item (`MSAF:121-188`) |
| `market.MarketBuyFrame` | stall name | another player's stall (12 items) |
| `market.MarketBuyAlertFrame` | "Comprar", "Deseja comprar:", "Preço: {0}" | buy confirmation (`MBAF:63-180`) |
| Map army view `MarketArmyView` | stall name above the hero | click a selling hero to browse (`decompiled/m3/scripts/map/campaign/view/physics/MarketArmyView.as:323`, `decompiled/m3/scripts/map/campaign/helper/hero/CampaignArmyViewHelper.as:69`) |

## 3. Routes (client to server)

All: C>S 8969 (0x2309) `C_MARKET_OP`, message `item.MarketOpMsg`: `op_type` (#1, INT32), `stall` (#2, MESSAGE `StallMsg`), `param1` (#3, INT32), `param2` (#4, INT32), `param3` (#5, INT32), `param4` (#6, INT32), `param5` (#7, STRING), `param6` (#8, BOOL). Senders in `MKM:51-139`; op constants `MKM:5-12`.

| Op | Constant | Action | Fields | Client checks | Sender |
|---:|---|---|---|---|---|
| 1 | `LOCK_POS` | start arranging at the hero position | `stall.x_pos` (#4), `stall.y_pos` (#5) | level >= 40, state 0 ("Arrumando barraca" otherwise) | `MMED:92-117` |
| 2 | `ADD_GOODS` | put an item on the stall | `param1` bag slot, `param2` stall slot 0..11, `param3` count, `param4` total price, `param6` false | unbound bag 1 item, not locked; target slot empty ("Este local já tem itens", `MBCD:62-75`) or first free ("Mochila de vendas cheia", `MBCC:50-62`); count 1..stack; price clamped to `[max(2, StartingPrice * count), 9 999 999]` (`MSAF:121-152`) | `MSAF:174-188` |
| 2 | `ADD_GOODS` (pet) | put an Einherjar on the stall | `param1` pet id, `param2` stall slot, `param4` price, `param6` true | pet not locked | `MSAF:185` |
| 3 | `BUY_GOODS` | buy an item | `param1` seller user id, `param2` stall slot, `param3` count, `param5` stall uid | `point >= price` else recharge prompt | `MBAF:166-180` |
| 4 | `CANCLE_GOODS` | take an item back to the bag | `param1` stall slot, `param2` count | stall not selling for double click (`MBCC:64-70`) | `MBCD:77-83`, `MBCC:69` |
| 5 | `BEGIN_SELL` | open the stall | `param5` stall name | name <= 24 characters (`MSF:300-309`); HTTP name check `GET {REQUEST_PATH}nicknamecheck?nickname=<name>&type=3&rnd=<r>` must return `<... value="true">` else its `message` (`MSF:356-399`); at least one item ("Neste momento a coluna de vendas não tem itens"); state 1 ("Estado atual não pode fazer barraca.") | `MSF:392` |
| 6 | `LOOK_UP` | view a stall | `param1` user id | | `MarketArmyView.as:323`, `CampaignArmyViewHelper.as:69` |
| 6 (sic) | rename | `param5` new name | | `MKM.reNameStall`, no caller (the constant `RENAME = 8` is not used) | |
| 7 | `END_SELL` | close the stall | | confirm when selling | `MSF:337-343`, `MBF:150-158` |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | Meaning |
|---|---|---|---|
| 4781 (0x12ad) `U_C_MARKET_OP_BACK` | `item.MarketOpMsg`: `op_type` echo; `stall` (`StallMsg`) the affected stall when present; `param6` success | `CSM.__marketOpbackHandler` (`CSM:629-704`, listener `CSM:388`): updates `MarketModel.stalls[userId]` (state, uid, name, position, items with `pos < 12`, `marketPrice = point`), updates the hero `sellState` and `stallName`, notifies `CampaignEvent.MARKET_OPBACK`: op 1 success opens `MarketBagFrame`, op 6 success opens `MarketBuyFrame` (`MMED:119-169`) | answer to every op |
| 4782 (0x12ae) `U_C_MARKET_SEND` | `item.MarketMsg`: `stalls` (#1, repeated `StallMsg`), `userId` (#2, INT32, repeated) | `CSM.__marketInfoHandler` (`CSM:706-810`, listener `CSM:389`): replaces the stall list; stalls absent from the list are removed and their heroes reset to state 0 | push to everyone on map 5801 when any stall changes (state, name, position) and on map entry |
| 115 | slot updates of bag 1 and bag 32 | `GM.__bagUpdateHandler` | after ops 2, 3, 4, 7 |
| 3 | `point` for buyer and seller | | after op 3 |

`item.StallMsg`: `userId` (#1, INT32), `state` (#2, INT32) 0/1/2, `name` (#3, STRING), `x_pos` (#4, INT32), `y_pos` (#5, INT32), `items` (#6, MESSAGE `StallItemMsg`, repeated), `uid` (#7, STRING) stall instance id. `item.StallItemMsg`: `point` (#1, INT32) price in diamonds, `money` (#2, INT32) unused by the client, `item_info` (#3, MESSAGE `item.ItemInfoMsg`; `pos` = stall slot, `property1` = pet data for Einherjar).

## 5. Rules and formulas

- Price per listing: total price for the listed count, `max(2, StartingPrice * count) <= price <= 9 999 999` diamonds.
- Buying transfers diamonds from buyer to seller (tax unknown, assumption 0) and the item (or pet) to the buyer's bag; buying a partial count of a listing is not offered by the client (`count` = listing count).
- Items must be unbound, unlocked, in bag 1; they move to bag 32 while listed; ending the stall returns unsold items to bag 1 (assumption).
- Leaving the map or logging out closes the stall (assumption).

## 6. Templates

`ItemTempInfos.xml`: `StartingPrice` (minimum unit price). No market template.

## 7. Persistent state

Stalls are session state on one map instance; persistence is not required. Items listed stay `inventory.items` rows with `bag_type = 32` (positions 0..11). Audit of sales:

```sql
CREATE TABLE inventory.market_sales (
  sale_id      BIGSERIAL   PRIMARY KEY,
  seller_id    INTEGER     NOT NULL REFERENCES player.players(player_id),
  buyer_id     INTEGER     NOT NULL REFERENCES player.players(player_id),
  item_id      BIGINT,
  pet_id       INTEGER,
  template_id  INTEGER,
  count        INTEGER     NOT NULL CHECK (count > 0),
  price_points INTEGER     NOT NULL CHECK (price_points >= 2),
  sold_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK ((item_id IS NULL) <> (pet_id IS NULL))
);
CREATE INDEX market_sales_seller_idx ON inventory.market_sales (seller_id, sold_at DESC);
```

## 8. Backend implementation notes

- `inventory::market::handle_op` (8969) on map 5801 only; in memory `HashMap<map_instance, HashMap<user_id, Stall>>`.
- Op 1: level, state 0, position on map -> state 1 -> reply 4781 with the stall -> broadcast 4782.
- Op 2: state 1 or 2 (assumption 1 only), slot free, item rules, price range -> move item to bag 32 slot (115) -> reply 4781.
- Op 3: seller state 2, listing exists, buyer diamonds -> transaction: debit buyer, credit seller, move the row to the buyer (bag 1, first free slot, ownership change) -> 115 to both, 3 to both, 4781 to buyer and seller, 4782 broadcast.
- Op 4: return the listing to bag 1 (115), reply 4781.
- Op 5: state 1, at least one listing, name validated (same rules as the HTTP check) -> state 2 -> 4781, 4782.
- Op 6: reply 4781 with the target stall (`param6` = exists).
- Op 7: return listings, state 0 -> 4781, 4782.
- The HTTP `nicknamecheck` endpoint with `type = 3` (stall names) must exist on the web server (see `routes/routes.md`).

## 9. Open questions and assumptions

- Sales tax and whether `money` (#2) represents a gold price option.
- Whether stalls persist across disconnects.
- Op 6 is reused for rename in `MKM.reNameStall` (no caller).

## 10. Implementation checklist

- [ ] Route 8969 ops 1..7
- [ ] Pushes 4781 and 4782 (broadcast on map 5801)
- [ ] Bag 32 handling and item ownership transfer
- [ ] HTTP `nicknamecheck` type 3
- [ ] Table `inventory.market_sales`
- [ ] Tests: bound item refused, price bounds, buyer without diamonds, end stall returns items
