# Theseus collection ("Coleção", code name cangping / TREASURECANGPING)

Module `collection`. A collectible album attached to the Theseus main frame: the player gathers shards of 24 "Arma Divina do Desafio de Teseus" collectibles, activates them, raises them from 0 to 10 stars with gold, shards and "Metal Divino", completes six 4-piece sets, opens five kinds of collection chests, buys chests with diamonds and climbs a 75-level "collector level" fed by opened Diamond chests.

**Feature switch.** `VersionSwitch.TREASURECANGPING = false` (`CM/yishi/datas/VersionSwitch.as:258`) and nothing assigns it at runtime, so in this build the "Coleção" button is never added to the Theseus equipment view (`T/view/ThereussoulEquipView.as:174-182`) and `TheseusCollenseFrame` is unreachable. The feature is hidden but fully mapped below. Two parts run anyway and need a server answer (see §8): the equipment view always sends 9740 op 1 (`T/view/ThereussoulEquipView.as:92`) and always listens to the collection events and to 212 (`:266-269`).

Path aliases:

| Alias | Path |
|---|---|
| C | `decompiled/m5/scripts/theseusCollention` |
| T | `decompiled/m5/scripts/theseus` |
| CM | `decompiled/core_module/scripts` |
| MGR | `decompiled/core_module/scripts/managers/TheseussoulManager.as` |
| MOD | `decompiled/core_module/scripts/mvc/module/theseus/TheseusCollenTionModel.as` |
| TX | `raw/xml/tempinfos` |

Conventions: opcode names from `protocol/opcodes.csv` (4725 is missing there and comes from `build/as3/gen/yishi/datas/consant/AcceptProtocolType.ts:543`). Proto fields from `protocol/proto.json`; every tag below was re-checked against the generated `writeToBuffer` in `build/as3/gen/com/road/yishi/proto/<pkg>/<Msg>.ts`. The readable TypeScript of every cited class is at `build/as3/gen/<same package path>.ts`. *(assumption)* marks anything the client does not prove.

---

## 1. Overview

- **Entry point (dead in this build).** Theseus main frame ("Alma de Teseu", see [soul.md](soul.md)) → equipment tab `ThereussoulEquipView` → button `theseuscollention.collentionBtn` with label "Coleção" (`T/view/ThereussoulEquipView.as:115-117`). Click → `theseussoulController.backTheseFrame = "theseussoul"` and `openControllerByInfo("theseussoul",9)` (`:287-291`) → `CM/mvc/controler/TheseussoulController.as:64-67` returns `theseusCollention.TheseusCollenseFrame`. Closing the frame reopens the main Theseus frame (`TheseussoulController.as:81-87`). No other caller opens type 9.
- **Unlock.** No own condition. It inherits the Theseus main frame conditions: hotkey requires `VersionSwitch.THESESOUL`, `thane.vocationIndex > 0` and `royaltyLevel > 0` (`CM/yishi/keyboard/KeyBoardRegister.as:1176-1190`); the toolbar child button of archaeology opens it too (`CM/ui/maintoolbar/MainToolBar.as:2353-2355`). Plus the switch above.
- **Six tabs** (image labels, no text; `C/TheseusCollenseFrame.as:62-93, 155-197`):
  1. Collected (album): activate and star up collectibles.
  2. Suit: six 4-piece sets with 0/3/6/10 star bonuses.
  3. Chip (shards bag): list of bag type 5 items, "Decompor" shards into Metal Divino.
  4. Box: open collection chests (x1, x10) and claim the point progress chest.
  5. Shop: buy chests with diamonds, weekly limit.
  6. Collector level: 75 reward levels based on Diamond chests opened.
- **Item storage.** Shards, Metal Divino and collectibles live in virtual bag type 5; chests in virtual bag type 6 (`CM/yishi/manager/BaseManager.as:372-381, 423-432`). Neither appears in the normal bag; no "use item" flow exists for SonType 350/2000/2001/2002 in the client.
- **Sources.** Chests 3501/3502 drop from "Desafio de Teseus" (`TX/StoreHouseChapterTmpls.xml` `FirstPassAward="3501,2|3502,2"`, `TX/StoreHouseMapTmpls.xml` `Award="3501,1,900|3502,1,100"`), from the shop (ShopType 1035) and from collector level rewards (3505). Shards come only from chests; Metal Divino from chests, resolve and level rewards.
- **Dependencies:** [soul.md](soul.md) (main frame, controller), the Theseus box challenge module of [README.md](README.md) (chest drops), core virtual bag (211/212), currency tokens (4725, masterType 70), gold resource, diamonds (`playerInfo.point`), shop purchase flow 8970 and counters 528, `SkillPropertyTempInfos` (stat effects applied server side).

---

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `C/TheseusCollenseFrame.as` | "Coleção" (`TheseusCollentionFrame.title`, `:219-223`) | 900x600 frame, 6 tab buttons, red dots on tabs 1, 4, 6 | `openControllerByInfo("theseussoul",9)` | Sends 9740 op 1 in its constructor (`:54`). Red dots `_redcollention` = `checkAllcollectionRed()`, `_redbox` = `checkAllboxRed()`, `_redboxcoll` = `model.allred` (`:121-135`), refreshed on 212 at once and 2 s after `EVENT_COLLECTION_UPDATE` / `OP_COLLECTION_UPGRADETASK` (`:103-119`) |
| `C/view/TheseusCollentionedView.as` | (tab 1) | Left scroll + right detail | Tab 1, default | Hosts the two views below (`:31-50`) |
| `C/UI/TheseusCollenedLeftViewUI.as` | | 3 rarity sections | Tab 1 | `byProGetCollection(1..3)` (Profile 3, 4, 5) (`:54-69`), refreshed on `EVENT_COLLECTION_UPDATE` (`:27`) |
| `C/UI/TheseusCollenedBigItemUI.as` | "Raro", "Épico", "Lendário" (`TheseusCollenedBigItemUI.profile1..3`) | One rarity section | Left view | Header color `0x34a1f4`, `0xad38f8`, `0xff8100` (`MOD:39`), item grid (`:56-109`) |
| `C/UI/TheseusCollentionItemUI.as` | | One collectible tile | Section grid (type 1), suit row (type 2) | Icon `icon/collection/<TemplateId>.png` (`CM/yishi/manager/PathManager.as:808-811`), gray if not activated, name colored by rarity, star icons, shard progress bar `owned/needed` when not activated, red dot (type 1 only) `checkRed(TemplateId)` (`:157-210`). Click → `MsgMan.notifyObserver("TheseusCollentionItemUI", data)`, `model.selectData = TemplateId` (`:266-270`) |
| `C/UI/TheseusCollenedRightViewUi.as` | button "Visualizar" (`theseus.equip.QHtips2`) | Selected collectible detail and action buttons | Tile click | Name, quality text, current star `x{star}` and next `x{star+1}`, up to two attribute names (`TheseusCollenedBigItemUI.<Attr>`, e.g. "Defesa", "Resistência", "Ataque Físico", "Magia", "Vida") with current and next values, special effect text, cost lines "Ouro" `owned/UpGold`, shard cell `owned/chipNeedNum`, "Metal Divino" `owned/chipNeedNum1` (red `#CE0F0F` when short, green `#04EF25` when enough). Buttons `_jihuo` (activate) and `_upStar` (star up) (`:338-541`) |
| `C/UI/TheseusMaxCollectItemUI.as` | "X10" | Star 10 preview popup toggled by "Visualizar" | Right view (`:263-268`) | Attributes of the Star 10 row (`starMaxInfo`) (`:58-79`) |
| `C/view/TheseusCollentionSuitView.as` | (tab 2) | List of all suits | Tab 2 | One `TheseusCollentionSuitBigItem` per `CollectionSuitTemplates` row (`:31-57`) |
| `C/item/TheseusCollentionSuitBigItem.as` | `SuitName` (e.g. "Viajante Dimensional") | One suit row | Suit view | The 4 collectibles (`getSuit(Suit)`) as type 2 tiles (`:72-99`) |
| `C/UI/TheseusSuitItemUI.as` | "[0 Estrela]", "[3 Estrelas]", "[6 Estrelas]", "[10 Estrelas]" (`theseusCollention.UI.suit1..4`) | Suit bonus text | Suit row | `Star0Desc`..`Star10Desc`, grayed when `model.suit(Suit, 0/3/6/10)` is false (`:56-92`) |
| `C/view/TheseusCollentionChipView.as` | (tab 3) | Bag type 5 grid (12 per row, at least 108 cells) and detail | Tab 3 | Every bag 5 entry with count; selection shows icon, name, quality, `Description`, button "Decompor" (`:64-130, 161-215`); refreshed on 212 (`:103`) |
| `C/item/SpliteCollectionFrame.as` | "Decompor" (`TheseusCollenedBigItemUI.resolve`) | Quantity input for resolve | "Decompor" button (`C/view/TheseusCollentionChipView.as:144-159`) | Extends `CM/bag/view/SpliteItemFrame.as` (default text "1", button "Confirmar"); input clamped to the owned count (`:19-23`) |
| `C/item/TheseusCollentionBagCell.as` | | Item cell with count text (`1.5k` style) | Chip grid, right view | `GoodsInfo` (`:58-141`) |
| `C/view/TheseusBoxView.as` | "Visualização dos Prêmios", "Probabilidade", "Coletar" (`TheseusCollenedBigItemUI.boxtext3/4/5`) | Open chests and claim the progress chest | Tab 4 | Five chest buttons (`TheseusBoxItem`), selected chest name, "Possuído：{0}" (`boxtext2`), drop preview grid, probability text (chest `Description`), progress bar `points/boxProcess`, text "ainda falta {0} pontos para obter {1}" (`boxtext1`), open x1 / x10 buttons, clickable chest animation when the progress is full (`:112-333, 462-510`) |
| `C/item/TheseusBoxItem.as` | chest `TemplateName` | Chest selector | Box view | Count, red dot when count > 0 (`:82-96`); click sets `model.selectBox` (`:68-75`) |
| `C/view/TheseusCollectShowBoxFrame.as` | | Result popup for multi-item opens | Box view animation (`C/view/TheseusBoxView.as:390-395, 437-441`) | Items of 585, 2 rows (`:57-82`) |
| `C/shop/TheseusCollentionShopView.as` | "Quantidade à escolha:" (`theseuscollectbox.txt2`) | Buy chests | Tab 5 | 5 chest goods (`TheseusShopItem`), quick quantity 1/10/50 (a 100 button is created but never added, `:113-143`), input, total price in diamonds (cyan `#95feff` / red) (`:82-198, 442-479`) |
| `C/shop/TheseusShopItem.as` | "Limite de Compra Semanal:" / "Sem limite" (`theseuscollectbox.txt3/txt4`) | One shop good | Shop view | Name, owned count, price `Point`, limit `canOneCount/VIP0Count` (`:100-130`) |
| `C/pro/TheseusCollProView.as` | "Baú de diamante" (`theseuscollectbox.txt1`) | Collector level | Tab 6 | Total `boxCount`, alert "Abra baús de diamante de coletáveis para aumentar o nível de colecionador" (`theseus.scoreAlertText.text`), current level digits, bar `boxCount/NeedNum` or "max", reward rows (`:73-192`) |
| `C/pro/TheseusCollProItem.as` | | One level reward row | Pro view | Level, `NeedNum`, up to 6 reward items, button enabled for state 1, "claimed" image for state 2 (`:91-150`) |

Selection order: chests and shop goods are sorted with `sortOn(...,2)` (descending), so the first and default entry is 3505 "Baú de diamante" (`C/view/TheseusBoxView.as:188-201`, `C/shop/TheseusCollentionShopView.as:86-91, 176-189`).

---

## 3. Routes (client to server)

All five collection actions use one sender: `TheseussoulManager.doCollectionthing(op, templateId=0, count=0)` (`MGR:959-967`) → **9740 (0x260c) `C_COLLECTION_CLIENT`**, body `player.PlayerOpMsg`, only these fields set:

| Field | Tag, type | Meaning |
|---|---|---|
| `op` | #1, INT32 | 1 data, 2 activate or star up, 3 claim progress chest, 4 open chests, 5 claim level reward (constants `OP_COLLECTION_DATA=1`, `OP_COLLECTION_UPGRADE=2`, `OP_COLLECTION_UPGRADETask=5`, `MGR:153-157`; 3 and 4 have no constant) |
| `count` | #4, INT32 | op 4: chests to open (1 or 10); else 0 |
| `templateId` | #8, INT32 | op 2: collectible TemplateId; op 4: chest TemplateId; op 5: `CollectionRewardTemplates.Id`; else 0 |

### R1. Load collection data (9740 op 1)

| Item | Value |
|---|---|
| UI control | Frame construction (`C/TheseusCollenseFrame.as:54`) and Theseus equipment view construction (`T/view/ThereussoulEquipView.as:92`, sent even with the switch off) |
| Client checks | None |
| Request | `{op:1}` |
| Expected responses | Prerequisites already sent at login: 211 bagType 5 and 6, 4725 with masterType 70. Then 584 `CollectionMsg{opType:1, datas: all activated collectibles, boxProcess, dropId}`, then 594 `CollectionRewardMsg{boxCount, tasks}` *(assumption: 594 is never requested explicitly, so op 1 is the only point where the level tab can be filled)* |

### R2. Activate or star up a collectible (9740 op 2)

| Item | Value |
|---|---|
| UI control | `_jihuo` (activate, visible only when not activated and shard count ≥ `chipNeedNum`) and `_upStar` (star up, visible when activated and a next star exists) in `C/UI/TheseusCollenedRightViewUi.as:245-246` |
| Sender | `__jihuoBtnClickHandler` → `doCollectionthing(2, _data.templeteInfo.TemplateId)` (`:309-312`) |
| Client checks | Activate: `_jihuo.visible = shards ≥ chipNeedNum` (`:532-539`). Star up: `_upStar.enable = UpGold ≤ gold`, and if `chipNeedNum1 > 0` also Metal ≥ `chipNeedNum1` (`:469, 477`). **The first material (`chipId`, `chipNeedNum`) is not checked for star up**, the server must check it. No confirmation, no cooldown |
| Request | `{op:2, templateId}` |
| Expected responses | 212 bagType 5 (materials debited), gold update (core resource push), 584 `{opType:2, datas:[{templateId, star}], boxProcess, dropId}` with exactly one entry. Send 212 before 584 so the right view recomputes with fresh counts |

### R3. Claim the point progress chest (9740 op 3)

| Item | Value |
|---|---|
| UI control | Chest animation `_mc` (`C/view/TheseusBoxView.as:179`), visible only when `max(boxProcess - points, 0) == 0` and the `CollectionGetDrop` row of `dropId` exists (`:214-253`) |
| Sender | `__gotoBoxHandler` → `doCollectionthing(3)` (`:347-356`) |
| Client checks | 500 ms debounce (`:349-353`); visibility rule above |
| Request | `{op:3}` |
| Expected responses | 4725 (masterType 70 points reduced) *(assumption)*, 212 bagType 6 (chest `itemId` of the stage added), 584 `{opType:3, datas:[], boxProcess:<next stage site>, dropId:<next stage>}` *(assumption on opType value; any value other than 2 works, `datas` must be empty, see §4)* |

### R4. Open chests (9740 op 4)

| Item | Value |
|---|---|
| UI control | `_openBtn1` (x1) and `_openBtn2` (x10) (`C/view/TheseusBoxView.as:177-178`) |
| Sender | `__openBottleHandler` → `doCollectionthing(4, model.selectBox.templateId, 1 or 10)` (`:358-376`) |
| Client checks | `_openBtn1.enable = count ≥ 1`, `_openBtn2.enable = count ≥ 10` (`:452-453, 505-506`); 1000 ms debounce (`:361-365`); buttons disabled during the result animation (`:415, 443-456`) |
| Request | `{op:4, templateId:3501..3505, count:1|10}` |
| Expected responses | 212 bagType 6 (chests debited), 212 bagType 5 (shards, Metal, collectibles), main bag update for "Bolsa de Ouro" 2030102 (core bag push), 4725 (points added) *(assumption)*, 594 if the chest is 3505 (`boxCount` grows) *(assumption)*, then 585 `BoxOpenItemMsg{items}` (drives the animation; send last) |

### R5. Claim a collector level reward (9740 op 5)

| Item | Value |
|---|---|
| UI control | `getBtn` of `C/pro/TheseusCollProItem.as:71` |
| Sender | `__onGetRewardHandler` → `doCollectionthing(5, int(_data.uuid))` (`:82-89`); `uuid` = `CollectionRewardTemplates.Id` (`MGR:589`) |
| Client checks | `rewardState == 1` (`:84-87`); button enabled only for state 1 (`:130-150`) |
| Request | `{op:5, templateId:<reward Id 1001..1075>}` |
| Expected responses | 212 bagType 6 (3505 x1), 212 bagType 5 (Metal Divino x50), 594 with the task now status 2 |

### R6. Resolve shards ("Decompor")

| Item | Value |
|---|---|
| UI control | "Decompor" in the chip tab → `SpliteCollectionFrame` "Confirmar" (`C/view/TheseusCollentionChipView.as:144-159`, `C/item/SpliteCollectionFrame.as:25-30`) |
| Sender | `TheseussoulManager.sendTheseusResolve("<templateId>,<count>", 5)` (`MGR:1010-1017`) via `SocketSendManager.sendProtoBuffer` |
| Client checks | A cell is selected; count clamped to `min(input, owned)` (`SpliteCollectionFrame.as:19-23`). The input may be empty or 0 and the button still sends. Any bag 5 item can be selected, including Metal Divino and collectibles that have no resolve row |
| Route | **8681 (0x21e9) `C_VIRTUAL_ITEM_RESOLVE`**, `player.PlayerOpMsg{type (#2, INT32) = 5 (virtual bag type), param1 (#15, STRING) = "templateId,count"}`. No other caller sends 8681 |
| Expected responses | 212 bagType 5 (shards removed, Metal Divino added). No dedicated result message; the chip view refreshes on 212 (`:103, 161-215`) |

### R7. Buy chests in the collection shop

| Item | Value |
|---|---|
| UI control | `_buyBtn` (`C/shop/TheseusCollentionShopView.as:163`) |
| Sender | `__buyHandler` (`:287-315`) → alert "Deseja consumir {0} diamantes para comprar {1} {2}?" (`theseuscollectbox.txt5`, title "Aviso", buttons "Confirmar"/"Cancelar") → `buyCallBack` (`:334-347`) → `ShopManager.Instance.buyOne(shopId, buyNum, playerInfo.userId, 1, false)` (`CM/managers/ShopManager.as:1205-1220`). When `GiftToken > 0` (never for these rows) `offerReward.RefreshAlertFrame` with "Não alertar mais" and payType 2 when ticked (`:305-308, 317-332`) |
| Client checks | `buyNum > 0`; `canBuyNum > 0` else tip "Limite de compra de {0} atingido" (`theseuscollectshoptips`); quantity clamped to `canBuyNum` (`:260-266`) and quick buttons fall back to `canBuyNum` with "Limite de quantidade ultrapassada" (`shop.utils.ShopingHelper.command06`, `:367-425`); diamonds via `LogicUtils.judgePointEnoughToShowPay(total,false)` after confirmation |
| Route | **8970 (0x230a) `C_SHOPCAR_BUY`**, `shop.ShopCarListMsg{receiveUserId (#2, INT32) = own userId, discountTempId (#3, INT32) = 0, carItemInfo (#4, CarItemInfoMsg, repeated) = [one item]}`; `CarItemInfoMsg{shopId (#1, INT32) = ShopTempInfos.Id 10350001..10350005, counts (#2, INT32) = quantity, payType (#3, INT32) = 1 diamonds, isDiscountShop (#4, BOOL) = false}`; `result (#1)`, `isMail (#5)` and `type (#5 of CarItemInfoMsg)` unset |
| Expected responses | Diamond update (core player push), 212 bagType 6 (chests added), 528 `CommonMsgList` with the new bought count. The view refreshes only through `BTHESSOXSHOPBUYEFF` raised by 528 (`CM/managers/ShopManager.as:146-161`, `C/shop/TheseusCollentionShopView.as:168, 244-253`) |

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields | Client receiver | When to send | Client reaction |
|---|---|---|---|---|---|
| 584 (0x0248) | U_C_COLLECTION_DATA | `collection.CollectionMsg`: `opType (#1, INT32)`, `datas (#2, CollectionDataMsg, repeated)`, `boxProcess (#3, INT32)` points needed for the current progress chest, `dropId (#4, INT32)` current `CollectionGetDrop.dropId` stage. `CollectionDataMsg`: `templateId (#1, INT32)` collectible, `star (#2, INT32)` 0..10 | `MGR.__treasureCollectionInfosHandler` (`MGR:230, 863-888`) | R1 (opType 1, full list), R2 (opType 2, one entry), R3 *(assumption)* | Always stores `boxDropId`, `boxProcess`. `opType == 2`: replaces or appends `datas[0]` in `hasCollectionArray` and marks the album dirty (`MOD:126-148`); only `datas[0]` is read. Any other opType: **appends** every entry to `hasCollectionArray` without clearing it, then rebuilds the album (`MOD:150-178`). Repeated op 1 answers therefore duplicate entries; harmless because the last match wins, but the list grows each open. Then fires `EVENT_COLLECTION_UPDATE` (left view, right view, box progress, red dots) |
| 585 (0x0249) | U_C_COLLECTION_BOX_OPEN_ITEMS | `collection.BoxOpenItemMsg`: `items (#1, collection.ItemMsg, repeated)`; `ItemMsg`: `itemId (#1, INT32)`, `num (#2, INT32)` | `MGR.__updateBuyDataHandler` (`MGR:231, 828-839`) → event `THESEUSCOLLECTIONBOXEXCHANGE_BUY_BACK` → `C/view/TheseusBoxView.as:378-435` | Response to R4, one entry per opened chest *(assumption)* | Plays `theseuscollection.buyResultMc<selectBoxindex>_<0 single | 1 multi>`. One item: shown inside the animation. More than one: `TheseusCollectShowBoxFrame` around frame 36-38, laid out in 2 rows of `length/2` (designed for 10) (`TheseusCollectShowBoxFrame.as:57-82`). Must not be empty |
| 594 (0x0252) | U_C_COLLECTION_REWARD_DATA | `collection.CollectionRewardMsg`: `boxCount (#1, INT32)` Diamond chests opened (collector score), `tasks (#2, RewardTask, repeated)`; `RewardTask`: `taskId (#1, INT32)` = `CollectionRewardTemplates.Id`, `status (#2, INT32)` 0 locked, 1 claimable, 2 claimed | `MGR.__updatePartyTempHandler` (`MGR:235, 450-578`), `resolveMsgToArr` (`:580-605`) | R1 *(assumption)*, R4 with 3505, R5 | Merges tasks by id into `playerScoreRewardList`, adds every missing template as state 0, sorts by level, keeps claimable + first 10 locked + claimed, sets `allred` if any state 1, `myTotalScore = allTotallevel = boxCount`, `myTotalid` = id of the first level not yet reached (1001 when none). Fires `OP_COLLECTION_UPGRADETASK` (level tab, red dots). Every `taskId` must exist in the template, else `resolveMsgToArr` throws on `_loc6_.Level` |
| 211 (0x00d3) | U_C_VIRTUAL_BAG_DATA | `item.VirtualBagMsg`: `bagType (#1, INT32)`, `items (#2, VirtualItemMsg, repeated)`; `VirtualItemMsg`: `templateId (#1, INT32)`, `count (#2, INT32)`, `pos (#3, INT32)`, `isLock (#4, BOOL)` | `CM/yishi/manager/BaseManager.as:350, 356-405` | Login, once for bagType 5 and once for bagType 6 *(assumption)* | Clears and refills `armorBagDic` (5) or `boxBagDic` (6) keyed by templateId |
| 212 (0x00d4) | U_C_VIRTUAL_BAG_UPDATE | same `VirtualBagMsg`, only changed rows | `BaseManager.as:351, 407-459`; also listened by the frame red dots, chip view, box view and Theseus equipment view | After every change of bag 5 or 6 | Upserts each row; `count == 0` deletes it |
| 4725 (0x1275) | U_C_PLAYER_TOKENINFO | `player.PlayerTokenInfoMsg{tokenInfos (#1, TokenInfoMsg, repeated)}`; `TokenInfoMsg`: `masterType (#1, INT32)` = 70 `THESEUSCOLLEECTIONVBOX` (`CM/mvc/module/currency/CurrencyType.as:128`), `amount (#2, INT32)` box points, `expiredDate (#3, STRING)` | `CM/managers/PlayerCurrencyManager.as:71, 465-470` | Login and on every point change | Sets `currencyInfo.theseuscollectionBox`; dispatches `CURRENCYREFRESH` (box view progress, `C/view/TheseusBoxView.as:175`). **Must be sent with masterType 70 at login**: the object has no default (`CM/mvc/module/currency/PlayerCurrencyInfo.as:637-646`) and `checkAllboxRed` dereferences it (`MOD:291`) on every 212 / 584 / 594 while the Theseus equipment view exists, even with the switch off |
| 528 (0x0210) | U_C_FROST_HEART_SHOP (generic shop counter) | `player.CommonMsgList{list (#1, CommonMsg, repeated)}`; `CommonMsg`: `param1 (#1, INT32)` = ShopTempInfos.Id, `param2 (#2, INT32)` = bought count in the period | `CM/managers/ShopManager.as:143, 146-161` (`getShopInfo` includes the ShopType 1035 dictionary at `:199`) | Login and after R7 | Sets `OneCurrentCount`, fires `BTHESSOXSHOPBUYEFF` → shop view refresh |

No result or error codes exist for this module. Every failure is pre-checked client side; on a server-side rejection send nothing *(assumption)*. Gold and diamond balance pushes belong to the core player module.

---

## 5. Rules and formulas

**Album content.** Collectibles = `ItemTempInfos` with `SonType == 2002 && Property2 == 1` (`MOD:118-124`, `CM/yishi/datas/templates/cate/GoodsTemplateCate.as:79-93`): 24 visible (21001-21006 Raro, 22001-22009 Épico, 23001-23009 Lendário). 21007-21010, 22010, 23010 have rows in `CollectionTemplates` but `Property2` is empty, so they are hidden. Section = `Profile - 2` (Profile 3, 4, 5).

**Star rows.** `CollectionTemplates.Id = TemplateId*1000 + Star + 1`; `getTemplateByID(id, n)` reads key `id*1000+n` (`CM/yishi/datas/templates/cate/CollectionTempCate.as:73-89`). For a collectible (`CM/mvc/module/theseus/TheseusCollectionInfo.as:39-55`):
- not activated: `starnextInfo` = Star 0 row (activation cost);
- activated at star s: `starInfo` = Star s row, `starnextInfo` = Star s+1 row (none at s = 10);
- `starMaxInfo` = Star 10 row (`:67-70`). Max star 10.

**Costs.** `UpNeed = "chipId,chipNeedNum[|chipId1,chipNeedNum1]"` (`CM/mvc/module/theseus/TheseusCollectionStarInfo.as:125-135`), plus `UpGold` gold. Shard of collectible X = `X*1000` (SonType 2001); Metal Divino = 20000000 (SonType 2000).

| Target star | Raro (21001) | Épico (22001) | Lendário (23001) |
|---|---|---|---|
| 0 (activate) | shard x20, 0 gold | shard x30, 0 gold | shard x40, 0 gold |
| 1 | Metal x20, 10000 | Metal x30, 20000 | Metal x40, 30000 |
| 2 | Metal x40, 15000 | Metal x60, 30000 | Metal x80, 45000 |
| 3 | shard 20 + Metal 80, 23000 | shard 30 + Metal 120, 45000 | shard 40 + Metal 240, 68000 |
| 5 | shard 60 + Metal 160, 53000 | shard 90 + Metal 240, 102000 | shard 120 + Metal 480, 153000 |
| 10 | shard 240 + Metal 560, 405000 | shard 360 + Metal 840, 777000 | shard 480 + Metal 1680, 1166000 |
| Total gold 0→10 | 1191000 | 2288000 | 3434000 |

All collectibles of the same rarity share the same ladder (verified over the 330 rows). Server rule for op 2: if not owned, require Star 0 row materials and create at star 0; if owned at s < 10, require Star s+1 row gold, `chipId x chipNeedNum` and `chipId1 x chipNeedNum1`, then star = s+1.

**Stats.** Each row holds the absolute values for that star (e.g. 21001 Defence 153 at star 0, 1680 at star 10), not increments; the right view compares `starInfo` vs `starnextInfo` (`C/UI/TheseusCollenedRightViewUi.as:404-495`). Only Attack, MagicAttack, Defence, MagicDefence, Live are non-zero in this data (at most two per collectible). `Specialeffect` (Épico and Lendário) points to `SkillPropertyTempInfos` (e.g. 22001001 `AddType="1" ReduceResiAgainst="273"`), text in `SpecialeffectDesc` "name:value". Stats are applied server side to the player *(assumption: added to the hero like other Theseus bonuses; the client has no total view)*.

**Suits.** 6 suits of 4 collectibles (`TX/CollectionSuitTemplates.xml`). Tier t ∈ {0,3,6,10} is active when all 4 are activated and each has `star ≥ t` (`MOD:195-209`, `C/UI/TheseusSuitItemUI.as:60-80`). `Star0/3/6/10` are `SkillPropertyTempInfos` ids with `AddType="0"` (percent, e.g. 2010102 `Defence=1 MagicDefence=1 Live=1`). Descriptions are cumulative, so only the highest active tier applies *(assumption)*.

**Red dots** (`MOD:264-320`):
- collectible: `starnextInfo` exists, gold ≥ `UpGold`, bag5[chipId] ≥ `chipNeedNum`, and (`chipNeedNum1 ≤ 0` or bag5[chipId1] ≥ `chipNeedNum1`);
- box tab: any bag 6 count > 0, or `boxProcess - points ≤ 0`;
- level tab: any task with status 1 (`allred`).
- The main toolbar Theseus button ORs these three only when the switch is on (`CM/yishi/view/component/MovieButton.as:325-333`).

**Chests** (`TX/ItemTempInfos.xml` SonType 350, `Property1` = open drop id, `Property2` = 1/10/20/30/50):

| Id | Name | Shop price (diamonds) | Weekly limit | Description odds (text only) |
|---|---|---|---|---|
| 3501 | Baú de Bronze | 100 | 50 | Bolsa de Ouro 90%, blue shard 7%, purple shard 3% |
| 3502 | Baú de Prata | 300 | 50 | Metal 75%, blue 15%, purple 10% |
| 3503 | Baú de Ouro | 1000 | 30 | Metal 60%, blue 20%, purple 15%, orange 5% |
| 3504 | Baú de Platina | 2000 | 20 | Metal 45%, shards 20/17/9%, collectible blue 5%, purple 3%, orange 1% |
| 3505 | Baú de diamante | 3000 | 10 | Metal 45%, shards 17/14/6%, collectible blue 8%, purple 6%, orange 4% |

- Open drop is two level (`CM/yishi/datas/templates/cate/CollectionOpenDrop.as:45-72`): chest `Property1` → group rows (`appearType 4`, `itemId` = sub drop id) → item rows (`appearType 1` or the shard/collectible lists). Example 3501 → {350101 blue shard x1, 350201 purple shard x1, 350105 blue x5, 350205 purple x5, 350501..350503 Bolsa de Ouro 2030102 x1..3}. All `site` values are 0, so the real weights are unknown; use the `Description` percentages as group weights and uniform choice inside a group *(assumption)*.
- One reward per chest opened *(assumption, matches the 10-item result layout)*.
- Destination: SonType 350 → bag 6; SonType 2000/2001/2002 → bag 5; anything else (2030102 SonType 203 "Bolsa de Ouro", "Ao usar, obterá 500000 ouro") → main bag *(assumption derived from what each screen reads)*.

**Point progress chest.** Points = currency masterType 70. Stages from `TX/CollectionGetDrop.xml`: dropId 350001..350009 with `site` 20, 30, 40, 80, 60, 100, 80, 120, 180 and reward chest 3502, 3502, 3503, 3504, 3503, 3505, 3503, 3504, 3505. Client: `remaining = max(boxProcess - points, 0)`, bar `points/boxProcess`, text `boxtext1(remaining, chest name)`, claim enabled at remaining 0 (`C/view/TheseusBoxView.as:214-253`). Server proposal: `boxProcess = site` of the current stage, claim debits `site` points, grants the chest, advances to the next stage and stays on 350009 at the end *(assumption)*. Point source: each opened chest adds its `Property2` (1/10/20/30/50) *(assumption, the only per-chest number with that scale)*.

**Collector level.** 75 rows `TX/CollectionRewardTemplates.xml` (Id 1001..1075, Level 1..75, `NeedNum` 5, 10, 15 ... 100, 120 ... 200, 250 ... 3000, every reward `3505,1|20000000,50`). Score = Diamond chests (3505) opened (`theseus.scoreAlertText.text`). Status per level: 2 if claimed, 1 if score ≥ `NeedNum`, else 0. Display: current level = Level of the first unreached row, bar `score/NeedNum`, "max" when reached (`C/pro/TheseusCollProView.as:170-192`).

**Resolve.** `TX/ItemResolveTemplates.xml` Type 5 (30 rows): one shard → Metal Divino x2 (Raro), x6 (Épico), x12 (Lendário). Reject items without a Type 5 row and counts ≤ 0 or above the owned amount.

**Shop.** `TX/ShopTempInfos.xml` ShopType 1035 (Ids 10350001..10350005, `ItemId` 3501..3505, prices above, `GiftToken="0"`), loaded into `_thessboxShopDic` (`CM/yishi/resolve/ShopGoodsInfoResolve.as:352-355`, `CM/yishi/manager/TempleteManager.as:2658, 2689-2692`). Limit uses only `VIP0Count` (`CM/mvc/module/shop/ShopGoodsInfo.as:767-816`): remaining = `VIP0Count - OneCurrentCount`. The label says weekly ("Limite de Compra Semanal") *(assumption: reset Monday 00:00 server time)*.

**Formatting.** Counts ≥ 1000 render as `1k`, `1.5k`, `12k` (`C/UI/TheseusCollenedRightViewUi.as:279-307`).

---

## 6. Templates

| File | Loader | Record | Fields used and meaning (sample) |
|---|---|---|---|
| `TX/CollectionTemplates.xml` (330 rows) | `CollectionTempCate` (`TempleteManager.as:1365`) | One collectible star | `Id` 21001001 (= TemplateId*1000+Star+1), `TemplateId` 21001, `CollectionName` "Manto Mágico", `Quality` 1..3, `Star` 0..10, `UpGold` 10000, `UpNeed` "21001000,20\|20000000,80", `Specialeffect` 22001001, `SpecialeffectDesc` "Bloqueio:260", stat columns (Defence 153, MagicDefence 65, Attack, MagicAttack, Live, plus unused resist columns), `Icon` "/21001.png" (unused, the client builds the path itself) |
| `TX/CollectionSuitTemplates.xml` (6 rows) | `CollectionSuitTempCate` (`:1366`) | One set | `Id` 101, `SuitName` "Viajante Dimensional", `Suit` "21001\|21002\|21004\|22002", `Star0/3/6/10` 2010101..2010104 (SkillProperty ids), `Star0Desc` "Vida 1%" ... `Star10Desc` "Vida 2% Defesa Física 2% Defesa Mágica 2%" |
| `TX/CollectionRewardTemplates.xml` (75 rows) | `CollectionRewardTempCate` (`:1150`) | Collector level | `Id` 1001, `Type` 1, `Level` 1, `NeedNum` 5, `Reward` "3505,1\|20000000,50" (up to 6 "itemId,count") |
| `TX/CollectionGetDrop.xml` (9 rows) | `CollectionGetDrop` (`:1194`) | Point chest stage | `id` 35000101, `dropId` 350001, `site` 20 (points, *assumption*), `itemId` 3502, `count` 1, `isBind` 1 |
| `TX/CollectionOpenDrop.xml` (154 rows) | `CollectionOpenDrop` (`:1195`) | Chest drop tree | `id` 350101, `dropId` 3501, `itemId` 350101 (sub drop) or real item, `count`, `appearType` 4 (group) / 1 (item) *(assumption)*, `site` 0 |
| `TX/ItemTempInfos.xml` | `goodsTemplateCate` (`:1146`) | Items | SonType 2002 collectibles (`Profile` 3..5, `Property1` = shard id, `Property2` 1 = shown), 2001 shards, 2000 "Metal Divino" 20000000 ("Usado para promoção de Coletáveis"), 350 chests (`Property1` drop id, `Property2`), 203 "Bolsa de Ouro" 2030102 |
| `TX/ItemResolveTemplates.xml` Type 5 | `ResolveTemplateCate` (`:1321`, server side only for this module) | Shard resolve | `ResolvedItem` 21001000, `Item1` 20000000, `Count1` 2 |
| `TX/ShopTempInfos.xml` ShopType 1035 | `ShopGoodsInfoResolve` (`:1444`) | Chest shop | `Id` 10350001, `ItemId` 3501, `Point` 100, `GiftToken` 0, `VIP0Count` 50, `Sort` 1 |
| `TX/SkillPropertyTempInfos.xml` | server | Effect values | 2010101 `AddType="0" Live="1"`; 22001001 `AddType="1" ReduceResiAgainst="273"` |

Icons: `<ResourcePath>icon/collection/<TemplateId>.png` (`PathManager.as:808-811`); 30 files exist under `raw/icon/collection/`.

---

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS theseus;

CREATE TABLE theseus.collection_items (
  player_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id   integer     NOT NULL,
  star          smallint    NOT NULL DEFAULT 0 CHECK (star BETWEEN 0 AND 10),
  activated_at  timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, template_id)
);

CREATE TABLE theseus.collection_bag_items (
  player_id    integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  bag_type     smallint NOT NULL CHECK (bag_type IN (5, 6)),
  template_id  integer  NOT NULL,
  count        integer  NOT NULL CHECK (count > 0),
  pos          integer  NOT NULL DEFAULT 0,
  is_locked    boolean  NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, bag_type, template_id)
);

CREATE TABLE theseus.collection_state (
  player_id             integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  stage_drop_id         integer     NOT NULL DEFAULT 350001,
  box_points            integer     NOT NULL DEFAULT 0 CHECK (box_points >= 0),
  diamond_boxes_opened  integer     NOT NULL DEFAULT 0 CHECK (diamond_boxes_opened >= 0),
  updated_at            timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE theseus.collection_level_rewards (
  player_id   integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  reward_id   integer     NOT NULL CHECK (reward_id BETWEEN 1001 AND 1075),
  claimed_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, reward_id)
);

CREATE TABLE theseus.collection_shop_purchases (
  player_id     integer NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  shop_id       integer NOT NULL,
  period_start  date    NOT NULL,
  bought        integer NOT NULL DEFAULT 0 CHECK (bought >= 0),
  PRIMARY KEY (player_id, shop_id, period_start)
);

CREATE TABLE theseus.collection_box_open_log (
  id               bigserial   PRIMARY KEY,
  player_id        integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  box_template_id  integer     NOT NULL,
  opened           smallint    NOT NULL CHECK (opened > 0),
  items            jsonb       NOT NULL,
  opened_at        timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX collection_box_open_log_player ON theseus.collection_box_open_log (player_id, opened_at DESC);
```

Notes:
- `collection_items` holds activated collectibles only; absence means "not activated".
- `collection_bag_items` is the virtual bag storage for bag types 5 and 6. If the inventory area defines one generic virtual bag table (bag type 3 is used by Avenger), reuse it instead.
- `box_points` is the value sent as currency masterType 70. If the currency area stores tokens generically, keep the points there and drop this column.
- Level reward status is derived: claimed row → 2, `diamond_boxes_opened ≥ NeedNum` → 1, else 0.
- `collection_shop_purchases.period_start` is the Monday of the purchase week *(assumption)*. If the shop area has a generic counter table, reuse it.
- `collection_box_open_log` is optional (audit).

---

## 8. Backend implementation notes

### Handlers

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `theseus::collection::handle_open` | 9740 op 1 | player loaded | Read only. Send 584 (opType 1, all `collection_items`, `boxProcess` = site of `stage_drop_id`, `dropId` = `stage_drop_id`), then 594 (`boxCount` = `diamond_boxes_opened`, tasks with status 1 or 2) |
| `theseus::collection::handle_upgrade` | 9740 op 2 | templateId is a visible collectible (SonType 2002, Property2 1) → next row exists (not owned: Star 0; owned at s < 10: Star s+1) → gold ≥ `UpGold` → bag5[chipId] ≥ need → bag5[chipId1] ≥ need1 | One tx: debit gold and materials, insert row at star 0 or increment star. After commit: 212 bagType 5, gold push, 584 opType 2 with one entry, and recompute player stats (collectible + suit tiers) with the core property push |
| `theseus::collection::handle_claim_progress_box` | 9740 op 3 | `box_points ≥ site(stage)` | One tx: debit points, add the stage chest to bag 6, advance stage. After commit: 4725 (type 70), 212 bagType 6, 584 opType 3 with empty `datas` |
| `theseus::collection::handle_open_boxes` | 9740 op 4 | templateId in 3501..3505 → count ∈ {1, 10} → bag6[templateId] ≥ count | One tx: debit chests, roll `count` drops, credit bag 5 / bag 6 / main bag, add points (`Property2 * count`, *assumption*), if 3505 add `count` to `diamond_boxes_opened`, write log. After commit: 212 bagType 6, 212 bagType 5, main bag push if any, 4725, 594 if 3505, then 585 |
| `theseus::collection::handle_claim_level_reward` | 9740 op 5 | reward id exists → `diamond_boxes_opened ≥ NeedNum` → not already claimed | One tx: insert claim, credit rewards by destination. After commit: 212 pushes, 594 |
| `theseus::collection::handle_resolve` | 8681 type 5 | `type == 5` → parse "templateId,count" → count > 0 → Type 5 resolve row exists → bag5[templateId] ≥ count | One tx: debit shards, credit Metal `Count1 * count`. After commit: one 212 bagType 5 with both rows |
| `theseus::collection::handle_shop_buy` | 8970 with ShopType 1035 goods | shop id in ShopType 1035 → counts > 0 → payType 1 → `bought + counts ≤ VIP0Count` for the week → diamonds ≥ `Point * counts` | One tx: debit diamonds, upsert purchase counter, credit bag 6. After commit: diamond push, 212 bagType 6, 528 with `{param1: shopId, param2: bought}`. Implemented inside the shared 8970 dispatcher of the shop area, routed here by ShopType *(assumption)* |

### Ordering and login sync
- Login: 211 bagType 5, 211 bagType 6, 4725 including masterType 70 (even with amount 0), 528 for the ShopType 1035 counters of the current week. Without masterType 70 the client throws in `checkAllboxRed` as soon as the Theseus equipment view receives 212, 584 or 594.
- Always push 212 before 584/585 so the views read fresh counts.
- Because the switch is off, the only collection traffic in this build is 9740 op 1 from the equipment view: `handle_open` is the minimum viable implementation.

### Other
- No battle, no pushes to other players, no timers except the weekly shop counter reset (period key, no job needed).
- Stat application: collectible row stats and suit `SkillPropertyTempInfos` effects feed the player's Theseus property totals owned by [soul.md](soul.md) *(assumption)*.

---

## 9. Open questions and assumptions

1. **Switch.** `TREASURECANGPING` is a compile-time false. Enabling the feature needs a runtime change of `yishi.datas.VersionSwitch.TREASURECANGPING` in the Flash runtime, outside this module.
2. **594 timing.** Not requested by the client; assumed sent after op 1, op 4 (3505) and op 5.
3. **Box points.** Source of currency 70 (assumed `Property2` per opened chest) and the meaning of `boxProcess` (assumed `site` of the current `CollectionGetDrop` stage, debited on claim, last stage repeats).
4. **Drop weights.** `CollectionOpenDrop.site` is 0 everywhere; the odds only exist as `Description` text.
5. **Collectible drops.** Chests 3504/3505 can drop a whole collectible (e.g. 21001 x1 via 350180). The client has no path for SonType 2002 items in bag 5 except listing them in the chip tab. Proposal: store it in bag 5 like the original data suggests, or auto-activate; needs a decision.
6. **Stats.** How collectible and suit stats reach the hero (absolute row values, highest suit tier only) is server side and unproven.
7. **Shop period.** "Semanal" in the label vs `OneDayCount` in code; weekly reset day assumed Monday.
8. **opType for op 3 / op 4 answers** of 584: any value except 2 with empty `datas`; the original value is unknown.
9. **Client quirks to keep in mind:** star up does not check the first material; the chip tab can submit 0 or Metal Divino for resolve; the 100 quick-buy button is never shown; `refreshprogressView` uses an unsorted chest list for the icon frame (`C/view/TheseusBoxView.as:220, 238-249`); `CollectionTempCate.getTemplateByID` lazy path filters `@TemplateID` (XML has `TemplateId`) but all rows are preloaded so it never matters.
10. **Overlap.** Chests also come from the Theseus box challenge (storehouse) module; virtual bag and token currency belong to inventory/economy. Coordinate table ownership.

---

## 10. Implementation checklist

**Screens (client, verify against the backend):**
- [ ] `TheseusCollenseFrame` opens, sends op 1, tab red dots
- [ ] Tab 1 album: left sections, tiles, right detail, activate, star up, "Visualizar" star 10 preview
- [ ] Tab 2 suits: tiers grayed or lit by stars
- [ ] Tab 3 chips: grid, "Decompor" with `SpliteCollectionFrame`
- [ ] Tab 4 chests: select, open x1 / x10, animation, `TheseusCollectShowBoxFrame`, progress bar and claim
- [ ] Tab 5 shop: quantity, limit label, confirm, purchase refresh
- [ ] Tab 6 collector level: level, bar, reward rows, claim
- [ ] Theseus equipment view with switch off: no error on 212/584/594

**Routes:**
- [ ] 9740 op 1 `handle_open`
- [ ] 9740 op 2 `handle_upgrade` (activation and star up)
- [ ] 9740 op 3 `handle_claim_progress_box`
- [ ] 9740 op 4 `handle_open_boxes`
- [ ] 9740 op 5 `handle_claim_level_reward`
- [ ] 8681 type 5 `handle_resolve`
- [ ] 8970 ShopType 1035 `handle_shop_buy`

**Server messages:**
- [ ] 584 opType 1 full list and opType 2 single entry
- [ ] 585 open results
- [ ] 594 reward tasks
- [ ] 211 / 212 bagType 5 and 6
- [ ] 4725 with masterType 70 at login and on change
- [ ] 528 ShopType 1035 counters

**Tables:**
- [ ] `theseus.collection_items`
- [ ] `theseus.collection_bag_items`
- [ ] `theseus.collection_state`
- [ ] `theseus.collection_level_rewards`
- [ ] `theseus.collection_shop_purchases`
- [ ] `theseus.collection_box_open_log` (optional)

**Rules and templates:**
- [ ] Loaders: CollectionTemplates, CollectionSuitTemplates, CollectionRewardTemplates, CollectionGetDrop, CollectionOpenDrop, ItemResolveTemplates Type 5, ShopTempInfos 1035, SkillPropertyTempInfos, ItemTempInfos SonTypes 2000/2001/2002/350
- [ ] Visible album filter (Property2 1)
- [ ] Star cost ladder and absolute stats per star
- [ ] Suit tiers 0/3/6/10
- [ ] Two level chest drop and destination by SonType
- [ ] Point progress stages
- [ ] Collector level statuses
- [ ] Shop weekly limit and diamond price
- [ ] Stat application to the hero

**Tests:**
- [ ] Op 1 for a new player: empty album, stage 350001, 75 locked levels, no client error
- [ ] Activate with exactly 20 shards; reject with 19
- [ ] Star up rejected when the first material is short while gold and Metal suffice
- [ ] Star 10 then op 2 is rejected
- [ ] Open x10 with 9 chests rejected; x10 with 10 returns 10 items in 585 after the 212 pushes
- [ ] Opening 3505 increments `boxCount` and unlocks levels at 5, 10, 15
- [ ] Claim level twice: second rejected
- [ ] Resolve 21001000 x3 → Metal +6; resolve 20000000 rejected; count 0 rejected
- [ ] Shop: 51st 3501 in a week rejected; counter resets next week
- [ ] `node server/flowtest.mjs` round trip for 9740 op 1 → 584 + 594
