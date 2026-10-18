# Protocol index (packages `item`, `storehouse`, `slate`)

Module of [README.md](README.md). Every message of the proto packages assigned to inventory, with its opcodes, client users and the module or feature that implements it. Messages whose screens belong to other features are documented here at wire level so nothing is lost; behaviour lives in the linked feature.

Source of field numbers: the generated classes `decompiled/core_module/scripts/com/road/yishi/proto/<package>/<Message>.as` (`protocol/proto.json` keeps only one message per simple name, so `item.ItemInfoMsg` is shadowed by `active.ItemInfoMsg`).

## 1. Overview

| Package | Messages | Implemented here | Used by other features |
|---|---:|---:|---:|
| `item` | 34 (33 in `proto.json` plus the shadowed `item.ItemInfoMsg`) | 17 (+5 unused: `EquipLookMsg`, `EquipLookDataMsg`, `ItemInfoReqMsg`, `ItemInfoRspMsg`, `ItemUseStoreRspMsg`) | 12 |
| `storehouse` | 5 | 3 + 2 unused rank messages ([thess-box.md](thess-box.md)) | 0 |
| `slate` | 4 | 4 ([slate.md](slate.md)) | 0 |

## 2. Screens

See each module. No screen belongs to this index.

## 3. Routes (client to server) per message

| Message | Fields | Opcode (C>S) | Sender | Module / feature |
|---|---|---|---|---|
| `item.ItemReqMsg` | `begin_bag_type` #1, `begin_obj_id` #2, `begin_pos` #3, `end_bag_type` #4, `end_obj_id` #5, `end_pos` #6, `count` #7, `object_id` #8 (all INT32) | 5005 `U_C_BAG_MOVE`; 5007 `U_C_BAG_SELL` (only #1, #3) | `SocketSendManager.sendMoveBagToBag` / `sendSellItem` | [bag.md](bag.md) B1, [sell.md](sell.md) |
| `item.ItemUseMsg` | `pos` #1, `count` #2, `bag_type` #3 (INT32), `battle_id` #4 (STRING), `friend_id` #5 (INT32) | 5006 `U_C_BAG_USEITEM`; 8665 `C_STELA_BOX` | `SocketSendManager.sendUseItem` / `sendUseStelaItem` | [item-usage.md](item-usage.md) |
| `item.ItemRemoveMsg` | `bag_type` #1, `pos` #2 | 8346 `C_BAG_REMOVE` | `SocketSendManager.sendDeleteGoods` | [bag.md](bag.md) B6 |
| `item.ArrangeReq` / `item.ArrangeInfo` | `isStackItem` #1 BOOL, `bagType` #2, `arrangeInfo` #3 repeated (`oldplace` #1, `newplace` #2) | 8220 `C_BAG_ARRANGE` | `GoodsManager.fixBagItem` | [bag.md](bag.md) B3 |
| `item.ItemSellReqMsg` / `item.SelledItemInfo` | `selledItemInfos` #1 repeated (`pos` #1, `count` #2, `bagType` #3) | 8624 `C_BAG_BATCH_SELL` | `ItemSellView.__alertResponse` | [sell.md](sell.md) |
| `item.MarketOpMsg` / `item.StallMsg` / `item.StallItemMsg` | `op_type` #1, `stall` #2, `param1..4` #3..#6, `param5` #7 STRING, `param6` #8 BOOL | 8969 `C_MARKET_OP` | `MarketModel` | [market-stall.md](market-stall.md) |
| `item.ItemUseStoreReqMsg` | `count` #1, `templateId` #2 | 8484 `C_BAG_USESTORE` (jewel experience with 208014 / 208031, `decompiled/m5/scripts/armyII/viewII/equip/JewelFrame.as:188-200`); 9592 `C_EQUIPMENT_REFINING` (`decompiled/m5/scripts/armyII/viewII/equip/ConciseFrame.as:163-170`) | army jewel / concise frames | [../smith/gems.md](../smith/gems.md), [../smith/refine.md](../smith/refine.md) |
| `item.BottleOpMsg` | `alter_type` #1, `op_type` #2, `stick_first` #3 | 8604 `C_BOTTLE_OP` (`BottleManager.sendOpenInfo`, ops 0 draw with `alter_type` = open type and `stick_first`, 1 and 2 storage, 3 refresh, 4 info, 5 count reward, 6 floor reward; `decompiled/core_module/scripts/managers/BottleManager.as:143-157`); 9542 `C_CHRISTMASTREE_OP` (`ChristmasTreeManager.sendOpenInfo`, `alter_type` and `op_type` swapped, `decompiled/core_module/scripts/managers/ChristmasTreeManager.as:119-126`) | golden tree, magic pot | [../golden-tree/README.md](../golden-tree/README.md), [../seasonal-events/README.md](../seasonal-events/README.md) |
| `item.CommonItemMsg` / `item.SellItemMsg` | `begin_bag_type` #1 .. `object_id` #8 as `ItemReqMsg`, `compose_id` #9, `compose_num` #10, `auto_buy` #11 BOOL, `op_type` #12, `hole_pos` #13, `operate` #14 BOOL, `payType` #15, `lock` #16 BOOL repeated, `bind_type` #17, `property1` #18, `sellItem` #19 repeated (`pos` #1, `count` #2, `id` #3), `material_pay_type` #20 | 8868 `C_CHILDREN_OP` (`decompiled/core_module/scripts/mvc/module/children/ChildSender.as:410-495`) | guardian equipment | [../guardians/README.md](../guardians/README.md) |
| `item.EquipLookMsg` | `otherId` #1 | none | no user | unused (8199 uses `simple.DetailReqMsg`, [equipment-slots.md](equipment-slots.md) E4) |
| `item.ItemInfoReqMsg` | `id` #1 repeated | none | no user | unused |

Other inventory routes use messages of other packages: 5010 `U_C_BAG_BUY` (`player.PayTypeMsg`), 8819 `C_RENTAL_BAG_OP` (`active.RentalBagOpReqMsg`), 9569 `C_STONEBAG_BUY` (`player.PayTypeMsg`), 8809 `C_LOCK_OR_UNLOCK` (`player.LockAndUnlockMsg`), 8521 `C_VIP_COIN_OPEN` (empty), 8345 `C_PLAYER_RENAME_REQ`, 8283 `C_EFFECT_STOP`, 8224 `C_LONIG_LOAD_REQ` (`bag` flag), 5019 / 5018 (`box.BoxMsg`), 9645 (`cccactive.PandoraLotteryMsg`), 8722 / 8723 (`privilege.PrivilegeMsg`), 9761 / 9762 (`player.PlayerOpMsg`).

## 4. Server messages (server to client) per message

| Message | Fields | Opcode (S>C) | Receiver | Module / feature |
|---|---|---|---|---|
| `item.ItemMovedListMsg` / `item.ItemMoveUpdateMsg` / `item.ItemInfoMsg` | see [item-instance.md](item-instance.md) S1, S2 | 115 `U_C_BAG_MOVE_UPDATE` | `GoodsManager.__bagUpdateHandler` | [item-instance.md](item-instance.md) |
| `item.ItemBufferRspMsg` / `item.BufferDataMsg` | `bufferData` #1 repeated (`template_id` #1, `validity_date` #2, `grade` #3, `type` #4, `type_templateid` #5, `isCancel` #6 BOOL) | 4188 `U_C_ITEM_BUFFER` | `PlayerBufferManager.__refreshItemBufferHandler` | [item-usage.md](item-usage.md) |
| `item.ItemSmithyMsg` | `composeId` #1 repeated | 4184 `U_C_ITEM_SMITH` | `PlayerManager.__addComposeTempHandler` | [item-usage.md](item-usage.md), [../smith/compose.md](../smith/compose.md) |
| `item.MarketOpMsg` | as above | 4781 `U_C_MARKET_OP_BACK` | `CampaignSocketManger.__marketOpbackHandler` | [market-stall.md](market-stall.md) |
| `item.MarketMsg` | `stalls` #1 repeated `StallMsg`, `userId` #2 repeated | 4782 `U_C_MARKET_SEND` | `CampaignSocketManger.__marketInfoHandler` | [market-stall.md](market-stall.md) |
| `item.CampaignCardsMsg` | `scene_type` #1 STRING, `card_count` #2, `pay_card_count` #3, `price` #4, `dropItems` #5 repeated `item.ItemInfoMsg` | 135 `U_C_CAMPAIGN_CARDS` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:305`, `:1985-2001`; shown by `ChestFrame`, `decompiled/core_module/scripts/map/internals/battle/ChestFrame.as:87-94`, `:280-290`). Card pick: C>S 5122 `U_C_CAMPAIGN_TAKE_CARD` (`campaign.CampaignReqMsg`: `paraInt1`, `paraBool1` pay, `paraInt2` index), reply 26 `U_C_CAMPAIGN_TAKE_CARD` (`campaign.CampaignTakeCardsMsg`) | post battle chest cards | [../campaign/README.md](../campaign/README.md) |
| `item.VirtualBagMsg` / `item.VirtualItemMsg` | `bagType` #1 (3 Avenger armor, 4 ignored, 5 Theseus collection armor, 6 Theseus box), `items` #2 repeated (`templateId` #1, `count` #2, `pos` #3, `isLock` #4 BOOL) | 211 `U_C_VIRTUAL_BAG_DATA` (full), 212 `U_C_VIRTUAL_BAG_UPDATE` (delta, count 0 deletes) (`BaseManager.as:350-351`, `:356-458`); C>S 5634 `C_VIRTUAL_BAG_MOVE` (`simple.PropertyMsg` `param1`, `param2`, `BaseManager.moveVirtual`, `:2822-2829`, no caller) | template keyed virtual bags | [../avenger/README.md](../avenger/README.md), [../theseus/README.md](../theseus/README.md) |
| `item.FastUseBloodMsg` | `result` #1, `template_id` #2 | 170 `U_C_FAST_USE_BLOOD`, answer to C>S 5633 `C_FAST_USE_BLOOD` (`shop.ShopMsg`, quick buy and use, `decompiled/core_module/scripts/managers/ShopManager.as:884-915`) | quick buy frame | [../shops/README.md](../shops/README.md) |
| `item.BottleDropListMsg` / `item.BottleItemInfoMsg` / `item.BottlePackage` | `dropItem` #1 repeated (`temp_id` #1, `count` #2, `is_show` #3, `is_new_items` #4), `score` #2 repeated `BottlePackage` (`param` #1, `item` #2 repeated), `storey` #3 repeated, `open` #4 BOOL, `end_time` #5 STRING | 295 `U_C_BOTTLE_DROP_DATA` (golden tree), Christmas tree drop data | `BottleManager.__updateBottleData`, `ChristmasTreeManager` | [../golden-tree/README.md](../golden-tree/README.md), [../seasonal-events/README.md](../seasonal-events/README.md) |
| `item.BottlePassMsg` | `pass_type` #1 (1 reward list append, 2 luck broadcast), `infos` #2 STRING repeated, `count` #3, `dropId` #4 | 4497 `U_C_BOTTLE_PASS`; 4957 / 4959 / 4960 / 4961 Christmas tree; 294 `U_C_OUTER_CITY_SHOP_PASS` (`OuterCityShopManager.as:57-63`); 332 `U_C_AUCTION_NOTIC` (`SaleManager.as:82-90`) | luck broadcast lists | golden tree, seasonal events, [../shops/README.md](../shops/README.md), [../auction/README.md](../auction/README.md) |
| `item.ItemInfoRspMsg` | `itemInfo` #1 repeated | none | no user | unused |
| `item.ItemUseStoreRspMsg` | `result` #1 BOOL | none | no user | unused |
| `item.EquipLookDataMsg` | `other_id` #1, `item` #2 repeated | none | no user | unused |
| `storehouse.StoreHouseUseMsg` | `opType` #1, `count` #2, `passChapter` #3, `firstReward` #4 STRING | 769 `U_C_STOREHOUSE_USER_DATA` | `TheseussoulManager.__thessBoxDataHandler` | [thess-box.md](thess-box.md) |
| `storehouse.StoreHouseFightMsg` | `type` #1, `curLevel` #2, `chapterId` #3, `mapId` #4, `equipSkills` #5 STRING, `allSkills` #6 repeated, `addSkill` #7 | 770 `U_C_STOREHOUSE_FIGHT_DATA` | `__thessBoxFightDataHandler` | [thess-box.md](thess-box.md) |
| `storehouse.StoreHouseAddSkillMsg` | `addSkills` #1 repeated | 771 `U_C_STOREHOUSE_ADD_SKILL` | `__thessBoxADDSKHandler` | [thess-box.md](thess-box.md) |
| `storehouse.StoreHouseRankListMsg` / `StoreHouseRankMsg` | `ranks` #1 repeated (`rank` #1, `level` #2, `nickName` #3) | none | no user | unused |
| `slate.UserSlateMsg` / `SlateMsg` / `SlateTaskMsg` / `SlatePropertyMsg` | see [slate.md](slate.md) S1 | 1024 `U_C_SLATE_USER_DATA` | `TheseussoulManager.__slateInfosHandler` | [slate.md](slate.md) |

## 5. Rules and formulas

- Declared but unanswered accept opcodes of the bag: 54 `U_C_BAG_MOVE`, 55 `U_C_BAG_USEITEM`, 56 `U_C_BAG_SELL`, 58 `U_C_BAG_BUY`, 59 `U_C_HERO_UPDATE_EQUIPMENT` have no client listener; the server answers with 115 / 3 / 109 instead.
- Opcodes used by the client but missing in `protocol/opcodes.csv`: 4 (time chest state), 5018, 5019 (`box.BoxMsg`), 9762 (slate ops). Add them to the server opcode table with names `U_C_TIME_BOX`, `C_BOX_NOVICE`, `C_BOX_TIME`, `C_SLATE_OP` (assumed names).

## 6. Templates

See the modules.

## 7. Persistent state

None in this index.

## 8. Backend implementation notes

- Register every C>S opcode of section 3 marked for inventory in the Rust dispatcher (`server/src/game.rs` style `match code`), and encoders for every S>C message of section 4 marked for inventory.
- Messages owned by other features must still have encoders in the shared `proto` module (generated from the `.as` field tables) so that those features can reuse them.

## 9. Open questions and assumptions

- Names for the missing opcodes (section 5) are assumptions.
- The unused messages may have been used by older client versions; they need no handler.

## 10. Implementation checklist

- [ ] Proto encoders/decoders for all 43 messages of the three packages
- [ ] Dispatcher entries for 5005, 5006, 5007, 8220, 8346, 8624, 8665, 8969, 9761, 9762
- [ ] Opcode table additions 4, 5018, 5019, 9762
- [ ] Cross check with owning features for 8484, 9592, 8604, 9542, 8868, 5633, 135 / 5122 / 26, 211 / 212
