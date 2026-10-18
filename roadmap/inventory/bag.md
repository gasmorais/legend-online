# Bag ("Mochila")

Module of [README.md](README.md). The main bag (bag type 1): grid and pages, capacity, row expansion with diamonds, the two rented temporary pages, moving, stacking and splitting, arranging and sort filters, deletion of expired items, item lock, tooltips and chat links. Selling is in [sell.md](sell.md), using in [item-usage.md](item-usage.md), the treasure bag (bag 34) in [storehouse.md](storehouse.md), equipping in [equipment-slots.md](equipment-slots.md).

Path aliases:

| Alias | File |
|---|---|
| AF | `decompiled/m5/scripts/armyII/ArmyFrameII.as` |
| EB | `decompiled/core_module/scripts/bag/view/EquipBagII.as` |
| BBLV | `decompiled/core_module/scripts/bag/view/BaseBagListView.as` |
| BH | `decompiled/core_module/scripts/bag/helper/BagHelper.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| PI | `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerInfo.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| PBC | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as` |
| PBD | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellDropMediator.as` |
| CDM | `decompiled/core_module/scripts/cell/mediator/CellDropMediator.as` |
| OGM | `decompiled/core_module/scripts/cell/mediator/playerbag/OpenGridMediator.as` |
| SIF | `decompiled/core_module/scripts/bag/view/SpliteItemFrame.as` |
| RBSV | `decompiled/core_module/scripts/bag/view/RentalBagStateView.as` |
| RBAF | `decompiled/core_module/scripts/bag/view/RentalBagAlertFrame.as` |
| EBSL | `decompiled/core_module/scripts/bag/view/EquipBagSortList.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| CIV | `decompiled/core_module/scripts/chat/view/ChatInputViewII.as` |

## 1. Overview

- The bag is the right half of the hero frame "Equipamentos" (`armyII.ArmyFrameII`). It shows bag 1 as a 7 x 8 grid (56 cells per page) with six page buttons, a tab switch between "Mochila" (bag 1) and the treasure bag (bag 34), and the buttons "Organizar", "Dividir", "Vender", a sort/filter button ("Ordem Padrão", "Moda", "Acessório", "Equipamento", "Gema") and the item lock buttons ("Bloquear").
- Capacity: 42 default slots (`PI:400`, config `Player_BagCount = 42`) plus purchased slots `bagCount` (rows of 7, config `Player_BagAdd = 7`) up to 4 full pages (224 slots), plus up to two rented pages of 49 slots (pages 5 and 6) once the 4 pages are full.
- Every mutation is a request whose answer is the generic slot push 115 ([item-instance.md](item-instance.md) S1). Purchases also change player counters in 3 `U_C_PLAYER_INFO`.

Entry points:

| Entry | Condition | Code |
|---|---|---|
| Main toolbar "Mochila" button (`mainToolBtn.PackBtn`, shortcut B) -> `armyController.startFrameByType(EQUIP_PANEL)` | hero level >= 4 (docs/ui/navigation.md) | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:324` |
| Hero button and any "open bag" link | same frame | |
| "Vender" button | hero level >= 10, tip "Função habilitada no Nv. {0}" | `AF:318`, `AF:341-355` |
| Lock buttons | hero level >= 10, second password set | `AF:568-651` |

## 2. Screens

| Class | pt-BR title | Purpose | Data shown |
|---|---|---|---|
| `armyII.ArmyFrameII` | "Equipamentos" | Hero frame hosting the bag (`AF:264-323`) | buttons "Organizar" (`armyII.ArmyFrameII.tidy`), "Dividir" (`.split`), "Vender" (`.sell`), sort button text `armyII.ArmyFrameII.SortOrder0..4`, page buttons 1..6, tabs bag / treasure bag (`AF:206-207`, `AF:493-535`) |
| `bag.view.EquipBagII` (7 x 8, 6 pages, `AF:309-313`) | | Bag 1 grid; locked cells, "unlock" text cell, rental overlay on pages 5 and 6, expiry cleanup (`EB:79-202`) | `GM.getGeneralBagList()` (bag 1, object 0) |
| `bag.view.RentalBagStateView` | | Overlay on pages 5 and 6: open button, renew button, expiry date `YYYY-MM-DD` (`RBSV:143-168`) | `PI.rentalBagStatus`, `PI.rentalBagTime` |
| `bag.view.RentalBagAlertFrame` | "Mochila Temporária" | Choose 30 / 90 / 180 days, "Diamante vinculado prioritário" checkbox (`RBAF:51-141`) | texts `RentalBagAlertFrame.contentText.text1` "Privilégios do uso da mochila temporária:", `.text2` "...ao continuar a pagar:", options "{0} dia(s) ({1} diamantes)" |
| `bag.view.SpliteItemFrame` | "Divisão de itens" | Enter a quantity to split (`SIF:53-187`) | input, default 1 |
| `bag.view.EquipBagSortList` | menu "Moda", "Acessório", "Equipamento", "Gema" | Choose a sort/filter type (`EBSL:31-80`) | |
| `cell.view.GoodsItemMenu` | menu "Usar", "Mover", "Usar em massa" | Single click on a usable item ([item-usage.md](item-usage.md)) | |
| Simple alerts | "Consumir {0} diamantes para abrir {1} linhas na Mochila?" (`cell.mediator.playerbag.OpenGridMediator.content`), "Sobrepor todos os itens?" (`bag.helper.BagHelper.content02`, once per day option) | confirmations | |
| Item tooltips | see [item-catalog.md](item-catalog.md) section 2 | hover on any cell | |

## 3. Routes (client to server)

### B1. Move, swap or merge by drag (5005)

- UI: drag a bag cell onto another bag cell, onto an equipment cell, onto a page button or out of the frame. A drag starts on single click of a non usable item (`PBC:171-179`), from "Mover" of the use menu (`decompiled/core_module/scripts/cell/view/GoodsItemMenu.as:133-140`) or from the split frame (B3). The drag carries a count: the whole stack (`[cell, data.count]`) or the split count (`CDM:41-47`, `PBD:47-65`).
- Drop handling `PBD.beDropHitCallBack` (`PBD:67-186`):
  - on another `BaseItemView`: ignored if the target is in the sell list (`PBD:98-101`), if the dragged item is Einherjar equipment (MasterType 5) and the target is a hero equipment cell (`PBD:102-105`), or if the target holds a novice pack (SonType 298, `PBD:106-109`); else `swapItem` (`PBD:247-325`): to a `PlayerBagCell` always sends the move; to a `PlayerEquipCell` or `RunesCell` applies equip checks ([equipment-slots.md](equipment-slots.md));
  - on a page button: first free slot of that page of the current bag (`GM.findEmputyPosByPageAndBagType`, `GM:714-747`), current bag = 1 or 34 by tab (`PBD:116-174`); none -> "Espaço nessa página da mochila insuficiente" (`cell.mediator.playerbag.PlayerBagCellDropMediator.command01`) and a fly back animation; else move the whole stack;
  - on a farm or market cell: handed to those features;
  - outside every frame and `newbieProcess > 19000`: sell flow ([sell.md](sell.md) S1).
- Client path: `PM.moveBagToBag(srcBag, srcObj, srcPos, dstBag, dstObj, dstPos, count, objectId?)` (`PM:1602-1606`; warns "Armazém temporário expirado" for guild rented pages, `PM:1613-1628`) -> `SSM.sendMoveBagToBag` (`SSM:139-155`).
- Route: C>S 5005 (0x138d) `U_C_BAG_MOVE`.
- Request `item.ItemReqMsg`: `begin_bag_type` (#1, INT32) source bag; `begin_obj_id` (#2, INT32) source owner (0 for bag 1); `begin_pos` (#3, INT32) source slot; `end_bag_type` (#4, INT32) destination bag; `end_obj_id` (#5, INT32) destination owner (hero id for equipment, pet id or 0 for bag 26); `end_pos` (#6, INT32) destination slot; `count` (#7, INT32) quantity to move (1 for equipment); `object_id` (#8, INT32) set only when > 0: Einherjar id for pet equipment moves.
- Response: 115 with the source and destination slots ([item-instance.md](item-instance.md) S1). Errors: no change, optional 126 text.
- This is the generic move route of the game: 136 client call sites (smith workspace, guild warehouse, pet and guardian equipment, monsters, Theseus, farm, fashion, runes...). Each owning feature adds a validation hook (8).

### B2. Split ("Dividir")

- UI: "Dividir" (`AF:1424-1428`) -> `BH.onSplitHandler` starts a drag with the split cursor (`BH:525-536`); dropping on a bag cell with `MaxCount > 1` and `count > 1` opens `SpliteItemFrame` (`BH:538-554`). Shift click path (`PBC:104-111`) is dead code (`_loc5_` is never set).
- Frame checks (`SIF:92-159`): quantity 1..count (for SonType 311 limited by what the player can pay); Enter confirms.
- Confirm sends `DRAG_ITEM_BagNotic [cell, n]` (`SIF:176-187`), which starts a drag of `n`; the drop then follows B1 with `count = n`. Split into an empty slot creates a new row with the same attributes.

### B3. Arrange ("Organizar") and sort filter

- UI: "Organizar" (`AF:1403-1414`) on the active tab (bag 1 or 34), or a type in the sort menu (`EBSL:68-80` -> `BAG_SORT_SELECT` -> `AF:795-798`).
- Client: `BH.onTidyHandler(bag, sortType)` (`BH:556-585`) asks "Sobrepor todos os itens?" (daily "do not ask again", `SharedManager.domesticateAlertDate`), then `bag.sort(true, sortType)` (`BH:597-605`). For bag 1, `EquipBagII.sort` (`EB:354-418`): novice pack in slot 0 (SonType 298) stays first; other items sorted by `sortFun` (`BBLV:308-353`): items matching the selected type first (`GM.isType`, `GM:1788-1831`), then SonType ascending, then TemplateId descending, then enhancement descending, then unbound before bound; when the treasure bag is active (`stoneBagCount > 0`) items of SonType 205, 224, 228, 312, 329, 343, 344, 752, 753, 760, 761 are placed after all others. New positions are 0..n-1 in that order. Then `GM.fixBagItem(oldPositions, newPositions, bagType, true)` (`GM:292-310`). After a bag 1 arrange the client records `lastBagSortType` and enables the filter (items not matching the type are dimmed, `decompiled/core_module/scripts/yishi/datas/goods/GoodsInfo.as:504-535`).
- Route: C>S 8220 (0x201c) `C_BAG_ARRANGE`.
- Request `item.ArrangeReq`: `isStackItem` (#1, BOOL) always true from the bag (merge stacks); `bagType` (#2, INT32) 1, 34 or 6; `arrangeInfo` (#3, MESSAGE `ArrangeInfo`, repeated): `oldplace` (#1, INT32) current slot, `newplace` (#2, INT32) target slot. The list covers every item of the bag.
- Response: 115 with every changed slot (moved and merged).
- Sort types (`decompiled/core_module/scripts/bag/datas/BagSortType.as:5-13`): 0 Default ("Ordem Padrão"), 1 Fashion ("Moda": MasterType 1 SonType 109..112), 2 Prop ("Acessório": MasterType 2 or 3, not a gem), 3 Equip ("Equipamento": MasterType 1 non fashion; 0 behaves the same in `isType`), 4 Jewel ("Gema": SonType 205, 228, 312, 224, 329, 343, 344 or template 208028).

### B4. Expand rows (unlock cells)

- UI: click a locked cell of pages 1 to 4 when not in sell mode (`OGM:39-67`, cells beyond `bagTotalCount` are locked, the first locked cell shows an unlock text, `EB:153-202`).
- Rows asked: `(cell.pos + 7) / 7 - (bagCount + 42) / 7` (minus 14 on page 4, whose locked cells carry positions shifted by 98) (`OGM:49-55`).
- Price: sum of `AddBag_Count[r]` for `r` from `bagCount / 7` to `bagCount / 7 + rows - 1`, the last value repeating (`OGM:69-90`; config `AddBag_Count = 5,10,15,20,25,30,35,40,45,50` diamonds per row).
- Alert "Consumir {0} diamantes para abrir {1} linhas na Mochila?" with the bound diamond priority checkbox (`USEBINDPOINT_ALERT`).
- Route: C>S 5010 (0x1392) `U_C_BAG_BUY`; request `player.PayTypeMsg`: `payType` (#1, INT32) 0 = bound diamonds first, 1 = diamonds only; `property1` (#2, INT32) rows to open; `property2` (#3, INT32) unset; `type` (#4, INT32) unset (0 = main bag). (`OGM:97-113`)
- Response: 3 `U_C_PLAYER_INFO` with `bagCount` (#35) increased by `7 * rows` and the new `point` (#6) / `giftToken` (#7); the client re-locks cells on `BAG_CAPICITY` change (`PI:1013-1020`, `EB:31-58`).
- Variant `type = 1, property1 = 1`: rune bag (bag 40) expansion by 12 slots for 20 diamonds (`runehole_bag_buy = 12,20`, max `runehole_bag = 12,120`), sent by `ArmySocketOutManager.sendBuyBox` (`decompiled/core_module/scripts/managers/ArmySocketOutManager.as:210-218`); owned by [../army/README.md](../army/README.md).

### B5. Rent or renew temporary pages ("Mochila Temporária")

- UI: open or renew button on page 5 or 6 (`RBSV:114-136`). Check: `bagTotalCount >= 224` else "Por favor desbloqueie os 3 primeiros compartimentos da Mochila" (`bag.view.RentalBagStateView.OpenBtn.TipData01`).
- Frame (`RBAF:75-141`): three options from config `rental_bag_day_cost = 30,200|90,500|180,900` (days, diamonds per page); the shown and checked price is `cost * 2` (both pages). Bound priority checkbox selected by default. Check: `allPoint` (bound plus normal) or `point` >= price, else recharge prompt.
- Route: C>S 8819 (0x2273) `C_RENTAL_BAG_OP`; request `active.RentalBagOpReqMsg`: `opType` (#1, INT32) = 1; `param1` (#2, INT32) 0 = bound diamonds first, 1 = diamonds only; `param2` (#3, STRING) days ("30", "90", "180") (`SSM:593-601`).
- Response: S2 4709, plus 3 with the new diamond counters.

### B6. Delete expired item

- Trigger: rendering a page of bag 1 (`EB:140-145`), any `BaseBagListView` (`BBLV:190-195`), the guild warehouse, hero equipment (`decompiled/m5/scripts/armyII/viewII/equip/EquipView.as:1411`) and Dragon Tamer equipment (`decompiled/m5/scripts/dragontalker/view/DragonTalkerEquipView.as:1009`): every item with `validDate > 0` and `now - beginDate >= validDate minutes`.
- Route: C>S 8346 (0x209a) `C_BAG_REMOVE`; request `item.ItemRemoveMsg`: `bag_type` (#1, INT32), `pos` (#2, INT32) (`SSM:354-361`).
- Response: 115 with the slot emptied. The server must refuse non expired items (there is no player "destroy" in this client: discarding is selling, [sell.md](sell.md)).

### B7. Lock or unlock an item ("Bloquear")

- UI: lock button -> cursor mode `VICE_PASSWORD_LOCK`; clicking a cell sends the op (`BH:261-395`). Password flow and guards: [../account/item-lock.md](../account/item-lock.md).
- Route: C>S 8809 (0x2269) `C_LOCK_OR_UNLOCK`; request `player.LockAndUnlockMsg`: `opType` (#1, INT32) 1 bag 1 item, 3 hero equipment (bag 4), 4 medal (bag 3), 5 treasure bag item (bag 34), 7 cell of bag type 401; `itemPos` (#2, INT32) slot; `petId` (#3, INT32) for pets only (`BH:326-337`, `BH:354-361`; `decompiled/core_module/scripts/mainBar/vicePassword/VicePasswordUtil.as:40-49`).
- Response: 115 with the item and `is_locked` (#35) toggled. Locked items cannot be sold ("O item atual foi bloqueado, favor desbloquear", `BH:463-472`, `PBD:199-204`).

### B8. Use menu, double click, tooltip, chat link (local or routed elsewhere)

- Single click on a usable item (MasterType 2 or 4 and usable SonType) opens "Usar" / "Mover" / "Usar em massa" (`PBC:117-170`); routes in [item-usage.md](item-usage.md). Items in bag 6 never show it (`PBC:1047-1052`).
- Double click: use, or equip ([equipment-slots.md](equipment-slots.md)).
- Shift + click (except templates 208002, 208003): `SEND_GOODS` appends `[TemplateName]` to the chat input and stores the item (`PBC:99-103`, `CIV:305-311`); on send, each bracket matching a stored item becomes a `chat.ChatItemInfoMsg` in `ChatChannelMsg.items` (#17) (`CIV:495-512`, `decompiled/core_module/scripts/com/road/pb/helper/item/ItemHelper.as:105-126`), sent with 15005 `U_CH_CHANNEL_CHA` by the chat feature ([../chat/README.md](../chat/README.md)). `ChatItemInfoMsg`: `id` #1, `templateId` #2, `pos` #3, `exist` #4, `objectId` #5, `bagType` #6, `bind` #7, `used` #8, `validDate` #9, `beginDate` #10 BYTES, `count` #11, `attack` #12, `defence` #13, `agility` #14, `ability` #15, `captain` #16, `strengthenGrade` #17, `join_1..3` #18..#20, `randomSkill_1..5` #21..#25, `isNew` #26, `userId` #27, `itemName` #28, `join_4` #29, `property1` #30, `mouldGrade` #31, `appraisalSkill` #32, `lifeSkill` #33. The receiver renders the tooltip from this message; no server item lookup.

## 4. Server messages (server to client)

### S1. 115 `U_C_BAG_MOVE_UPDATE`

See [item-instance.md](item-instance.md) S1. Answer to B1, B2, B3, B6, B7.

### S2. 4709 (0x1265) `U_C_RENTAL_BAG`

- Message `active.RentalBagOpResMsg`: `opType` (#1, INT32) echo; `rentalBagTime` (#2, STRING) expiry `YYYY-MM-DD hh:mm:ss`; `status` (#3, INT32) 0 none or expired, 1 page 5 only (page 6 overlay stays locked), 2 pages 5 and 6; `param1` (#4, STRING) unused by the client.
- Receiver `BaseManager.__rentalBagResHandler` (`BM:1018-1032`, listener `BM:331`): sets `PI.rentalBagTime` and `PI.rentalBagStatus`, which refresh the overlay (`RENTAL_BAG_TIME_REFRESH`) and `bagTotalCount` (`PI:1219-1230`).
- When: answer to B5; push when the rental expires (status 0).

### S3. 3 (0x0003) `U_C_PLAYER_INFO` (bag fields)

`player.PlayerMsg` fields read by `PlayerManager.__uPlayerInfoHandler` (`PM:150`): `bagCount` (#35, INT32) purchased slots (`PM:1014-1017`); `rentalBagTime` (#97, STRING) and `status` (#98, INT32) same meaning as S2 (`PM:1119-1126`); `stoneBagCount` (#125, INT32) treasure bag flag ([storehouse.md](storehouse.md)); `point` (#6) diamonds and `giftToken` (#7) bound diamonds. Sent at login and after B4, B5.

### S4. 126 `U_C_MSG`

Optional failure text ([item-instance.md](item-instance.md) S4).

## 5. Rules and formulas

### 5.1 Capacity and positions of bag 1

- `bagTotalCount = bagCount + 42 (+ 49 if status 1) (+ 98 if status 2)` (`PI:1219-1230`).
- Pages hold 56 cells (7 columns x 8 rows). Page 4 shows `bagCount - 126` unlocked cells (`EB:120-127`, `EB:163-167`).
- Positions: `[0, 42 + bagCount)` normal slots; rented page 5 `[42 + bagCount, 42 + bagCount + 49)`; rented page 6 the next 49 (`EB:229-247`, `GM:714-731`). Locked page 4 cells use positions shifted by 98 (never valid targets). Highest valid position 321 (`GM.findNullCount` scans 322, `GM:749-767`).
- Maximum purchased slots 182 (26 rows): pages 1..4 full = 224. Total cost of all rows: 5+10+...+50 (275) + 16 x 50 = 1 075 diamonds.
- Rental requires all 224 slots; price per page per option: 30 days 200, 90 days 500, 180 days 900 diamonds; both pages are rented together (price x 2). Renewal extends from the current expiry (assumption).
- Expired rental: assumption, items stay in their slots but cannot be moved in; existing items can be moved out or used (the client still renders them under the lock overlay).

### 5.2 Move semantics for 5005 (server, assumption based on client usage)

1. Source row must exist at `(begin_bag_type, begin_obj_id, begin_pos)` and belong to the player; `1 <= count <= source.count`.
2. Destination slot must be valid for the destination bag (capacity, rented page active, bag specific hooks).
3. Destination empty: move `count`; when `count < source.count` create a new row (split) with the same attributes and a new id.
4. Destination holds the same template and bind flag with `MaxCount > 1`: merge `min(count, MaxCount - dest.count)`.
5. Destination holds another item: swap whole rows, only when `count == source.count`; equipment swap rules in [equipment-slots.md](equipment-slots.md).
6. A slot holding a novice pack (SonType 298) is never a swap target (client rule).
7. Locked items may be moved (assumption; the lock only blocks destructive actions).

### 5.3 Arrange semantics for 8220

Apply the permutation `oldplace -> newplace`; every old position must hold a player item of `bagType`, every new position must be valid and unique. With `isStackItem`, merge partial stacks of the same template and bind flag into the lowest position afterwards (assumption). When the treasure bag is active and `bagType = 1`, assumption: the server moves the gem types listed in B3 into free slots of bag 34 (the client puts them last and re-sorts after 276 `U_C_ACTIVESTONEBAG_RESULT`, `EB:45-48`).

### 5.4 Bag full

`GM.findEmputyPos() == -1` makes the toolbar bag button blink (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2592-2611`). Rewards while full: assumption, mailed.

## 6. Templates

| File | Key | Use |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `Player_BagCount = 42`, `Player_BagAdd = 7`, `AddBag_Count = 5,10,15,20,25,30,35,40,45,50`, `rental_bag_day_cost = 30,200|90,500|180,900`, `RentalBag_Per_Month = 200` (read by `ArmyModel`, legacy), `runehole_bag = 12,120`, `runehole_bag_buy = 12,20` | B4, B5 |
| `ItemTempInfos.xml` | `MaxCount`, `SonType`, `Profile` | stacking, sort |

## 7. Persistent state

Items: `inventory.items` ([item-instance.md](item-instance.md)). Bag capacity per player:

```sql
CREATE TABLE inventory.bag_capacity (
  player_id            BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  purchased_slots      SMALLINT    NOT NULL DEFAULT 0 CHECK (purchased_slots BETWEEN 0 AND 182 AND purchased_slots % 7 = 0),
  rental_status        SMALLINT    NOT NULL DEFAULT 0 CHECK (rental_status IN (0,1,2)),
  rental_expires_at    TIMESTAMPTZ,
  rune_bag_slots       SMALLINT    NOT NULL DEFAULT 12 CHECK (rune_bag_slots BETWEEN 12 AND 120),
  treasure_bag_active  BOOLEAN     NOT NULL DEFAULT false,
  updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE inventory.bag_purchase_log (
  purchase_id  BIGSERIAL   PRIMARY KEY,
  player_id    BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  kind         TEXT        NOT NULL CHECK (kind IN ('rows','rental','rune_bag','treasure_bag')),
  amount       INTEGER     NOT NULL,
  diamonds     INTEGER     NOT NULL DEFAULT 0,
  bound_diamonds INTEGER   NOT NULL DEFAULT 0,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX bag_purchase_log_player_idx ON inventory.bag_purchase_log (player_id, created_at DESC);
```

`treasure_bag_active` backs `PlayerMsg.stoneBagCount` ([storehouse.md](storehouse.md)).

## 8. Backend implementation notes

- `inventory::bag::handle_move` (5005): lock player inventory (row level `FOR UPDATE` on both slots); validation order: source exists and owned -> count range -> destination slot range for the destination bag -> feature hook by bag type (`smith::store_frame::validate_workspace_move` for bag 0, `guild::warehouse::validate_move` for bag 6, `hero::equipment::validate_equip` for bags 2/3/4, `inventory::storehouse::validate` for bag 34, `einherjar::equipment::validate` for bag 26 with `object_id`, `guardians::equipment::validate` for bag 30, `market::validate` for bag 32...) -> apply 5.2 -> commit -> push 115 (and hero recompute / 149 broadcast for bag 4 changes).
- `inventory::bag::handle_arrange` (8220): validate the full permutation in one transaction; reject partial lists that drop items.
- `inventory::bag::handle_buy_rows` (5010, `type` 0): rows >= 1, `purchased_slots + 7 * rows <= 182`; price from `AddBag_Count`; debit through `currency::spend_diamonds(player, price, bound_first = payType == 0)`; update, log, push 3.
- `inventory::bag::handle_rent` (8819): `opType == 1`, days in config, `42 + purchased_slots >= 224`; price `cost * 2`; set status 2 and `expires_at = greatest(now, expires_at) + days`; push S2 and 3. Scheduler: at expiry set status 0 and push S2.
- `inventory::bag::handle_remove_expired` (8346): only rows past validity; delete and push 115.
- `inventory::bag::handle_lock` is owned by account ([../account/item-lock.md](../account/item-lock.md)); inventory exposes `set_locked(player, bag, pos, locked)` and pushes 115.
- One 115 per request; error feedback with 126.

## 9. Open questions and assumptions

- Server behaviour when `count` exceeds the stack or when swapping a partial stack: rejected (assumption).
- Whether arrange with the treasure bag active moves gems into bag 34 (5.3).
- Expired rental page content handling (5.1).
- `RentalBagStateView` texts `OpenBtn.TipData02..04` (single page 30 day prices) are not used by this client build; the frame always rents both pages.
- Bag type 401 in lock op 7 is not defined in `BagType` (probably the Dragon Tamer talisman bag, assumption).

## 10. Implementation checklist

- [ ] Screen: ArmyFrameII bag half with 6 pages, locked cells, unlock text, tabs
- [ ] Route 5005 generic move with hooks per bag type
- [ ] Split via 5005 with partial count (new row)
- [ ] Route 8220 arrange with stack merge
- [ ] Sort types 0..4 and client filter
- [ ] Route 5010 row purchase (type 0) with `AddBag_Count` pricing; type 1 delegated to army
- [ ] Route 8819 rental and push 4709; expiry scheduler
- [ ] Route 8346 expired removal
- [ ] Lock op 8809 bag cases (with account feature)
- [ ] PlayerMsg fields `bagCount`, `rentalBagTime`, `status`, `stoneBagCount`
- [ ] Tables `inventory.bag_capacity`, `inventory.bag_purchase_log`
- [ ] Tests: position layout with 0 / 7 / 182 purchased slots and rental status 0 / 1 / 2
- [ ] Tests: merge, split, swap and invalid count on 5005
