# Auction and market ("Mercado e leilão")

Client packages `auction` (module m7, `decompiled/m7/scripts/auction/`) and `sale` (module m11, `decompiled/m11/scripts/sale/`), plus the shared managers in core_module (`mediator/AuctionMessageSender.as`, `mediator/AuctionMessageHandler.as`, `managers/SaleManager.as`, `managers/MysteryShopManager.as`). Protobuf package `auction` (system auction lots) and the auction messages of the packages `mall` and `simple` (player auction house, mystery shop).

The feature has three independent systems:

1. **Leilão** (player auction house, `auction.view.AuctionFrame`): players list bag items and unbound Einherjar for diamonds with a minimum bid and a buyout ("Oferta Fixa"), choose 8, 24 or 48 hours and pay a gold custody fee. Other players search by name, category, level, quality and class, bid or buy out. Purchases, refunds and expired items travel by system mail. A 20% service fee is taken from every completed sale.
2. **Evento do Leilão** (system auction event, `sale.SaleFrame`, top toolbar key `auctionsale` "Sistema do Leilão"): a timed server event that sells 5 lots plus one daily special lot ("Itens valorosos diários") for diamonds, with bids (+10% minimum step) and fixed prices.
3. **Loja Misteriosa** (mystery shop, `auction.view.mysteryshop.MysteryShopFrame`) and its hub **Mercado** (`auction.SupermarketFrame`): 6 random offers refreshed every 4 hours or for diamonds, daily purchase limit, mystery points spent in an exchange tab.

All traffic is socket based. No HTTP or AMF routes. PostgreSQL schema: `auction`. Rust handlers: `auction::<module>::handle_<action>`.

## Entry points

| Entry | Condition | Opens | Citation |
|---|---|---|---|
| Space (Reino do Céu) NPC dialog option type 5 | option level from `MapNodeInfos.Param3` (`type,title,level`) | `openControllerByInfo("auction")` -> `AuctionControl` -> `auction.AuctionFrame` | `decompiled/m3/scripts/map/space/helper/hero/SpaceArmyViewHelper.as:198-199`, `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:344-359` |
| "Leilão" button of the Mercado hub | none | same | `decompiled/m7/scripts/auction/view/supermarket/AuctionShopView.as:86-89` |
| "Loja Misteriosa" button of the Mercado hub | level 26, daily buys left | `openControllerByInfo("mysteryshop")` | `decompiled/m7/scripts/auction/view/supermarket/MysteryShopView.as:91-109` |
| Top toolbar `auctionsale` (TopToolBtnInfos 2034 "拍卖活动") | level 35, scene check, event open (push 330) | `openControllerByInfo("sale")` -> `sale.SaleFrame` | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:301-302`, `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1268-1270` |
| Chat link "open sale" | event open | `sale.SaleFrame` | `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:317-325` |
| Quest 825 "Leiloar" (condition type 56, level 26) | quest tracker | `SwitchPageHelp.gotoMarkeFrame` -> `goSpaceAndFind(8)` | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:319-320`, `:1398-1424`, `raw/xml/tempinfos/QuestCondictionInfos.xml` (TemplateId 825) |
| Castle building 1506 "Mercado" | none | `goSpaceAndFind(8)` (walks to space node 8 "Lara") | `decompiled/m4/scripts/castle/view/CastleBuildingView.as:355-357` |

Reachability in this build (verified): no `MapNodeInfos` node carries dialog option 5, and `openControllerByInfo("supermarket")` is never called (only `closeFrame`, `decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1307-1308`). The Leilão and the Loja Misteriosa therefore have no reachable UI entry with the shipped data. The space node 10 "Rona, Loja Misteriosa" opens option 100 = `outercityshop` (shops feature), not the mystery shop. See the open questions of [market-browse.md](market-browse.md) and [mystery-shop.md](mystery-shop.md).

## Modules

| Module | Content | Opcodes |
|---|---|---|
| [market-browse.md](market-browse.md) | Buy tab: search by name, category tree, level, quality, class, "usable" filter, hot searches, sort columns, paging, list item rendering, pet listings | 8457 -> 4359, 8450 -> 4354 |
| [listing.md](listing.md) | Sell tabs (items and Einherjar): which items can be listed, quantity, minimum bid, buyout, duration, custody fee, my listings, cancel | 8448 -> 4352, 8449 -> 4353, 8454 -> 4358 |
| [bidding.md](bidding.md) | Bid, buyout, "Meus lances" record tab, outbid display, result codes | 8451 -> 4355, 8453 -> 4357, 8452 -> 4356 |
| [settlement.md](settlement.md) | Server side lifecycle: escrow, outbid refunds, expiry, winner delivery, 20% fee, seller income, mails, daily purchase cap, level 40 gate | timers, mail |
| [system-auction.md](system-auction.md) | "Evento do Leilão": 5 lots plus special lot, bids, fixed price, preview storage, lucky notices, open state | 9584 -> 329, 330, 332 |
| [mystery-shop.md](mystery-shop.md) | Mercado hub, Loja Misteriosa offers, refresh, purchase, exchange tab with mystery points, event list | 8483 -> 4384, 8482 -> 4383, 4470, 8970 -> 4783 |

## Dependencies

| Feature | Why |
|---|---|
| [../inventory/README.md](../inventory/README.md) | Item taxonomy (`MasterType`, `SonType`, `Profile` quality, `NeedGrades`, `Job`), item instances, bag types 1 and 34, binding (`isBinds`) and vice password lock (`isLock`), bag push 115 `U_C_BAG_MOVE_UPDATE`. Not duplicated here |
| [../einherjar/README.md](../einherjar/README.md) | Einherjar listings: `isBind`, `isEnterWar`, `isPractice`, arena formation, remote expedition, pet push 4540 `U_C_PLAYER_PETINFO`, pet serialization in `property1` |
| [../mail/README.md](../mail/README.md) | System mail with item, pet (mail type 5 `PET_MAIL`) and diamond attachments for purchases, refunds, sale income, expired items |
| [../currency/README.md](../currency/README.md) | Diamonds (`point`), bound diamonds (`giftToken`), gold; player info push 3 `U_C_PLAYER_INFO` |
| [../shops/README.md](../shops/README.md) | Generic shop purchase 8970 `C_SHOPCAR_BUY` used by the mystery exchange tab; `outercityshop` NPC shop; `ShopTempInfos.xml` loader |
| [../sky-realm/README.md](../sky-realm/README.md) | Space scene NPC nodes and dialog options that open the auction |
| [../quests/README.md](../quests/README.md) | Quest condition 56 "Leiloar" progress on a successful listing (assumption: listing, not sale) |
| [../hero/README.md](../hero/README.md) | Daily reset 4202 `U_C_DATARESET` (`DataResetMsg.buy_count` of the mystery shop, package `player`) |
| [../chat/README.md](../chat/README.md) | Chat link that opens the system auction; notice strings rendered as chat cells |

## Suggested implementation order

1. Tables of [listing.md](listing.md), [bidding.md](bidding.md) and [settlement.md](settlement.md), item escrow helpers from the inventory module, mail attachment helpers.
2. [listing.md](listing.md): 8448, 8449, 8454.
3. [market-browse.md](market-browse.md): 8457 with filters, sorting and paging.
4. [bidding.md](bidding.md): 8451, 8453, 8452.
5. [settlement.md](settlement.md): expiry scheduler, delivery, fee, refunds, daily cap.
6. [system-auction.md](system-auction.md): event scheduler, 329/330/332, 9584.
7. [mystery-shop.md](mystery-shop.md): needs ShopType 5 and 7 rows that this build does not ship.
8. Decide and wire the entry points (space NPC option 5 or the Mercado hub).
