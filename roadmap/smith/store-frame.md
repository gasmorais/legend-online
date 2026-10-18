# Smith: frame shell, smith workspace and shared request path

Path aliases:

| Alias | File |
|---|---|
| MF | `decompiled/m14/scripts/store/MakeFrame.as` |
| SV1 | `decompiled/m14/scripts/store/StoreView1.as` |
| SF | `decompiled/m14/scripts/store/StoreFrame.as` (legacy shell) |
| SB2 | `decompiled/m14/scripts/store/StoreBagII.as` |
| SB | `decompiled/m14/scripts/store/StoreBag.as` (legacy bag) |
| TSB | `decompiled/m14/scripts/store/treasure/TreasureStoreBag.as` |
| ASB | `decompiled/m14/scripts/store/AvengerStoreBag.as` |
| THSB | `decompiled/m14/scripts/store/TheseusStoreBag.as` |
| SC | `decompiled/core_module/scripts/mvc/controler/StoreControler.as` |
| SM | `decompiled/core_module/scripts/mvc/module/store/StoreModel.as` |
| SSOM | `decompiled/core_module/scripts/managers/StoreSocketOutManager.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| CLK | `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellClickMediator.as` |
| DRP | `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellDropMediator.as` |
| ICLK | `decompiled/core_module/scripts/cell/mediator/storebag/IntensifyBagCellClickMediator.as` |
| IDRP | `decompiled/core_module/scripts/cell/mediator/storebag/IntensifyBagCellDropMediator.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| PI | `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerInfo.as` |
| SPH | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as` |

## 1. Overview

The smith ("Ferreiro") is one client frame that hosts every equipment workshop operation. It has no state of its own on the client: all operations act on a hidden inventory bag, bag type 0 with object id 0 and positions 0..11 (the "smith workspace", `GM:1155-1158`). The player moves items from the normal bags into that workspace (inventory move 5005), presses an operation button, and the server reads the workspace, applies the operation and pushes the updated items. When a tab changes or the frame closes, the client moves every workspace item back to the player bag (`SC.moveGoodsBack`, `SC:490-497`).

This module covers:
- The active shell `store.MakeFrame` ("Fabricar") with its four top tabs and the "store" sub view `StoreView1` with six sub tabs, plus the legacy shell `store.StoreFrame` ("Ferreiro").
- `StoreControler` (FrameControllerManager key `"store"`) and `StoreModel` (panel ids, compose lists, flags).
- The bag views `StoreBagII` (active), `StoreBag` (legacy), `TreasureStoreBag`, `AvengerStoreBag`, `TheseusStoreBag`.
- Item placement into / out of the workspace (click, double click, drag and drop), per tab filters and validations.
- The shared request/response pattern of every smith operation (`StoreReqMsg` / `StoreRspMsg` and the per operation result opcodes), the login recipe push 4184 `U_C_ITEM_SMITH`, and shared tables.

Operation specific routes live in [strengthen.md](./strengthen.md), [gems.md](./gems.md), [enchant.md](./enchant.md), [compose.md](./compose.md), [refine.md](./refine.md), [transfer.md](./transfer.md), [decompose.md](./decompose.md).

Entry points (all call `SC.startFrameByType(panel, data)`, `SC:116-121`, which rebuilds the compose lists, stores `model.defalutPanel` and opens controller `"store"` with `frameData = data`):

| Entry | Panel | Condition | Citation |
|---|---|---|---|
| Main toolbar button `storeBtn` (child button opens `stelesys`) | `STORE_PANEL_INTENSIFY` | Hero level >= 7 (`MainToolCheckBtnOpen.as:38-39`, locked tip "Função habilitada no Nv. 7" `:157-158`); refused while in an Athena team: "Favor sair primeiro do grupo atual!" | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2170-2190` |
| Hotkey T ("Atalho" + "T") | `STORE_PANEL_INTENSIFY` | Not in battle / vehicle, keyboard enabled, `newbieProcess > 19000` | `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:124-125,384-411`, `MainToolCheckBtnOpen.as:98-99` |
| Castle map smithy building (SonType 1501) | `STORE_PANEL_INTENSIFY` | Level >= 7, else "Ferreiro não está aberto!" | `decompiled/m4/scripts/castle/view/CastleBuildingView.as:289-299` |
| Equipped item "upgrade" button | `STORE_PANEL_COMPOSE` with the item as `frameData` | | `decompiled/core_module/scripts/cell/view/playerequip/PlayerEquipCell.as:253-256` |
| Task trace tips | `INTENSIFY`, `MOUNT`, `REFRESH`, `COMPOSE` | | `decompiled/m16/scripts/tasktracetip/view/IntensifyTipView.as:43`, `MountTipView.as:51`, `RefreshTipView.as:43`, `StoreComposeBetterEquipTipView.as:43` |
| Quest "go" links (task condition types 17, 18, 19, 46, 47) and daily guide | 17 `INTENSIFY`, 18 `MOUNT`, 19 `COMPOSE` (sets `StoreModel.defaultChildPanel = 3`), 46 `RESOLVE`, 47 `REFRESH` | `SPH.gotoStoreFrame` checks: INTENSIFY needs `newbieProcess > 19000` (tip "Nível baixo, função habilitada no Nv. 7"); MOUNT/COMPOSE need level >= 15; REFRESH/RESOLVE/SWITCH need level >= 19 | `SPH:190-199,287-291,1333-1367`, `decompiled/core_module/scripts/managers/DayGuideManager.as:536` |
| `ArmyControler.openStoreFarme` | `STORE_PANEL_INTENSIFY` | No caller in this build | `decompiled/core_module/scripts/mvc/controler/ArmyControler.as:263-266` |
| NPC dialog option type 33 (life skills) | opens `"store"` with openType `"SKILL"` -> `store.makeFrame.lifeskill` | Level >= 35 else "Nível insuficiente, a função só é ativada no nível 35."; the class `store.LifeSkillFrame` is absent from the decompiled client (see [enchant.md](./enchant.md)) | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:612-618`, `SC:99-107` |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `MF` `store.MakeFrame` (728x500) | "Fabricar" (`store.view.MakeFrame.title`, `MF:155`) | Active smith shell; 4 top tabs: 0 store (`make.storeBtn`), 1 compose (`make.composeBtn`), 2 switch (`make.switchBtn`), 3 resolve (`make.resolveBtn`) (`MF:153-196`). Tab labels are bitmaps. Help button visible only on the compose tab (`MF:138-147,300-307`) | `SC.frameClassName` returns `store.MakeFrame` unless openType is `"SKILL"` (`SC:99-107`) | Tab 0 -> `StoreView1`; tab 1 -> `ComposeView1` ([compose.md](./compose.md)); tab 2 -> `SwitchView1` ([transfer.md](./transfer.md)); tab 3 -> `NewResolveView` ([decompose.md](./decompose.md)) (`MF:294-377`) |
| `SV1` `store.StoreView1` | (sub view, no title) | Sub tabs: 0 strengthen (`make.store.IntensifyBtn`), 1 inlay (`make.store.MountBtn`), 2 refine (`make.store.refreshBtn`), 3 divine mould / cast (`make.store.CastBtn`), 4 treasure strengthen (`make.store.treasureBtn`), 5 treasure refine (`make.store.treasureRefreshBtn`) (`SV1:80-121`) | MF tab 0 | Left `StoreBagII` (hidden on treasure tabs) and the selected operation view (`SV1:203-249`) |
| `SB2` `store.StoreBagII` | "Equipamentos" (`StoreBagII.equipText.text`) and a per panel material caption `StoreBagII.materialText.text.<panel>`: "Material de Fortalecimento" (INTENSIFY and TREASURE_INTENSIFY), "Material de Inserção" (MOUNT), "Material de Purificação" (REFRESH), "Material de Molde Divino" (CAST), "Material de decomposição obtido" (RESOLVE), "Material de Fundição" (TREASURE_REFRESH); on RESOLVE the equipment caption becomes "Itens" (`SB2:303-313`) | Two scrollable 6 column grids (min 18 cells each, grows by rows): equipment and materials (`SB2:103-141,332-354`) | `SV1`, also used by resolve/switch views | Equipment grid: equipped items of the main hero (bag 4, object id = hero id) then player bag equipment; material grid: player bag props then stone bag (34) props; filtered per panel by `filterGoods` (`SB2:157-231,744-872`) |
| `TSB` `store.treasure.TreasureStoreBag` | toggles "Externo" / "Interno" (`TreasureStoreBag.outerBtn.text` / `.innerBtn.text`) | Treasure item grid (SonType 750 outer, 751 inner) and stone grid | Treasure strengthen / refine views ([strengthen.md](./strengthen.md), [refine.md](./refine.md)) | Treasures from `GM.getTreasureListByType(type)` (resolve: `getTreasureBagListByType`); material = stone 2127022 / 2127026 (strengthen) or 2127021 / 2127025 (refine) (`TSB:166-228,406-435`). Changing the toggle dispatches `STORE_TREASURE_BAG_UPDATE` and returns workspace items (`TSB:181`) |
| `ASB` `store.AvengerStoreBag`, `THSB` `store.TheseusStoreBag` | | Avenger (devil armor) and Theseus (war frame) virtual bags used by the resolve sub views | [decompose.md](./decompose.md) | `AvengerManager.model.armorBagDic` split by SonType 670 (`ASB:272-289`); `TheseussoulManager.model.armorBagDic` (`THSB:269-289`) |
| `SF` `store.StoreFrame` (728x465) | "Ferreiro" (`store.view.StoreFrame.title`, `SF:111`) | Legacy shell with 7 tabs: intensify, mount, compose, refresh, resolve, switch, cast (cast only when `VersionSwitch.STORE_CAST`) and the legacy `StoreBag` (`SF:109-144,232-381`) | Not reachable: `SC.frameClassName` never returns it; only `MainBarFrameType.STORE` keeps the name for toolbar fly-in animation (`MainToolBar.as:1459-1462`) | Same views as the active shell |
| `SB` `store.StoreBag` | | Legacy bag with the same filter logic (includes `STORE_PANEL_ENCHANT`, `SB:540`) | `SF` | |
| Help frames `core.StoreHelpFrame_1..8` | help texts `store.StoreControler.helpContent01..08` | Per panel help: 1 intensify, 2 mount, 3_<composeType> compose, 4 refresh, 5 resolve, 6 switch, 7 cast, 8 enchant (`SC:257-287`) | MF help button (compose only in the active shell) | Static text |

## 3. Routes (client to server)

The smith frame itself sends nothing when it opens. All placement actions reuse the inventory move route.

### R1. Place an item into the smith workspace (double click in StoreBagII)
- UI: double click on a `StoreBagCell` of `StoreBagII` / `TreasureStoreBag` (`CLK:82-272`). Single click starts a "drag to target" selection (`DRAG_ITEM_BagNotic`, `CLK:56-80`).
- Client checks, in order (`CLK:82-272`):
  1. Cells of bag 101/102 forward to the generic `DOUBLE_CLICK` notification; no panel selected -> generic `DOUBLE_CLICK` (normal bag behavior).
  2. `canDoubleClick` false: panel COMPOSE; panel MOUNT with SonType 299 (Perfurador); panel INTENSIFY while `model.isIntensifing` (`CLK:301-323`).
  3. Panel MOUNT with a gem (SonType 205 / 228): handled as inlay, see [gems.md](./gems.md) R2 (`CLK:325-453`).
  4. Locked item (`isLock`) on RESOLVE: "Não é possível Decompor equipamento bloqueado" (`AllResolvePopFrame.Avenger.name2`).
  5. Target position: 1 for SonType 204 (luck / strengthen stones), else 0 (`CLK:116-123`).
  6. REFRESH or CAST with a non equipment (MasterType != 1): "Tipo de equipamento incorrespondente".
  7. SWITCH with a locked item: "Os itens bloqueados não podem ser trocados".
  8. ENCHANT: equipment -> pos 0, material SonType 236 -> pos 1, compatibility check, see [enchant.md](./enchant.md).
  9. RESOLVE: position from `SC.getGoodsPosForRelove` (first free of 0..11) plus confirmations, see [decompose.md](./decompose.md).
  10. INTENSIFY: luck stone compatibility with the equipment in pos 0, see [strengthen.md](./strengthen.md); count = full stack for SonType 228 else 1 (`CLK:174-215`).
  11. TREASURE_INTENSIFY / TREASURE_REFRESH: MasterType must be 11, else "O tipo de tesouro não corresponde" (`CLK:216-235`).
- Sender: `PlayerManager.moveBagToBag(beginBag, beginObj, beginPos, 0, 0, toPos, count)` (`PM:1602-1606`) -> `SocketSendManager.sendMoveBagToBag` (`SSM:139-155`).
- Route: client to server, 5005 (0x138d) `U_C_BAG_MOVE`, `item.ItemReqMsg`:
  - `begin_bag_type` (#1, INT32): source bag (1 player bag, 4 hero equipment, 34 stone bag, 6 guild bag).
  - `begin_obj_id` (#2, INT32): source object (hero id for bag 4, else 0).
  - `begin_pos` (#3, INT32): source slot.
  - `end_bag_type` (#4, INT32) = 0 (smith workspace).
  - `end_obj_id` (#5, INT32) = 0.
  - `end_pos` (#6, INT32): workspace slot (0 main item, 1 material, 0..11 for resolve).
  - `count` (#7, INT32): 1, or the stack size for SonType 228 on INTENSIFY.
  - `object_id` (#8, INT32): unset.
- Expected response: push 115 `U_C_BAG_MOVE_UPDATE` with the source slot cleared and workspace slot filled (owned by [../inventory/README.md](../inventory/README.md)). Equipped items keep their hero binding semantics: the server must treat a bag 4 item moved to bag 0 as temporarily unequipped. Assumption: the hero attribute push follows when an equipped item leaves bag 4.

### R2. Place an item by drag and drop
- UI: drag a `StoreBagCell` onto a workspace cell (`DRP:125-429`): `StoreJewelCell` (gem inlay, [gems.md](./gems.md)), `StoreMountCell` (equipment for inlay, MasterType 1 only), `StoreResolveCell`, `StoreRefreshCell` (MasterType 1 or 11), `StoreCastCell` (MasterType 1), `StoreSwitchCell` (not locked), `StoreEnchantCell`, `StoreIntensifyCell` (204 stones only into the material cell, MasterType 1/11 only into the main cell). Drop onto a `battleguard_*` icon routes to battle guard gems (`PM.sendAddBattleGem`, not smith).
- Sender: `DRP.swapItem` -> `moveBagToBag(src.bagType, src.objectId, src.pos, target.bagType, target.objectId, target.pos, 1)` (`DRP:449-452`).
- Route: 5005 as in R1 with `end_*` = target cell (bag 0).

### R3. Return one workspace item
- UI: double click a workspace cell (`ICLK:50-65`) or drag it back onto a bag cell (`IDRP:139-168`).
- Client rule: gems / crystals / child gems (`GM.isStoreBagGoods`: SonType 205, 228, 312, 224, 329, `GM:2059-2082`) go to the stone bag 34 when `playerInfo.stoneBagCount > 0`, everything else to bag 1.
- Route: 5005 with `begin_bag_type` = 0, `begin_obj_id` = 0, `begin_pos` = workspace slot, `end_bag_type` = 34 or 1, `end_obj_id` = 0, `end_pos` = 0, `count` = 1.
- Assumption: `end_pos` = 0 with a non workspace end bag means "first free slot / merge stack" (the client never computes a real slot here).

### R4. Return all workspace items (tab change, frame close)
- Trigger: `SC.moveGoodsBack` on every tab change (`MF:297`, `SV1:246`, `SF:235`), on `TSB` toggle (`TreasureIntensifyView.as:311-316`) and on `exitFrame` (`SC:109-114`).
- Route: one 5005 per item in bag 0: `begin_bag_type` 0, `begin_obj_id` 0, `begin_pos` item pos, `end_bag_type` 1, `end_obj_id` 0, `end_pos` 0, `count` 1 (`SC:490-497`).
- Note: count 1 even for stacks (a SonType 228 stack placed with its full count). Assumption: the server moves the whole stack when the source is bag 0, and also returns workspace items to bag 1 on logout / login if the client disconnected with items in bag 0.

### R5. Request smith data at login
- Sender: `LoginInitDataAccept.request` sets `PlayerDataMsg.smith = true` (`decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as:154-184`, line 167) -> `SSM.loginDataReq` (`SSM:83-87`).
- Route: 8224 (0x2020) `C_LONIG_LOAD_REQ`, `player.PlayerDataMsg`, relevant field `smith` (#8, BOOL) = true (other flags belong to [../account/README.md](../account/README.md)).
- Expected response: 4184 `U_C_ITEM_SMITH` with the full known recipe list (S1), plus the bag data (bag 0 included) from the inventory login load.

### Generic smith operation request (reference)
Every operation request is a separate opcode carrying `store.StoreReqMsg` (or a dedicated message). `StoreReqMsg` fields and which operation uses them:

| Field | Meaning | Used by |
|---|---|---|
| `hole_pos` (#1, INT32) | socket index 1..4 | 5152 punch / remove gem ([gems.md](./gems.md)) |
| `operate` (#2, BOOL) | 5152: true open hole, false remove gem; 5153: inherit mould ("extendsMould") | gems, compose |
| `bag_type` (#3, INT32) | source bag of the gem | 5151 inlay |
| `bag_pos` (#4, INT32) | source slot of the gem | 5151 inlay |
| `mount_pos` (#5, INT32) | target socket 1..4 | 5151 inlay |
| `compose_id` (#6, INT32) | recipe id | 5153 compose |
| `compose_num` (#7, INT32) | quantity | 5153 compose |
| `auto_buy` (#8, BOOL) | buy missing materials with diamonds | 5153 compose (gems "Sintetizar Agora") |
| `src_itemid` (#9, INT32) | source item / 0 | 5150 strengthen (always 0 from the active client), 8538 transform |
| `des_itemid` (#10, INT32) | target item | 8538 transform |
| `count` (#11, INT32) | quantity | 8538 transform, 8594 fashion compose |
| `pay_type` (#12, INT32) | 0 = default (bound first) / 1 = alternative payment (see per module) | 5152, 5153 |
| `opType` (#13, INT32) | 5150 sub operation: 0 normal, 1 one key, 3 treasure | strengthen |

Operation opcodes (client to server) and their result opcode:

| Request | Name | Message | Result push | Module |
|---|---|---|---|---|
| 5150 (0x141e) | `U_C_ITEM_STRENGTHEN` | `StoreReqMsg` | 86 `U_C_ITEM_STRENGTHEN` | [strengthen.md](./strengthen.md) |
| 5151 (0x141f) | `U_C_ITEM_INLAY` | `StoreReqMsg` | 87 `U_C_ITEM_INLAY` (no client listener) | [gems.md](./gems.md) |
| 5152 (0x1420) | `U_C_ITEM_INLAYJOIN` | `StoreReqMsg` | 88 `U_C_ITEM_INLAYJOIN` (no client listener) | [gems.md](./gems.md) |
| 8484 (0x2124) | `C_BAG_USESTORE` | `item.ItemUseStoreReqMsg` | 3 `U_C_PLAYER_INFO` | [gems.md](./gems.md) |
| 5153 (0x1421) | `U_C_ITEM_COMPOSE` | `StoreReqMsg` | 89 `U_C_ITEM_COMPOSE` | [compose.md](./compose.md) |
| 8644 (0x21c4) | `C_MOULD_ITEM` | `player.PayTypeMsg` | 4558 `U_C_MOULD_ITEM` | [compose.md](./compose.md) (cast) |
| 8336 / 8339 / 8464 | refine random / replace / property | `SmithFreshReqMsg` / none / `RefreshPropertyReqMsg` | 4258 / 4259 / 4368 | [refine.md](./refine.md) |
| 8538 (0x215a) | `C_ITEM_TRANSFORM` | `StoreReqMsg` | | [transfer.md](./transfer.md) |
| 8340 / 8683 | resolve / new resolve | none / `PlayerOpMsg` | 4260 `U_C_RESOLVE` | [decompose.md](./decompose.md) |
| 8971 (0x230b) op 7 | `C_LIFE_SKILL_OP` | `simple.PropertyMsg` | 4788 `U_C_EQUIPMENT_ENCHANT` | [enchant.md](./enchant.md) |

## 4. Server messages (server to client)

### S1. 4184 (0x1058) `U_C_ITEM_SMITH`
- Message `item.ItemSmithyMsg`: `composeId` (#1, INT32, repeated) = recipe ids (`ComposeTempInfos.xml` `Id`).
- Receiver: `PlayerManager.__addComposeTempHandler` (`PM:155,450-459`) -> `PlayerInfo.addComposeTemp` (`PI:1204-1217`): the first message sets `composeList`; later messages append and set `addCompose`; commit dispatches `COMPOSE_LIST_CHANGE` (`PI:1502-1505`, no listener in this build).
- When: response to R5 (full list), and push with only the new ids whenever recipes are granted. `SC.addComposeToTemp` only shows recipes present in `composeList` (`SC:159-191,230-237`), so the full list is mandatory. Table and grant rules: [compose.md](./compose.md) (`smith.known_recipes`).
- Note: despite its name this opcode carries no operation result.

### S2. 115 (0x0073) `U_C_BAG_MOVE_UPDATE`
- Message `item.ItemMovedListMsg`: `moved` (#1, `ItemMoveUpdateMsg`, repeated) with `change_type` (#1, INT32), `change_obj_id` (#2, INT32), `change_pos` (#3, INT32), `item` (#4, `item.ItemInfoMsg`). Smith relevant `ItemInfoMsg` fields: `pos` (#3), `object_id` (#5), `bag_type` (#6), `bind` (#7), `count` (#11), `strengthen_grade` (#17), `join_1..join_4` (#18..#21, socket state), `random_skill_1..5` (#22..#26), `mould_grade` (#32), `bless_value` (#33), `is_locked` (#35), `str_bless_value` (#36). Full definition: [../inventory/README.md](../inventory/README.md).
- Receiver: `GoodsManager.__bagUpdateHandler` (`GM:98,101`) -> `UPDATE_BAG` / `DELETE_BAG` events consumed by every smith view (`SB2:633-680`, operation views).
- When: after every R1..R4 move and after every smith operation (item changed, material consumed, item created or deleted). Must be sent before the operation result message, because result handlers read the workspace item (`IntensifyView.as:638-646`).

### S3. 54 (0x0036) `U_C_BAG_MOVE`
- Accepted opcode for the 5005 response; no client listener. Assumption: the server may send it with a result code; the client relies only on S2. Errors for invalid moves: 126 `U_C_MSG` text notice ([../inventory/README.md](../inventory/README.md)).

### S4. Resource pushes after paid operations
- Gold: 109 (0x006d) `U_C_CASTLE_UPDATE`, `castle.CastleYieldMsg` (`gold_total_count` #6 etc.), receiver `ResourceManager.__resourceUpgrade` (`decompiled/core_module/scripts/yishi/manager/ResourceManager.as:61-72`). Owner: [../currency/README.md](../currency/README.md).
- Diamonds / player attributes: 3 (0x0003) `U_C_PLAYER_INFO`, `player.PlayerMsg`, receiver `PM.__uPlayerInfoHandler` (`PM:150,496`). Owner: [../hero/README.md](../hero/README.md).
- Errors: 126 (0x007e) `U_C_MSG` (text notice). The smith views re-enable their buttons only on their own result message, so a failure without a result message leaves the button disabled until the view is rebuilt; Assumption: on failure the server sends the operation result message with `false` where one exists (86, 89, 4258, 4260) plus 126.

## 5. Rules and formulas

Tab unlock conditions:

| Tab | Condition | Client behavior | Citation |
|---|---|---|---|
| MF store (strengthen etc.) | none (frame needs level 7) | | |
| MF compose | level >= 15 | disabled + strip tip "Função habilitada no Nv. 15"; click blocked | `MF:184-187,259-266` |
| MF switch, MF resolve | level >= 19 | disabled + tip "Função habilitada no Nv. 19" | `MF:188-195` |
| SV1 mount (inlay) | level >= 15 | disabled + tip; click blocked | `SV1:107-110,254-259` |
| SV1 refresh | level >= 19 | | `SV1:111-114,260-265` |
| SV1 cast | level >= 80 (enable) and `vocationGrades > 0` on click, else "Esta função será liberada após o avanço de nv.80" | | `SV1:115-118,266-271` |
| SV1 treasure, treasure refresh | visible only when `RoyaltyBossManager.model.royaltyLevel > 0` and `VersionSwitch.TREASURE` | | `SV1:119-120` |
| Legacy SF | compose/mount >= 15, refresh/resolve/switch >= 19, cast needs `vocationGrades > 0` | | `SF:209-230` |

Default tab: `MF.show` selects tab 1 only for `STORE_PANEL_COMPOSE`, otherwise tab 0 (`MF:134-151`); `SV1.initTabSelect` maps INTENSIFY 0, MOUNT 1, REFRESH 2, CAST 3, TREASURE_INTENSIFY 4, anything else 0 (`SV1:168-191`). Quirk: `gotoStoreFrame("STORE_PANEL_RESOLVE")` and SWITCH open the store tab on strengthen, not the resolve / switch tab. When `frameData` is a `GoodsInfo`, `MF.showStoreView` auto places it by simulating a double click in `StoreBagII` (`MF:328-347`, `SB2:483-519`).

Panel ids (`StorePanelEnum`): `STORE_PANEL_INTENSIFY`, `STORE_PANEL_MOUNT`, `STORE_PANEL_COMPOSE`, `STORE_PANEL_REFRESH`, `STORE_PANEL_RESOLVE`, `STORE_PANEL_SWITCH`, `STORE_PANEL_CAST`, `STORE_PANEL_ENCHANT`, `STORE_PANEL_TREASURE_INTENSIFY`, `STORE_PANEL_TREASURE_REFRESH` (`decompiled/core_module/scripts/yishi/datas/consant/StorePanelEnum.as`). `model.selectedPanel` changes dispatch `SELECTED_PANEL_CHANGE`, which reloads `StoreBagII` (`SM:413-420`, `SB2:628-631`).

Bag types used by the smith: 0 workspace (object 0, pos 0..11), 1 player bag, 4 hero equipment (object = hero id, `GM:948-958`), 34 stone bag, 6 guild bag (punch tool lookup), 101/102 ignored by smith clicks.

Workspace slot layout per panel:

| Panel | Slot 0 | Slot 1 | Other |
|---|---|---|---|
| INTENSIFY | equipment (MasterType 1 / SonType != 204) | luck or strengthen stone (SonType 204) | |
| TREASURE_INTENSIFY / TREASURE_REFRESH | treasure (MasterType 11) | | stones read from bags |
| MOUNT | equipment | | gems go straight into sockets (5151) |
| REFRESH / CAST | equipment (MasterType 1) | | see refine / compose |
| SWITCH | source item | | see transfer |
| RESOLVE | items 0..11 | | see decompose |
| ENCHANT | equipment | enchant material (SonType 236) | |

`StoreBagII.filterGoods` per panel (`SB2:744-872`): MasterType 5 and 6 never shown; fashion items hidden except on RESOLVE; INTENSIFY: SonType 204 or `StrengthenMax > 0`; MOUNT: SonType 205, 228, 299 or MasterType 1 with SonType != 109; COMPOSE: everything; REFRESH: SonType 215, MasterType 1 with `Refresh != 0`, template 208027 when `VersionSwitch.REFRESH_LOCK`; SWITCH: `TransformId > 0` and SonType not 343/344; CAST: mould materials 2120100..2120107 or `StrengthenMax > 0 && Profile >= 5 && NeedGrades >= 50` (excluding 1170006..1170009, 1180006..1180009 when `SPEASAL_CAST`); ENCHANT: MasterType 1 or MasterType 2 SonType 236. Treasure stones 2127021, 2127022, 2127025, 2127026 are never shown in the material grid (`SB2:200-203`).

Sort: equipment unbound first, then higher `Profile`, higher `NeedGrades`, higher `strengthenGrade` (`SB2:233-268`); materials unbound first, then MasterType, NeedGrades, TemplateId desc, Profile desc (`SB2:521-564`).

Client side flags kept in `StoreModel`: `isIntensifing` (blocks bag clicks during the strengthen animation), `isEnchantfing`, `isViceIntensifing`, `autoBuy`, `selectedCompose`, `currentComposeCount` and the compose lists (`SM:211-265`). Confirmation "do not ask today" flags are client local `SharedManager` values (`IS_STRENGTHEN`, `resolveStrengthen`, `showResolveAlertForMountCard`, `showResolveAlertForFashion`).

Batch operations in the smith: compose quantity (`compose_num` up to `canMakeCount`, or up to 9 with auto buy, `SC:798-866`, [compose.md](./compose.md)); decompose all (`AllResolvePopFrame`, [decompose.md](./decompose.md)); one key strengthen `opType = 1` exists in `SSOM.sendOneKeyIntensify` (`SSOM:68-75`) but has no caller ([strengthen.md](./strengthen.md)).

Fight power: both shells call `setFightingCapacityRecord("start")` on open and `"end"` on close and dispatch `REFRESH_FIGHT` (`MF:149,402-403`); purely client side.

Quest hooks: task condition types 17 (strengthen), 18 (inlay), 19 (compose), 46 (decompose), 47 (refine) (`SPH:190-199,287-291`). The server must report progress to [../quests/README.md](../quests/README.md) after each successful operation of that kind.

## 6. Templates

| File | Record | Fields used here |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | `ItemTempInfo` (12201 rows) | `TemplateId`, `MasterType` (1 equipment, 2 prop, 11 treasure), `SonType` (per panel filters above), `Profile` (quality), `NeedGrades`, `StrengthenMax`, `Refresh` (refine / decompose eligibility), `TransformId` (switch), `Job` ("99" = dragon / vice equipment, `GoodsTemplateInfo.as:247-263`), `NeedChangeJob`, `Property1..6` (per module) |
| `raw/xml/tempinfos/ComposeTempInfos.xml` | `ComposeTempInfo` (3340 rows) | `Id` is the id carried by 4184; details in [compose.md](./compose.md) |
| `raw/ui/zh_cn/xml/decoded/store.xml` | UI layout | style names quoted above |

## 7. Persistent state

The workspace is not a smith table: items in it are ordinary `inventory.items` rows with `bag_type = 0`. Assumption: `inventory.items(item_id BIGINT PK, player_id, template_id, bag_type, position, count, ...)` exists and enforces `position BETWEEN 0 AND 11` for bag 0.

Recipes: `smith.known_recipes` is defined in [compose.md](./compose.md).

Shared operation log for the operations of part A modules (strengthen, gems, enchant). Part B modules keep their own logs: `smith.compose_log` ([compose.md](./compose.md)), `smith.refresh_log` ([refine.md](./refine.md)), `smith.transform_log` ([transfer.md](./transfer.md)), `smith.resolve_log` ([decompose.md](./decompose.md)):

```sql
CREATE SCHEMA IF NOT EXISTS smith;

CREATE TABLE smith.operation_log (
    log_id          BIGSERIAL PRIMARY KEY,
    player_id       BIGINT      NOT NULL REFERENCES player.players(player_id),
    operation       TEXT        NOT NULL CHECK (operation IN (
                        'strengthen','strengthen_treasure','inlay','socket_open','gem_remove',
                        'soul_seal','enchant')),
    item_id         BIGINT,                 -- main item (inventory.items.item_id), NULL when not applicable
    template_id     INTEGER,
    success         BOOLEAN     NOT NULL,
    value_before    INTEGER,                -- e.g. strengthen grade, socket state
    value_after     INTEGER,
    gold_spent      BIGINT      NOT NULL DEFAULT 0,
    diamonds_spent  BIGINT      NOT NULL DEFAULT 0,
    materials       JSONB       NOT NULL DEFAULT '[]'::jsonb, -- [{template_id, count}]
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX operation_log_player_idx ON smith.operation_log (player_id, created_at DESC);
CREATE INDEX operation_log_item_idx   ON smith.operation_log (item_id) WHERE item_id IS NOT NULL;
```

Per item smith attributes are defined in the module that owns them: `smith.item_strengthen` ([strengthen.md](./strengthen.md)), `smith.item_sockets` ([gems.md](./gems.md)), `smith.item_enchant` ([enchant.md](./enchant.md)), `smith.item_mould` ([compose.md](./compose.md)); pending refine results `smith.pending_refresh` ([refine.md](./refine.md)).

## 8. Backend implementation notes

- Workspace moves are handled by the inventory 5005 handler. Smith adds a validation hook `smith::store_frame::validate_workspace_move(player, item, end_pos)` called when `end_bag_type = 0` or `begin_bag_type = 0`:
  1. `end_pos` in 0..11, slot empty or same template stackable.
  2. Item exists, belongs to the player, not expired. Locked items are rejected for resolve and switch (client also blocks).
  3. Do not trust panel specific filters from the client; each operation handler re validates the workspace content.
- Login: `smith::store_frame::handle_login_smith_data` when `PlayerDataMsg.smith` is set: push 4184 with all known recipes (delegates to `smith::compose::push_known_recipes`). Also `smith::store_frame::return_workspace_items(player)` on login and logout: move bag 0 items back to bag 1 (or stone bag 34 for SonType 205/228/312/224/329 when the stone bag exists), mail them if the bag is full (Assumption).
- Generic operation pattern for every smith handler (`smith::<module>::handle_<action>`):
  1. Load player (row lock `FOR UPDATE`) and the workspace items (bag 0) in one transaction.
  2. Validate level / tab unlock (table above), item eligibility by template, costs (gold, diamonds, materials).
  3. Deduct costs, roll RNG server side, mutate item attributes, consume materials, bind the item when the operation binds (strengthen, inlay, punch, compose results are bound per help texts).
  4. Insert `smith.operation_log` (or module log).
  5. Commit, then push in order: 115 item updates, the operation result opcode, 109 gold / 3 player info, quest progress, hero attribute refresh when the item is equipped.
- Serialize all smith operations per player (single player actor or advisory lock on player_id) to avoid double spending from fast clicks.
- No timers, no battles, no pushes to other players.

## 9. Open questions and assumptions

- Assumption: 5005 with end bag 1 / 34 and `end_pos = 0` means auto placement; the client always sends 0 for returns (`SC:490-497`, `ICLK:57-64`).
- Assumption: the server returns bag 0 items to the player bags when the session ends; the client only does it on frame close.
- Assumption: equipped items (bag 4) moved into the workspace are unequipped for attribute computation while in bag 0, and the client expects them back in bag 1 (not re equipped) on frame close (`SC:490-497`). Confirm whether the original server re equipped them.
- Open: 54 `U_C_BAG_MOVE`, 87 and 88 have no listener; the payload the original server sent is unknown. Recommended: send `StoreRspMsg` with the result flag for 87/88 anyway.
- Open: `PlayerDataMsg.smith` may also have triggered other pushes (e.g. life skill data 4787); only 4184 is evidenced.
- The legacy `StoreFrame` / `StoreBag` are unreachable; implement only the `MakeFrame` flow.

## 10. Implementation checklist

- [ ] Screen `MakeFrame` tabs and unlock rules (compose 15, switch 19, resolve 19).
- [ ] Screen `StoreView1` sub tabs and unlock rules (mount 15, refresh 19, cast 80 + advanced job, treasure tabs by royalty level).
- [ ] `StoreBagII` filters per panel and sort order (server side equivalents for validation).
- [ ] `TreasureStoreBag` outer / inner toggle data sources.
- [ ] Route R1/R2 workspace placement via 5005 with smith validation hook.
- [ ] Route R3/R4 workspace return via 5005 (auto slot, whole stack, stone bag rule).
- [ ] Route R5 login smith flag -> 4184 full recipe list.
- [ ] Server message S1 4184 (login full list + increments).
- [ ] Server message S2 115 ordering before every result opcode.
- [ ] Server message S4 109 / 3 after paid operations, 126 on errors.
- [ ] Entry points: toolbar (level 7), hotkey T, castle building, equip upgrade button, task tips, quest links 17/18/19/46/47.
- [ ] Table `smith.operation_log`.
- [ ] Workspace cleanup on login / logout.
- [ ] Per player serialization of smith operations.
- [ ] Tests: move into each slot type, invalid slot, locked item, return with full bag, disconnect with items in bag 0, recipe list at login.
