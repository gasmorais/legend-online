# Personal storage: treasure bag ("Bolsa de tesouro", bag 34)

Module of [README.md](README.md). The only personal storage separate from the main bag in this client: the treasure bag (`BagType.STONE_BAG = 34`), bought once with diamonds, 280 slots, meant for gems, crystals, divine souls and agates. It is the second tab of the bag in the hero frame. The guild warehouse (bag 6) is documented in [../guild/warehouse.md](../guild/warehouse.md); the rented temporary pages of the main bag in [bag.md](bag.md) B5. The proto package `storehouse` is unrelated (Theseus challenge, see [thess-box.md](thess-box.md)).

Path aliases:

| Alias | File |
|---|---|
| AF | `decompiled/m5/scripts/armyII/ArmyFrameII.as` |
| SB | `decompiled/core_module/scripts/bag/view/StoreBag.as` |
| SBSV | `decompiled/core_module/scripts/bag/view/StoreBagStateView.as` |
| EB | `decompiled/core_module/scripts/bag/view/EquipBagII.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| PBD | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellDropMediator.as` |
| PEBD | `decompiled/core_module/scripts/cell/mediator/playerequip/PlayerEquipBagCellDropMediator.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |

## 1. Overview

- Locked until purchased: the tab shows `StoreBagStateView` with an open button; buying costs `Buy_StoneBag = 1000` diamonds (bound diamonds may be used first) and is permanent ("Deseja consumir {0} diamantes para obter permanentemente a bolsa de tesouro? (A bolsa de tesouro pode armazenar gemas, cristais, almas divinas, ágatas), pode usar diamantes vinculados para comprar.").
- Once active (`PlayerMsg.stoneBagCount > 0`), the tab shows `StoreBag`: 7 x 8 grid, 5 pages of 56 = 280 slots (`GM:659-681`).
- Deposit and withdraw are ordinary moves (5005) between bag 1 and bag 34 (drag on a cell or on a page button while the tab is active). Arrange works per bag (8220 with `bagType = 34`). Items in bag 34 count as owned for costs and gem operations (`GM.getBagCountInPlayerAndStoneByTempId`, `GM:518-529`; smith gem inlay sends bag 34 when active, `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellDropMediator.as:66-115`).
- Main bag arrange puts the treasure types last when the treasure bag is active; after purchase the client re-arranges bag 1 (`EB:45-48`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data |
|---|---|---|---|---|
| Tab buttons `army.BagStroeBagBtn` / `army.BagStroeStroeBtn` (`AF:206-207`, group `AF:293-296`) | bag / treasure bag | switch the right panel (`AF:493-535`): treasure tab hides page button 6, disables the sort button, and when not purchased disables the page buttons and shows the purchase view | hero frame "Equipamentos" | |
| `bag.view.StoreBagStateView` (extends `RentalBagStateView`) | lock overlay with open button (`SBSV:33-45`) | purchase confirmation (`SBSV:56-75`) | treasure tab when `stoneBagCount <= 0` | price from config |
| `bag.view.StoreBag` (`SB:14-21`, 7 x 8, 6 page objects, `AF:314-317`) | | bag 34 grid (cells `army.HeroBagItemView`, unlocked), arrange (`SB:45-109`) | treasure tab when active (`AF:553-566` on `STORE_BAG_COUNT_CHANGE`) | `GM.getStroeBagList()` (`GM:439-450`) |

## 3. Routes (client to server)

### T1. Buy the treasure bag

- UI: open button of `StoreBagStateView` -> alert with bound diamond checkbox (`USEBINDPOINT_ALERT`, price 1000) (`SBSV:56-67`).
- Client path: `SSM.buyStoreBag(useBind)` (`SSM:612-625`).
- Route: C>S 9569 (0x2561) `C_STONEBAG_BUY`; request `player.PayTypeMsg`: `payType` (#1, INT32) 0 = bound diamonds first, 1 = diamonds only; other fields unset.
- Response, in order: 3 `U_C_PLAYER_INFO` with `stoneBagCount` (#125, INT32) > 0 and new `point` / `giftToken` (`PM:1152-1160` fires `STORE_BAG_COUNT_CHANGE`, the hero frame swaps the view, `AF:553-566`); then 276 (S1).

### T2. Deposit (bag 1 -> bag 34) and withdraw (bag 34 -> bag 1)

- UI: drag a cell onto a cell of the other bag, or onto a page button while the matching tab is shown (`PBD:116-174`: target bag = 34 when the frame `currentIndex == 1`, first free slot by `GM.findEmputyPosByPageAndBagType(page, 34)`, limit 280, `GM:714-747`). Unequipping while the treasure tab is shown targets bag 34 (`PEBD:175-195`).
- Route: 5005 `U_C_BAG_MOVE` (`item.ItemReqMsg`, fields in [bag.md](bag.md) B1) with `begin_bag_type` / `end_bag_type` 1 and 34, `object_id` unset.
- Response: 115.

### T3. Arrange the treasure bag

- UI: "Organizar" with the treasure tab active (`AF:1403-1414`). `StoreBag.sort` (`SB:45-109`): sorted by `sortFun`, SonType 205, 224, 228, 312, 329 placed after the others, positions 0..n-1.
- Route: 8220 `C_BAG_ARRANGE` with `bagType = 34`, `isStackItem = true` ([bag.md](bag.md) B3). Response 115.

### T4. Lock, sell

- Lock: 8809 with `opType = 5` when the treasure tab is active (`decompiled/core_module/scripts/bag/helper/BagHelper.as:326-329`).
- Sell: 5007 with `begin_bag_type = 34` or 8624 rows with `bagType = 34` ([sell.md](sell.md)).

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When |
|---|---|---|---|
| 276 (0x0114) `U_C_ACTIVESTONEBAG_RESULT` | body not read by the client | `EquipBagII.onOpenStoreBag` -> `sort(true)` of bag 1 (`EB:35`, `EB:45-48`); `ArmyFrameII.onOpenStoreBag` re-enables the page buttons (`AF:416`, `AF:465-478`) | after T1 succeeded |
| 3 (0x0003) `U_C_PLAYER_INFO` | `player.PlayerMsg.stoneBagCount` (#125, INT32): 0 = not bought, > 0 = active (assumption: value 1 or the slot count 280) | `PlayerManager.__uPlayerInfoHandler` (`PM:1152-1160`) | login, after T1 |
| 115 (0x0073) | slot updates | `GM.__bagUpdateHandler` | T2, T3, T4 |

## 5. Rules and formulas

- Price: `Buy_StoneBag = 1000` diamonds, bound first when `payType = 0`; one time purchase.
- Capacity: 280 slots, positions 0..279 (`GM:659-681`, `GM:735-738`).
- Allowed content (assumption from the purchase text and the client sorts): SonType 205 (gems), 228 (double gems), 312 (anti resistance crystals), 224 (Guardian agates), 329, 343, 344 (Einherjar divine souls), and also 752, 753, 760, 761 (treasure and war soul stones, which the bag 1 arrange moves to the end when the treasure bag is active, `EB:394-397`). `GM.isStoreBagGoods` lists only 205, 228, 312, 224, 329 (`GM:2059-2082`).
- Stacking and moving follow [bag.md](bag.md) 5.2.
- No rental, no expiry, no expansion.

## 6. Templates

| File | Key |
|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `Buy_StoneBag = 1000` ("购买珍宝背包所需钻石") |
| `ItemTempInfos.xml` | `SonType` for allowed content |

## 7. Persistent state

- Rows: `inventory.items` with `bag_type = 34`, `object_id = 0`, `position BETWEEN 0 AND 279` (enforced by the handler).
- Flag: `inventory.bag_capacity.treasure_bag_active` ([bag.md](bag.md) section 7); purchase in `inventory.bag_purchase_log` with `kind = 'treasure_bag'`.

## 8. Backend implementation notes

- `inventory::storehouse::handle_buy` (9569): not yet active -> price 1000 -> `currency::spend_diamonds(bound_first = payType == 0)` -> set flag, log -> commit -> push 3 (`stoneBagCount`) then 276 (empty body).
- `inventory::storehouse::validate(move)`: hook of `inventory::bag::handle_move` when either side is bag 34: treasure bag active; position < 280; for deposits, template SonType in the allowed set (assumption); withdrawals always allowed.
- Arrange for bag 34 uses the generic arrange with the 280 limit.
- Item cost helpers (`inventory::store::count_owned(template)`) sum bags 1 and 34; consumption takes from bag 1 first (assumption).

## 9. Open questions and assumptions

- Exact allowed SonTypes for deposits (client does not check; the bag 1 arrange list and `isStoreBagGoods` differ).
- Value of `stoneBagCount` sent by the original server (only `> 0` matters to the client).
- Unequipping into bag 34 is possible on the client (`PEBD:181-185`); assumption: the server refuses non allowed types with 126.

## 10. Implementation checklist

- [ ] Route 9569 purchase, push 3 `stoneBagCount` and 276
- [ ] Move hook for bag 34 (capacity 280, allowed types)
- [ ] Arrange for bag 34
- [ ] Lock op 5 and sell from bag 34
- [ ] Cost helpers counting bag 1 and bag 34
- [ ] Tests: deposit of an allowed and a forbidden type, full treasure bag, purchase twice refused
